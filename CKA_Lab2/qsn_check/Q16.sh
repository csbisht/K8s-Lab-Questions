#!/bin/bash

podname="sec-context"
grpname="fsGroup"
asusername="runAsUser"
asgrpname="runAsGroup"

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" &> /dev/null`
out3="$?"

if [ "${out3}" = 0 ]; then
getpodsec=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.securityContext}' |grep -w "$grpname" |grep -w "2000" |grep -w "$asusername" |grep -w "1000" |grep -w "$asgrpname" |grep -w "3000"`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "securityContext not available in pod $podname on $1"
out3="1"
else
echo "securityContext available in pod $podname on $1"
out3="0"	
fi

else
echo "Pod $podname not found on $1"
out3="1"
fi
