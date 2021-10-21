#!/bin/bash

podname="dev-load-"
labelname="environment=dev"
clstnum=`echo ${1} |cut -d'r' -f2`

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" |grep -w "$podname""$clstnum"`
out3="$?"

if [ "${out3}" = 0 ]; then
check1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods -l "$labelname"`
out1="$?"	
if [ "${out1}" -gt 0 ]; then
echo "Label $labelname not found in pod "$podname""$clstnum" on "$1""
out3="1"
else
echo "Label $labelname found in pod "$podname""$clstnum" on "$1""
out3="0"	
fi
else
echo "pod "$podname""$clstnum" not found on "$1""
out3="1"
fi
