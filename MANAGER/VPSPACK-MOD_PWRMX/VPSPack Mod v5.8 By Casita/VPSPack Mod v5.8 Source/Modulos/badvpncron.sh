#!/bin/bash
fecha=`date`;
if netstat -tunlp |grep badvpn; then
echo -e "ON"
echo -e "Ninguna accion requerida"
else
echo -e "OFF"
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
echo "$fecha - BadVPN Reiniciado" >> /root/badvpn.log
fi;
