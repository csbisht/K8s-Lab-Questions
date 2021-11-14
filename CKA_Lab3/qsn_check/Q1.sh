#!/bin/bash

namespace="networker"
usrname="admin"
clstnum=`echo ${1} |cut -d'r' -f2`


checkgetingress=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get ingress -n "$namespace" --as "$usrname""$clstnum" 2> /dev/null`
out3="$?"

if [ ${out3} = 0 ]; then
checkverbs=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe role -n "$namespace" |grep -w "ingresses" |grep -w get |grep -w list`
out2="$?"

if [ ${out2} = 0 ]; then
checkverbs1=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe role -n "$namespace" |grep -w "networkpolicies" |grep -w get |grep -w list`
out1="$?"

if [ ${out1} -gt 0 ]; then
echo "verbs not granted to user "$usrname""$clstnum" in namespace $namespace on "$1""
out3="1"
else
echo "verbs granted to user "$usrname""$clstnum" in namespace $namespace on "$1""
out3="0"
fi	

else
echo "verbs not granted to user "$usrname""$clstnum" in namespace $namespace on "$1""
out3="1"
fi

else
echo "access not granted to user "$usrname""$clstnum" in namespace $namespace on "$1""
out3="1"
fi	
