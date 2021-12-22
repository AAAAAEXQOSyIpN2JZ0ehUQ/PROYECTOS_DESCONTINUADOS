#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
cowsay -f eyes "esta herramienta cambia la contrase�a de tu vps...." | lolcat 
figlet ..dankelthaher.. | lolcat
echo -e "\033[47;31mATENCION: \033[1;34m ESTA CONTRASENA SERA USADA PARA ENTRAR A SU SERVIDOR
\033[1;31m\033[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;31mESCRIBA SU NUEVA CONTRASENA\e[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
read  -p ": " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;34mCONTRASENA CAMBIADA CON EXITO!\e[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"

echo -e "\033[1;34mSU CONTRASENA AHORA ES: \033[1;32m$pass\e[0m"

  sleep 3s