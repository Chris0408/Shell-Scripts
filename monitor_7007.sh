curl -I 10.10.20.35:7007>header.txt
status=`awk 'NR==1{print}' header.txt |awk -F " " '{print $2}'`
if [ ! -s header.txt ];then
cd /Users/user/ss/7007/
expect 7007.sh
rm /Users/user/header.txt
elif [ "$status" -ne 200 ];then
cd /Users/user/ss/7007/
expect 7007.sh
rm /Users/user/header.txt
else
rm /Users/user/header.txt
exit 0
fi
