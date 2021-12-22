#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
cowsay -f eyes "esta herramienta ayuda aproteger tu vps de un ataque DDOS" | lolcat 
figlet ..dankelthaher.. | lolcat
BARRA1="\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "$BARRA1"

if [ -d '/usr/local/ddos' ]; then

	echo; echo; echo "\e[1;31mDESINSTALA LA VERSION ANTERIOR CON UN-DDOS\e[0m"

	exit 0

else

	mkdir /usr/local/ddos

fi

echo -e "$BARRA1"

echo -e "\e[1;34mInstalando DOS-Deflate 0.6\e[0m"
echo -e "$BARRA1"
sleep 4s

echo -e "\e[1;31mDescargando archivos fuente ...\e[0m"
echo -e "$BARRA1"
sleep 4s

wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf

echo -e "\e[1;33mDESCARGANDO (dados.conf)\e[0m"
sleep 3s
echo ""

wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE 
echo -e "\e[1;33mDESCARGANDO \e[1;37m(LICENSE)\e[0m"
sleep 3s
echo ""

wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -e "\e[1;33mDESCARGANDO (ignore.ip.list)\e[0m"
sleep 3s

wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh

chmod 0755 /usr/local/ddos/ddos.sh

cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo ""
echo -e "$BARRA1"

echo -e "\e[0;32m...HECHO\e[0m"
sleep 3s

echo -e "$BARRA1"
echo -e "\e[1;34mCreando CRON para ejecutar el script cada minuto ..... (ajuste predeterminado)\e[0m"
sleep 4s
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo -e "$BARRA1"
echo -e "\e[0;32m.....HECHO\e[0m"
sleep 3s

echo -e "$BARRA1"
echo -e "\e[1;37mLa instalacion ha finalizado.\e[0m"
echo -e "$BARRA1"
echo -e "\e[1;37mEl archivo de configuracion esta en \e[1;33m/usr/local/ddos/ddos.conf\e[0m"
echo -e "$BARRA1"
echo -e "\e[1;37mGRACIAS POR UTILIZAR NEW-ADM \033[1;33m[\033[1;34m OFICIAL BY-DANKELTHAHER \033[1;33m]"
echo -e "$BARRA1"

echo


exit