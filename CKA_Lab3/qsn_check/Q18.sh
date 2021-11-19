#!/bin/bash

deployname="web-nginx"
filelocation="/opt/K8sLab/Lab3"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f "${filelocation}"/ClusterIP-"${1}".svc ]; then
checksvc=`cat "${filelocation}"/ClusterIP-"${1}".svc |grep -w default.svc.cluster.local`
out3="$?"

if [ "${out3}" = 0 ]; then
echo "file "${filelocation}"/ClusterIP-"${1}".svc output matched"
out3="0"
else
echo "file "${filelocation}"/ClusterIP-"${1}".svc output not matched"
out3="1"
fi

else
echo "file "${filelocation}"/ClusterIP-"${1}".svc not found"
out3="1"
fi

