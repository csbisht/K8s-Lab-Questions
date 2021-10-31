#!/bin/bash

podname="nginx-mnt"
clstnum=`echo ${1} |cut -d'r' -f2`


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out1="$?"

if [ ${out1} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/var/log/nginx")]}' |grep -w "/var/log/nginx"`
out2="$?"

if [ ${out2} -gt 0 ]; then
echo "mount path on pod "$podname""$clstnum" is not correct on "$1""
out3="1"
else
echo "found mount path on pod "$podname""$clstnum" on "$1""
out3="0"
fi

else
echo "pod "$podname""$clstnum" is not in running stat on "$1""
out3="1"
fi

else
echo "pod "$podname""$clstnum" not found on "$1""
out3="1"
fi	
