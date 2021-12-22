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
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    echo -e "$barra"
    echo -e "${cor[3]} $(fun_trans ${id} "Aplicar Sistema Para Melhorar Pacotes Ssh?")"
    echo -e "${cor[3]} $(fun_trans ${id} "Opcao Para Usuarios Avancados")"
    echo -e "$barra"
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]} $(fun_trans ${id} "Correcao de problemas de pacotes no SSH...")"
           echo -e " $(fun_trans ${id} "Qual A Taxa RX")"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e " $(fun_trans ${id} "Qual A Taxa TX")"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     echo -e "$barra"
     }
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[33m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
fun_shadowsocks () {
[[ -e /etc/shadowsocks.json ]] && {
[[ $(ps x|grep ssserver|grep -v grep|awk '{print $1}') != "" ]] && kill -9 $(ps x|grep ssserver|grep -v grep|awk '{print $1}') > /dev/null 2>&1 && ssserver -c /etc/shadowsocks.json -d stop > /dev/null 2>&1
echo -e "\033[1;33m $(fun_trans ${id} "SHADOWSOCKS PARADO")\n${barra}${cor[0]}"
rm /etc/shadowsocks.json
return 0
}
       while true; do
       echo -e "\033[33m $(fun_trans ${id} "Selecione uma Criptografia")\n${barra}${cor[0]}"
       encript=(aes-256-gcm aes-192-gcm aes-128-gcm aes-256-ctr aes-192-ctr aes-128-ctr aes-256-cfb aes-192-cfb aes-128-cfb camellia-128-cfb camellia-192-cfb camellia-256-cfb chacha20-ietf-poly1305 chacha20-ietf chacha20 rc4-md5)
       for((s=0; s<${#encript[@]}; s++)); do
       echo -e " [${s}] - ${encript[${s}]}"
       done
       echo -e "$barra"
       while true; do
       unset cript
       echo -ne "$(fun_trans ${id} "Qual Criptografia? Escolha uma Opcao"): "; read -e -i 0 cript
       [[ ${encript[$cript]} ]] && break
       echo -e "$(fun_trans ${id} "Opcao Invalida")"
       done
       encriptacao="${encript[$cript]}"
       [[ ${encriptacao} != "" ]] && break
       echo -e "$(fun_trans ${id} "Opcao Invalida")"
      done
#ESCOLHENDO LISTEN
      echo -e "${barra}\n\033[33m $(fun_trans ${id} "Selecione Uma Porta Para o Shadowsocks Escutar")\n${barra}${cor[0]}"
      while true; do
      unset Lport
      read -p " Listen Port: " Lport
      [[ $(mportas|grep "$Lport") = "" ]] && break
      echo -e " ${Lport}: $(fun_trans ${id} "Porta Invalida")"      
      done
#INICIANDO
echo -e "${barra}\n\033[33m $(fun_trans ${id} "Digite a Senha Shadowsocks")${cor[0]}"
read -p" Pass: " Pass
echo -e "${barra}\n\033[33m $(fun_trans ${id} "Instalando")\n${barra}${cor[0]}"
fun_bar 'apt-get install python-pip python-m2crypto -y'
fun_bar 'pip install shadowsocks'
echo -ne '{\n"server":"' > /etc/shadowsocks.json
echo -ne "0.0.0.0" >> /etc/shadowsocks.json
echo -ne '",\n"server_port":' >> /etc/shadowsocks.json
echo -ne "${Lport},\n" >> /etc/shadowsocks.json
echo -ne '"local_port":1080,\n"password":"' >> /etc/shadowsocks.json
echo -ne "${Pass}" >> /etc/shadowsocks.json
echo -ne '",\n"timeout":600,\n"method":"aes-256-cfb"\n}' >> /etc/shadowsocks.json
echo -e "${barra}\n\033[1;31m STARTING\033[0m"
ssserver -c /etc/shadowsocks.json -d start > /dev/null 2>&1
value=$(ps x |grep ssserver|grep -v grep)
[[ $value != "" ]] && value="\033[1;32mSTARTED" || value="\033[1;31mERROR"
echo -e "${barra}\n ${value} ${cor[0]}\n${barra}"
return 0
}
fun_shadowsocks