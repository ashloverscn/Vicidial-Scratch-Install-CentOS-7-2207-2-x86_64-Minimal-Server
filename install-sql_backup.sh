#to backup asterisk database into sql file 
#mysqldump asterisk > /usr/src/complete_backup_vicibox11_45.142.112.124.sql
#to transfer backup to a new server
#\scp -r /usr/src/complete_backup_vicibox11_45.142.112.124.sql root@45.142.112.126:/usr/src/

#input server ip to ipvariable

cd /usr/src
#sed $ipvariable to ip > backup.sql

#sed $hostvariable to host-domain > backup.sql
sed -i 's/45.142.112.124/45.142.112.126/g' /usr/src/complete_backup_vicibox11_45.142.112.124.sql

mysql -uroot -e "drop database asterisk"
mysql -uroot -e "create database asterisk"
mysql -uroot asterisk < /usr/src/complete_backup_vicibox11_45.142.112.124.sql
mysql -u root -f asterisk < /usr/src/astguiclient/trunk/extras/upgrade_2.x.sql

#correct asterisk version
# to check running asterisk version 
asterisk -rx "core show version"
# to check database asterisk version 
mysql -uroot -e "use asterisk ; select asterisk_version from servers"
# to update database entry of asterisk version
mysql -uroot -e "use asterisk ; update servers set asterisk_version='xx.xx.x-vici'"



