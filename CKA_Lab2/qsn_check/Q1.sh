#!/bin/bash

podname="admin-pod"
sleeptime="3500"
systime="SYS_TIME"

check1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].command}' |grep -w "$sleeptime"`
out1="$?"

check2=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.containers[*].securityContext.capabilities.add}' |grep -w "$systime"`
out2="$?"

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" |grep -w "$podname"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ] && [ "${out2}" -gt 0 ]; then
echo "command or capabilities not found in pod"
fi
else
echo "pod "$podname" not found on "$1""
fi
