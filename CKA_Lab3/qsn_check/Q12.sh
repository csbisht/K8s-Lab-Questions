#!/bin/bash

podname="sa-test"
saname="admin"
clstnum=`echo ${1} |cut -d'r' -f2`

checkpodstatus=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" |grep -w Running`
out3="$?"

if [ "${out3}" = 0 ]; then
checksapod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname""$clstnum" -o jsonpath='{.spec.serviceAccount}' |grep -w "$saname""$clstnum"`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "service account not found on pod "$podname""$clstnum""
out3="1"
else
echo "service account found on pod "$podname""$clstnum""
out3="0"
fi

else
echo "pod "$podname""$clstnum" is not ready or not available on "$1""
out3="1"
fi
