echo "Limpiando sistema y Reiniciando Servicios" 
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null 
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null 
swapoff -a && swapon -a 1> /dev/null 2> /dev/null 
service ssh restart 1> /dev/null 2> /dev/null 
service squid restart 1> /dev/null 2> /dev/null 
service squid3 restart 1> /dev/null 2> /dev/null
echo "Limpieza Finalizada"
