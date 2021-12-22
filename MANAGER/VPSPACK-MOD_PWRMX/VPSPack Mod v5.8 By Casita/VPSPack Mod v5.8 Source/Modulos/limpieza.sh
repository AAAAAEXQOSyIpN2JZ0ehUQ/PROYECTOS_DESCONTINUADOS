#!/bin/bash
fecha=`date`;
echo "Limpiando sistema y Reiniciando Servicios" 
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null 
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null 
swapoff -a && swapon -a 1> /dev/null 2> /dev/null 
service stunnel4 restart
killall badvpn-udpgw
badvpn start
echo "Limpieza Finalizada"
echo "$fecha - limpieza realizada" >> /root/limpieza.log
notify -t "Limpieza realizada" 1> /dev/null 2> /dev/null
