#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )

podname="hr-web-app"

for i in ${clusterlist[@]}
do
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config run "$podname" --image=nginx --port=8080 &> /dev/null
done	


