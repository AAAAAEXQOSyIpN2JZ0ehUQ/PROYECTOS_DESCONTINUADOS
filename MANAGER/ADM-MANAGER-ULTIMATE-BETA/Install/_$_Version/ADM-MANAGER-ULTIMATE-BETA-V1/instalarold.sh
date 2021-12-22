#!/bin/bash

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

elimined_fun () {
text=$(source trans -b pt:${id} "Instalando")
echo -e "${cor[2]} $text Curl"
apt-get install screen -y > /dev/null 2>&1
apt-get install python -y > /dev/null 2>&1
echo -e "${cor[2]} $text Nmap"
apt-get install lsof -y > /dev/null 2>&1
apt-get install python3-pip -y > /dev/null 2>&1
echo -e "${cor[2]} $text Lsof"
apt-get install python -y > /dev/null 2>&1
apt-get install unzip -y > /dev/null 2>&1
echo -e "${cor[2]} $text Python3"
apt-get install zip -y > /dev/null 2>&1
apt-get install apache2 -y > /dev/null 2>&1
echo -e "${cor[2]} $text Unzip"
apt-get install ufw -y > /dev/null 2>&1
apt-get install nmap -y > /dev/null 2>&1
echo -e "${cor[2]} $text Screen"
apt-get install figlet -y > /dev/null 2>&1
apt-get install bc -y > /dev/null 2>&1
echo -e "${cor[2]} $text Apache2"
apt-get install lynx -y > /dev/null 2>&1
apt-get install curl -y > /dev/null 2>&1
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
}

instalar_fun () {
cd /etc/adm-lite && bash instalar
}

error_fun () {
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;31mYour apt-get Error!"
echo -e "Reboot the System!"
echo -e "Use Command:"
echo -e "\033[1;36mdpkg --configure -a"
echo -e "\033[1;31mVerify your Source.list"
echo -e "For Update Source list use this comand"
echo -e "\033[1;36mwget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ULTIMATE-BETA/raw/master/Install/apt-source.sh && chmod 777 ./* && ./apt-*"
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne "\033[0m"
exit 1
}

rm $(pwd)/$0
cor[1]="\033[1;36m"
cor[2]="\033[1;33m"
cor[3]="\033[1;31m"
cor[5]="\033[1;32m"
cor[4]="\033[0m"
cd $HOME
if ! apt-get install at -y > /dev/null 2>&1
then
error_fun
fi
if ! apt-get install netpipes -y > /dev/null 2>&1
then
error_fun
fi
if ! apt-get install gawk -y > /dev/null 2>&1
then
error_fun
fi
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
wget -O trans https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ULTIMATE-BETA/raw/master/Install/trans -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]}SELECT YOUR LANGUAGE\n${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠\n${cor[2]}[1]-PT-BR\n[2]-EN\n[3]-ES\n[4]-FR"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne " OPC: "; read lang
case $lang in
1)
id="pt"
;;
2)
id="en"
;;
3)
id="es"
;;
4)
id="fr"
;;
*)
id="pt"
;;
esac
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[5]} $(source trans -b pt:${id} "INSTALADOR ADM-SCRIPTS ®")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} $(source trans -b pt:${id} "Iniciando Instalação...")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne "${cor[4]}"
sleep 3s
wget -O lista https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ULTIMATE-BETA/master/lista -o /dev/null
if [ "$(cat $HOME/lista | grep $link_list/${key[1]})" = "" ]; then
[[ -e $HOME/lista ]] && rm $HOME/lista
echo -e "${cor[2]}INVÁLIDA, saliendo..."
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠\033[0m"
sleep 2s
exit
fi
echo -e "${cor[2]}$(source trans -b pt:${id} "Excelente!, Instalando...")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
[[ -d /etc/adm-lite ]] && rm -rf /etc/adm-lite
mkdir /etc/adm-lite
cd /etc/adm-lite
echo "cd /etc/adm-lite && bash ./menu" > /bin/menu && chmod +x /bin/menu
echo "cd /etc/adm-lite && bash ./menu" > /bin/adm && chmod +x /bin/adm
echo "verify" > /bin/verifysys && chmod +x /bin/verifysys
echo > /usr/bin/adm-ultimate && chmod +x /usr/bin/adm-ultimate
_contador="1"
cd /etc/adm-lite
wget -O lista https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ULTIMATE-BETA/master/lista -o /dev/null
wget -i lista -o /dev/null
_contador=$(($_contador + 1))
echo -e "${cor[3]}$(source trans -b pt:${id} "Agora Será Instalado las Dependencias")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
cd /etc/adm-lite
chmod +x ./*
instalar_fun
[[ -e $HOME/lista ]] && rm $HOME/lista && rm /etc/adm-lite/lista
cd /etc/
echo -e "
${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]}$(source trans -b pt:${id} "Deseja Instalar Painel De Upload?")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
read -p " [ s | n ]: " up_load
if [[ "$up_load" = "s" || "$up_load" = "S" ]]; then
bash /etc/adm-lite/insta_painel
fi
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]}$(source trans -b pt:${id} "Perfeito, Agora Presizamos Selecionar 1 Tipo de Instalação!!!")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} |1|• ${cor[2]}OPENSSH + PROXY"
echo -e "${cor[3]} |2|• ${cor[2]}DROPBEAR + PROXY"
echo -e "${cor[3]} |3|• ${cor[2]}OPENVPN + OPENSSH + PROXY"
cd /etc/adm-lite
echo -ne "${cor[1]}"
while true; do
read -p " [ 1~3 ]: " xadm
case $xadm in
1)
source openssh_proxy
break
;;
2)
source dropbear_proxy
break
;;
3)
source openvpn_proxy
break
;;
esac
done
exit