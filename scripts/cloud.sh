# Configure serial console
yum -y install grub2-tools

cat > /etc/default/grub <<EOF
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="\$(sed 's, release .*\$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/swap crashkernel=auto  rd.lvm.lv=centos/root vconsole.font=latarcyrheb-sun16 vconsole.keymap=de-latin1 rhgb console=ttyS0"
GRUB_DISABLE_RECOVERY="true"
EOF

grub2-mkconfig -o /boot/grub2/grub.cfg


# remove uuid
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-e*

# Installs cloudinit, epel is required
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

# replace password from root with a encrypted one
# usermod -p "*" root


