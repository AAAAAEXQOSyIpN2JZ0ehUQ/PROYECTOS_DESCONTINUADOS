#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
cowsay -f eyes "Con esta herramienta puedes ver el trafico de red...." | lolcat 
figlet ..dankelthaher.. | lolcat
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;31mPARA SALIR DEL PANEL PRESIONE CTLR+C \e[0m"
sleep 5s
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"

nload

