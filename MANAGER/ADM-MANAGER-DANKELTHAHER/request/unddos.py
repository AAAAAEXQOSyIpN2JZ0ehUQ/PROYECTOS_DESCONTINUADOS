#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
cowsay -f eyes "esta herramienta desinstala la version pasada de ANTI-DDoS" | lolcat 
figlet ..dankelthaher.. | lolcat
BARRA1="\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "$BARRA1"

echo -e "\e[1;34mUninstalling DOS-Deflate\e[0m"
sleep 3s
echo -e "$BARRA1"

echo -e "\e[0;31mEliminando archivos de script .....\e[0m"
sleep 4s


if [ -e '/usr/local/sbin/ddos' ]; then

	rm -f /usr/local/sbin/ddos

	echo -n ".."

fi

if [ -d '/usr/local/ddos' ]; then

	rm -rf /usr/local/ddos

	echo -n ".."
sleep 3s
echo ""
echo -e "$BARRA1"
sleep 3s
fi

echo -e "\e[0;32m...HECHO\e[0m"
echo -e "$BARRA1"
sleep 3s



echo -e "\e[1;33mBorrando cron job .....\e[0m"

if [ -e '/etc/cron.d/ddos.cron' ]; then

	rm -f /etc/cron.d/ddos.cron

	echo -n ".."
sleep 3s
echo ""
echo -e "$BARRA1"


fi
sleep 3s
echo -e "\e[0;32m...HECHO\e[0m"
echo -e "$BARRA1"
sleep 3s


echo -e "\e[1;33mDesinstalacion completa\e[0m"
echo -e "$BARRA1"
