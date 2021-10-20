#!/bin/bash



checkpod=`/usr/bin/kubectl --kubeconfig=/opt/K8sLab/Lab2/"$1".config get pod`
out3="$?"

if [ "${out3}" -gt 0 ]; then
echo "connection breaking with ${1}"
fi
