#!/bin/bash

podname="static-pod"
nodename="controlplane"
clstnum=`echo ${1} |cut -d'r' -f2`
static-pod-cluster1-controlplane

checkstaticpod=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods "$podname"-"$1"-"$nodename"`
out3="$?"



if [ "${out3}" = 0 ]; then
echo "static pod "$podname"-"$1"-"$nodename" found in cluster $1"
else
echo "static pod "$podname"-"$1"-"$nodename" not found in cluster $1"
out3="1"
fi
