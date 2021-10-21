#!/bin/bash

podname="pod-test"

labelname1="env=dev"
labelname2="env=stg"
labelname3="env=prod"
labelcommon="tier=front"
namespace="account"

clstnum=`echo ${1} |cut -d'r' -f2`

funcheck () {
checklabel=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/cluster"$clstnum".config get pod "$1" -n "$namespace" --show-labels |grep -w "$2,$labelcommon"`
out1="$?"

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/cluster"$clstnum".config get pod "$1" -n "$namespace" |grep -w "$1"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ]; then
echo "Label $2 not found in pod $1"
out3="1"
fi
else
echo "pod $1 not found on cluster"$clstnum""
out3="1"
fi

}

if [ "${1}" = "cluster1" ]; then
funcheck "${podname}""$clstnum" ${labelname1}

elif [ "${1}" = "cluster2" ]; then
funcheck "${podname}""$clstnum" ${labelname2}

elif [ "${1}" = "cluster3" ]; then
funcheck "${podname}""$clstnum" ${labelname3}

else
echo "cluster not declare"
out3="1"
fi



