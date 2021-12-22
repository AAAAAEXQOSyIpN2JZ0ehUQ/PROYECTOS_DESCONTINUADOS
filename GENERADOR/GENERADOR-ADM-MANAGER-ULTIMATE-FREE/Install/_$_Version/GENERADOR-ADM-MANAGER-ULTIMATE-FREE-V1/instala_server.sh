#!/bin/bash
cd
if [ $(id -u) != 0 ]
then
echo "Ejecte este script como root"
exit
fi
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;32m ° PREPARANDO SYSTEMA...\033[0m"
rm -rf /etc/adm-server  2>/dev/null
mkdir /etc/adm-server 2>/dev/null
rm -rf $HOME/instala_server.sh > /dev/null 2>&1

corPadrao="\033[0m"
preto="\033[0;30m"
vermelho="\033[0;31m"
verde="\033[0;32m"
marrom="\033[0;33m"
azul="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
cinzaClaro="\033[0;37m"
pretoCinza="\033[1;30m"
vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m"
amarelo="\033[1;33m"
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m"
cyanClaro="\033[1;36m"
branco="\033[1;37m"

echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;31m ° INSTALADOR ADM-SCRIPTS KEY-ADM-MANAGER ®\033[0m"
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
sleep 5

echo -e "\033[1;33m ° ACTUALIZANDO SYSTEMA...\033[1;32m"
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;33m Aguarde...\033[1;32m"

apt-get update -y > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1
apt-get install netpipes -y > /dev/null 2>&1
apt-get install zip -y > /dev/null
apt-get install unzip -y > /dev/null
apt-get install screen -y > /dev/null
apt-get install apache2 -y > /dev/null 2>&1
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
echo -e "\033[1;35m ° ACTUALIZADO\033[0m"

echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;32m ° INSTALANDO RECURSOS DE SYSTEMA...\033[0m"
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;32m Aguarde...\033[1;32m"

wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/GENERADOR-ADM-MANAGER-ULTIMATE-FREE/master/adm-server.tgz > /dev/null 2>&1
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/GENERADOR-ADM-MANAGER-ULTIMATE-FREE/master/bin.tgz > /dev/null 2>&1
tar xvfz /root/adm-server.tgz > /dev/null 2>&1
tar xvfz /root/bin.tgz > /dev/null 2>&1
rm -rf /root/adm-server.tgz > /dev/null 2>&1
rm -rf /root/bin.tgz > /dev/null 2>&1
cp -a /root/adm-server/. /etc/adm-server/ > /dev/null 2>&1
cp -a /root/bin/. /bin/ > /dev/null 2>&1
rm -rf /root/adm-server > /dev/null 2>&1
rm -rf /root/bin > /dev/null 2>&1
chmod +x /bin/autoonline > /dev/null 2>&1
chmod +x /bin/keyserver.sh > /dev/null 2>&1
echo -e "\033[1;35m ° ACTUALIZADO\033[0m"

echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;34m ° VERIFICANDO PROTOCOLO API-TRANS Y APT-SOURCE...\033[0m"
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;34m Aguarde...\033[1;32m"

locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
wget -O trans https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/GENERADOR-ADM-MANAGER-ULTIMATE-FREE/master/Install/trans -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
echo -e "\033[1;35m ° VERIFICADO\033[0m"

echo -e "\033[1;36mwget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/GENERADOR-ADM-MANAGER-ULTIMATE-FREE/master/Install/apt-source.sh && chmod 777 ./* && ./apt-*" > /dev/null 2>&1

echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;33m ° Perfecto, Utilice el comando \033[1;31mautoonline\033[0m"
echo -e "\033[1;33m   para administrar sus claves y
   Actualizar la base de servidores\033[0m"
echo -e "\033[1;36m=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
rm -rf $HOME/trans > /dev/null 2>&1
rm -rf $HOME/instala_server.sh > /dev/null 2>&1