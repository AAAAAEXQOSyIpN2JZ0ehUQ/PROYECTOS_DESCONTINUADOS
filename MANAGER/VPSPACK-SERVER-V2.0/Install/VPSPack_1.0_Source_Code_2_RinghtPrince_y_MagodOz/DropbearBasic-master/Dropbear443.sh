#!/bin/bash
#  Lite 3.0
#  Criado por Vinicius (@Vinicius10)
#  Canal: @RinghtPrinceYT
#
#
#
#
tput setaf 2 ; tput bold ; echo "	Lite 3.0 " ; tput sgr0
sleep 3
#
echo "$(tput bold) ATUALIZANDO PAQUETES ...$(tput sgr0)"
#
apt-get update -y 1>/dev/null 2>/dev/null
apt-get upgrade -y 1>/dev/null 2>/dev/null
#
echo "$(tput bold) INSTALANDO DROPBEAR ...$(tput sgr0)"
#
apt-get install dropbear -y 1>/dev/null 2>/dev/null
#
echo "$(tput bold) ATIVANDO PUERTO 443 (DropBear) ...$(tput sgr0)"
#
echo "#Dropbear By GtaVpn" > /etc/default/dropbear
echo "NO_START=0" >> /etc/default/dropbear
echo "DROPBEAR_PORT=443" >> /etc/default/dropbear
#
echo "$(tput bold) REMOVENDO PROXY SQUID ...$(tput sgr0)"
#
apt-get remove squid3 -y 1>/dev/null 2>/dev/null
apt-get remove squid -y 1>/dev/null 2>/dev/null
apt-get autoremove -y 1>/dev/null 2>/dev/null
#
service dropbear start
service dropbear restart
#
echo "$(tput bold) SERVIDOR CONFIGURADO CON EXITO. $(tput sgr0)"
echo "$(tput bold) ESTE ESCRIPT FUE CREADO POR RinghtPrinceYT $(tput sgr0)"
#