#!/bin/bash
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
host_name () {
unset name
while [[ ${name} = "" ]]; do
echo -ne "\033[1;37m $(fun_trans "Digite el nombre nuevo"): " && read name
tput cuu1 && tput dl1
done
hostnamectl set-hostname $name 
if [ $(hostnamectl status | head -1  | awk '{print $3}') = "${name}" ]; then 
echo -e "\033[1;32m $(fun_trans "Nombre de la vps alterado corretamente")!, $(fun_trans "reiniciar VPS")"
else
echo -e "\033[1;31m $(fun_trans "Nombre de la vps no modificado")!"
fi
echo -e "$barra"
return
}

cambiopass () {
echo -e "${cor[5]} $(fun_trans "Esta herramienta cambia la contraseña de su servidor vps")"
echo -e "${cor[5]} $(fun_trans "Esta contraseña es utilizada como usuario") root"
echo -e "$barra"
echo -e "${cor[0]} $(fun_trans "Escriba su nueva contraseña")"
echo -e "$barra"
read  -p " Nuevo passwd: " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
echo -e "$barra"
echo -e "${cor[0]} $(fun_trans "Contraseña cambiada con exito!")"
echo -e "${cor[0]} $(fun_trans "Su contraseña ahora es"): ${cor[2]}$pass\n${barra}"
return
}

rootpass () {
echo -e "${cor[5]} $(fun_trans "Esta herramienta cambia a usuario root las vps de ")"
echo -e "${cor[5]} $(fun_trans "Googlecloud y Amazon esta configuracion solo")"
echo -e "${cor[5]} $(fun_trans "funcionan en Googlecloud y Amazon Puede causar")"
echo -e "${cor[5]} $(fun_trans "error en otras VPS agenas a Googlecloud y Amazon ")"
echo -e "$barra"
echo -e " $(fun_trans "Desea Seguir?")"
read -p " [S/N]: " -e -i n PROS
[[ $PROS = @(s|S|y|Y) ]] || exit 1
echo -e "$barra"
#Inicia Procedimentos
#Parametros iniciais
sed -i "s;PermitRootLogin prohibit-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PermitRootLogin without-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PasswordAuthentication no;PasswordAuthentication yes;g" /etc/ssh/sshd_config
echo -e "${cor[5]} $(fun_trans "Esta contraseña es utilizada como usuario") root"
echo -e "$barra"
echo -e "${cor[0]} $(fun_trans "Escriba su nueva contraseña")"
echo -e "$barra"
read  -p " Nuevo passwd: " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
echo -e "$barra"
echo -e "${cor[0]} $(fun_trans "Contraseña cambiada con exito!")"
echo -e "${cor[0]} $(fun_trans "Su contraseña ahora es"): ${cor[2]}$pass\n${barra}"
echo -e "${cor[5]} $(fun_trans "Configuracoes adicionadas")"
echo -e "${cor[5]} $(fun_trans "La vps estar totalmente configurada")"
echo -e "$barra"
service ssh restart > /dev/null 2>&1
return
}
shadowe_fun () {
echo -e " \033[1;36m $(fun_trans "PERMISOS ROOT PASSWD") \033[1;32m[NEW-ADM]"
echo -e "$barra"
while true; do
echo -e "${cor[4]} [1] > ${cor[5]}$(fun_trans "LIBERAR VPS VURTL PARA CREAR USUARIOS")"
echo -e "${cor[4]} [2] > ${cor[5]}$(fun_trans "CAMBIAR CONTRASEÑA ROOT DELA VPS")"
echo -e "${cor[4]} [3] > ${cor[5]}$(fun_trans "PERMISO ROOT PARA Googlecloud y Amazon")"
echo -e "${cor[5]} [4] > ${cor[4]}$(fun_trans "ALTERAR NOMBRE DE LA VPS")"
echo -e "${cor[4]} [5] > ${cor[0]}$(fun_trans "VOLVER")"
echo -e "${cor[4]} [0] > ${cor[0]}$(fun_trans "SALIR")\n${barra}"
while [[ ${opx} != @(0|[1-5]) ]]; do
echo -ne "${cor[0]}$(fun_trans "Digite una Opcion"): \033[1;37m" && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	exit;;
	1)
	wget -O /bin/pan_cracklib.sh https://www.dropbox.com/s/k3p5h7zfj6ou70b/pan_cracklib.sh > /dev/null 2>&1; chmod +x /bin/pan_cracklib.sh; pan_cracklib.sh
	break;;
	2)
	cambiopass
	break;;
    3)
	rootpass
	break;;
    4)
	host_name
	break;;
    5)
	return;;
  
esac
done
}
shadowe_fun