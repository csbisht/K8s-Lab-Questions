#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )

podname="redispod"

for i in ${clusterlist[@]}
do
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config run "$podname" --restart Never --image redis:0.2 &> /dev/null
done	


