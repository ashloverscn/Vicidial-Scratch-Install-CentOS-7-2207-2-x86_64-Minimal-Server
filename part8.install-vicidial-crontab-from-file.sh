#Install crontab entry from file
cd /usr/src
\cp -r /usr/src/vici-cron /usr/src/vici-cron.original 
wget -O /usr/src/vici-cron https://github.com/ashloverscn/Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server/raw/main/vici-cron
crontab -l > vici-cron.original
crontab < vici-cron

