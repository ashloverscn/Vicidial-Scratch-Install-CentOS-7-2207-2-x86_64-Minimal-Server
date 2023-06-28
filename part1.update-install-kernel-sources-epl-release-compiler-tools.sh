#!/bin/sh

echo -e "\e[0;32m Update install kernel-sources epl-release compiler tools \e[0m"
sleep 2
yum check-update
yum -y update
yum -y install epel-release
yum -y groupinstall 'Development Tools'
yum -y install kernel-*
yum -y update

echo -e "\e[0;32m Disable SeLinux \e[0m"
sleep 2
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo -e "\e[0;32m Set TimeZone Asia/Kolkata \e[0m"
sleep 2
timedatectl set-timezone Asia/Kolkata

echo -e "\e[0;32m System updated with new kernel and must be REBOOTED \e[0m"
echo -e "\e[0;32m Please Comment out #wget line and #./part1.*.sh in install.sh and rerun it after this boot\e[0m"
echo -e "\e[0;32m System will REBOOT in 50 Seconds \e[0m"
sleep 50 
reboot

