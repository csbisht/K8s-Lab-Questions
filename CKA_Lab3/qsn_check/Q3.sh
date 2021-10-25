#!/bin/bash

deploymentname="cicd-pod"
clstnum=`echo "${1}" |cut -d'r' -f2`
imagename="jenkins/jenkins:lts"
namespace="cicd"

checkdeployment=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" -n "$namespace"`
out3="$?"

if [ "${out3}" = 0 ]; then
checkreplica=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods -n "$namespace" |grep "${deploymentname}${clstnum}" |wc -l`
if [ "${checkreplica}" = 5 ]; then
checkimage=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" -n "$namespace" -o yaml |grep -w "image: ${imagename}"`
out1="$?"

if [ "${out1}" -gt 0 ]; then
echo "deploy image not found"
out3="1"
else
echo "deploy image found"
out3="0"
fi

else
echo "replicas not scaled to 5"
out3="1"
fi

else
echo "deployment "${deploymentname}""${clastnum}" not found in namespace "$namespace" on "$1""
out3="1"
fi
