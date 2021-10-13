#!/bin/bash

nodename="node0"
clstnum=`echo ${1} |cut -d'r' -f2`


if [ -f /opt/K8sLab/Lab1/"$nodename"-cluster"$clstnum".json ]; then
checknodename=( `cat /opt/K8sLab/Lab1/"$nodename"-cluster"$clstnum".json |grep -w "name" |cut -d'"' -f4` )
out3="$?"
if [ ${#checknodename[@]} -gt 1 ]; then
echo "more then one node captured in file /opt/K8sLab/Lab1/"$nodename"-cluster"$clstnum".json"
out3="1"
else
echo "node cluster"$clstnum"-"$nodename" found in json file"
out3="0"
fi	
else
echo "file "$nodename"-cluster"$clstnum".json not available at /opt/K8sLab/Lab1/"
out3="1"
fi	

