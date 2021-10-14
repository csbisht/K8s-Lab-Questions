#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )

podname="finance-audit-pod"
namespace="finance"

for i in ${clusterlist[@]}
do
/usr/bin/kubectl --kubeconfig=$HOME/.kube/"$i".config create ns finance &> /dev/null
/usr/bin/kubectl --kubeconfig=$HOME/.kube/"$i".config run "$podname" --image=busybox --namespace="$namespace" --command sleeep 4500 &> /dev/null
done	


