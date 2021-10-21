#!/bin/bash

clusterlist=( cluster1 cluster2 cluster3 )

nsname="audit"
usrname="chan"

for i in ${clusterlist[@]}
do
clstnum=`echo ${i} |cut -d'r' -f2`

###create namespace
/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$i".config create ns "$nsname" &> /dev/null

if [ -d "$HOME/pki" ];then
###generate private key
openssl genrsa -out "$HOME"/pki/"$usrname""$clstnum".key 2048 &> /dev/null
###generate CSR
openssl req -new -key "$HOME"/pki/"$usrname""$clstnum".key -out "$HOME"/pki/"$usrname""$clstnum".csr -subj "/C=IN/ST=New Delhi/L=Delhi/O=K8s Test Example/CN=k8stestexample.com" &> /dev/null
else
mkdir -p "$HOME"/pki
###generate private key
openssl genrsa -out "$HOME"/pki/"$usrname""$clstnum".key 2048 &> /dev/null
###generate CSR
openssl req -new -key "$HOME"/pki/"$usrname""$clstnum".key -out "$HOME"/pki/"$usrname""$clstnum".csr -subj "/C=IN/ST=New Delhi/L=Delhi/O=K8s Test Example/CN=k8stestexample.com" &> /dev/null
fi	
done	


