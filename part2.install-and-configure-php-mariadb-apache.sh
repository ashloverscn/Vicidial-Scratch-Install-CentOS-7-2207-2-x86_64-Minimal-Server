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

##or Change my.cnf config using file
echo -e "\e[0;32m Download httpd.conf file from git \e[0m"
sleep 2
\cp -r /etc/my.cnf /etc/my.cnf.original
echo "" > /etc/my.cnf
wget -O /etc/my.cnf https://raw.githubusercontent.com/jaganthoutam/vicidial-install-scripts/main/my.cnf

echo -e "\e[0;32m Configure Httpd\Apache2 \e[0m"
sleep 2

##or Change Httpd\Apache2 config using file
echo -e "\e[0;32m Donwload httpd.cof file from git \e[0m"
sleep 2
wget -O /etc/httpd/conf/httpd.conf https://raw.githubusercontent.com/jaganthoutam/vicidial-install-scripts/main/httpd.conf

echo -e "\e[0;32m Configure PHP \e[0m"
sleep 2

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

