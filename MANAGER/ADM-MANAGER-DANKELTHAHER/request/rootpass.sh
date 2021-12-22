#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
clear
apt-get install figlet -y
apt-get install cowsay -y
echo -e ""
apt-get install lolcat -y
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
cowsay -f eyes "esta herramienta cambia a usuario ROOT las vps de googlecloud y amazon...." | lolcat 
figlet ..dankelthaher.. | lolcat
sleep 4s
sed -i "s;PermitRootLogin prohibit-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PermitRootLogin without-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PasswordAuthentication no;PasswordAuthentication yes;g" /etc/ssh/sshd_config
echo -e "\033[47;31mATENCION: \033[1;34m ESTA CONTRASENA SERA USADA PARA ENTRAR A SU SERVIDOR LOGEADO COMO ROOT\033[1;31m\033[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;31mESCRIBA SU NUEVA CONTRASENA\e[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
read  -p ": " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;34mCONTRASENA AGREGADA CON EXITO!\e[0m"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;34mSU CONTRASENA NUEVA ES: \033[1;32m$pass\e[0m"

echo ""
fun_bar "service ssh restart"

  sleep 3s