#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )


for i in ${clusterlist[@]}
do

if [ "${i}" = cluster1 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo systemctl stop kubelet"

ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo grep -w "ca.crt" /var/lib/kubelet/config.yaml" &> /dev/null
out1="$?"
if [ "${out1}" = 0 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo sed -i 's/ca.crt/ca.cert/g' /var/lib/kubelet/config.yaml"
fi

fi

if [ "${i}" = cluster2 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo systemctl stop kubelet"

ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo grep -w "ca.crt" /var/lib/kubelet/config.yaml" &> /dev/null
out1="$?"
if [ "${out1}" = 0 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo sed -i 's/ca.crt/CA.crt/g' /var/lib/kubelet/config.yaml"
fi
fi

if [ "${i}" = cluster3 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo systemctl stop kubelet"

ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo grep -w "pki" /var/lib/kubelet/config.yaml" &> /dev/null
out1="$?"
if [ "${out1}" = 0 ]; then
ssh -o "StrictHostKeyChecking no" "$i"-node0 "sudo sed -i 's/pki/pKi/g' /var/lib/kubelet/config.yaml"
fi
fi

done	


