#!/bin/bash

podname="redispod"
eventfile="/opt/K8sLab/Lab3/events_redispod-cluster"
clstnum=`echo ${1} |cut -d'r' -f2`

checkpodstatus=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" |grep -w Running`
out3="$?"

if [ "${out3}" = 0 ]; then
checkpodevent=`cat "$eventfile""$clstnum".txt |grep -w "$podname"`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "no events found on "$eventfile""$clstnum".txt for pod $podname"
out3="1"
else
echo "pod $podname event found on "$eventfile""$clstnum".txt"
out3="0"
fi

else
echo "pod $podname is not ready on "$1""
out3="1"
fi
