#!/bin/bash

checknode=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-node0 -o jsonpath='{.status.conditions[?(@.type == "Ready")].status}' |grep -w "True"`
out3="$?"

if [ "${out3}" -gt 0 ]; then
echo "Node "$1"-node0 not Ready stat on $1"
out3="1"
else
echo "Node "$1"-node0 Ready stat on $1"
out3="0"
fi
