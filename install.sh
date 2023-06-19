#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
RESET='\033[0m'
sec=10

tput civis

echo -e "${YELLOW}"

while [ $sec -gt 0 ]; do
	clear
	let "sec=sec-1"
	echo -ne "${GREEN}"
	echo -e "Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server"
	echo -ne "${YELLOW}"
	echo -e "$(printf "INSTALLATION WILL START IN") $(printf "%02d" $sec) $(printf "SECONDS")\033[0K\r"
	sleep 1
done

echo -e "${RESET}"

tput cnorm

history -c

clear


#################################################################################
cd /usr/src

yum -y check-update

yum -y install wget git unzip tar net-tools

wget -O ./Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server.zip https://github.com/ashloverscn/Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server/archive/refs/heads/main.zip

unzip ./Vicidial-Scratch-Install-*

rm -rf ./Vicidial-Scratch-Install-*.zip

mv ./Vicidial-Scratch-Install-*/* ./

rm -rf ./Vicidial-Scratch-Install-*

chmod +x *.sh

pwd

###########################################################################################################
./part2.install-and-configure-php-mariadb-apache.sh
./part2.wget-install-and-configure-php-mariadb-apache.sh
./part4.a.compile-and-install-asterisk-perl.sh
./part4.b.compile-and-install-sipsak.sh
./part4.c.compile-and-install-lame.sh
./part4.d.compile-and-install-jansson.sh
./part4.e.compile-and-install-eaccelerator.sh
./part5.a.compile-and-install-dahdi.sh
./part5.b.compile-and-install-libpri.sh
./part6.compile-asterisk-make-install-and-samples-menuconfig-automated.sh







