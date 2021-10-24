#!/bin/bash

podname="nginx-pvc-pod"
clstnum=`echo ${1} |cut -d'r' -f2`


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" &2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out1="$?"

if [ ${out1} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/data")]}' |grep -w "/data"`
out2="$?"
if [ ${out2} = 0 ]; then
checkmntsize=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pvc pvc"$clstnum"-data -o jsonpath='{.spec.resources.requests.storage}' |grep 50Mi`
out1="$?"
if [ ${out1} = 0 ]; then
echo "Storage Request size also correct on pod "$podname""$clstnum" in "$1""
out3="0"
else
echo "Storage Request size not correct on pod "$podname""$clstnum" in "$1""
out3="1"
fi	
else
echo "mount path on pod "$podname""$clstnum" is not not correct on "$1""
out3="1"
fi	
else
echo "pod "$podname""$clstnum" is not in running stat on "$1""
out3="1"
fi

else
echo "pod "$podname""$clstnum" not found on "$1""
out3="1"
fi	
