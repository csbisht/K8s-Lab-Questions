#!/bin/bash

podname="hr-web-app"
deploymentname="apache-webserver"
svcname="apache-web"
clstnum=`echo ${1} |cut -d'r' -f2`

checkdeployment=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get deployment "$deploymentname""$clstnum" 2> /dev/null`

out3="$?"

if [ "${out3}" = 0 ]; then
checksvc=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get svc "$svcname""$clstnum"-svc 2> /dev/null`
out2="$?"

if [ "${out2}" = 0 ]; then	
getnodeport=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe svc "$svcname""$clstnum"-svc |grep -w "NodePort" |grep -w "30007"`
out1="$?"

if [ "${out1}" -gt 0 ]; then
echo "NodePort 30007 not exposed in SVC "$svcname""$clstnum"-svc on $1"
out3="1"
else
echo "NodePort 30007 exposed in SVC "$svcname""$clstnum"-svc on $1"
out3="0"
fi

else
echo "service "$svcname""$clstnum"-svc not found on $1"
out3="1"	
fi

else
echo "deployment "$deploymentname""$clstnum" not found on $1"
out3="1"
fi
