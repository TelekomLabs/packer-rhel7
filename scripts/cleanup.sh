# delete packages
yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
rm -rf VBoxGuestAdditions_*.iso

# clean yum history
yum history new
yum -y clean all

# clean up logs
truncate -c -s 0 /var/log/yum.log
rm -rf /var/log/anaconda*
rm -rf /var/lib/yum/*
rm -rf /var/lib/random-seed
rm -rf /root/install.log
rm -rf /root/install.log.syslog
rm -rf /root/anaconda-ks.cfg
