#!/bin/bash

podname="web-app"
svcname="web-app-svc"
filelocation="/opt/K8sLab/Lab1"

if [ -f "${filelocation}"/"${podname}"-"${1}".svc ]; then
checksvc=`cat "${filelocation}"/"${podname}"-"${1}".svc |grep -w web-app-svc.default.svc.cluster.local`
out3="$?"

if [ "${out3}" = 0 ]; then

if [ -f "${filelocation}"/"${podname}"-"${1}".pod ]; then
checkpod=`cat "${filelocation}"/"${podname}"-"${1}".pod |grep -w web-app-svc.default.svc.cluster.local`
out1="$?"

if [ "${out1}" = 0 ]; then
echo "file "${filelocation}"/"${podname}"-"${1}".pod output matched"	
out3="0"
else
echo "file "${filelocation}"/"${podname}"-"${1}".pod not found"
out3="1"	
fi

else
echo "file "${filelocation}"/"${podname}"-"${1}".pod output not matched"
out3="1"
fi

else
echo "file "${filelocation}"/"${podname}"-"${1}".svc output not matched"
out3="1"
fi

else
echo "file "${filelocation}"/"${podname}"-"${1}".svc not found"
out3="1"
fi

