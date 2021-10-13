#!/bin/bash

podname="pod-multi"
sleeptime="5800"
contname1="nginx"
contname2="busybox"

check1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].command}' |grep -w "$sleeptime"`
out1="$?"

checkcontname=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].name}' |grep -w "$contname1 $contname2"`
out2="$?"

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" |grep -w "$podname"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ]; then
echo "command not found in pod"
out3="1"
else
if [ "${out2}" -gt 0 ]; then
echo "containers name not found in pod"
out3="1"
fi	
fi
else
echo "pod "$podname" not found on "$1""
out3="1"
fi
