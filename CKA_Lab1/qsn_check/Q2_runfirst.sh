#!/bin/bash

cp $HOME/.kube/cluster*.config /opt/K8sLab/Lab1/

listfiles=( `ls /opt/K8sLab/Lab1/cluster*.config` )

for i in ${!listfiles[@]}
do
clustercount=`expr ${i} + 1`	
getserverip=`cat /opt/K8sLab/Lab1/cluster"${clustercount}".config |grep -w "server" |awk -F '/' '{print $3}'`
sed -i "s/${getserverip}/${getserverip}${clustercount}/g" /opt/K8sLab/Lab1/cluster"${clustercount}".config
echo "${listfiles["$i"]}"
done

