#!/bin/bash

filelocation="/opt/K8sLab/Lab3"
filename="NodePort-"

if [ -f "${filelocation}"/"${filename}""${1}".wget ]; then
checkfile=`cat "${filelocation}"/"${filename}""${1}".wget |grep -w '<title>Welcome to nginx!</title>'`
out3="$?"

if [ "${out3}" = 0 ]; then
echo "file "${filelocation}"/"${filename}""${1}".wget output matched"
out3="0"
else
echo "file "${filelocation}"/"${filename}""${1}".wget output not matched"
out3="1"
fi

else
echo "file "${filelocation}"/"${filename}""${1}".wget not found"
out3="1"
fi

