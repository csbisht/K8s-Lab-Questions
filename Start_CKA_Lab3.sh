#!/bin/bash

NONE='\033[00m'
BOLD='\033[1m'
F_VDOBLE="\033#6"
CYAN='\033[01;36m'
RED='\033[01;31m'
GREEN='\033[01;32m'

confirm="Please confirm if you done [yes/no]:"
nextq="Or you can switch to next question [Press Enter / exit]:"

if [ -d "$HOME/K8s-Lab-Questions/kubeconfig" ]; then
cp $HOME/.kube/cluster*.config $HOME/K8s-Lab-Questions/kubeconfig/
else
mkdir -p $HOME/K8s-Lab-Questions/kubeconfig
cp $HOME/.kube/cluster*.config $HOME/K8s-Lab-Questions/kubeconfig/
fi

if [ -d "/opt/K8sLab/Lab3" ]; then
sudo chown -R ubuntu:ubuntu /opt/K8sLab
else
sudo mkdir -p /opt/K8sLab/Lab3
sudo chown -R ubuntu:ubuntu /opt/K8sLab	
fi	

###make executable to all scripts
sudo chmod +x "$HOME"/K8s-Lab-Questions/CKA_Lab3/qsn_check/*.sh

qsncheck () {
clusterconf=`ls "$HOME"/K8s-Lab-Questions/kubeconfig |cut -d'.' -f1`
for y in `echo ${clusterconf}`
do
source "$HOME"/K8s-Lab-Questions/CKA_Lab3/qsn_check/Q"${qsn_no}".sh "${y}"
done
if [ "${out3}" -gt 0 ]; then
echo -e "\n\n"	
echo -e "${F_VDOBLE}${RED}wrong answer...${NONE} \n\n"
echo "do you wants to re-try [yes/no]:"
read firstfail
if [ "${firstfail}" = "yes" ];then
labcase
fi	
else
echo -e "\n\n"
echo -e "${F_VDOBLE}${GREEN}correct answer...${NONE} \n\n"	
fi
}	

labcaseifno () {
if [ "${ANS}" = "no" ]; then
clear
echo -e "\n\n\n\n"
printf "${BOLD}${CYAN}${qsnread}${NONE}"
echo -e "\n\n"
echo -e "${BOLD}${confirm}${NONE}"
echo -e "${BOLD}${nextq}${NONE}"
read ANS
#labcase
labrun
fi	
}	

labcase () {
case "$ANS" in
   "exit") clear;
	   break ;;
   "yes") #clear;
          qsncheck
	  echo -e "\n\n"
	  echo "Please wait...";
	  sleep 3;
   ;;
   "no") clear;
	 echo -e "\n\n"
	 echo -e "${BOLD}${CYAN}OK! we will wait...${NONE} \n";
	 sleep 3;
	 labcaseifno;
   ;;
   *) clear;
      echo "Sorry, please provide a valide input! or exit to next question or ctrl+c to quit this Lab";
   ;;
  esac
}  

questionlst=( `ls $HOME/K8s-Lab-Questions/CKA_Lab3/questions` )

labrun () {
clear
echo -e "\n\n\n\n"
qsnread=`cat $HOME/K8s-Lab-Questions/CKA_Lab3/questions/Q"${qsn_no}".md | fmt`
printf "${BOLD}${CYAN}${qsnread}${NONE}"
echo -e "\n\n"
echo -e "${BOLD}${confirm}${NONE}"
echo -e "${BOLD}${nextq}${NONE}"
read ANS
if  [ "${ANS}" = "yes" ]; then
labcase
else
labcaseifno
fi
}

for i in "${!questionlst[@]}"
do
qsn_no=`expr ${i} + 1`	
if [ -f "${HOME}/K8s-Lab-Questions/CKA_Lab3/qsn_check/Q${qsn_no}_runfirst.sh" ]; then
chmod +x "${HOME}/K8s-Lab-Questions/CKA_Lab3/qsn_check/Q${qsn_no}_runfirst.sh"
"${HOME}"/K8s-Lab-Questions/CKA_Lab3/qsn_check/Q"${qsn_no}"_runfirst.sh
labrun
else
labrun
fi	
done

