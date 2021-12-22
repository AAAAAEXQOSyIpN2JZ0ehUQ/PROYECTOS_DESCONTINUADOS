#!/bin/bash
clear
rm -rf $HOME/vpsmanagersetup.sh
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "VPS-MANAGER V3.0" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Este script irá:" ; echo ""
echo "● Instalar y configurar el proxy squid en las puertos 80, 3128, 8080 e 8799" ; echo "  para permitir conexiones SSH a este servidor"
echo "● Configurar OpenSSH para ejecutarse en los puertos 22 e 443"
echo "● Instalar un conjunto de secuencias de comandos y comandos del sistema para la gestión de los usuarios" ; tput sgr0
echo ""
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Para continuar confirme o IP de este servidor: " -e -i $IP ipdovps
if [ -z "$ipdovps" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "" ; echo " No ha introducido la dirección IP de este servidor. Inténtalo de nuevo. " ; echo "" ; echo "" ; tput sgr0
	exit 1
fi
if [ -f "/root/usuarios.db" ]
then
tput setaf 6 ; tput bold ;	echo ""
	echo "Se encontró una base de datos de usuario ('usuarios.db')!"
	echo "¿Quieres mantenerlo (preservando el límite de conexiones simultáneas de los usuarios)"
	echo "o crear una nueva base de datos?"
	tput setaf 6 ; tput bold ;	echo ""
	echo "[1] Mantener la base de datos actual"
	echo "[2] Crear una nueva base de datos"
	echo "" ; tput sgr0
	read -p "Opção?: " -e -i 1 optiondb
else
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
echo ""
read -p "¿Quieres activar la compresión de SSH (puede aumentar el consumo de memoria RAM)? [s/n]) " -e -i n sshcompression
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Espere a que la configuración automática" ; echo "" ; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/vps > /dev/null
rm /root/ExpCleaner.sh /root/CriarUsuario.sh /root/sshlimiter.sh > /dev/null
apt-get install squid3 bc screen nano unzip dos2unix wget -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/squid.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/terminos -O /bin/terminos
	chmod +x /bin/terminos
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/alterarclaveusuario.sh -O /bin/alterarclaveusuario
	chmod +x /bin/alterarclaveusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/socks.sh -O /bin/socked
	chmod +x /bin/socked
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/shadowsocks.sh -O /bin/shadowsocks
	chmod +x /bin/shadowsocks
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/vps.sh -O /bin/vps
	chmod +x /bin/vps
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/speedtest.py -O /bin/speedtest.py
	chmod +x /bin/speedtest.py
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/badvpnsetup.sh -O /bin/badvpnsetup
	chmod +x /bin/badvpnsetup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/userbackup.sh -O /bin/userbackup
	chmod +x /bin/userbackup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/openvpn-install.sh -O /bin/openvpn-install
	chmod +x /bin/openvpn-install
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/tcptweaker.sh -O /bin/tcptweaker
	chmod +x /bin/tcptweaker
	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/squid.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/Install/terminos -O /bin/terminos
	chmod +x /bin/terminos
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/2/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/alterarclaveusuario.sh -O /bin/alterarclaveusuario
	chmod +x /bin/alterarclaveusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/2/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/vps.sh -O /bin/vps
	chmod +x /bin/vps
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/speedtest.py -O /bin/speedtest.py
	chmod +x /bin/speedtest.py
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/badvpnsetup.sh -O /bin/badvpnsetup
	chmod +x /bin/badvpnsetup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/userbackup.sh -O /bin/userbackup
	chmod +x /bin/userbackup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/openvpn-install.sh -O /bin/openvpn-install
	chmod +x /bin/openvpn-install
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/scripts/extra/tcptweaker.sh -O /bin/tcptweaker
	chmod +x /bin/tcptweaker
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid restart > /dev/null
	else
		/etc/init.d/squid restart > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh restart > /dev/null
	else
		/etc/init.d/ssh restart > /dev/null
	fi
fi
echo ""
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "VPS-MANAGER V3.0" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; 
echo "● Scripts para la gestión de usuarios instalados"
echo "● Proxy squid instalado y en ejecución en los puertos: 80, 3128, 8080 y 8799"
echo "● OpenSSH se ejecuta en los puertos 22 y 443"
echo "● Lea la documentación para evitar preguntas y problemas!"
echo "● Para ver los comandos disponibles, usar el comando: vps" ; tput sgr0
echo ""
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
exit 1
rm -rf $HOME/vpsmanagersetup.sh