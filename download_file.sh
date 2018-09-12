#!/bin/bash
url=$1
dirname=$2
download()
	{
		if [[ ! -d $dirname ]];then
			read -p "$dirname,no such directory,creat?(y/n)" answer
			if [[ $answer == y ]];then
				mkdir -p $dirname
			else
				return "51"
			fi
		fi
		cd $dirname && wget $url >/dev/null 2>&1
		if [[ $? != 0 ]];then
			return "52"
		fi
		return 0
	}
download $url $dirname
echo $?
