#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1

SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"


red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)

pid_inst () {
[[ $1 = "" ]] && echo -e "\033[1;31m[off]" && return 0
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
i=0
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e ${portas[@]}|grep "$var1 $var2")" ]] || {
    portas[$i]="$var1 $var2\n"
    let i++
    }
done <<< "$portas_var"
[[ $(echo "${portas[@]}"|grep "$1") ]] && echo -e "\033[1;32m[on]" || echo -e "\033[1;31m[off]"
}

#Screen
[[ ! -e /usr/bin/trans ]] && { 
echo -e "Piratear es muy feo, toma vergüenza en la cara"
echo -e "Di duro para llegar hasta aquí, Muchas noches sin dormir"
echo -e "Adquiere un Serial y Ayuda al desarrollador"
}
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && exit 1
SCPusr="${SCPdir}/ger-user" && [[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPidioma="${SCPdir}/idioma"
if [[ -e /etc/bash.bashrc-bakup ]]; then AutoRun="\033[1;32m[on]"
elif [[ -e /etc/bash.bashrc ]]; then AutoRun="\033[1;31m[off]"
fi
# Funcoes Globais
msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[35m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;36m' #MAG='\033[1;36m'
COLOR[7]='\033[1;34m' #AZULR='\033[1;34m'
COLOR[8]='\e[0;31m' #rojoc='\e[0;31m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
8)COLOR[$COL]='\033[1;34m';;
9)COLOR[$COL]='\033[0;31m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${COLOR[0]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="\e[1;30m=-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-=\e[0m" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
  -azuc)cor="${COLOR[7]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -rojoc)cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
esac
}
canbio_color () {
msg -ama "$(fun_trans "Hola, este es el Administrador de Colores") \033[1;31m[ NEW - ULTIMATE - SCRIPT ]  \033[1;33m[\033[1;34m ANONYMOUS \033[1;33m]"
msg -bar2
msg -ama "$(fun_trans "Selecciona 7 colores"): "
echo -e '\033[1;37m [1] ###\033[0m'
echo -e '\e[31m [2] ###\033[0m'
echo -e '\e[32m [3] ###\033[0m'
echo -e '\e[33m [4] ###\033[0m'
echo -e '\e[34m [5] ###\033[0m'
echo -e '\e[35m [6] ###\033[0m'
echo -e '\033[1;36m [7] ###\033[0m'
msg -bar2
for number in $(echo {1..7}); do
msg -ne "$(fun_trans "Introduzca el color") [$number]: " && read corselect
[[ $corselect != @([1-7]) ]] && corselect=1
cores+="$corselect "
corselect=0
done
echo "$cores" > /etc/new-adm-color
msg -bar2
}

menu_func () {
local options=${#@}
local array
for((num=1; num<=$options; num++)); do
echo -ne "$(msg -verd "[$num]") $(msg -verm2 ">") "
  array=(${!num})
  case ${array[0]} in
    "-vd")msg -verd "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
    "-vm")msg -verm2 "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
  "-azc")msg -azuc "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
  "-rc")msg -rojoc "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
  "-am")msg -ama "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
  "-bl")msg -bra "$(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
    "-fi")msg -azu "$(fun_trans "${array[@]:2}") ${array[1]}" | sed ':a;N;$!ba;s/\n/ /g';;
    *)msg -azu "$(fun_trans "${array[@]}")" | sed ':a;N;$!ba;s/\n/ /g';;
  esac
done
}

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m$(fun_trans "Selecione una Opcion"): " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

fun_trans () { 
local texto
local retorno
declare -A texto
SCPidioma="${SCPdir}/idioma"
[[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
local LINGUAGE=$(cat ${SCPidioma})
[[ -z $LINGUAGE ]] && LINGUAGE=es
[[ $LINGUAGE = "es" ]] && echo "$@" && return
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 &> /dev/null
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z "$(echo ${texto[$@]})" ]]; then
#ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
#NUM="$(($RANDOM%${#ENGINES[@]}))"
retorno="$(source trans -e bing -b es:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
echo "texto[$@]='$retorno'"  >> /etc/texto-adm
echo "$retorno"
else
echo "${texto[$@]}"
fi
}

panel_v10 () {
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PAINEL SSHPLUS v10           \E[0m"
echo ""
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINFORME SIEMPRE LA MISMA CONTRASENA"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -e "\033[1;36mINICIANDO INSTALACION"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO APACHE2\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get install apache2 -y > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO DEPENDENCIAS\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart 
echo ""
echo -e "\033[1;36mINSTALANDO MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINFORME SIEMPRE LA MISMA PASS CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON  \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, Para Continuar!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mINSTALANDO PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -e "\033[1;32mSELECIONE LA OPCION \033[1;31mAPACHE2 \033[1;32mCON LA TECLA '\033[1;33mENTER\033[1;32m'"
echo ""
echo -e "\033[1;32mSELECIONE \033[1;31mYES\033[1;32m EN LA SIGUIENTE OPCION (\033[1;36mdbconfig-common\033[1;32m)"
echo -e "PARA CONFIGURAR LA BASE DE DATOS"
echo ""
echo -e "\033[1;32mSIEMPRE INTRODUZCA LA MISMA CONTRASENA"
echo ""
echo -ne "\033[1;33mEnter, Para Continuar!\033[1;37m"; read
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
clear
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mINTRODUZCA LA MISMA CONTRASENA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE plus"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo ""
echo -e "\033[1;33mAGUARDE..."
echo ""
cd /var/www/html
wget https://www.dropbox.com/s/wcc3wdx49ep06mk/painel10.zip > /dev/null 2>&1
sleep 1
unzip painel10.zip > /dev/null 2>&1
rm -rf painel10.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://www.dropbox.com/s/5c6qnsj7nxqy9q8/plus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/plus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 plus < plus.sql
    rm /root/plus.sql
else
    clear
    echo -e "\033[1;31mERROR AL IMPORTAR BASE DE DATOS\033[0m"
    sleep 2
    exit
fi
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPANEL INSTALADO CON EXITO!"
echo ""
echo -e "\033[1;36mLINK AREA DE ADMIN:\033[1;37m $IP:81/admin\033[0m"
echo -e "\033[1;36mLINK AREA DE REVENDEDOR: \033[1;37m $IP:81\033[0m"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo ""

echo -e "\033[1;36mINGRESE ESTE ENLACE EN LA VPS QUE SERA SERVIDOR\033[0m"
echo -e "\033[1;37mwget http://ssh-plus.tk/revenda/confpainel/inst > /dev/null 2>&1; bash inst\033[0m"


echo -e "\033[1;33mCambie la contrasena una vez entrando al panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
}

panel_v11 () {
clear
IP=$(wget -qO- ipv4.icanhazip.com)
link="seu-ip"
cor="\e[1;30m=-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-=\e[0m"
cor2="\033[0;31m--------------------------------------------------------------------\033[0m"
dnk=@anonymous

echo -e "\e[1;34;47m########################################################"
echo -e "\e[1;34;47m#        _____ _____ _____ _____ _        ${dnk}#"              
echo -e "\e[1;34;47m#       |   __|   __|  |  |  _  | |_ _ ___             #"
echo -e "\e[1;34;47m#       |__   |__   |     |   __| | | |_ -|            #"
echo -e "\e[1;34;47m#       |_____|_____|__|__|__|  |_|___|___|            #"
echo -e "\e[1;34;47m#                                                      #"
echo -e "\e[1;34;47m# **************************************************** #"
echo -e "\e[1;30;47m# Este script funciona para administrar la vps desde   #"
echo -e "\e[1;30;47m# Un panel web,Podras crear revendedores,Cuentas ssh,  #"
echo -e "\e[1;30;47m# Dandole acceso alos vendedores atu vps para que      #"
echo -e "\e[1;30;47m# Administren desde un panel de revendedor........     #"
echo -e "\e[1;34;47m#                                                      #"
echo -e "\e[1;34;47m# NOTA:                                                #"
echo -e "\e[1;34;47m# Los usuarios solo aparecen en linea en el panel con  #"
echo -e "\e[1;34;47m# el puerto (OpenSSH,SSL,SQUID,OPENVPN) solo con       #"
echo -e "\e[1;34;47m# el puerto DROPBEAR no marca los usuarios en linea    #"
echo -e "\e[1;34;47m#                                                      #"
echo -e "\e[1;34;47m########################################################\033[0m"
echo -e "$cor" 
echo ""                     
echo -e "\e[1;37;44m#                 PANEL SSHPLUS WEB                    #\033[0m"
echo -e "$cor" 
echo ""
echo -ne "\033[1;32mINTRODUZCA UNA CONTRASENA\033[1;37m: "; read senha
echo -e "$cor" 
if [[ -z $senha ]]; then
echo -e "\n\033[1;31mCONTRASENA VACIA\033[0m"
sleep 2; clear; exit
fi
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
echo -e "\n\033[1;36mINICIANDO INSTALACION"
echo -e "$cor" 
echo ""
echo -e "\033[1;33mESPERE..."
echo -e "$cor" 
echo ""
apt-get update -y > /dev/null 2>&1
echo -e "\033[1;36mINSTALANDO APACHE2\033[0m"
echo -e "$cor" 
echo ""
echo -e "\033[1;33mESPERE..."
echo -e "$cor" 
echo ""
apt-get install apache2 -y > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo -e "\033[1;36mINSTALANDO DEPENDENCIAS\033[0m"
echo -e "$cor" 
echo ""
echo -e "\033[1;33mESPERE..."
echo -e "$cor" 
echo ""
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
echo -e "\033[1;36mINSTALANDO MySQL\033[0m"
echo -e "$cor" 
echo ""
echo -e "\n\033[1;33mESPERE..."
echo -e "$cor" 
sleep 1
echo "debconf mysql-server/root_password password $senha" | debconf-set-selections
echo "debconf mysql-server/root_password_again password $senha" | debconf-set-selections
apt-get install mysql-server -y > /dev/null 2>&1
mysql_install_db > /dev/null 2>&1
(echo $senha; echo n; echo y; echo y; echo y; echo y)|mysql_secure_installation > /dev/null 2>&1
echo -e "\n\033[1;36mINSTALANDO PHPMYADMIN\033[0m"
echo -e "$cor" 
echo ""
echo -e "\n\033[1;33mESPERE..."
echo -e "$cor" 
echo ""
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
apt-get install phpmyadmin -y > /dev/null 2>&1
php5enmod mcrypt > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
apt-get install php-ssh2 > /dev/null 2>&1
if [ "$(php -m |grep ssh2)" != "ssh2" ]; then
  clear
  echo -e "\033[1;31mERROR CRITICO\033[0m"
  #rm $HOME/install
  exit
fi
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo -e "$cor"
echo -e "\033[1;33mESPERE..."
echo -e "$cor"
cd /var/www/html
wget https://www.dropbox.com/s/ejwek9i5hbzc2by/PAINELWEB1.zip > /dev/null 2>&1
unzip PAINELWEB1.zip > /dev/null 2>&1
sleep 1
rm -rf PAINELWEB1.zip index.html > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
mysql -h localhost -u root -p$senha --default_character_set utf8 sshplus < sshplus.sql
sleep 1
rm sshplus.sql > /dev/null 2>&1
(crontab -l 2>/dev/null; echo -e "* * * * * /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php\n*/1 * * * * /usr/bin/php /var/www/html/pages/system/cron.ssh.php\n0 */1 * * * /usr/bin/php /var/www/html/pages/system/hist.online.php\n0 */2 * * * /usr/bin/php /var/www/html/pages/system/cron.php\n0 */3 * * * /usr/bin/php /var/www/html/pages/system/cron.servidor.php") | crontab -
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart > /dev/null 2>&1
/etc/init.d/mysql restart > /dev/null 2>&1
sed -i '26i\header("Content-Type: application/download");' /var/www/html/pages/downloads/baixar.php
clear
echo -e "\033[1;32mPAINEL INSTALADO CON EXITO!"
echo -e "$cor"
echo -e "\033[1;36mSU PAINEL\033[1;37m $IP:81/admin\033[0m"
echo -e "$cor2"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "$cor2"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo -e "$cor2"
echo -e "$cor"
echo -e "\033[1;33mCambie la contrasena al iniciar sesion en el panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
rm /root/install > /dev/null 2>&1
}

del_panel () {
clear
echo -e "$barra"
echo -e "\033[1;32m SIEMPRE CONFIRME LAS PREGUNTAS CON LA LETRA \033[1;37m Y "
echo -e "\033[1;32m PRESIONE ENTER PARA CONFIRMAR \033[1;37mENTER"
echo -e "$cor"
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /var/www/html
mkdir /var/www/html
echo -e "$cor"
echo -e "\033[1;36mPANEL SSHPLUS ELIMINADO CON EXITO \033[1;32m[!OK]"
echo -e "$cor"
}


webmin () {
BARRA1="\e[1;30m=-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-=\e[0m"
BARRA="\e[0;31m--------------------------------------------------------------------\e[0m"
meu_ip () {
if [[ -e /etc/MEUIPADM ]]; then
echo "$(cat /etc/MEUIPADM)"
else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
fi
}
IP="$(meu_ip)"
menu ()
{

clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Webmin Install" ; tput sgr0 ; echo ""
echo -e "$BARRA1"
echo ""
tput setaf 2 ; tput bold ; printf '%s' "[1]"; tput setaf 6 ; printf '%s' " Instalar WEBMIN" ; tput setaf 4 ; printf '%s' " = " ; tput setaf 7 ; echo "Iniciara la instalacion automatica del panel webmin" ; tput sgr0 ;
echo -e "$BARRA"
tput setaf 2 ; tput bold ; printf '%s' "[2]"; tput setaf 6 ; printf '%s' " Eliminar WEBMIN" ; tput setaf 4 ; printf '%s' " = " ; tput setaf 7 ; echo "Iniciara la eliminacion automatica del panel webmin" ; tput sgr0 ;
echo -e "$BARRA"
tput setaf 2 ; tput bold ; printf '%s' "[0]"; tput setaf 6 ; printf '%s' " Salir" ; tput setaf 4 ; printf '%s' " = " ; tput setaf 7 ; echo "Regresar al menu" ; tput sgr0 ;
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Selecione una opcion" ; tput sgr0 ; echo ""
echo -e "$BARRA1"
read -p "Introduzca un numero: " opcao

case $opcao in
	1) installwebmin ;;
	2) removewebmin ;;
	0) exit ;;
esac

}

installwebmin()
{
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Iniciando instalacion" ; tput sgr0 ; echo ""
mkdir webmininstall
cd webmininstall
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
dpkg -i webmin_1.831_all.deb
apt-get -f install
rm -R webmin_1.831_all.deb
cd $USER
rm -R webmininstall
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Instalacion Completa para acceder" ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Al panel Webmin pegue en su navegador" ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "https://$IP:10000" ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Y deve logearse con usuario root y contrasena" ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "de su servidor VPS" ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Si se produce un error de seguridad en el navegador," ; tput sgr0
echo -e "$BARRA"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "de en opciones avanzadas y en continuar de todos modos" ; tput sgr0
echo -e "$BARRA"
}

removewebmin() {
clear
apt-get purge webmin -y
apt-get autoremove -y
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Eliminado con exito" ; tput sgr0 ; echo ""
}
menu
}



msg -bar
menu_func "SSHPLUS V10" "SSHPLUS V11" "-vm Eliminar panel" "webmin"
echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") " && msg -bra "SALIR DEL SCRIPT"
msg -bar
# FIM
selection=$(selection_fun 4)
case ${selection} in
1)panel_v10;;
2)panel_v11;;
3)del_panel;;
4)webmin;;
esac
msg -ne "$(fun_trans "Enter Para Continuar")" && read enter
${SCPdir}/menu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 