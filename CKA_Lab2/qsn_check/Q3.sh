#!/bin/bash

podname="test-pod"
sleeptime="4800"
systime="SYS_TIME"
netadmin="NET_ADMIN"


checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" |grep -w "$podname"`
out3="$?"

if [ "${out3}" = 0 ]; then
check1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].command}' |grep -w "$sleeptime"`
out1="$?"

if [ "${out1}" = 0 ]; then
check2=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].securityContext.capabilities.add}' |grep -w "$systime"`
out2="$?"
if [ "${out2}" = 0 ]; then
checknetadmin=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].securityContext.capabilities.add}' |grep -w "$netadmin"`
out2_3="$?"
if [ "${out2_3}" -gt 0 ]; then
echo "capabilities NET_ADMIN not found in pod"
out3="1"
else
echo "capabilities found in pod"
out3="0"	
fi
else
echo "capabilities SYS_TIME not found in pod"
out3="1"
fi
else	
echo "command not found in pod"
out3="1"
fi

else
echo "pod "$podname" not found on "$1""
fi
