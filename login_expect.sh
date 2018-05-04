#!/usr/bin/expect
set timeout 30
spawn ssh -f -N -L 10.10.20.35:7007:10.10.20.203:80 root@10.10.20.177 >/dev/null 2>&1 &
expect "password:"
send "123456\r"
expect eof
