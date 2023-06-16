mkdir /usr/src/astguiclient
cd /usr/src/astguiclient
svn checkout svn://svn.eflo.net/agc_2-X/trunk
cd /usr/src/astguiclient/trunk

mysql -uroot

CREATE DATABASE asterisk DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'cron'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT,CREATE,ALTER,INSERT,UPDATE,DELETE,LOCK TABLES on asterisk.* TO cron@'%' IDENTIFIED BY '1234';
GRANT SELECT,CREATE,ALTER,INSERT,UPDATE,DELETE,LOCK TABLES on asterisk.* TO cron@localhost IDENTIFIED BY '1234';
GRANT RELOAD ON *.* TO cron@'%';
GRANT RELOAD ON *.* TO cron@localhost;
CREATE USER 'custom'@'localhost' IDENTIFIED BY 'custom1234';
GRANT SELECT,CREATE,ALTER,INSERT,UPDATE,DELETE,LOCK TABLES on asterisk.* TO custom@'%' IDENTIFIED BY 'custom1234';
GRANT SELECT,CREATE,ALTER,INSERT,UPDATE,DELETE,LOCK TABLES on asterisk.* TO custom@localhost IDENTIFIED BY 'custom1234';
GRANT RELOAD ON *.* TO custom@'%';
GRANT RELOAD ON *.* TO custom@localhost;
flush privileges;
SET GLOBAL connect_timeout=60;
use asterisk;
\. /usr/src/astguiclient/trunk/extras/MySQL_AST_CREATE_tables.sql
\. /usr/src/astguiclient/trunk/extras/first_server_install.sql
update servers set asterisk_version='13.29.2';
quit

cd /usr/src/astguiclient/trunk
perl install.pl

#--Follow the onscreen instructions--
#--for web type /var/www/html--
#--for asterisk version type 13.X--
#--type Y to copy sample configuration---
#--below is my output for reference type your IP address--

#server webroot path or press enter for default: [/usr/local/apache2/htdocs] /var/www/html
#server IP address or press enter for default: [] server_ip 
#Enter asterisk version or press enter for default: [13.X]
#Copy sample configuration files to /etc/asterisk/ ? [n] y
#Copy web language translation files to webroot ? []y

/usr/share/astguiclient/ADMIN_area_code_populate.pl
/usr/share/astguiclient/ADMIN_update_server_ip.pl --old-server_ip=10.10.10.15

