#!/bin/bash

etcdbkpgood="/opt/etcd_backup_good.db"
etcdbkpbad="/opt/etcd_backup_bad.db"


checkdbfile=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "ls $etcdbkpgood" 2> /dev/null`
out3="$?"

if [ "${out3}" = 0 ]; then
checkdb=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "sudo ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key snapshot status $etcdbkpgood"`
out2="$?"

if [ "${out2}" = 0 ]; then
checkdbfile1=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "ls $etcdbkpbad" 2> /dev/null`
out1="$?"

if [ "${out1}" = 0 ]; then
checkdbgood=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "sudo ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key snapshot status "$etcdbkpgood" |cut -d',' -f2"`
checkdbbad=`ssh -o "StrictHostKeyChecking no" "$1"-controlplane "sudo ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key snapshot status "$etcdbkpbad" |cut -d',' -f2"`

if [ "$checkdbgood" -gt "$checkdbbad" ]; then
echo "Your $etcdbkpgood has a higher version then $etcdbkpbad"
out3="1"
elif [ "$checkdbgood" = "$checkdbbad" ]; then
echo "Your both db backup has the same version"
out3="1"	
else
echo "DB backup version looks good"
out3="0"
fi	

else
echo "ETCD db backup "$etcdbkpbad" is corrupted on $1"
out3="1"
fi

else
echo "ETCD db backup "$etcdbkpgood" is corrupted on $1"
out3="1"
fi

else
echo "ETCD db backup "$etcdbkpfile" is not available on $1"
out3="1"
fi
