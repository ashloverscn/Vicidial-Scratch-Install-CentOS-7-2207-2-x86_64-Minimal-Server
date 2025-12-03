#!/bin/bash
# Fix CentOS 7 repo using Aliyun Vault Mirror
# Removes old repo files and recreates working CentOS-Base.repo

echo "➜ Removing old repo files..."
rm -f /etc/yum.repos.d/*.repo

echo "➜ Creating new CentOS-Base.repo..."

sudo tee /etc/yum.repos.d/CentOS-Base.repo > /dev/null << 'EOF'
[base]
name=CentOS-7 - Base
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/os/$basearch/
enabled=1
gpgcheck=0

[updates]
name=CentOS-7 - Updates
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/updates/$basearch/
enabled=1
gpgcheck=0

[extras]
name=CentOS-7 - Extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/extras/$basearch/
enabled=1
gpgcheck=0

[centosplus]
name=CentOS-7 - Plus
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/centosplus/$basearch/
enabled=1
gpgcheck=0
EOF

echo "➜ Cleaning YUM cache..."
yum clean all

echo "➜ Rebuilding YUM metadata..."
yum makecache

echo "✔ Repo Fix Complete!"
echo "Run: yum repolist"
