#!/bin/sh

yum -y install expect
##assuming self signed cert or letencrypt generated

echo -e "\e[0;32m Installing VIciPhone \e[0m"

mv /etc/asterisk/http.conf /etc/asterisk/http.conf.bak
mv /etc/asterisk/modules.conf /etc/asterisk/modules.conf.bak
mv /etc/asterisk/sip.conf /etc/asterisk/sip.conf.bak
\cp -r /usr/src/viciphone-etc-asterisk/* /etc/asterisk/

sed -i 's/wgetbin -q/wgetbin --no-check-certificate -q/g' /usr/share/astguiclient/ADMIN_audio_store_sync.pl

asterisk  -rx"sip reload"
asterisk  -rx"reload"
asterisk  -rx"module reload"

sleep 5

systemctl restart asterisk.service

#improved version of viciphone
rm -rf /var/tmp/ViciPhone/
rm -rf /var/www/html/agc/viciphone
cd /var/tmp
git clone https://github.com/ccabrerar/ViciPhone.git
mkdir /var/www/html/agc/viciphone
\cp -r ./ViciPhone/* /var/www/html/agc/viciphone
chmod -R 755 /var/www/html/agc/viciphone
cd /usr/src

sleep 5 

reboot
