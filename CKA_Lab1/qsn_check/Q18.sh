#!/bin/bash

filename="Internal_IP_cluster"
filepath="/opt/K8sLab/Lab1"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f "$filepath"/"$filename""$clstnum"_List ]; then
getInternalIP=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get nodes -o=jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'`

checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$getInternalIP"`
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

