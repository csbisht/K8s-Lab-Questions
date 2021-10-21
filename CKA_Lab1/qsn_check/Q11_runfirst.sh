#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )

podname="finance-audit-pod"
namespace="finance"

for i in ${clusterlist[@]}
do
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config create ns "$namespace" &> /dev/null
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config run "$podname" --image=busybox --namespace="$namespace" --command sleeep 4500 &> /dev/null
done	


