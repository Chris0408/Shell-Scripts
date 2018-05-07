#!/bin/bash
code_status=`curl -i -m 15 -o /dev/null -s -w %{http_code} 192.168.3.23:7007`
if [ $code_status -ne 200 ]
then
  expect /root/ss/7007.sh
else
  exit
fi
