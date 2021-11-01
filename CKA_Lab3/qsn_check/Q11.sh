#!/bin/bash

podname="web-serv"
nodename="node0"
#clstnum=`echo ${1} |cut -d'r' -f2`

checkstaticpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname"-"${1}"-"$nodename" |grep -w "${1}"-"$nodename"`
out3="$?"

if [ "${out3}" = 0 ]; then
echo "static pod "$podname"-"${1}"-"$nodename" found in cluster $1"
out3="0"
else
echo "static pod "$podname"-"${1}"-"$nodename" not found in cluster $1"
out3="1"
fi
