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

yum -y install wget git unzip net-tools expect bash-completion bash-completion-extras

wget -O ./Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server.zip https://github.com/ashloverscn/Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server/archive/refs/heads/main.zip

unzip ./Vicidial-Scratch-Install-*

rm -rf ./Vicidial-Scratch-Install-*.zip

mv ./Vicidial-Scratch-Install-*/* ./

rm -rf ./Vicidial-Scratch-Install-*

chmod +x *.sh

pwd

###########################################################################################################
timedatectl set-timezone Asia/Kolkata
./part0.*.sh
./part1.*.sh
./part2.*.sh
./part3.*.sh
./part4.a.*.sh
./part4.b.*.sh
./part4.c.*.sh
./part4.d.*.sh
./part4.e.*.sh
./part5.a.*.sh
./part5.b.*.sh
./part6.*.sh
./part7.*.sh
./part8.*.sh
./part9.a.*.sh
./part9.b.*.sh
./part10.*.sh










