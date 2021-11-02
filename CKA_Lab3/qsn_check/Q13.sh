#!/bin/bash

podname="secret-pod"
secretname="mysecret"

checkpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out1="$?"

if [ ${out1} = 0 ]; then
checksecret=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.spec.volumes[*].secret.secretName}' |grep -w "$secretname"`
out2="$?"

if [ ${out2} -gt 0 ]; then
echo "secret $secretname not mounted in pod "$podname" on "$1""
out3="1"
else
echo "secret $secretname mounted in pod "$podname" on "$1""
out3="0"
fi

else
echo "pod "$podname" is not in running stat on "$1""
out3="1"
fi

else
echo "pod "$podname" not found on "$1""
out3="1"
fi	
