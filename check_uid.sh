#!/bin/bash

a=`awk -F : '$3==0' /etc/passwd |grep -v root`>>a.txt
if [ -z "$a" ] 
	then
 	echo "There isn't user's UID is 0 except root!"
else
	echo $a>a.txt
	cat a.txt|sed 's/ /\n/g'>a1.txt
	rm   a.txt
fi
	cat a1.txt|while read line
	do 
		i=1000
		sed 's/0/"$i++"/g'
	done
	rm a1.txt
