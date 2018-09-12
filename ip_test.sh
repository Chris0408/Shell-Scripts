#!/bin/bash
# 判断192.168.0.x/24网段内，在线的主机数，能ping通则代表在线。
for i in `seq 1 255`
  do 
   `ping -c 1 192.168.0.$i >/dev/null 2>&1`
   if [ $? -ne 0 ] 
    then
         echo "192.168.0.$i is down">>down.txt
    else
         echo "192.168.0.$i is UP">>up.txt
   fi
  done
