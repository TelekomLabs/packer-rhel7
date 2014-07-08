# install official epel package
# @see https://fedoraproject.org/wiki/EPEL
rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

yum -y update