#!/bin/bash

k8s_version="v1.21.0"


getnodes=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get nodes |grep -w "${k8s_version}" |awk '{print $1}'`
#out3="$?"

if [ ! -z "${getnodes}" ]; then
for ver in ${getnodes}
do
checkclusterversion=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node ${ver} |grep -w "${k8s_version}" |awk '{print $5}'`
if [ "${checkclusterversion}" = "${k8s_version}" ];then
echo "node ${ver} upgraded to version ${k8s_version}"
out3="0"
else
echo "node ${ver} not upgraded to version ${k8s_version}"	
out3="1"
fi	
done
else
echo "cluster ${1} not upgraded to version ${k8s_version}"
out3="1"
fi
