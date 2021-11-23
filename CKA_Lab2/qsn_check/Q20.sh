#!/bin/bash

filename="Hostname_IP_cluster"
filepath="/opt/K8sLab/Lab2"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f "$filepath"/"$filename""$clstnum"_List ]; then
gethost_master=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-controlplane -o=jsonpath='{.status.addresses[?(@.type=="Hostname")].address}'`

checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$gethost_master"`
out3="$?"
if [ ${out3} = 0 ]; then
getmaster_ip=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-controlplane -o=jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}'`
checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$getmaster_ip"`
out2="$?"

if [ ${out2} = 0 ]; then
gethost_controlplane=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-controlplane -o=jsonpath='{.status.addresses[?(@.type=="Hostname")].address}'`
checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$gethost_controlplane"`
out1="$?"

if [ ${out1} = 0 ]; then
getcontrolplane_ip=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get node "$1"-controlplane -o=jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}'`
checkfile=`cat "$filepath"/"$filename""$clstnum"_List |grep -w "$getcontrolplane_ip"`
out4="$?"

if [ ${out4} -gt 0 ]; then
echo "node "$1"-controlplane InternalIP not matched in file "$filepath"/"$filename""$clstnum"_List"
out3="1"
else
echo "node "$1"-controlplane InternalIP matched in file "$filepath"/"$filename""$clstnum"_List"
out3="0"
fi

else
echo "node "$1"-controlplane Hostname not matched in file "$filepath"/"$filename""$clstnum"_List"
out3="1"
fi	

else
echo "node "$1"-controlplane InternalIP not matched in file "$filepath"/"$filename""$clstnum"_List"
out3="1"
fi

else
echo "node "$1"-controlplane Hostname not matched in file "$filepath"/"$filename""$clstnum"_List"
out3="1"
fi

else
echo "file "$filename""$clstnum"_List not available at $filepath"
out3="1"
fi	

