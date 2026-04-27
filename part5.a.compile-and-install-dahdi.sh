#!/bin/sh
ver=3.4.0

echo -e "\e[0;32m Install Dahdi Audio_CODEC Driver v$ver \e[0m"
sleep 2
cd /usr/src
yum install kernel-devel-$(uname -r) -y
#rm -rf dahdi-linux-complete*
#yum remove dahdi* -y
#yum remove dahdi-tools* -y
yum install dahdi* -y
yum install dahdi-tools* -y
yum install gcc gcc-c++ make perl patch libedit-devel libuuid-devel libxml2-devel newt-devel -y

wget -O dahdi-linux-complete-$ver+$ver.tar.gz https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-$ver+$ver.tar.gz
tar -xvzf dahdi-linux-complete-$ver+$ver.tar.gz
cd dahdi-linux-complete-$ver+$ver
sed -i 's/#if __has_attribute(__fallthrough__)/#if 0 \/* __has_attribute(__fallthrough__) *\//g' linux/include/dahdi/kernel.h

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
\cp -r system.conf system.conf.bak
\cp -r system.conf.sample system.conf

echo -e "\e[0;32m Enable dahdi.service in systemctl \e[0m"
sleep 2

\cp -r /etc/systemd/system/dahdi.service /etc/systemd/system/dahdi.service.bak
rm -rf /etc/systemd/system/dahdi.service
touch /etc/systemd/system/dahdi.service

cat <<DAHDI>> /etc/systemd/system/dahdi.service

[Unit]
Description=DAHDI Telephony Drivers
After=network.target
Before=asterisk.service

[Service]
Type=oneshot
ExecStartPre=/sbin/modprobe dahdi
ExecStartPre=/sbin/modprobe dahdi_dummy
ExecStart=/usr/sbin/dahdi_cfg -v
ExecReload=/usr/sbin/dahdi_cfg -v
ExecStop=/usr/sbin/dahdi_cfg -v
Restart=on-failure
RestartSec=2
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

DAHDI

#restart dahdi Service
systemctl daemon-reload && \
systemctl disable dahdi.service && \
systemctl enable dahdi.service && \
systemctl restart dahdi.service && \
systemctl status dahdi.service | head -n 18

\cp -r /dahdi.sh /dahdi.sh.bak
rm -rf /dahdi.sh
\cp -r  /usr/src/dahdi.sh /dahdi.sh

chmod +x /dahdi.sh 

