#! /bin/bash
function changeserver {
 read -p "please input server verison:" version
 serverversion="$version"
 sed -i "4s/scmjd:.*$/scmjd:$serverversion-test/" docker-compose.yml
}
function rubyapi {
 read -p "please input rubyapi verison:" version
 apiversion="$version"
 sed -i "17s/jdruby:.*$/jdruby:$apiversion-tjd/" docker-compose.yml
}
function start {
 docker-compose up -d
}
echo "----------------------------------"
echo "please enter your choise:"
echo "(1) Update server"
echo "(2) Update rubyapi"
echo "(3) Update web"
echo "----------------------------------"
read input
case $input in
    1)
    changeserver
    start ;;
    2)
    rubyapi
    start ;;
    3)
    echo ToDo
    start ;;
    *)
   echo "Sorry.wrong selection" ;;
esac
