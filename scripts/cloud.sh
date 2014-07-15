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

# remove uuid
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-enp*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-enp*

# remove password from root
passwd -d root


