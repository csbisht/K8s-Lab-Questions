#!/bin/bash

deploymentname="web-00"
clstnum=`echo "${1}" |cut -d'r' -f2`
imagename="nginx:1.18"

checkrecord=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config rollout history deployment/"${deploymentname}""${clstnum}" |grep -w "nginx=${imagename}"`
out1="$?"

checkimage=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" -o yaml |grep -w "image: ${imagename}"`
out2="$?"

checkreplica=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods |grep "${deploymentname}${clstnum}" |wc -l`

checkdeployment=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}"`
out4="$?"

if [ "${out4}" = 0 ]; then
if [ "${out1}" -gt 0 ] && [ "${out2}" -gt 0 ]; then
echo "rollout history or deploy image not found"
out3="1"
else
#echo "rollout history or deploy image found or replicas scaled to 3"	
if [ "${checkreplica}" -lt 3 ]; then
echo "replicas not scaled to 3"
out3="1"
fi
fi
else
echo "deployment "${deploymentname}""${clastnum}" not found on "$1""
out3="1"
fi
