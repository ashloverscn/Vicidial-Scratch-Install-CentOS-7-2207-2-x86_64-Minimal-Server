echo -e "\e[0;32m Install Dahdi Audio_CODEC Driver \e[0m"
sleep 2
cd /usr/src
#yum remove dahdi* -y
yum install dahdi* -y
yum install dahdi-tools* -y
wget http://download.vicidial.com/beta-apps/dahdi-linux-complete-2.11.1.tar.gz
tar -xvzf dahdi-linux-complete-*
cd dahdi-linux-complete-*
make all
make install
make config
modprobe dahdi
modprobe dahdi_dummy
dahdi_genconf -v
dahdi_cfg -v

