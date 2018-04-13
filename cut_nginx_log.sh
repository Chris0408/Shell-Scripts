#!/bin/bash
dateformat=`date +%Y%m%d`
nginx_logdir="/var/log/nginx/"
logname="access.log"
[ -d $nginx_logdir ] && cd $nginx_logdir||exit 1
[ -f $logname  ]||exit 1
mv $logname "$dateformat"_"$logname"
/usr/sbin/nginx -s reload
