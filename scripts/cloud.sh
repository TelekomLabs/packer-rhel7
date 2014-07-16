# to install the following packages, epel is required
yum -y update

# Installs cloudinit
yum -y install cloud-init

# configure cloud init 'cloud-user' as sudo
# this is not configured via default cloudinit config
cat > /etc/cloud/cloud.cfg.d/02_user.cfg <<EOL
system_info:
  default_user:
    name: cloud-user
    lock_passwd: true
    gecos: Cloud user
    groups: [wheel, adm]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
EOL

# Install haveged for entropy
yum -y install haveged

# Configure serial console
sed -i '/kernel/s|$| console=tty0 console=ttyS0,115200n8 |' /boot/grub/grub.conf

# remove uuid
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-e*

# replace password from root with a encrypted one
# usermod -p "*" root


