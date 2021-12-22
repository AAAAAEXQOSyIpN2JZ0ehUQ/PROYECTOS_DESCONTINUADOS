#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"

apt-get install lsof
apt-get install sudo
apt-get install figlet -y
apt-get install cowsay -y
apt-get install bc -y
apt-get install python -y
echo -e ""
apt-get install lolcat -y
clear

mm_decho ()
{
local i stepping
stepping="0.01"

# When first argument is empty or not given, it just echoes a new line
# and leaves.
if [ ! "$1" ]; then 
echo
return
fi

# If a second argument is given (delay stepping), check it for validity
# (if it is a float) and set stepping according to the argument.
if (( $# > 1 )) && 
[[ ($2 = $(echo $2 | grep -oE '[[:digit:]]')) ||
($2 = $(echo $2 | grep -oE '[[:digit:]]+\.[[:digit:]]+')) ]] 
then
stepping="$2"
# In case the previous test failed, but we have a second argument,
# meaning it is invalid, just print the message, complain a bit and then
# quit the function with false.
elif (( $# > 1 )); then
echo "$1"
echo ".! mm_decho() oops: second argument is invalid!" 1>&2
echo ".! must be /float but is: \"$2\", leaving function.." 1>&2
return false 2>/dev/null
fi

# Do delayed printing of first input argument. Calculate the
# length of first arg. and substract one. Then make it a /for/
# sequence going through all the characters of the string,
# printing these and wait the delay stepping time.
for i in $(seq 0 $((${#1}-1))); do
echo -ne "${1:$i:1}"
sleep $stepping
done
echo
}

msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="\e[0;31m========================================\e[0m" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="${AZUL}${NEGRITO}========================================" && echo -e "${cor}${SEMCOR}";;
 esac
}

# VARIABLES DE COLORES
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'

COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[35m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;36m' #MAG='\033[1;36m'
BARRA="\e[0;31m--------------------------------------------------------------------\e[0m"
blan='\033[1;37m'
ama='\033[1;33m'
blue='\033[1;34m'
asul='\033[0;34m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# LOGO DO INSTALADOR
fun_logo(){
BARRA="\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "$BARRA"
cat << EOF

           INSTALADOR ADM-NEW FREE OFICIAL
           FEITO POR LUIS 8TH (BOM USO)
           
EOF
echo -e "$BARRA"
}
meu_ip(){
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ $MIP = "127.0.0.1" ]]; then
MIP=$(wget -qO- ipv4.icanhazip.com)
elif [[ ! $MIP ]]; then
MIP=$(wget -qO- ipv4.icanhazip.com)
fi
echo "$MIP"
}

install_fim () {
msg -bar2
msg -ama "$(source trans -b es:${id} "Instalacion completa, utilice los comandos"|sed -e 's/[^a-z -]//ig')" && echo -e "$BARRA"
echo -e " menu / adm"
msg -bar2
}

# Variables
Basic="menu PGet.py ports.sh ADMbot.sh usercodes sockspy.sh POpen.py v2ray.sh vnc htop.sh GENERADOR_BIN.sh payySND.sh  toolmaster.py insta_painel rootpass.sh Proxy-Publico.sh Proxy-Privado.sh Gestor.sh panelweb.sh unddos.py dados.py cambiopass.sh Crear-Demo.sh PPriv.py PPub.py PDirect.py ssrrmu.sh shadown.sh ssld.sh speedtest.py speed.sh utils.sh dropbear.sh apacheon.sh openvpn.sh shadowsocks.sh ssl.sh squid.sh"
LINK="https://www.dropbox.com/s/1yjzitlg1kkceyl/Script-xtomx.zip?dl=0"
TEMP="$HOME/$RANDOM" && [[ ! -d ${TEMP} ]] && mkdir ${TEMP}
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
SCPusr="${SCPdir}/ger-user" && [[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPfrm3="/etc/adm-lite" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
SCPidioma="${SCPdir}/idioma"
if [[ -e /etc/adm-lite ]]; then
echo ""
else
mkdir /etc/adm-lite
fi
if [[ -e /etc/nanobc ]]; then
echo ""
else
mkdir /etc/nanobc
fi
if [[ -e /etc/bin ]]; then
echo ""
else
mkdir /etc/bin
fi
if [[ -e /etc/crondbl ]]; then
echo ""
else
mkdir /etc/crondbl
fi
if [[ -e /etc/rom ]]; then
echo ""
else
mkdir /etc/rom
fi
if [[ -e /etc/expects ]]; then
echo ""
else
mkdir /etc/expects
fi

funcao_idioma () {
msg -bar2
echo -e "\e[1;33mSelecione Un Idioma\e[0m"
msg -bar2
declare -A idioma=( [1]="en English" [2]="fr Franch" [3]="de German" [4]="it Italian" [5]="pl Polish" [6]="pt Portuguese" [7]="es Spanish" [8]="tr Turkish" )
for ((i=1; i<=12; i++)); do
valor1="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor1 ]] && break
valor1="\033[1;32m[$i] > \033[0;31m$valor1"
    while [[ ${#valor1} -lt 37 ]]; do
       valor1=$valor1" "
    done
echo -ne "$valor1"
let i++
valor2="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor2 ]] && {
   echo -e " "
   break
   }
valor2="\033[1;32m[$i] > \033[0;31m$valor2"
     while [[ ${#valor2} -lt 37 ]]; do
        valor2=$valor2" "
     done
echo -ne "$valor2"
let i++
valor3="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor3 ]] && {
   echo -e " "
   break
   }
valor3="\033[1;32m[$i] > \033[0;31m$valor3"
     while [[ ${#valor3} -lt 37 ]]; do
        valor3=$valor3" "
     done
echo -e "$valor3"
done
msg -bar2
unset selection
while [[ ${selection} != @([1-8]) ]]; do
echo -ne "\033[1;37mSELECIONE: " && read selection
tput cuu1 && tput dl1
done
pv="$(echo ${idioma[$selection]}|cut -d' ' -f1)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}

wget -O /usr/bin/trans https://www.dropbox.com/s/v7wfn6wwtiaq1ps/trans?dl=0 &> /dev/null
clear
msg -bar2
cowsay -f eyes "BIENVENIDO Y GRACIAS POR UTILIZAR NEW-ADM" | lolcat
figlet ..new-XTOMX.. | lolcat
 echo -e " "
msg -bar2
msg -bra "[ NEW - ADM ] ? \033[1;33m[\033[1;34m XTOMX +529335694027 \033\033[1;33m]\033[0m"
echo ""
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }

# Instalacion
clear

figlet ..TOM4NDANTE.. | lolcat
msg -bar2
echo -e "${green}ESPERE UN MOMENTO${plain}"
apt-get install php -y >/dev/null 2>&1
apt-get install jq -y >/dev/null 2>&1
echo ""
echo -e "$BARRA"
apt-get install apache2 -y &>/dev/null && mm_decho "INSTALANDO APACHE2" "0.08"
 sed -i "s;Listen 81;Listen 85;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 echo -e "$BARRA"
apt-get update -y >/dev/null 2>&1 && mm_decho "INSTALANDO DEPENDENCIAS" "0.08"
apt-get upgrade -y >/dev/null 2>&1
apt-get install screen -y >/dev/null 2>&1
echo -e "$BARRA"
apt-get install zip -y >/dev/null 2>&1 && mm_decho "ACTUALIZANDO SISTEMA" "0.08"
apt-get python -y >/dev/null 2>&1
echo -e "$BARRA"
apt-get install unzip -y >/dev/null 2>&1 && mm_decho "EJECUTANDO DESCARGA" "0.08"
apt-get python3 -y >/dev/null 2>&1
echo -e "$BARRA"
wget ${LINK} -O $HOME/ADM -o /dev/null && mm_decho "MOVIENDO ARCHIVOS" "0.08"
echo -e "$BARRA"
cd ${TEMP} && unzip $HOME/ADM && echo -e "$BARRA" && mm_decho "EXITO EN EXTRACCION!" "0.08"

echo -e "$BARRA"
echo -e "${COLOR[0]}INSTALANDO..."
echo -e "$BARRA"

echo -ne "${COLOR[3]}["
#Transferencia de arquivo.
for arq in `ls ${TEMP}`; do
echo -ne "${COLOR[1]}X" && sleep 0.2s
case $arq in
"painel.zip")mv -f ${TEMP}/$arq ${SCPfrm3}/$arq && chmod +x ${SCPfrm3}/$arq;;
"dados.zip")mv -f ${TEMP}/$arq ${SCPfrm3}/$arq && chmod +x ${SCPfrm3}/$arq;;
"openssh.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"ssrrmu.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"v2ray.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"vdoray.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"ssld.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"shadown.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"squid.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"dropbear.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"openvpn.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"ssl.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"sslmanager.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"shadowsock.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"errormanager.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"shadowsocks.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"sockspy.sh")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"PDirect.py")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"PGet.py")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"POpen.py")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"PPriv.py")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"PPub.py")mv -f ${TEMP}/$arq ${SCPinst}/$arq && chmod +x ${SCPinst}/$arq;;
"ports.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"Crear-Demo.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"cambiopass.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"permisos_passwd.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"unddos.py")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"hora.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"dados.py")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"Gestor.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"insta_painel")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"panelweb.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"Proxy-Privado.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"Proxy-Publico.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"rootpass.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"toolmaster.py")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"vnc")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"fai2ban.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"htop.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"paysnd.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"payySND.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"GENERADOR_BIN.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"MasterBin.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"apacheon.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"utils.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"dados.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"speed.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"ultrahost")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"ADMbot.sh")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"speedtest.py")mv -f ${TEMP}/$arq ${SCPfrm}/$arq && chmod +x ${SCPfrm}/$arq;;
"usercodes")mv -f ${TEMP}/$arq ${SCPusr}/$arq && chmod +x ${SCPusr}/$arq;;
*)mv -f ${TEMP}/$arq ${SCPdir}/$arq && chmod +x ${SCPdir}/$arq;;
esac
done && rm -rf ${TEMP}
echo -e "${COLOR[3]}]"

#Creando Inicializador
cat << EOF > /bin/adm
#!/bin/bash
cd ${SCPdir} && ./menu
EOF
cat << EOF > /bin/menu
#!/bin/bash
cd ${SCPdir} && ./menu
EOF
chmod +x /bin/adm && chmod +x /bin/menu
[[ ${#id} -gt 2 ]] && echo "${id}" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
[[ ${byinst} = "true" ]] && install_fim

#Eliminando Arqs

rm $HOME/ADM > /dev/null 2>&1
rm $HOME/$0  > /dev/null 2>&1

#echo -e "${COLOR[0]}INSTALACION FINALIZADA PARA ENTRAR USE: ${COLOR[1]}adm o menu \033[0m'"
echo ""
echo -e "${COLOR[0]}GRACIAS POR UTILIZAR"
echo -e "$BARRA"
msg -bra "[ NEW - ADM ] ? \033[1;33m[\033[1;34m ScriptMX \033\033[1;33m]\033[0m"
echo ""
echo -e "$BARRA"