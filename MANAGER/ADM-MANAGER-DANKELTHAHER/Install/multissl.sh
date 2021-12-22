#!/bin/bash
echo -e "\e[1;33mREDIRECIONADOR DE PUERTO SSL NEWADM\e[0m"
echo -e "\e[1;41mEscriba El Nombre Para Redireccionar El Puerto SSL\e[0m"
echo -e "\e[1;36m(ejemplo) shadowsocks,dropbear,sshd,python,obfc,openvpn\e[0m"
read -p ": " nombressl
echo -e "\e[1;33mEscriba el puerto del Servicio a enlazar\e[0m"
echo -e "\e[1;36m(ejemplo) 22,443,445,110,1114\e[0m"
read -p ": " portserv
echo -e "\e[1;33mEscriba el Nuevo Puerto SSL\e[0m"
echo -e "\e[1;36m(ejemplo)442,445,447,448,446,521,522\e[0m"
read -p ": " portssl
if lsof -Pi :$portssl -sTCP:LISTEN -t >/dev/null ; then
    echo -e "\e[1;41mYa esta en uso este puerto\e[0m"
else
echo "[$nombressl] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf 
echo "accept = $portssl " >> /etc/stunnel/stunnel.conf 
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf 
sleep 5
echo -e "\e[1;33mReiniciando Servicio : Stunnel4\e[0m"
service stunnel4 restart 1> /dev/null 2> /dev/null
fi
