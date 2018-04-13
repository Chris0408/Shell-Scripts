#!/bin/bash
# a menu for creat sftp server
function version {
 clear 
 ssh -V
 echo "ssh版本必须高于4.8"
}


function addgroup {
 clear
 read -p "new sftp group  name:" groupname
 groupname="$groupname"
 egrep "^$groupname" /etc/group >& /dev/null  
 if [ $? -ne 0 ]
 then
 groupadd $groupname
 else
 echo "The group is already exist !  Please try again！"
 fi
}


function adduser {
 clear
 read -p "new sftp user name:" username
 username="$username"
 egrep "^$username" /etc/passwd >& /dev/null
 if [ $? -ne 0 ]
 then
 useradd -g $groupname $username
 else
 echo "The user is already exist !  Please try again! "
 fi
 read -p "sftp rootdir:" rootdir
 rootdir="$rootdir"
 userdir="/$rootdir/$username"
 if [ ! -d "$userdir" ];
  then
  mkdir -p  $userdir
  else
  echo "$rootdir is already exist ! Please try again!"
 fi
 usermod -d $userdir $username
}


function set_user_password {
 clear
 passwd $username
}


function addsubdir {
 clear
 read -p "user subdir:" subdir
 subdir="$subdir"
 mkdir -p $userdir/$subdir
}


function change_config_file {
 sed -i 's/Subsystem sftp \/usr\/lib\/openssh\/sftp-server/#Subsystem sftp \/usr\/lib\/openssh\/sftp-server/g' /etc/ssh/sshd_config
 cat config.txt >> /etc/ssh/sshd_config
}

function change_user_permissions {
 chown -R root:sftp  $userdir
 chmod 775 $userdir/$subdir
}
 
function restartsshd {
 clear
 service sshd restart
} 


function menu {
  clear 
  echo
  echo -e "\t\t Creat sftp server Menu"
  echo -e "\t1. Display sshd version"
  echo -e "\t2. Add sftp group"
  echo -e "\t3. Add sftp user"
  echo -e "\t4. Set sftp user's password"
  echo -e "\t5. Add sftp user's subdir"
  echo -e "\t6. Change config file"
  echo -e "\t7. change user permissions"
  echo -e "\t8. Restart service"
  echo -e "\t0. Exit program\n\n"
  echo -en "\tEnter option: "
  read -n 1 option
}


while [ 1 ]
do
 menu

 case $option in
 0)
   break ;;
 1)
   version ;;
 2)
   addgroup ;;
 3)
   adduser ;;
 4)
   set_user_password ;;
 5)
   addsubdir;;
 6)
   change_config_file;;
 7)
   change_user_permissions;;
 8)
   restartsshd;;
 *)	
   clear
   echo "Sorry.wrong selection" ;;
 esac

 echo -en "\n\n\t\t\tPress any key to continue: "
 read -n 1 line

done
clear
