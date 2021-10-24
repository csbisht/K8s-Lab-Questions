#!/bin/bash

namespace="audit"
clstnum=`echo ${1} |cut -d'r' -f2`


checkgetpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods -n "$namespace" --as test"$clstnum" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkverbs=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe role -n "$namespace" |grep -w pods |grep -w create |grep -w get |grep -w list |grep -w update |grep -w delete`
out1="$?"

if [ ${out1} -gt 0 ]; then
echo "verbs not granted to user test"$clstnum" in namespace $namespace on "$1""
out3="1"
else
echo "verbs granted to user test"$clstnum" in namespace $namespace on "$1""
out3="0"
fi

else
echo "access not granted to user test"$clstnum" in namespace $namespace on "$1""
fi	
