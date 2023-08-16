#!/bin/sh

mv /etc/motd /etc/motd.bak
\cp -r /usr/src/motd /etc/motd

cat /etc/ssh/sshd_config | grep "#PrintMotd yes"
cat /etc/ssh/sshd_config | grep "PrintMotd yes"

sed -i "s|#PrintMotd yes|PrintMotd yes|g" /etc/ssh/sshd_config
#sed -i "s|PrintMotd yes|#PrintMotd yes|g" /etc/ssh/sshd_config

rm -rf ~/.hushlogin
#touch ~/.hushlogin


