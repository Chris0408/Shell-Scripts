#! /bin/bash
version=$1
if [[ -z $1 ]]; then
	echo "请输入版本号, 如: 1.0"
	exit 1
fi
#替换docker-compose文件中第4行中有关镜像版本的关键字
sed -i "4s/scmjd:.*$/scmjd:$version/" docker-compose.yml
docker-compose up -d
