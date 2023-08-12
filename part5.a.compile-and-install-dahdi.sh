#!/bin/sh
ver=3.2.0
vici=0

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

#sed -i 's/netif_napi_add(netdev, &wc->napi, &wctc4xxp_poll, 64);/netif_napi_add(netdev, &wc->napi, wctc4xxp_poll);/g' /usr/src/dahdi-linux-complete-3.2.0+3.2.0/linux/drivers/dahdi/wctc4xxp/base.c

make all
make install
make config
make install-config
yum -y install dahdi-tools-libs
modprobe dahdi
modprobe dahdi_dummy
dahdi_genconf -v
dahdi_cfg -v

cd tools
make clean
make all
make install
make install-config

cd /etc/dahdi
mv system.conf.sample system.conf
systemctl enable dahdi
systemctl start dahdi


