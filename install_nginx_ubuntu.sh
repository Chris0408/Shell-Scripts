#!/bin/bash
wget https://nginx.org/keys/nginx_signing.key 
sudo apt-key add nginx_signing.key
Codename=`lsb_release -c |awk '{print $2}'`
echo "deb http://nginx.org/packages/ubuntu/ $Codename nginx">>/etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ $Codename nginx">>/etc/apt/sources.list
apt-get update
apt-get install nginx


