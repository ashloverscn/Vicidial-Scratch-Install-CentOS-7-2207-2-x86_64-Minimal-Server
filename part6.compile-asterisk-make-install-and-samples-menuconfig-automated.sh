#!/bin/sh
ver=16.17.0
oem=-vici
subdr=beta-apps
echo -e "\e[0;32m Install Asterisk v$ver$oem \e[0m"
sleep 2
cd /usr/src
#rm -rf asterisk*
#yum remove asterisk -y
#yum remove asterisk-* -y
yum install asterisk -y
yum install asterisk-* -y
wget -O asterisk-$ver$oem.tar.gz http://download.vicidial.com/$subdr/asterisk-$ver$oem.tar.gz
#wget http://download.vicidial.com/beta-apps/asterisk-16.17.0-vici.tar.gz
tar -xvzf asterisk-$ver$oem.tar.gz
cd asterisk-$ver$oem

: ${JOBS:=$(( $(nproc) + $(nproc) / 2 ))}
./configure --libdir=/usr/lib64 --with-gsm=internal --enable-opus --enable-srtp --with-ssl --enable-asteriskssl --with-pjproject-bundled --with-jansson-bundled

#### asterisk menuselect preconfig
make menuselect/menuselect menuselect-tree menuselect.makeopts
#enable app_meetme
menuselect/menuselect --enable app_meetme menuselect.makeopts
#enable res_http_websocket
menuselect/menuselect --enable res_http_websocket menuselect.makeopts
#enable res_srtp
menuselect/menuselect --enable res_srtp menuselect.makeopts
make -j ${JOBS} all
make install
make samples

