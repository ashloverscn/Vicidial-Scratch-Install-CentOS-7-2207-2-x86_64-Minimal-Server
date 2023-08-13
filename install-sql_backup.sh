#input server ip to ipvariable

cd /usr/src
#sed $ipvariable to ip > backup.sql

#sed $hostvariable to host-domain > backup.sql

#to backup asterisk database into sql file 
#mysqldump asterisk > /usr/src/complete_backup_45.142.112.120.sql
#to transfer backup to a new server
#\scp -r /usr/src/complete_backup_45.142.112.120.sql root@45.142.112.126:/usr/src/

mysql -uroot -e "drop database asterisk"
mysql -uroot -e "create database asterisk"
mysql -uroot asterisk < /usr/src/complete_backup_45.142.112.120.sql
mysql -u root -f asterisk < /usr/src/astguiclient/trunk/extras/upgrade_2.x.sql

#################### correct asterisk version #####################
# confirm running asterisk version also same as in database
# if not replace with the running asterisk's version 

# to check running asterisk version 
asterisk -rx "core show version"

# to check database asterisk version 
mysql -uroot -e "use asterisk ; select asterisk_version from servers"

# to update database entry of asterisk version
mysql -uroot -e "use asterisk ; update servers set asterisk_version='xx.xx.x-vici'"



