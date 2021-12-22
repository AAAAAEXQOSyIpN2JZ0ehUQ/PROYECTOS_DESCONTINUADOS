#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
cowsay -f eyes "con esta herramienta puedes verificar los procesos del sistema...." | lolcat 
figlet ..dankelthaher.. | lolcat
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[47;31mATENCION: \033[1;34m LA INSTALACION PUEDE DEMORAR UNOS MINUTOS\033[1;31m\033[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
apt-get install htop > /dev/null 2>&1
sleep 4s
echo -e "\033[1;31mPARA SALIR DEL PANEL PRESIONE CTLR+C \e[0m"
sleep 5s
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"

htop

