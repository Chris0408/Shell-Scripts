#!/bin/bash

####install
yum --version &> /dev/null
if [ $?==0 ];then
	CMD=yum
else
	CMD=apt
fi
case ${CMD} in 
     yum)	
		 yum remove docker docker-common  docker-selinux docker-engine
		 yum install -y yum-utils device-mapper-persistent-data lvm2
		 yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
		 yum makecache fast
		 yum install -y docker-ce
      ;;          
     apt)            
		apt-get remove docker docker-engine docker.io
		apt-get update
		apt-get install  apt-transport-https ca-certificates curl software-properties-common
    	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		apt-key fingerprint 0EBFCD88
		add-apt-repository \
    	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    	$(lsb_release -cs) \
   		stable"
		apt-get update
		apt-get install docker-ce
	;;
esac

####add mirror path
systemctl enable docker
### daocloud mirror
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://02e24992.m.daocloud.io
#line=`cat /etc/systemd/system/multi-user.target.wants/docker.service|grep "ExecStart=" `
#mirrorURL="ExecStart=/usr/bin/dockerd --registry-mirror=https://registry.docker-cn.com"
#sed -i 's/$line/$mirrorURL/g'  /etc/systemd/system/multi-user.target.wants/docker.service
systemctl daemon-reload
systemctl restart docker
ps -ef | grep dockerd
##install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.16.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
