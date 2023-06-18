#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
RESET='\033[0m'
sec=11
tput civis
echo -ne "${GREEN}"

while [ $sec -ge 0 ]; do
echo -ne "$(printf "%02d" $sec):$(printf "%02d" $sec):$(printf "%02d" $sec)\0
let "sec=sec-1"
sleep 1
done

#clear

#echo -e "\e[0;32m Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server \e[0m"
echo -e "\e[0;32m INSTALLATION WILL START IN 10 SECONDS \e[0m"

#for i in {10..01}
#do
#tput cup 10 $l
#echo -n "$i"
#sleep 1
#done
#echo

#sleep 2

