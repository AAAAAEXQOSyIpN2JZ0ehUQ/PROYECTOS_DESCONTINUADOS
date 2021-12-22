#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
barra="\033[0m\e[34m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans http://git.io/trans &> /dev/null

fun_trans () {
declare -A texto
[[ ! -e /etc/texto-gestor ]] && touch /etc/texto-gestor
source /etc/texto-gestor
if [[ -z $(echo ${texto[$2]}) ]]; then
 retorno="$(source trans -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 if [[ $retorno = "" ]];then
 retorno="$(source trans -e bing -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 fi
 if [[ $retorno = "" ]];then 
 retorno="$(source trans -e yandex -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 fi
 echo "texto[$2]='$retorno'"  >> /etc/texto-gestor
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}

update_pak () {
echo -ne " \033[1;31m[ ! ] apt-get update"
apt-get update -q > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
return
}

reiniciar_ser () {
echo -ne " \033[1;31m[ ! ] Services restart"
( 
[[ -e /etc/init.d/stunnel4 ]] && /etc/init.d/stunnel4 restart
[[ -e /etc/init.d/squid ]] && /etc/init.d/squid restart
[[ -e /etc/init.d/squid3 ]] && /etc/init.d/squid3 restart
[[ -e /etc/init.d/apache2 ]] && /etc/init.d/apache2 restart
[[ -e /etc/init.d/openvpn ]] && /etc/init.d/openvpn restart
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear restart
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart
fail2ban-client -x stop && fail2ban-client -x start
) > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
return
}

reiniciar_vps () {
echo -ne " \033[1;31m[ ! ] Sudo Reboot"
sleep 3s
echo -e "\033[1;32m [OK]"
(
sudo reboot
) > /dev/null 2>&1
echo -e "$barra"
return
}

host_name () {
unset name
while [[ ${name} = "" ]]; do
echo -ne "\033[1;37m $(fun_trans ${id} "Digite o nome do host"): " && read name
tput cuu1 && tput dl1
done
hostnamectl set-hostname $name 
if [ $(hostnamectl status | head -1  | awk '{print $3}') = "${name}" ]; then 
echo -e "\033[1;32m $(fun_trans ${id} "Nome de host alterado corretamente")!, $(fun_trans ${id} "reiniciar VPS")"
else
echo -e "\033[1;31m $(fun_trans ${id} "Nome de host não modificado")!"
fi
echo -e "$barra"
return
}


gestor_fun () {
echo -e " \033[1;32m $(fun_trans ${id} "Administrador VPS") [NEW-ADM]"
echo -e "$barra"
while true; do
echo -e "${cor[4]} [1] > \033[1;37m$(fun_trans ${id} "Atualizar pacotes")"
echo -e "${cor[4]} [2] > \033[1;37m$(fun_trans ${id} "Alterar o nome do VPS")"
echo -e "${cor[4]} [3] > \033[1;37m$(fun_trans ${id} "Reiniciar os Serviços")"
echo -e "${cor[4]} [4] > \033[1;37m$(fun_trans ${id} "Reiniciar VPS")"
echo -e "${cor[4]} [0] > \033[1;37m$(fun_trans ${id} "VOLTAR")\n${barra}"
while [[ ${opx} != @(0|[1-5]) ]]; do
echo -ne "${cor[0]}$(fun_trans ${id} "Digite a Opcao"): \033[1;37m" && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	return;;
	1)
	update_pak
	break;;
	2)
	host_name
	break;;
	3)
	reiniciar_ser
	break;;
	4)
	reiniciar_vps
	break;;
esac
done
}
gestor_fun