echo -e "\e[0;32m Configure fail2ban for vicidial with jail.local file \e[0m"
sleep 2

#yum -y remove fail2ban
yum -y install fail2ban
systemctl enable fail2ban

rm -rf /etc/fail2ban/jail.local.bak
mv /etc/fail2ban/jail.local /etc/fail2ban/jail.local.bak
\cp -r /usr/src/jail.local /etc/fail2ban/jail.local

systemctl start fail2ban

yum -y install expect
echo -e "\e[0;32m Please Enter This Server IP ADDRESS to avoid self ban \e[0m"
read serveripadd

echo "fail2ban self ignore ip will be set to "$serveripadd
sleep 5

sed -i "s|ignoreip = 127.0.0.1|ignoreip = 127.0.0.1 ${serveripadd}|g" /etc/fail2ban/jail.local

systemctl restart fail2ban
systemctl status fail2ban

/usr/src/./jail_blackip.sh

