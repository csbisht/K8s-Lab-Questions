#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )


read -r -d '' text <<-"EOT"
apiVersion: v1
kind: Pod
metadata:
  name: web-serv
spec:
  containers:
  - image: nginx
    name: web-serv
  restartPolicy: Always
EOT

echo "$text" >/tmp/pod-web-serv.txt

for i in ${clusterlist[@]}
do
scp -o "StrictHostKeyChecking no" /tmp/pod-web-serv.txt "$i"-controlplane:/tmp/pod-web-serv.yaml 
ssh -o "StrictHostKeyChecking no" "$i"-controlplane "sudo cp /tmp/pod-web-serv.yaml /etc/kubernetes/manifests/pod-web-serv.yaml"
done	


