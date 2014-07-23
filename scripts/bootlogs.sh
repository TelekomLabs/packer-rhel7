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
