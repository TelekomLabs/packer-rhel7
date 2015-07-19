# install official epel package
# @see https://fedoraproject.org/wiki/EPEL
rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

yum -y update