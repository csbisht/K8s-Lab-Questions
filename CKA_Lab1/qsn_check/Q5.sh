#!/bin/bash

podname="web-load-"
labelname="tier=web"
clstnum=`echo ${1} |cut -d'r' -f2`

check1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods -l "$labelname"`
out1="$?"


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" |grep -w "$podname""$clstnum"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ]; then
echo "Label $labelname not found in pod "$podname""$clstnum""
out3="1"
fi
else
echo "pod "$podname""$clstnum" not found on "$1""
out3="1"
fi
