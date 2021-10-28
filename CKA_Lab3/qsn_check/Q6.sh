#!/bin/bash

etcdbkpgood="/opt/etcd_backup_good.db"
etcdbkpbad=="/opt/etcd_backup_bad.db"

checkdb=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "sudo ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key snapshot status $etcdbkpgood"`
out1="$?"


checkdbfile=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "ls $etcdbkpgood"`
out3="$?"

if [ "${out3}" = 0 ]; then
if [ "${out1}" -gt 0 ]; then
echo "ETCD db backup is corrupted on $1"
out3="1"
else
echo "ETCD db backup "$etcdbkpfile" is good on $1"
out3="0"
fi
else
echo "ETCD db backup "$etcdbkpfile" is not available on $1"
out3="1"
fi
