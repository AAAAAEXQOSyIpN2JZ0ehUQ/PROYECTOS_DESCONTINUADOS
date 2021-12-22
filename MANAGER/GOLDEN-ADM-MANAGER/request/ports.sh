#!/bin/bash
declare -A cor=( [0]="\033[33m" [1]="\033[33m" [2]="\033[33m" [3]="\033[33m" [4]="\033[33m" )
barra="\033[0m\e[33m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
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
msg () {
BRAN='\033[33m' && VERMELHO='\e[31m'
VERDE='\e[33m' && AMARELO='\e[33m'
AZUL='\e[33m' && MAGENTA='\e[35m'
MAG='\033[33m' && NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${AZUL}======================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}
port () {
local portas
local portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
i=0
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e ${portas}|grep -w "$var1 $var2")" ]] || {
    portas+="$var1 $var2 $portas"
    echo "$var1 $var2"
    let i++
    }
done <<< "$portas_var"
}
verify_port () {
local SERVICE="$1"
local PORTENTRY="$2"
[[ ! $(echo -e $(port|grep -v ${SERVICE})|grep -w "$PORTENTRY") ]] && return 0 || return 1
}
edit_squid () {
msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS SQUID")"
msg -bar
if [[ -e /etc/squid/squid.conf ]]; then
local CONF="/etc/squid/squid.conf"
elif [[ -e /etc/squid3/squid.conf ]]; then
local CONF="/etc/squid3/squid.conf"
fi
NEWCONF="$(cat ${CONF}|grep -v "http_port")"
msg -ne "$(fun_trans ${id} "Novas Portas"): "
read -p "" newports
for PTS in `echo ${newports}`; do
verify_port squid "${PTS}" && echo -e "\033[1;33mPort $PTS \033[1;32mOK" || {
echo -e "\033[1;33mPort $PTS \033[1;31mFAIL"
return 1
}
done
rm ${CONF}
while read varline; do
echo -e "${varline}" >> ${CONF}
 if [[ "${varline}" = "#portas" ]]; then
  for NPT in $(echo ${newports}); do
  echo -e "http_port ${NPT}" >> ${CONF}
  done
 fi
done <<< "${NEWCONF}"
msg -azu "$(fun_trans ${id} "AGUARDE")"
service squid restart &>/dev/null
service squid3 restart &>/dev/null
sleep 1s
msg -bar
msg -azu "$(fun_trans ${id} "PORTAS REDEFINIDAS")"
msg -bar
}
edit_apache () {
msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS APACHE")"
msg -bar
local CONF="/etc/apache2/ports.conf"
local NEWCONF="$(cat ${CONF})"
msg -ne "$(fun_trans ${id} "Novas Porta"): "
read -p "" newports
for PTS in `echo ${newports}`; do
verify_port apache "${PTS}" && echo -e "\033[1;33mPort $PTS \033[1;32mOK" || {
echo -e "\033[1;33mPort $PTS \033[1;31mFAIL"
return 1
}
done
rm ${CONF}
while read varline; do
if [[ $(echo ${varline}|grep -w "Listen") ]]; then
 if [[ -z ${END} ]]; then
 echo -e "Listen ${newports}" >> ${CONF}
 END="True"
 else
 echo -e "${varline}" >> ${CONF}
 fi
else
echo -e "${varline}" >> ${CONF}
fi
done <<< "${NEWCONF}"
msg -azu "$(fun_trans ${id} "AGUARDE")"
service apache2 restart &>/dev/null
sleep 1s

msg -bar
msg -azu "$(fun_trans ${id} "PORTAS REDEFINIDAS")"
msg -bar
}
edit_openvpn () {
msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS OPENVPN")"
msg -bar
local CONF="/etc/openvpn/server.conf"
local CONF2="/etc/openvpn/client-common.txt"
local NEWCONF="$(cat ${CONF}|grep -v [Pp]ort)"
local NEWCONF2="$(cat ${CONF2})"
msg -ne "$(fun_trans ${id} "Nova Porta"): "
read -p "" newports
for PTS in `echo ${newports}`; do
verify_port openvpn "${PTS}" && echo -e "\033[1;33mPort $PTS \033[1;32mOK" || {
echo -e "\033[1;33mPort $PTS \033[1;31mFAIL"
return 1
}
done
rm ${CONF}
while read varline; do
echo -e "${varline}" >> ${CONF}
if [[ ${varline} = "proto tcp" ]]; then
echo -e "port ${newports}" >> ${CONF}
fi
done <<< "${NEWCONF}"
rm ${CONF2}
while read varline; do
if [[ $(echo ${varline}|grep -v "remote-random"|grep "remote") ]]; then
echo -e "$(echo ${varline}|cut -d' ' -f1,2) ${newports} $(echo ${varline}|cut -d' ' -f4)" >> ${CONF2}
else
echo -e "${varline}" >> ${CONF2}
fi
done <<< "${NEWCONF2}"
msg -azu "$(fun_trans ${id} "AGUARDE")"
service openvpn restart &>/dev/null
/etc/init.d/openvpn restart &>/dev/null
sleep 1s

msg -bar
msg -azu "$(fun_trans ${id} "PORTAS REDEFINIDAS")"
msg -bar
}
edit_dropbear () {
msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS DROPBEAR")"
msg -bar
local CONF="/etc/default/dropbear"
local NEWCONF="$(cat ${CONF}|grep -v "DROPBEAR_EXTRA_ARGS")"
msg -ne "$(fun_trans ${id} "Novas Portas"): "
read -p "" newports
for PTS in `echo ${newports}`; do
verify_port dropbear "${PTS}" && echo -e "\033[1;33mPort $PTS \033[1;32mOK" || {
echo -e "\033[1;33mPort $PTS \033[1;31mFAIL"
return 1
}
done
rm ${CONF}
while read varline; do
echo -e "${varline}" >> ${CONF}
 if [[ ${varline} = "NO_START=0" ]]; then
 echo -e 'DROPBEAR_EXTRA_ARGS="VAR"' >> ${CONF}
 for NPT in $(echo ${newports}); do
 sed -i "s/VAR/-p ${NPT} VAR/g" ${CONF}
 done
 sed -i "s/VAR//g" ${CONF}
 fi
done <<< "${NEWCONF}"
msg -azu "$(fun_trans ${id} "AGUARDE")"
service dropbear restart &>/dev/null
sleep 1s

msg -bar
msg -azu "$(fun_trans ${id} "PORTAS REDEFINIDAS")"
msg -bar
}
edit_openssh () {
msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS OPENSSH")"
msg -bar
local CONF="/etc/ssh/sshd_config"
local NEWCONF="$(cat ${CONF}|grep -v [Pp]ort)"
msg -ne "$(fun_trans ${id} "Novas Portas"): "
read -p "" newports
for PTS in `echo ${newports}`; do
verify_port sshd "${PTS}" && echo -e "\033[1;33mPort $PTS \033[1;32mOK" || {
echo -e "\033[1;33mPort $PTS \033[1;31mFAIL"
return 1
}
done
rm ${CONF}
for NPT in $(echo ${newports}); do
echo -e "Port ${NPT}" >> ${CONF}
done
while read varline; do
echo -e "${varline}" >> ${CONF}
done <<< "${NEWCONF}"
msg -azu "$(fun_trans ${id} "AGUARDE")"
service ssh restart &>/dev/null
service sshd restart &>/dev/null
sleep 1s

msg -bar
msg -azu "$(fun_trans ${id} "PORTAS REDEFINIDAS")"
msg -bar
}
main_fun () {
unset newports
i=0
while read line; do
let i++
          case $line in
          squid|squid3)squid=$i;; 
          apache|apache2)apache=$i;; 
          openvpn)openvpn=$i;; 
          dropbear)dropbear=$i;; 
          sshd)ssh=$i;; 
          esac
done <<< "$(port|cut -d' ' -f1|sort -u)"
for((a=1; a<=$i; a++)); do
[[ $squid = $a ]] && echo -ne "\033[1;32m [$squid] > " && msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS SQUID")"
[[ $apache = $a ]] && echo -ne "\033[1;32m [$apache] > " && msg -azu "$(fun_trans ${id} "REDEFINIR PORTA APACHE")"
[[ $openvpn = $a ]] && echo -ne "\033[1;32m [$openvpn] > " && msg -azu "$(fun_trans ${id} "REDEFINIR PORTA OPENVPN")"
[[ $dropbear = $a ]] && echo -ne "\033[1;32m [$dropbear] > " && msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS DROPBEAR")"
[[ $ssh = $a ]] && echo -ne "\033[1;32m [$ssh] > " && msg -azu "$(fun_trans ${id} "REDEFINIR PORTAS SSH")"
done
echo -ne "\033[1;32m [0] > " && msg -azu "$(fun_trans ${id} "VOLTAR")"
echo -e "$barra"
while true; do
echo -ne "\033[1;37m$(fun_trans ${id} "Selecione"): " && read selection
tput cuu1 && tput dl1
[[ ! -z $squid ]] && [[ $squid = $selection ]] && edit_squid && break
[[ ! -z $apache ]] && [[ $apache = $selection ]] && edit_apache && break
[[ ! -z $openvpn ]] && [[ $openvpn = $selection ]] && edit_openvpn && break
[[ ! -z $dropbear ]] && [[ $dropbear = $selection ]] && edit_dropbear && break
[[ ! -z $ssh ]] && [[ $ssh = $selection ]] && edit_openssh && break
[[ "0" = $selection ]] && break
done
#exit 0
}
main_fun