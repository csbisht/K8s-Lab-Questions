#!/bin/bash

filename="osImages_allNodes-cluster"
filepath="/opt/K8sLab/Lab1"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f "$filepath"/"$filename""$clstnum".txt ]; then
getosImages=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get nodes -o=jsonpath='{.items[*].status.nodeInfo.osImage}'`

checkfile=`cat "$filepath"/"$filename""$clstnum".txt |grep -w "$getosImages"`
out3="$?"
if [ ${out3} -gt 0 ]; then
echo "file "$filepath"/"$filename""$clstnum".txt output not matched"
out3="1"
else
echo "file "$filepath"/"$filename""$clstnum".txt output matched"
out3="0"
fi

else
echo "file "$filename""$clstnum".txt not available at $filepath"
out3="1"
fi	

