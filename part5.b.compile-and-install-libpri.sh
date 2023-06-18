#!/bin/sh

echo -e "\e[0;32m Install LibPri \e[0m"
sleep 2
cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
tar -xvzf libpri-*
cd libpri*
make
make install

