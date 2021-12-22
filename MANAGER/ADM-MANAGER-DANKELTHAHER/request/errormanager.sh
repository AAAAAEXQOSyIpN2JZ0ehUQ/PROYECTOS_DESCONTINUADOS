#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1

SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"

declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;35m" [3]="\033[1;32m" [4]="\033[1;31m" [5]="\033[1;33m" [6]="\E[44;1;37m" [7]="\E[41;1;37m" )
barra="\033[0m\e[31m======================================================\033[1;37m"
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && exit 1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
SCPidioma="${SCPdir}/idioma" && [[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}

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
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
elimi_dropbear () {
msg -bar
msg -ama " $(fun_trans "CORRIGIENDO ERRORES DROPBEAR")"
msg -bar
service dropbear stop
apt-get remove dropbear -y
apt-get purge dropbear -y
rm -rf /etc/default/dropbear
msg -bar
msg -ama " $(fun_trans "PUERTOS COREGIDAS DROPBEAR")"
msg -bar
}

corre_squid () {
msg -bar
msg -ama " $(fun_trans "CORRIGIENDO LOS PUERTOS SQUID")"
msg -bar
apt-get remove squid -y
apt-get purge squid -y
rm -rf /etc/squid
msg -bar
msg -ama " $(fun_trans "ELIMINANDO PUERTOS SQUI3")"
msg -bapt-get remove squid3 -y
apt-get purge squid3 -y
rm -rf /etc/squid3
msg -bar
msg -ama " $(fun_trans "PUERTOS SQUID CORREGIDAS")"
msg -bar
}
ssl_del () {
msg -bar
msg -ama " $(fun_trans "ELIMINANDO PUERTOS SSL")"
msg -bar
service stunnel4 stop
apt-get remove stunnel4 -y
apt-get purge stunnel4 -y
rm -rf /etc/stunnel/stunnel.conf
rm -rf /etc/default/stunnel4
rm -rf /etc/stunnel/stunnel.pem
msg -bar
msg -ama " $(fun_trans "LOS PUERTOS SSL SEAN DETENIDO CON EXITO")"
msg -bar
}
corregir_fun () {
echo -e " \033[1;36m $(fun_trans "CORREGIR PUERTOS DROPBEAR,SQUID,SSL") \033[1;32m[NEW-ADM]"
echo -e "$barra"
while true; do
echo -e "${cor[4]} [1] > ${cor[5]}$(fun_trans "CORREGIR ERROR DE DROPBEAR")"
echo -e "${cor[4]} [2] > ${cor[5]}$(fun_trans "CORREGIR ERROR SQUID")"
echo -e "${cor[4]} [3] > ${cor[5]}$(fun_trans "ELIMINAR PUERTOS SSL")"
echo -e "${cor[4]} [4] > ${cor[0]}$(fun_trans "SALIR")"
echo -e "${cor[4]} [0] > ${cor[0]}$(fun_trans "VOLVER")\n${barra}"
while [[ ${opx} != @(0|[1-4]) ]]; do
echo -ne "${cor[0]}$(fun_trans "Digite una Opcion"): \033[1;37m" && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	menu;;
	1)
	elimi_dropbear
	break;;
	2)
	corre_squid
	break;;
    3)
	ssl_del
	break;;
    4)
	exit;;
  
esac
done
}
corregir_fun