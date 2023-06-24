#!/bin/sh
ver=3.2.0
vici=0
dahdi-linux-complete-$ver+$ver
echo -e "\e[0;32m Install Dahdi Audio_CODEC Driver v$ver \e[0m"
sleep 2
cd /usr/src
#rm -rf dahdi-linux-complete*
#yum remove dahdi* -y
#yum remove dahdi-tools* -y
yum install dahdi* -y
yum install dahdi-tools* -y
if [ $vici -eq 1 ]
then
	wget http://download.vicidial.com/required-apps/dahdi-linux-complete-2.3.0.1+2.3.0.tar.gz
	tar -xvzf dahdi-linux-complete-2.3.0.1+2.3.0.tar.gz
	cd dahdi-linux-complete-2.3.0.1+2.3.0
else
	wget -O dahdi-linux-complete-$ver+$ver.tar.gz https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-$ver%2B$ver.tar.gz
	tar -xvzf dahdi-linux-complete-$ver+$ver.tar.gz
	cd dahdi-linux-complete-$ver+$ver
fi
make all
make install
make config
modprobe dahdi
modprobe dahdi_dummy
dahdi_genconf -v
dahdi_cfg -v

