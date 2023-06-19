#!/bin/sh

echo -e "\e[0;32m Update install kernel-sources epl-release compiler tools \e[0m"
sleep 2
yum check-update
yum update -y
yum -y install epel-release
yum -y groupinstall 'Development Tools'
yum -y update
yum install -y kernel-*

echo -e "\e[0;32m Disable SeLinux \e[0m"
sleep 2
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo -e "\e[0;32m Set TimeZone Asia/Kolkata \e[0m"
sleep 2
timedatectl set-timezone Asia/Kolkata

reboot

