#!/bin/bash

filename="Hostname_IP_cluster"
filepath="/opt/K8sLab/Lab2"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f "$filepath"/"$filename""$clstnum"_List ]; then
gethost_ip=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-controlplane -o=jsonpath='{.status.addresses[?(@.type=="Hostname")].address} {.status.addresses[?(@.type=="InternalIP")].address}'`

checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$gethost_ip"`
out3="$?"
if [ ${out3} -gt 0 ]; then
echo "file "$filepath"/"$filename""$clstnum"_List output not matched"
out3="1"
else
echo "file "$filepath"/"$filename""$clstnum"_List output matched"
out3="0"
fi

else
echo "file "$filename""$clstnum"_List not available at $filepath"
out3="1"
fi	

