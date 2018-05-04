#!/bin/bash
cat image_name.txt|while read line
do
	project=${line}
	curl  $registryurl/v2/$project/tags/list|cut -d : -f 3 >>tags.txt
done
sed -i "s/\[//g" tags.txt
sed -i "s/\]//g" tags.txt
sed -i "s/\}//g" tags.txt
cat tags.txt | sed 's/,/\n/g'>>tags1.txt
cat tags1.txt| sed '/"/s/"//g'>>newtags.txt
rm tags.txt
rm tags1.txt


i=0
t=`cat image_name.txt|wc -l`
n=0
array=()
cat image_name.txt|while read line
do
	array[$i]=${line}
	i=`expr $i + 1`
	n=`expr  $n + 1`
	if [ $n -eq $t ];then
		break
	fi
done

cat newtags.txt|while read line
m=0
do
	tags=${line}
    project=${array[m]}
	curl --header "Accept: application/vnd.docker.distribution.manifest.v2+json" -I -X HEAD $registryurl/v2/$project/manifests/$tags | grep Digest >>sha256.txt
	m=`expr  $m + 1`
done
cat sha256.txt |sed 's/Docker-Content-Digest: //g'>>sha.txt
rm sha256.txt
j=0
cat sha.txt|while read line
do
    sha256=${line}
    project=${array[j]}
    curl -X DELETE $registryurl/v2/$project/manifests/${sha256%?}
    j=`expr $j+1`
done
rm sha.txt
rm newtags.txt
echo "DELETE successful"

