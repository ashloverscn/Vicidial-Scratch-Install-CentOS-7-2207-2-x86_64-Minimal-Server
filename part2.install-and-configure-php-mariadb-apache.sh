# part 2
echo -e "\e[0;32m Install RemiRepo PHP7 \e[0m"
sleep 2
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php74

echo -e "\e[0;32m Add MariaDB Repo \e[0m"
sleep 2


echo -e "\e[0;32m Install Compiler\Build Tools \e[0m"
sleep 2
yum install make patch gcc perl-Term-ReadLine-Gnu gcc-c++ subversion php php-devel php-gd gd-devel php-mbstring php-mcrypt php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc php-opcache curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel httpd libpcap libpcap-devel libnet ncurses ncurses-devel screen mysql-devel ntp mutt glibc.i686 wget nano unzip sipsak sox libss7* libopen* openssl libsrtp libsrtp-devel unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel htop iftop -y

yum install make patch gcc perl-Term-ReadLine-Gnu gcc-c++ subversion php php-devel php-gd gd-devel php-mbstring php-mcrypt php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel httpd libpcap libpcap-devel libnet ncurses ncurses-devel screen mysql-devel ntp mutt glibc.i686 wget nano unzip sipsak sox libss7* libopen* openssl libsrtp libsrtp-devel unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel -y

# part 3
echo -e "\e[0;32m Install and configure MariaDB\SQL \e[0m"
sleep 2
yum -y install sqlite-devel
yum install mariadb-server mariadb -y

echo -e "\e[0;32m Create mysql Log files \e[0m"
sleep 2
mkdir /var/log/mysqld
mv /var/log/mysqld.log /var/log/mysqld/mysqld.log
touch /var/log/mysqld/slow-queries.log
chown -R mysql:mysql /var/log/mysqld

echo -e "\e[0;32m Backup Orig my.cnf file \e[0m"
sleep 2
\cp -r /etc/my.cnf /etc/my.cnf.original
echo "" > /etc/my.cnf
#vi /etc/my.cnf

echo -e "\e[0;32m Create new my.cnf file \e[0m"
sleep 2
cat <<MYSQLCONF>> /etc/my.cnf
[mysql.server]
user = mysql
#basedir = /var/lib
[client]
port = 3306
socket = /var/lib/mysql/mysql.sock
[mysqld]
datadir = /var/lib/mysql
bind-address = 127.0.0.1
socket = /var/lib/mysql/mysql.sock
user = mysql
old_passwords = 0
ft_min_word_len = 3
max_connections = 800
max_allowed_packet = 32M
skip-external-locking
sql_mode="NO_ENGINE_SUBSTITUTION"
log-error = /var/log/mysqld/mysqld.log
query-cache-type = 1
query-cache-size = 32M
long_query_time = 1
#slow_query_log = 1
#slow_query_log_file = /var/log/mysqld/slow-queries.log
tmp_table_size = 128M
table_cache = 1024
join_buffer_size = 1M
key_buffer = 512M
sort_buffer_size = 6M
read_buffer_size = 4M
read_rnd_buffer_size = 16M
myisam_sort_buffer_size = 64M
max_tmp_tables = 64
thread_cache_size = 8
thread_concurrency = 8
# If using replication, uncomment log-bin below
#log-bin = mysql-bin
[mysqldump]
quick
max_allowed_packet = 16M
[mysql]
no-auto-rehash
[isamchk]
key_buffer = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M
[myisamchk]
key_buffer = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M
[mysqlhotcopy]
interactive-timeout
[mysqld_safe]
#log-error = /var/log/mysqld/mysqld.log
#pid-file = /var/run/mysqld/mysqld.pid
MYSQLCONF

##or Change my.cnf config using file
echo -e "\e[0;32m Download httpd.conf file from git \e[0m"
sleep 2
\cp -r /etc/my.cnf /etc/my.cnf.original
echo "" > /etc/my.cnf
wget -O /etc/my.cnf https://raw.githubusercontent.com/jaganthoutam/vicidial-install-scripts/main/my.cnf


echo -e "\e[0;32m Configure Httpd\Apache2 \e[0m"
sleep 2
## convert it to sed injection
vi +217 /etc/httpd/conf/httpd.conf
--replace --
CustomLog logs/access_log combined
--with --
CustomLog /dev/null common

#--goto Last line by typing ctrl+c and shift+g---
Alias /RECORDINGS "/var/spool/asterisk/monitorDONE/"
<Directory "/var/spool/asterisk/monitorDONE/">
Options Indexes MultiViews
AllowOverride None
Require all granted
</Directory>

##or Change Httpd\Apache2 config using file
echo -e "\e[0;32m Donwload httpd.cof file from git \e[0m"
sleep 2
wget -O /etc/httpd/conf/httpd.conf https://raw.githubusercontent.com/jaganthoutam/vicidial-install-scripts/main/httpd.conf


echo -e "\e[0;32m Configure PHP \e[0m"
sleep 2
## convert it to sed injection
vi /etc/php.ini
#--search and edit below settings --
error_reporting = E_ALL & ~E_NOTICE
memory_limit = 48M
short_open_tag = On
max_execution_time = 330
max_input_time = 360
post_max_size = 48M
upload_max_filesize = 42M
default_socket_timeout = 360
date.timezone = Asia/Kolkata

#or Change PHP config using file
echo -e "\e[0;32m Download the PHP ini file from Git \e[0m"
sleep 2
#wget -O /etc/php.ini https://raw.githubusercontent.com/jaganthoutam/vicidial-install-scripts/main/php.ini

#create auto redirect to welcome.php
touch /var/www/html/index.html
echo "" > /var/www/html/index.html
sed -i -e '$a\
<META HTTP-EQUIV=REFRESH CONTENT="1; URL=/vicidial/welcome.php"> \
Please Hold while I redirect you! \
' /var/www/html/index.html

echo -e "\e[0;32m Enable and start Httpd and MariaDb services \e[0m"
sleep 2
systemctl enable httpd.service
systemctl enable mariadb.service
systemctl start httpd.service
systemctl start mariadb.service
systemctl status mariadb.service
systemctl status httpd.service

