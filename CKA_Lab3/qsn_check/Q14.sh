#!/bin/bash

podname="nginx-limit"
clstnum=`echo ${1} |cut -d'r' -f2`

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out1="$?"

if [ ${out1} = 0 ]; then
checklimit=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.spec.containers[*].resources}' |grep -w '{"limits":{"cpu":"101m","memory":"101Mi"},"requests":{"cpu":"51m","memory":"51Mi"}}'`
out2="$?"

if [ ${out2} -gt 0 ]; then
echo "resource limit not found in pod "$podname""$clstnum" on "$1""
out3="1"
else
echo "resource limit found in pod "$podname""$clstnum" on "$1""
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
