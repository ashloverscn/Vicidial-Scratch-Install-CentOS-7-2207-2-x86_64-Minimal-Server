#!/bin/sh

cd /usr/src
cd asterisk-*
make
make install
make samples
