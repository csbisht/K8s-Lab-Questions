#!/bin/bash

podname="web-pvc-pod"
clstnum=`echo ${1} |cut -d'r' -f2`


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out1="$?"

if [ ${out1} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/log")]}' |grep -w "/log"`
out2="$?"
if [ ${out2} = 0 ]; then
echo "mount path on pod "$podname""$clstnum" is correct on "$1""
out3="0"	
else
echo "mount path on pod "$podname""$clstnum" is not correct on "$1""
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
