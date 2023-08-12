#!/bin/sh

echo -e "\e[0;32m Install Lame \e[0m"
sleep 2
cd /usr/src
wget http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar -zxf lame-3.100.tar.gz
cd lame-3.100
./configure
make
make install

