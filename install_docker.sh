#!/bin/bash
####install

apt-get remove docker docker-engine docker.io
apt-get update
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt-get update
apt-get install docker-ce

####add mirror path
systemct enable docker
line=`cat /etc/systemd/system/multi-user.target.wants/docker.service|grep "ExecStart=" `
mirrorURL="ExecStart=/usr/bin/dockerd --registry-mirror=https://registry.docker-cn.com"
sed -i 's/$line/$mirrorURL/g'  /etc/systemd/system/multi-user.target.wants/docker.service
systemctl daemon-reload
systemctl restart docker
ps -ef | grep dockerd

