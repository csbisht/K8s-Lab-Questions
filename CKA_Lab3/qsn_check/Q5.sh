#!/bin/bash

deploymentname="nginx-web"
clstnum=`echo "${1}" |cut -d'r' -f2`
imagename="nginx:1.18"

checkdeployment=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" 2> /dev/null`
out3="$?"

if [ "${out3}" = 0 ]; then

checkimage=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" -o yaml |grep -w "image: ${imagename}"`
out2="$?"
if [ "${out2}" = 0 ]; then
checkreplica=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods |grep "${deploymentname}${clstnum}" |wc -l`
if [ "${checkreplica}" -lt 3 ]; then
echo "replicas not scaled to 3"
out3="1"
else
echo "image and replicas are correct"
out3="0"	
fi
else
echo "undo deploy image not found"
out3="1"	
fi

else
echo "deployment "${deploymentname}""${clastnum}" not found on "$1""
out3="1"
fi
