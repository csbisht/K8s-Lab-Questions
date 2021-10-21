#!/bin/bash

podname="hr-pod"
namespace="hr"

checkpodstatus=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -n "$namespace" |grep -w Running`
out3="$?"

if [ "${out3}" = 0 ]; then
checkcommand=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -n "$namespace" -o jsonpath='{.spec.containers[*].command}' |grep -w "sleep"`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "issue not fixed in pod $podname in namespace $namespace"
out3="1"
fi

else
echo "pod $podname is not ready in namespace $namespace on "$1""
out3="1"
fi
