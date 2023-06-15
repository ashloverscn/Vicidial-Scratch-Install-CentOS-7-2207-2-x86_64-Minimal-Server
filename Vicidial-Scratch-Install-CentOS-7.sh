#!/bin/sh

echo -e "\e[0;32m Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server \e[0m"
sleep 5

export LC_ALL=C

# part 0
#we will later blow holes in the firewall for now its off
systemctl disable firewalld
systemctl stop firewalld


# part 1
echo -e "\e[0;32m Update install kernel-sources epl-release compiler tools \e[0m"
sleep 2
yum check-update
yum update -y
yum -y install epel-release
yum -y groupinstall 'Development Tools'
yum -y update
yum install -y kernel*

echo -e "\e[0;32m Disable SeLinux \e[0m"
sleep 2
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo -e "\e[0;32m Set TimeZone Asia/Kolkata \e[0m"
sleep 2
timedatectl set-timezone Asia/Kolkata

#set a lock file if not present then reboot 
#reboot

# part 2
echo -e "\e[0;32m Install RemiRepo PHP7 \e[0m"
sleep 2
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php74

echo -e "\e[0;32m Add MariaDB Repo \e[0m"
sleep 2
#vi /etc/yum.repos.d/MariaDB.repo
touch /etc/yum.repos.d/MariaDB.repo
echo "" > /etc/yum.repos.d/MariaDB.repo

cat <<MARIADBREPO>> "" > /etc/yum.repos.d/MariaDB.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
MARIADBREPO

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


echo -e "\e[0;32m Enable and start Httpd and MariaDb services \e[0m"
sleep 2
systemctl enable httpd.service
systemctl enable mariadb.service
systemctl start httpd.service
systemctl start mariadb.service
systemctl status mariadb.service
systemctl status httpd.service


echo -e "\e[0;32m Install and Configure Perl-CPAN\Perl-CPAN-Modules \e[0m"
sleep 2
yum install perl-CPAN -y
yum install perl-YAML -y
yum install perl-libwww-perl -y
yum install perl-DBI -y
yum install perl-DBD-MySQL -y
yum install perl-GD -y

cd /usr/bin/
cpan App::cpanminus 
#cpanm --installdeps .
curl -LOk http://xrl.us/cpanm
chmod +x cpanm
cpanm -f File::HomeDir
cpanm -f File::Which
cpanm CPAN::Meta::Requirements
cpanm -f CPAN
cpanm YAML
cpanm MD5
cpanm Digest::MD5
cpanm Digest::SHA1
#cpanm readline --force
cpanm Bundle::CPAN
cpanm DBI
cpanm -f DBD::mysql
cpanm Net::Telnet
cpanm Time::HiRes
cpanm Net::Server
cpanm Switch
cpanm Mail::Sendmail
cpanm Unicode::Map
cpanm Jcode
cpanm Spreadsheet::WriteExcel
cpanm OLE::Storage_Lite
cpanm Proc::ProcessTable
cpanm IO::Scalar
cpanm Spreadsheet::ParseExcel
cpanm Curses
cpanm Getopt::Long
cpanm Net::Domain
cpanm Term::ReadKey
cpanm Term::ANSIColor
cpanm Spreadsheet::XLSX
cpanm Spreadsheet::Read
cpanm LWP::UserAgent
cpanm HTML::Entities
cpanm HTML::Strip
cpanm HTML::FormatText
cpanm HTML::TreeBuilder
cpanm Time::Local
cpanm MIME::Decoder
cpanm Mail::POP3Client
cpanm Mail::IMAPClient
cpanm Mail::Message
cpanm IO::Socket::SSL
cpanm MIME::Base64
cpanm MIME::QuotedPrint
cpanm Crypt::Eksblowfish::Bcrypt
cpanm Crypt::RC4
cpanm Text::CSV
cpanm Text::CSV_XS
cpanm readline --force


echo -e "\e[0;32m Install Asterisk Perl \e[0m"
sleep 2
cd /usr/src
wget http://download.vicidial.com/required-apps/asterisk-perl-0.08.tar.gz
tar xzf asterisk-perl-0.08.tar.gz
cd asterisk-perl-0.08
perl Makefile.PL
make all
make install


echo -e "\e[0;32m Install SIPSack \e[0m"
sleep 2
cd /usr/src
wget http://download.vicidial.com/required-apps/sipsak-0.9.6-1.tar.gz
tar -zxf sipsak-0.9.6-1.tar.gz
cd sipsak-0.9.6
./configure
make
make install
/usr/local/bin/sipsak --version
sipsak --version


echo -e "\e[0;32m Install Lame \e[0m"
sleep 2
cd /usr/src
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar -zxf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure
make
make install


echo -e "\e[0;32m Install Jansson \e[0m"
sleep 2
cd /usr/src/
wget http://www.digip.org/jansson/releases/jansson-2.5.tar.gz
tar -zxf jansson-2.5.tar.gz
#tar xvzf jasson*
cd jansson*
./configure
make clean
make
make install
ldconfig



echo -e "\e[0;32m Install Eaccelerator - Maybe not nescessasy \e[0m"
sleep 2
cd /usr/src
wget https://github.com/eaccelerator/eaccelerator/zipball/master -O eaccelerator.zip
unzip eaccelerator.zip
cd eaccelerator-*
export PHP_PREFIX="/usr"
$PHP_PREFIX/bin/phpize
./configure --enable-eaccelerator=shared --with-php-config=$PHP_PREFIX/bin/php-config
make
make install

mkdir /tmp/eaccelerator
chmod 0777 /tmp/eaccelerator
php -v


echo -e "\e[0;32m Install Dahdi Audio_CODEC Driver \e[0m"
sleep 2
cd /usr/src
#yum remove dahdi* -y
yum install dahdi* -y
yum install dahdi-tools* -y
wget http://download.vicidial.com/beta-apps/dahdi-linux-complete-2.11.1.tar.gz
tar -xvzf dahdi-linux-complete-*
cd dahdi-linux-complete-*
make all
make install
make config
modprobe dahdi
modprobe dahdi_dummy
dahdi_genconf -v
dahdi_cfg -v


echo -e "\e[0;32m Install LibPri \e[0m"
sleep 2
cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
tar -xvzf libpri-*
cd libpri*
make
make install


echo -e "\e[0;32m Install Asterisk \e[0m"
sleep 2
cd /usr/src
#yum remove asterisk* -y
yum install asterisk* -y
wget http://download.vicidial.com/required-apps/asterisk-13.29.2-vici.tar.gz
#wget http://download.vicidial.com/beta-apps/asterisk-16.17.0-vici.tar.gz
tar -xvzf asterisk-1*
cd asterisk-*
./configure --libdir=/usr/lib64 --with-gsm=internal --enable-opus --enable-srtp --with-ssl --enable-asteriskssl --with-pjproject-bundled --with-jansson-bundled
make menuselect

# sed inject this
#--- select app_meetme under applications
#---select res_http_websocket, res_srtp from Resources Modules
#---- save exit. Press ESC and press shift S

make
make install
make samples

