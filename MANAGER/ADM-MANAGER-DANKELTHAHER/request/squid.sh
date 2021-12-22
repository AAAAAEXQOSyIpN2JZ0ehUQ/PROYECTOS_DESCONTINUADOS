#!/bin/bash
Block="/etc/crondbl" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;32m" [3]="\033[1;36m" [4]="\033[1;31m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
#LISTA PORTAS
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
fun_squid  () {
  if [[ -e /etc/squid/squid.conf ]]; then
  var_squid="/etc/squid/squid.conf"
  elif [[ -e /etc/squid3/squid.conf ]]; then
  var_squid="/etc/squid3/squid.conf"
  fi
  [[ -e $var_squid ]] && {
  msg -ama " $(fun_trans "REMOVIENDO SQUID")"
  msg -bar
  service squid stop > /dev/null 2>&1
  fun_bar "apt-get remove squid3 -y"
  msg -ama " $(fun_trans "Procedimiento completado")"
  msg -bar
  [[ -e $var_squid ]] && rm $var_squid
  return 0
  }
}
install_squid () {
msg -ama  " $(fun_trans "INSTALADOR SQUID ADM-ULTIMATE")"
msg -bar
fun_ip
msg -ne " $(fun_trans "Confirme su IP")"; read -p ": " -e -i $IP ip
msg -ama " $(fun_trans "Ahora elige las Puertas que desea en el Squid")"
msg -ama " $(fun_trans "Seleccione las puertas en orden secuencial de ejemplo: 80 8080 8799 3128")"
msg -ne " $(fun_trans "Introduzca los puertos:") "; read portasx
totalporta=($portasx)
unset PORT
   for portx in $(echo $portasx); do
        [[ $(mportas|grep "${portx}") = "" ]] && {
        msg -ama " $(fun_trans "Puerta Elegida:")\033[1;32m ${portx} OK"
        PORT+="${portx}\n"
        } || {
        msg -ama " $(fun_trans "Puerta Elegida:")\033[1;31m ${portx} FALLO"
        }
   done
  [[ -z $PORT ]] && {
  msg -verm " $(fun_trans "No se ha elegido ninguna puerta valida")\033[0m"
  return 1
  }
msg -bar
msg -ama  " $(fun_trans "INSTALACION SQUID")"
msg -bar
fun_bar "apt-get install squid3 -y"
msg -bar
msg -ama  " $(fun_trans "INICIANDO CONFIGURACION")"
msg -bar
echo -e ".bookclaro.com.br/\n.claro.com.ar/\n.claro.com.br/\n.claro.com.co/\n.claro.com.ec/\n.claro.com.gt/\n.cloudfront.net/\n.claro.com.ni/\n.claro.com.pe/\n.claro.com.sv/\n.claro.cr/\n.clarocurtas.com.br/\n.claroideas.com/\n.claroideias.com.br/\n.claromusica.com/\n.clarosomdechamada.com.br/\n.clarovideo.com/\n.facebook.net/\n.facebook.com/\n.netclaro.com.br/\n.oi.com.br/\n.oimusica.com.br/\n.speedtest.net/\n.tim.com.br/\n.timanamaria.com.br/\n.vivo.com.br/\n.rdio.com/\n.compute-1.amazonaws.com/\n.portalrecarga.vivo.com.br/\n.vivo.ddivulga.com/" > /etc/payloads
msg -ama " $(fun_trans "Ahora Escoja Una Configuracion Para Su Proxy")"
msg -bar
msg -ama  "|1| $(fun_trans "Comum")"
msg -ama  "|2| $(fun_trans "Customizado") -\033[1;31m $(fun_trans "Usuario Debe Ajustar")\033[1;37m"
msg -bar
read -p "[1/2]: " -e -i 1 proxy_opt
tput cuu1 && tput dl1
if [[ $proxy_opt = 1 ]]; then
msg -ama  " $(fun_trans "INSTALACION SQUID COMUN")"
elif [[ $proxy_opt = 1 ]]; then
msg -ama " $(fun_trans "INSTALACION SQUID CUSTOMIZADO")"
else
msg -ama " $(fun_trans "INSTALACION SQUID COMUM")"
proxy_opt=1
fi
unset var_squid
if [[ -d /etc/squid ]]; then
var_squid="/etc/squid/squid.conf"
elif [[ -d /etc/squid3 ]]; then
var_squid="/etc/squid3/squid.conf"
fi
if [[ "$proxy_opt" = @(02|2) ]]; then
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 url_regex -i '/etc/opendns'
acl url5 dstdomain -i localhost
acl accept dstdomain -i GET
acl accept dstdomain -i POST
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i CONNECT
acl accept dstdomain -i PUT
acl HEAD dstdomain -i HEAD
acl accept dstdomain -i TRACE
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i PATCH
acl accept dstdomain -i PROPATCH
acl accept dstdomain -i DELETE
acl accept dstdomain -i REQUEST
acl accept dstdomain -i METHOD
acl accept dstdomain -i NETDATA
acl accept dstdomain -i MOVE
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow url5
http_access allow accept
http_access allow HEAD
http_access deny all

# Request Headers Forcing

request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
#request_header_access All deny all

# Response Headers Spoofing

#reply_header_access Via deny all
#reply_header_access X-Cache deny all
#reply_header_access X-Cache-Lookup deny all

#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname ADM-MANAGER

via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
 else
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 url_regex -i '/etc/opendns'
acl url5 dstdomain -i localhost
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow url5
http_access deny all

#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname ADM-MANAGER

via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
fi
touch /etc/opendns
fun_eth
msg -ne " \033[1;31m [ ! ] \033[1;33m$(fun_trans "REINICIANDO SERVICIOS")"
squid3 -k reconfigure > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
echo -e " \033[1;32m[OK]"
msg -bar && msg -ama " $(fun_trans "SQUID CONFIGURADO")" && msg -bar
#UFW
for ufww in $(mportas|awk '{print $2}'); do
ufw allow $ufww > /dev/null 2>&1
done
}
online_squid () {
payload="/etc/payloads"
msg -azu " $(fun_trans "SQUID CONFIGURADO")"
msg -bar
echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "Colocar Host en Squid")"
echo -ne "\033[1;32m [2] > " && msg -azu "$(fun_trans "Quitar el host de Squid")"
echo -ne "\033[1;32m [3] > " && msg -azu "$(fun_trans "Desinstalar Squid")"
echo -ne "\033[1;32m [0] > " && msg -bra "$(fun_trans "Volver")"
msg -bar
while [[ $varpay != @(0|[1-3]) ]]; do
read -p "[0/3]: " varpay
tput cuu1 && tput dl1
done
if [[ "$varpay" = "0" ]]; then
return 1
elif [[ "$varpay" = "1" ]]; then
msg -ama " $(fun_trans "Hosts Actuales Dentro del Squid")"
msg -bar
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar
while [[ $hos != \.* ]]; do
msg -ne " $(fun_trans "Escriba el nuevo host"): " && read hos
tput cuu1 && tput dl1
[[ $hos = \.* ]] && continue
msg -ama " $(fun_trans "Comience con") .${cor[0]}"
sleep 2s
tput cuu1 && tput dl1
done
host="$hos/"
[[ -z $host ]] && return 1
[[ `grep -c "^$host" $payload` -eq 1 ]] &&:echo -e "${cor[4]}$(fun_trans "Host Ya Existe")${cor[0]}" && return 1
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
msg -ama "$(fun_trans "Host agregado con exito")"
msg -bar
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar
if [[ ! -f "/etc/init.d/squid" ]]; then
service squid3 reload
service squid3 restart
else
/etc/init.d/squid reload
service squid restart
fi	
return 0
elif [[ "$varpay" = "2" ]]; then
echo -e "${cor[4]} $(fun_trans "Hosts Actuales Dentro del Squid")"
msg -bar 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar
while [[ $hos != \.* ]]; do
echo -ne "${cor[4]}$(fun_trans "Introduzca el host"): " && read hos
tput cuu1 && tput dl1
[[ $hos = \.* ]] && continue
echo -e "${cor[4]}$(fun_trans "Comience con") .${cor[0]}"
sleep 2s
tput cuu1 && tput dl1
done
host="$hos/"
[[ -z $host ]] && return 1
[[ `grep -c "^$host" $payload` -ne 1 ]] &&!msg -ama "$(fun_trans "Host no encontrado")" && return 1
grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
msg -ama " $(fun_trans "Host Removido Con exito")${cor[0]}"
msg -bar
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar
if [[ ! -f "/etc/init.d/squid" ]]; then
service squid3 reload
service squid3 restart
else
/etc/init.d/squid reload
service squid restart
fi	
return 0
elif [[ "$varpay" = "3" ]]; then
fun_squid
fi
}

squid_19 () {
#Instalador squid soporte a nuevos O.S 

msg -bar
msg -bra "ESTE INSTALADOR CONFIGURA AUTOMATICAMNETE EL PUERTO SQUID EN LOS 2 UNICOS"
msg -bar
msg -bra "FUNCIONALES QUE ES EL 8080 Y EL 80 CON SOPORTE ALOS O.S"
msg -bar
msg -ama "DEBIAN 8,9               UBUNTU 14.04, 16.04, 18.04, 19.04"
sleep 2s
msg -bar
msg -bra "DETECTECTANDO SISTEMA OPERATIVO ESPERE......"
sleep 3s

msg -bar

if cat /etc/os-release | grep PRETTY_NAME | grep "Ubuntu 19.04"; then
    /usr/bin/apt update > /dev/null 2>&1
    /usr/bin/apt -y install apache2-utils squid
    touch /etc/squid/passwd
    /bin/rm -f /etc/squid/squid.conf
    /usr/bin/touch /etc/squid/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
echo -e "acl url1 dstdomain -i $ip" >> /etc/squid/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
    /sbin/iptables-save
    systemctl enable squid
    systemctl restart squid

elif cat /etc/os-release | grep PRETTY_NAME | grep "Ubuntu 18.04"; then
    /usr/bin/apt update > /dev/null 2>&1
    /usr/bin/apt -y install apache2-utils squid
    touch /etc/squid/passwd
    /bin/rm -f /etc/squid/squid.conf
    /usr/bin/touch /etc/squid/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
    /sbin/iptables-save
    systemctl enable squid
    systemctl restart squid

elif cat /etc/os-release | grep PRETTY_NAME | grep "Ubuntu 16.04"; then
    /usr/bin/apt update > /dev/null 2>&1
    /usr/bin/apt -y install apache2-utils squid3
    touch /etc/squid/passwd
    /bin/rm -f /etc/squid/squid.conf
    /usr/bin/touch /etc/squid/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
    /sbin/iptables-save
    service squid restart
    update-rc.d squid defaults

elif cat /etc/*release | grep DISTRIB_DESCRIPTION | grep "Ubuntu 14.04"; then
    /usr/bin/apt update > /dev/null 2>&1
    /usr/bin/apt -y install apache2-utils squid3
    touch /etc/squid3/passwd
    /bin/rm -f /etc/squid3/squid.conf
    /usr/bin/touch /etc/squid3/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid3/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
    /sbin/iptables-save
    service squid3 restart
    ln -s /etc/squid3 /etc/squid
    #update-rc.d squid3 defaults
    ln -s /etc/squid3 /etc/squid

elif cat /etc/os-release | grep PRETTY_NAME | grep "jessie"; then
    # OS = Debian 8 > /dev/null 2>&1
    /bin/rm -rf /etc/squid
    /usr/bin/apt update
    /usr/bin/apt -y install apache2-utils squid3
    touch /etc/squid3/passwd
    /bin/rm -f /etc/squid3/squid.conf
    /usr/bin/touch /etc/squid3/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid3/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
    /sbin/iptables-save
    service squid3 restart
    update-rc.d squid3 defaults
    ln -s /etc/squid3 /etc/squid

elif cat /etc/os-release | grep PRETTY_NAME | grep "stretch"; then
    # OS = Debian 9 > /dev/null 2>&1
    /bin/rm -rf /etc/squid
    /usr/bin/apt update
    /usr/bin/apt -y install apache2-utils squid
    touch /etc/squid/passwd
    /bin/rm -f /etc/squid/squid.conf
    /usr/bin/touch /etc/squid/blacklist.acl
    /usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://www.dropbox.com/s/5mb69eainxialac/squid.conf
    /sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
    /sbin/iptables-save
    systemctl enable squid
    systemctl restart squid
else
    echo "SISTEMA OPERATIVO NO SOPORTADO POR FAVOR PONGASE EN CONTACTO CON @dankelthaher1"
    exit 1;
fi
#/usr/bin/htpasswd -b -c /etc/squid/passwd USERNAME_HERE PASSWORD_HERE
}

msg -bar
echo -ne "$(msg -verd "[1]") $(msg -verm2 ">") " && msg -azu "INSTALAR SQUID"
echo -ne "$(msg -verd "[2]") $(msg -verm2 ">") " && msg -bra "SQUID UBUNTU 18,19"
echo -ne "$(msg -verd "[3]") $(msg -verm2 ">") " && msg -azu "DETENER SQUID"
echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") " && msg -bra "SALIR"
msg -bar
while [[ ${varread} != @([0-3]) ]]; do
read -p "Opcion: " varread
done
echo -e "$BARRA"
if [[ ${varread} = 0 ]]; then
exit
elif [[ ${varread} = 1 ]]; then
install_squid
elif [[ ${varread} = 2 ]]; then
squid_19
elif [[ ${varread} = 3 ]]; then
fun_squid
fi