#!/bin/bash

etcdbkpfile="/opt/etcd_backup.db"


checkdb=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "sudo ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key snapshot status $etcdbkpfile"`
out1="$?"


checkdbfile=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "ls $etcdbkpfile"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ]; then
echo "ETCD db backup is corrupted on $1"
out3="1"
else
echo "ETCD db backup is good on $1"
out3="0"
fi
else
echo "ETCD db backup is not available on $1"
out3="1"
fi
