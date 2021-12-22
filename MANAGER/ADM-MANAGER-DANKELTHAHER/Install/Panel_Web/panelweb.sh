#!/bin/bash
red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)
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
  "-bar2"|"-bar")cor="\e[1;30m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
  -azuc)cor="${COLOR[7]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -rojoc)cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
esac
}
canbio_color () {
msg -ama "$(fun_trans "Hola, este es el Administrador de Colores") \033[1;31m[ NEW - ULTIMATE - SCRIPT ]  \033[1;33m[\033[1;34m OFICIAL BY DANKELTHAHER \033[1;33m]"
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
wget https://www.dropbox.com/s/2x6w32kacpkmzvc/painel10.zip > /dev/null 2>&1
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
wget https://www.dropbox.com/s/3zfjofux5ooxrwj/plus.sql > /dev/null 2>&1
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
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PANEL SSHPLUS v11          \E[0m"
echo ""
echo ""
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINTRODUZCA LA MISMA PASS CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -e "\033[1;36mINICIANDO INSTALACION"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO O APACHE2\033[0m"
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
echo -e "\033[1;36mINSTALANDO O MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINTRODUZCA LA MISMA CONTRASENA CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, Para Continuiar!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mINSTALANDO PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -e "\033[1;32mSELECIONE LA OPCION \033[1;31mAPACHE2 \033[1;32mCON A TECLA '\033[1;33mENTER\033[1;32m'"
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
echo -e "\033[1;31mATENĂ‡ION \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mINFORME LA MISMA CONTRASENA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
echo ""
cd /var/www/html
wget https://www.dropbox.com/s/v7b6yiwg5jn4prh/PAINELWEB1.zip > /dev/null 2>&1
sleep 1
unzip PAINELWEB1.zip > /dev/null 2>&1
rm -rf PAINELWEB1.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://www.dropbox.com/s/lfxwu5wy7i46b80/sshplus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/sshplus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 sshplus < sshplus.sql
    #rm /root/sshplus.sql
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
echo -e "\033[1;32mPAINEL INSTALADO CON EXITO!"
echo ""
echo -e "\033[1;36mLINK AREA ADMIN:\033[1;37m $IP:81/admin\033[0m"
echo -e "\033[1;36mLINK AREA REVENDA: \033[1;37m $IP:81\033[0m"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo -e "\033[1;33mCambie la contrasena cuando logre entrar al panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
}
msg -bar
menu_func "SSHPLUS V10" "SSHPLUS V11"
echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") " && msg -bra "$(fun_trans "SALIR DEL SCRIPT")"
msg -bar
# FIM
selection=$(selection_fun 2)
case ${selection} in
1)panel_v10;;
2)panel_v11;;
esac
msg -ne "$(fun_trans "Enter Para Continuar")" && read enter
${SCPdir}/menu