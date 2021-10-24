#!/bin/bash

podname1="nginx-dev"
podname2="nginx-prod"


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname2" &2> /dev/null`
out3="$?"

if [ "${out3}" = 0 ]; then
getnode0taint=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe node "$1"-node0 |grep -w Taints |awk '{print $2}'`
getpodtoleration=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe pod "$podname2" |grep -w "${getnode0taint}"`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "pod $podname2 Tolerations not matched with "$1"-node0"
out3="1"
else
checkpod1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname1" -o jsonpath='{.spec.nodeName}' |grep -w "$1"-controlplane`
out2="$?"
if [ "${out2}" -gt 0 ]; then
echo "pod $podname1 not found or not in "$1"-controlplane"
out3="1"
else
echo "all conditions matched on $1"
out3="0"	
fi
fi

else
echo "Pod $podname2 not found on $1"
out3="1"
fi
