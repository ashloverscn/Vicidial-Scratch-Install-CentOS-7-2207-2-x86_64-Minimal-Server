##assuming self signed cert or letencrypt generated

sed -i "s/Redirect permanent \/ https:\/\/.*/Redirect permanent \/ https:\/\/$serveripadd\//g" /etc/httpd/conf.d/0000-default.conf
cat /etc/httpd/conf.d/0000-default.conf
cd ~

systemctl restart httpd.service

mv /etc/asterisk/http.conf /etc/asterisk/http.conf.bak
mv /etc/asterisk/modules.conf /etc/asterisk/modules.conf.bak
mv /etc/asterisk/sip.conf /etc/asterisk/sip.conf.bak
\cp -r /usr/src/viciphone-etc-asterisk/* /etc/asterisk/

systemctl restart asterisk.service

sed -i 's/wgetbin -q/wgetbin --no-check-certificate -q/g' /usr/share/astguiclient/ADMIN_audio_store_sync.pl

##sql load webphone address
mysql -u root
use asterisk;
select sounds_web_server,webphone_url from system_settings;
select external_server_ip,web_socket_url from servers;
UPDATE system_settings set sounds_web_server='New_IP',webphone_url='https://New_IP/agc/viciphone/viciphone.php';
UPDATE servers set external_server_ip='New_IP',web_socket_url='wss://New_IP:8089/ws';
select sounds_web_server,webphone_url from system_settings;
select external_server_ip,web_socket_url from servers;
exit

##sql convert sip to viciphone
mysql -uroot
use asterisk;
select login,is_webphone,webphone_dialpad,webphone_auto_answer,webphone_dialbox,webphone_mute,webphone_volume,webphone_debug,template_id from phones;
UPDATE phones set is_webphone='Y',webphone_dialpad='N',webphone_auto_answer='Y',webphone_dialbox='N',webphone_mute='Y',webphone_volume='Y',webphone_debug='N',template_id='webphonevici';
select login,is_webphone,webphone_dialpad,webphone_auto_answer,webphone_dialbox,webphone_mute,webphone_volume,webphone_debug,template_id from phones;
exit

#improved version of viciphone
rm -rf /var/tmp/ViciPhone/
rm -rf /var/www/html/agc/viciphone
cd /var/tmp
git clone https://github.com/ccabrerar/ViciPhone.git
mkdir /var/www/html/agc/viciphone
\cp -r ./ViciPhone/* /var/www/html/agc/viciphone
chmod -R 755 /var/www/html/agc/viciphone
cd /usr/src

