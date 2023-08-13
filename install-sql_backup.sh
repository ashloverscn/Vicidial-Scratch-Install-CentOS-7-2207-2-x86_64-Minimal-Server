#!/bin/sh

yum -y install expect
echo -e "\e[0;32m Please Enter This Server IP ADDRESS \e[0m"
read serveripadd

echo "serveripadd is "$serveripadd
sleep 2

#to backup asterisk database into sql file 
#mysqldump asterisk > /usr/src/complete_backup_vicibox11_45.142.112.124.sql
#to transfer backup to a new server
#\scp -r /usr/src/complete_backup_vicibox11_45.142.112.124.sql root@45.142.112.126:/usr/src/

sed -i 's/45.142.112.124/$serveripadd/g' /usr/src/complete_backup_vicibox11_45.142.112.124.sql
#sed -i 's/oldhostname/$newhostname/g' /usr/src/complete_backup_vicibox11_45.142.112.124.sql

mysql -uroot -e "drop database asterisk"
mysql -uroot -e "create database asterisk"
mysql -uroot asterisk < /usr/src/complete_backup_vicibox11_45.142.112.124.sql
mysql -u root -f asterisk < /usr/src/astguiclient/trunk/extras/upgrade_2.14.sql

#asterisk -rx "core show version"
#mysql -uroot -e "use asterisk ; select asterisk_version from servers"
#mysql -uroot -e "use asterisk ; update servers set asterisk_version='xx.xx.x-vici'"



