#!/bin/bash

cp $HOME/.kube/cluster*.config /opt/K8sLab/Lab2/

listfiles=( `ls /opt/K8sLab/Lab2/cluster*.config` )

for i in ${!listfiles[@]}
do
clustercount=`expr ${i} + 1`	
clustercount2=`expr ${i} + 2`
getserverip=`cat /opt/K8sLab/Lab2/cluster"${clustercount}".config |grep -w "server" |awk -F '/' '{print $3}'`
sed -i "s/${getserverip}/${getserverip}${clustercount2}/g" /opt/K8sLab/Lab2/cluster"${clustercount}".config
done

