#!/bin/bash

podname="audit-web-app"
svcname="audit-web-app-svc"


checksvc=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get svc "$svcname" &> /dev/null`
out3="$?"

if [ "${out3}" = 0 ]; then
getpodip=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config get pod "$podname" -o jsonpath='{.status.podIP}'`
matchsvcendpoint=`/usr/bin/kubectl --kubeconfig=$HOME/K8s-Lab-Questions/kubeconfig/"$1".config describe svc "$svcname" |grep -w "Endpoints" |grep -w "$getpodip":8080`
out1="$?"

if [ "${out1}" -gt 0 ]; then	
echo "pod IP $getpodip or port 8080 not exposed in SVC $svcname"
out3="1"
fi


else
echo "SVC $svcname not found on $1"
out3="1"
fi
