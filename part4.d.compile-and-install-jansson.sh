#!/bin/sh

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

