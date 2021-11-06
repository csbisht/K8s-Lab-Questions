#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )


for i in ${clusterlist[@]}
do
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config drain "$i"-node0 --ignore-daemonsets --force &>/dev/null
out1="$?"

if [ "$out1" = 0 ]; then
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config delete node "$i"-node0 &>/dev/null
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo kubeadm reset -f" &>/dev/null
fi

done	


