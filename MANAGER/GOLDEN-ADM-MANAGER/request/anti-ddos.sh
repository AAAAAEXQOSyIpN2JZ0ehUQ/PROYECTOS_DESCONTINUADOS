#!/bin/bash
clear

if [ -d '/usr/local/ddos' ]; then
echo  "\033[33m=====================================================\033[1;37m"
	echo; echo; echo "POR FAVOR, DESINSTALE LA VERSION ANTERIOR"
echo  "\033[33m=====================================================\033[1;37m"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo  "\033[33m=====================================================\033[1;37m"
echo; echo 'INSTALANDO ANTI-DDOS [GOLDEN ADM PRO]'; echo
echo  "\033[33m=====================================================\033[1;37m"
echo; echo -n 'DESCARGANDO ARCHIVOS ...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...BIEN HECHO'

echo; echo -n 'Creando Cronometro para que el Script Inicie el test cada minuto'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo "\033[33m=====================================================\033[1;37m"
echo; echo 'INSTALACION ANTI-DDOS COMPLETADA CON EXITO'
echo "\033[33m=====================================================\033[1;37m"
echo 'EL ARCHIVO DE CONFIGURACION ESTA EN -> /usr/local/ddos/ddos.conf'
echo 'DA GRACIAS A @DEADSHOT593 +593996534252 POR ESTA HERRAMIENTA DE PROTECCION'
echo "\033[33m=====================================================\033[1;37m"
