#!/bin/bash

deploymentname="nginx-web"
clstnum=`echo "${1}" |cut -d'r' -f2`
imagename="nginx:1.19"
filename="Rollout_history_cluster"
filepath="/opt/K8sLab/Lab"

checkdeployment=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}"`
out3="$?"

if [ "${out3}" = 0 ]; then

if [ -f "$filepath""${clstnum}"/"$filename""${clstnum}".txt ]; then
gethistory=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config rollout history deployment "${deploymentname}""${clstnum}" |sed '1,2d' |awk {'print $1'}`
catfile=`cat "$filepath""${clstnum}"/"$filename""${clstnum}".txt |sed '1,2d' |awk {'print $1'}`
if [ "$gethistory" = "$catfile" ]; then

checkimage=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "${deploymentname}""${clstnum}" -o yaml |grep -w "image: ${imagename}"`
out2="$?"
if [ "${out2}" = 0 ]; then
checkreplica=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pods |grep "${deploymentname}${clstnum}" |wc -l`
if [ "${checkreplica}" -lt 3 ]; then
echo "replicas not scaled to 3"
out3="1"
else
echo "replicas scaled to 3"
out3="0"	
fi
else
echo "upgrade deploy image not found"
out3="1"	
fi

else
echo "Rollout history not matched with file "$filepath""${clstnum}"/"$filename""${clstnum}".txt"
fi

else
echo "file "$filepath""${clstnum}"/"$filename""${clstnum}".txt not found on "$1""
fi

else
echo "deployment "${deploymentname}""${clastnum}" not found on "$1""
out3="1"
fi
