#!/bin/bash
fun_trans () { 
local texto
local retorno
declare -A texto
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z $(echo ${texto[$2]}) ]]; then
ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
  while [[ -z $retorno ]]; do
    NUM="$(($RANDOM%${#ENGINES[@]}))"
    retorno="$(source trans -e ${ENGINES[$NUM]} -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
  done
 echo "texto[$2]='$retorno'"  >> /etc/texto-adm
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}
declare -A cor=( [0]="\033[33m" [1]="\033[33m" [2]="\033[33m" [3]="\033[33m" [4]="\033[33m" )
barra="\033[0m\e[33m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
[[ -z $1 ]] && exit || id=$1
echo -e "${cor[4]} $(fun_trans ${id} "Test de Velocidad") [GOLDEN ADM PRO]"
echo -e "${barra}"
ping=$(ping -c1 google.com |awk '{print $8 $9}' |grep -v loss |cut -d = -f2 |sed ':a;N;s/\n//g;ta')
(
echo -ne "[" >&2
while [[ ! -e /tmp/pyend ]]; do
echo -ne "." >&2
sleep 0.8s
done
rm /tmp/pyend
echo -e "]" >&2
) &
starts_test=$(python ${SCPfrm}/speedtest.py) && touch /tmp/pyend
sleep 0.6s
down_load=$(echo "$starts_test" | grep "Download" | awk '{print $2,$3}')
up_load=$(echo "$starts_test" | grep "Upload" | awk '{print $2,$3}')
echo -e "${cor[5]} $(fun_trans ${id} "Latencia"): $ping"
echo -e "${cor[5]} $(fun_trans ${id} "Upload"): $up_load"
echo -e "${cor[5]} $(fun_trans ${id} "Download"): $down_load"
echo -e "${barra}"