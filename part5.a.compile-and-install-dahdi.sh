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

tee /etc/systemd/system/dahdi.service <<'EOF'
[Unit]
Description=DAHDI Telephony Drivers
# Ensure hardware is initialized before starting
After=systemd-modules-load.service local-fs.target
Before=asterisk.service

[Service]
Type=oneshot
RemainAfterExit=yes
# Load kernel modules
ExecStartPre=/usr/sbin/modprobe dahdi
ExecStartPre=/usr/sbin/modprobe dahdi_dummy
# Configure spans
ExecStart=/usr/sbin/dahdi_cfg -v
# Reloading re-runs configuration
ExecReload=/usr/sbin/dahdi_cfg -v
# Properly unconfigure spans on stop to prevent "device busy" errors
ExecStop=/usr/sbin/dahdi_cfg -v -unconfigure

[Install]
WantedBy=multi-user.target
EOF

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

