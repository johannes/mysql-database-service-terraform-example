#!/bin/sh
cd /tmp
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo rpm -i mysql80-community-release-el7-3.noarch.rpm
sudo yum update
sudo yum install -y mysql-shell
