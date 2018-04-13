#!/bin/bash
cat /var/log/auth.log|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"="$1;}'>/root/black.list
DEFINE="5"
for i in `cat /root/black.list`
do 
IP=`echo $i|awk -F= '{print $1}'`
NUM=`echo $i|awk -F= '{print $2}'`
if [ $NUM -gt $DEFINE ];
then
echo	"sshd:$IP">>/etc/hosts.deny
fi
done
rm /root/black.list

