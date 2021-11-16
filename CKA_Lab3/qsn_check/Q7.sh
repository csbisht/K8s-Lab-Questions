#!/bin/bash

poddev="redis-dev"
podstg="redis-stag"
podprod="redis-prod"
cmname="redisconf"

checkcm=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get cm "$cmname" 2>/dev/null`
out3="$?"

if [ ${out3} = 0 ]; then

if [ "$1" = "cluster1" ]; then
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$poddev" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out2="$?"
if [ ${out2} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$poddev" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/config")]}' |grep -w "/config"`
out1="$?"
if [ ${out1} -gt 0 ]; then
echo "mount path on pod "$poddev" is not correct on "$1""
out3="1"
else
echo "mount path on pod "$poddev" is correct on "$1""
out3="0"
fi
else
echo "pod "$poddev" is not running on "$1""
fi

elif [ "$1" = "cluster2" ]; then	
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podstg" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out2="$?"
if [ ${out2} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podstg" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/config")]}' |grep -w "/config"`
out1="$?"
if [ ${out1} -gt 0 ]; then
echo "mount path on pod "$podstg" is not correct on "$1""
out3="1"
else
echo "mount path on pod "$podstg" is correct on "$1""
out3="0"
fi
else
echo "pod "$podstg" is not running on "$1""
fi

else
checkpodstat=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podprod" -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out2="$?"
if [ ${out2} = 0 ]; then
checkpodmnt=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podprod" -o jsonpath='{.spec.containers[*].volumeMounts[?(@.mountPath == "/config")]}' |grep -w "/config"`
out1="$?"
if [ ${out1} -gt 0 ]; then
echo "mount path on pod "$podprod" is not correct on "$1""
out3="1"
else
echo "mount path on pod "$podprod" is correct on "$1""
out3="0"
fi
else
echo "pod "$podprod" is not running on "$1""
fi	

fi	

else
echo "ConfigMap "$cmname" not found on "$1""
out3="1"
fi

