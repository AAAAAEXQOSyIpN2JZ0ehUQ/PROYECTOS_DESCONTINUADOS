#!/bin/bash
fun_trans () { 
local texto
local retorno
declare -A texto
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z $(echo ${texto[$2]}) ]]; then
ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
  while [[ -z $retorno ]]; do
    NUM="$(($RANDOM%${#ENGINES[@]}))"
    retorno="$(source trans -e ${ENGINES[$NUM]} -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
  done
 echo "texto[$2]='$retorno'"  >> /etc/texto-adm
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}
declare -A cor=( [0]="\033[33m" [1]="\033[33m" [2]="\033[33m" [3]="\033[33m" [4]="\033[33m" )
barra="\033[0m\e[33m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
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
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    echo -e "$barra"
    echo -e "${cor[3]} $(fun_trans ${id} "Aplicar Sistema Para Melhorar Pacotes Ssh?")"
    echo -e "${cor[3]} $(fun_trans ${id} "Opcao Para Usuarios Avancados")"
    echo -e "$barra"
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]} $(fun_trans ${id} "Correcao de problemas de pacotes no SSH...")"
           echo -e " $(fun_trans ${id} "Qual A Taxa RX")"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e " $(fun_trans ${id} "Qual A Taxa TX")"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     echo -e "$barra"
     }
}
dns_fun () {
case $1 in
3)dns[$2]='push "dhcp-option DNS 1.0.0.1"';;
4)dns[$2]='push "dhcp-option DNS 1.1.1.1"';;
5)dns[$2]='push "dhcp-option DNS 9.9.9.9"';;
6)dns[$2]='push "dhcp-option DNS 1.1.1.1"';;
7)dns[$2]='push "dhcp-option DNS 80.67.169.40"';;
8)dns[$2]='push "dhcp-option DNS 80.67.169.12"';;
9)dns[$2]='push "dhcp-option DNS 84.200.69.80"';;
10)dns[$2]='push "dhcp-option DNS 84.200.70.40"';;
11)dns[$2]='push "dhcp-option DNS 208.67.222.222"';;
12)dns[$2]='push "dhcp-option DNS 208.67.220.220"';;
13)dns[$2]='push "dhcp-option DNS 8.8.8.8"';;
14)dns[$2]='push "dhcp-option DNS 8.8.4.4"';;
15)dns[$2]='push "dhcp-option DNS 77.88.8.8"';;
16)dns[$2]='push "dhcp-option DNS 77.88.8.1"';;
17)dns[$2]='push "dhcp-option DNS 176.103.130.130"';;
18)dns[$2]='push "dhcp-option DNS 176.103.130.131"';;
esac
}
meu_ip () {
if [[ -e /etc/MEUIPADM ]]; then
echo "$(cat /etc/MEUIPADM)"
else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
fi
}
IP="$(meu_ip)"
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[33m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
instala_ovpn () {
parametros_iniciais () {
#Verifica o Sistema
[[ "$EUID" -ne 0 ]] && echo "Desculpe, você precisa rodar isso como root" && return 1
[[ ! -e /dev/net/tun ]] && echo "TUN não está disponível" && return 1
if [[ -e /etc/debian_version ]]; then
OS="debian"
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
IPTABLES='/etc/iptables/iptables.rules'
[[ ! -d /etc/iptables ]] && mkdir /etc/iptables
[[ ! -e $IPTABLES ]] && touch $IPTABLES
SYSCTL='/etc/sysctl.conf'
 [[ "$VERSION_ID" != 'VERSION_ID="7"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="8"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="9"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="14.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="16.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="17.10"' ]] && {
 echo " Sua versão do Debian / Ubuntu não é suportada."
 while [[ $CONTINUE != @(y|Y|s|S|n|N) ]]; do
 read -p "Continuar ? [y/n]: " -e CONTINUE
 done
 [[ "$CONTINUE" = @(n|N) ]] && exit 1
 }
else
echo -e "\033[33m $(fun_trans ${id} "Parece que voce nao esta executando este instalador em um sistema Debian ou Ubuntu")\n$barra"
return 1
fi
#Pega Interface
NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
echo -e "\033[33m $(fun_trans ${id} "Sistema Preparado Para Receber o OPENVPN")\n$barra"
}
add_repo () {
#INSTALACAO E UPDATE DO REPOSITORIO
# Debian 7
if [[ "$VERSION_ID" = 'VERSION_ID="7"' ]]; then
echo "deb http://build.openvpn.net/debian/openvpn/stable wheezy main" > /etc/apt/sources.list.d/openvpn.list
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add - > /dev/null 2>&1
# Debian 8
elif [[ "$VERSION_ID" = 'VERSION_ID="8"' ]]; then
echo "deb http://build.openvpn.net/debian/openvpn/stable jessie main" > /etc/apt/sources.list.d/openvpn.list
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add - > /dev/null 2>&1
# Ubuntu 14.04
elif [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
echo "deb http://build.openvpn.net/debian/openvpn/stable trusty main" > /etc/apt/sources.list.d/openvpn.list
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add - > /dev/null 2>&1
fi
}
coleta_variaveis () {
echo -e " $(fun_trans ${id} "Responda as perguntas para iniciar a instalacao")"
echo -e " $(fun_trans ${id} "Responda corretamente")"
echo -e "\033[33m$(fun_trans ${id} "Primeiro precisamos do ip de sua maquina, este ip esta correto?")\033[0m"
read -p "IP address: " -e -i $IP IP
echo -e "$barra\n\033[1;33m$(fun_trans ${id} "Qual porta voce deseja usar?")\033[0m\n$barra"
read -p "Port: " -e -i 1194 PORT
echo -e "\033[33m$(fun_trans ${id} "Qual protocolo voce deseja para as conexoes OPENVPN?")"
echo -e "\033[33m$(fun_trans ${id} "A menos que o UDP esteja bloqueado, voce nao deve usar o TCP (mais lento)")"
#PROTOCOLO
while [[ $PROTOCOL != @(UDP|TCP) ]]; do
read -p "Protocol [UDP/TCP]: " -e -i TCP PROTOCOL
done
[[ $PROTOCOL = "UDP" ]] && PROTOCOL=udp
[[ $PROTOCOL = "TCP" ]] && PROTOCOL=tcp
#DNS
echo -e "$barra\n\033[33m$(fun_trans ${id} "Qual DNS voce deseja usar?")\n$barra"
echo "   1) Usar padrões do sistema "
echo "   2) Cloudflare"
echo "   3) Quad"
echo "   4) FDN"
echo "   5) DNS.WATCH"
echo "   6) OpenDNS"
echo "   7) Google DNS"
echo "   8) Yandex Basic"
echo "   9) AdGuard DNS"
while [[ $DNS != @([1-9]) ]]; do
read -p "DNS [1-9]: " -e -i 1 DNS
done
#CIPHER
echo -e "$barra\n\033[33m$(fun_trans ${id} "Escolha qual codificação você deseja usar para o canal de dados:")\n$barra"
echo "   1) AES-128-CBC"
echo "   2) AES-192-CBC"
echo "   3) AES-256-CBC"
echo "   4) CAMELLIA-128-CBC"
echo "   5) CAMELLIA-192-CBC"
echo "   6) CAMELLIA-256-CBC"
echo "   7) SEED-CBC"
while [[ $CIPHER != @([1-7]) ]]; do
read -p "Cipher [1-7]: " -e -i 1 CIPHER
done
case $CIPHER in
1) CIPHER="cipher AES-128-CBC";;
2) CIPHER="cipher AES-192-CBC";;
3) CIPHER="cipher AES-256-CBC";;
4) CIPHER="cipher CAMELLIA-128-CBC";;
5) CIPHER="cipher CAMELLIA-192-CBC";;
6) CIPHER="cipher CAMELLIA-256-CBC";;
7) CIPHER="cipher SEED-CBC";;
esac
echo -e "$barra\n\033[33m$(fun_trans ${id} "Estamos prontos para configurar seu servidor OpenVPN")\n$barra"
read -n1 -r -p "Enter to Continue..."
}
parametros_iniciais # BREVE VERIFICACAO
coleta_variaveis # COLETA VARIAVEIS PARA INSTALAÇÃO
add_repo # ATUALIZA REPOSITÓRIO OPENVPN E INSTALA OPENVPN
# Cria Diretorio
[[ ! -d /etc/openvpn ]] && mkdir /etc/openvpn
# Install openvpn
echo -ne "\033[1;31m[ ! ] apt-get update"
apt-get update -q > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne "\033[1;31m[ ! ] apt-get install openvpn curl openssl"
apt-get install -qy openvpn curl > /dev/null 2>&1 && apt-get install openssl -y > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
SERVER_IP="$(meu_ip)" # IP Address
[[ -z "${SERVER_IP}" ]] && SERVER_IP=$(ip a | awk -F"[ /]+" '/global/ && !/127.0/ {print $3; exit}')
echo -ne "\033[33m[ ! ] Generating Server Config" # Gerando server.con
(
case $DNS in
1)
i=0
grep -v '#' /etc/resolv.conf | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
dns[$i]="push \"dhcp-option DNS $line\""
done
[[ ! "${dns[@]}" ]] && dns[0]='push "dhcp-option DNS 8.8.8.8"' && dns[1]='push "dhcp-option DNS 8.8.4.4"'
;;
2)dns_fun 3 && dns_fun 4;;
3)dns_fun 5 && dns_fun 6;;
4)dns_fun 7 && dns_fun 8;;
5)dns_fun 9 && dns_fun 10;;
6)dns_fun 11 && dns_fun 12;;
7)dns_fun 13 && dns_fun 14;;
8)dns_fun 15 && dns_fun 16;;
9)dns_fun 17 && dns_fun 18;;
esac
echo 01 > /etc/openvpn/ca.srl
while [[ ! -e /etc/openvpn/dh.pem || -z $(cat /etc/openvpn/dh.pem) ]]; do
openssl dhparam -out /etc/openvpn/dh.pem 2048 &>/dev/null
done
while [[ ! -e /etc/openvpn/ca-key.pem || -z $(cat /etc/openvpn/ca-key.pem) ]]; do
openssl genrsa -out /etc/openvpn/ca-key.pem 2048 &>/dev/null
done
chmod 600 /etc/openvpn/ca-key.pem &>/dev/null
while [[ ! -e /etc/openvpn/ca-csr.pem || -z $(cat /etc/openvpn/ca-csr.pem) ]]; do
openssl req -new -key /etc/openvpn/ca-key.pem -out /etc/openvpn/ca-csr.pem -subj /CN=OpenVPN-CA/ &>/dev/null
done
while [[ ! -e /etc/openvpn/ca.pem || -z $(cat /etc/openvpn/ca.pem) ]]; do
openssl x509 -req -in /etc/openvpn/ca-csr.pem -out /etc/openvpn/ca.pem -signkey /etc/openvpn/ca-key.pem -days 365 &>/dev/null
done
cat > /etc/openvpn/server.conf <<EOF
server 10.8.0.0 255.255.255.0
verb 3
duplicate-cn
key client-key.pem
ca ca.pem
cert client-cert.pem
dh dh.pem
keepalive 10 120
persist-key
persist-tun
comp-lzo
float
push "redirect-gateway def1 bypass-dhcp"
${dns[0]}
${dns[1]}

user nobody
group nogroup

${CIPHER}
proto ${PROTOCOL}
port $PORT
dev tun
status openvpn-status.log
EOF
updatedb
PLUGIN=$(locate openvpn-plugin-auth-pam.so | head -1)
[[ ! -z $(echo ${PLUGIN}) ]] && {
echo "client-to-client
client-cert-not-required
username-as-common-name
plugin $PLUGIN login" >> /etc/openvpn/server.conf
}
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne "\033[33m[ ! ] Generating CA Config" # Generate CA Config
(
while [[ ! -e /etc/openvpn/client-key.pem || -z $(cat /etc/openvpn/client-key.pem) ]]; do
openssl genrsa -out /etc/openvpn/client-key.pem 2048 &>/dev/null
done
chmod 600 /etc/openvpn/client-key.pem
while [[ ! -e /etc/openvpn/client-csr.pem || -z $(cat /etc/openvpn/client-csr.pem) ]]; do
openssl req -new -key /etc/openvpn/client-key.pem -out /etc/openvpn/client-csr.pem -subj /CN=OpenVPN-Client/ &>/dev/null
done
while [[ ! -e /etc/openvpn/client-cert.pem || -z $(cat /etc/openvpn/client-cert.pem) ]]; do
openssl x509 -req -in /etc/openvpn/client-csr.pem -out /etc/openvpn/client-cert.pem -CA /etc/openvpn/ca.pem -CAkey /etc/openvpn/ca-key.pem -days 365 &>/dev/null
done
) && echo -e "\033[33m [OK]" || echo -e "\033[1;31m [FAIL]"
teste_porta () {
  echo -ne "\033[33m$(fun_trans ${id} "Verificando")"
  sleep 1s
  [[ ! $(mportas | grep "$1") ]] && {
    echo -e "$(fun_trans ${id} "\033[33m [Porta Invalida!]")"
    } || {
    echo -e "\033[1;32m [Pass]"
    return 1
    }
   }
echo -e "$barra\n\033[33m$(fun_trans ${id} "Agora Precisamos da Porta Que Esta Seu Proxy Squid(Socks)")"
echo -e "\033[33m$(fun_trans ${id} "Se nao Existir Proxy na Porta um Proxy Python sera Aberto!")\n$barra"
while [[ $? != "1" ]]; do
read -p "Confirme a Porta(Proxy): " -e -i 80 PPROXY
teste_porta $PPROXY
done
cat > /etc/openvpn/client-common.txt <<EOF
# OVPN_ACCESS_SERVER_PROFILE=New-Ultimate
client
nobind
dev tun
redirect-gateway def1 bypass-dhcp
remote-random
remote ${SERVER_IP} ${PORT} ${PROTOCOL}
http-proxy ${SERVER_IP} ${PPROXY}
$CIPHER
comp-lzo yes
keepalive 10 20
float
auth-user-pass
EOF
# Iptables
if [[ ! -f /proc/user_beancounters ]]; then
    INTIP=$(ip a | awk -F"[ /]+" '/global/ && !/127.0/ {print $3; exit}')
    N_INT=$(ip a |awk -v sip="$INTIP" '$0 ~ sip { print $7}')
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $N_INT -j MASQUERADE
else
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $SERVER_IP
fi
iptables-save > /etc/iptables.conf
cat > /etc/network/if-up.d/iptables <<EOF
#!/bin/sh
iptables-restore < /etc/iptables.conf
EOF
chmod +x /etc/network/if-up.d/iptables
# Enable net.ipv4.ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
# Regras de Firewall 
if pgrep firewalld; then
 if [[ "$PROTOCOL" = 'udp' ]]; then
 firewall-cmd --zone=public --add-port=$PORT/udp
 firewall-cmd --permanent --zone=public --add-port=$PORT/udp
 elif [[ "$PROTOCOL" = 'tcp' ]]; then
 firewall-cmd --zone=public --add-port=$PORT/tcp
 firewall-cmd --permanent --zone=public --add-port=$PORT/tcp
 fi
firewall-cmd --zone=trusted --add-source=10.8.0.0/24
firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
fi
if iptables -L -n | grep -qE 'REJECT|DROP'; then
 if [[ "$PROTOCOL" = 'udp' ]]; then
 iptables -I INPUT -p udp --dport $PORT -j ACCEPT
 elif [[ "$PROTOCOL" = 'tcp' ]]; then
 iptables -I INPUT -p tcp --dport $PORT -j ACCEPT
 fi
iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables-save > $IPTABLES
fi
if hash sestatus 2>/dev/null; then
 if sestatus | grep "Current mode" | grep -qs "enforcing"; then
  if [[ "$PORT" != '1194' ]]; then
   if ! hash semanage 2>/dev/null; then
   yum install policycoreutils-python -y
   fi
   if [[ "$PROTOCOL" = 'udp' ]]; then
   semanage port -a -t openvpn_port_t -p udp $PORT
   elif [[ "$PROTOCOL" = 'tcp' ]]; then
   semanage port -a -t openvpn_port_t -p tcp $PORT
   fi
  fi
 fi
fi
#Liberando DNS
agrega_dns () {
echo -e "\033[33m$(fun_trans ${id} "Digite o DNS que deseja Adicionar")"
read -p "[NewDNS]: " SDNS
cat /etc/hosts|grep -v "$SDNS" > /etc/hosts.bak && mv -f /etc/hosts.bak /etc/hosts
[[ -e /etc/opendns ]] && echo "$SDNS" >> /etc/opendns || echo "$SDNS" > /etc/opendns
[[ -z $NEWDNS ]] && NEWDNS="$SDNS" || NEWDNS="$NEWDNS $SDNS"
unset SDNS
}
echo -e "$barra\n\033[33m$(fun_trans ${id} "Ultima Etapa, Configuracoes DNS")\n$barra"
while [[ $DDNS != @(n|N) ]]; do
echo -ne "\033[33m"
read -p "Adicionar DNS [S/N]: " -e -i n DDNS
[[ $DDNS = @(s|S|y|Y) ]] && agrega_dns
done
[[ ! -z $NEWDNS ]] && {
sed -i "/127.0.0.1[[:blank:]]\+localhost/a 127.0.0.1 $NEWDNS" /etc/hosts
for DENESI in $(echo $NEWDNS); do
sed -i "/remote ${SERVER_IP} ${PORT} ${PROTOCOL}/a remote ${DENESI} ${PORT} ${PROTOCOL}" /etc/openvpn/client-common.txt
done
}
echo -e "$barra"
# REINICIANDO OPENVPN
if [[ "$OS" = 'debian' ]]; then
 if pgrep systemd-journal; then
 sed -i 's|LimitNPROC|#LimitNPROC|' /lib/systemd/system/openvpn\@.service
 sed -i 's|/etc/openvpn/server|/etc/openvpn|' /lib/systemd/system/openvpn\@.service
 sed -i 's|%i.conf|server.conf|' /lib/systemd/system/openvpn\@.service
 #systemctl daemon-reload
 systemctl restart openvpn
 systemctl enable openvpn
 else
 /etc/init.d/openvpn restart
 fi
else
 if pgrep systemd-journal; then
 systemctl restart openvpn@server.service
 systemctl enable openvpn@server.service
 else
 service openvpn restart
 chkconfig openvpn on
 fi
fi
service squid restart &>/dev/null
service squid3 restart &>/dev/null
apt-get install ufw -y > /dev/null 2>&1
for ufww in $(mportas|awk '{print $2}'); do
ufw allow $ufww > /dev/null 2>&1
done
echo -e "$barra\n\033[33m$(fun_trans ${id} "Openvpn Configurado Com Sucesso!")"
echo -e "\033[33m$(fun_trans ${id} "Agora So Criar Um Usuario Para Gerar um Cliente!")\n$barra"
return 0
}
fun_openvpn () {
[[ -e /etc/openvpn/server.conf ]] && {
unset OPENBAR
[[ $(mportas|grep -w "openvpn") ]] && OPENBAR="\033[1;32mOnline" || OPENBAR="\033[1;31mOffline"
echo -e "\033[33m $(fun_trans ${id} "OPENVPN JA ESTA INSTALADO")\n$barra"
echo -e "\033[33m [1] >\033[33m $(fun_trans ${id} "Remover Openvpn")"
echo -e "\033[33m [2] >\033[33m $(fun_trans ${id} "Editar Cliente Openvpn") \033[1;31m(comand nano)"
echo -e "\033[33m [3] >\033[33m $(fun_trans ${id} "Liga ou Para OPENVPN") $OPENBAR\n$barra"
while [[ $xption != @([1-3]) ]]; do
echo -ne "\033[33m $(fun_trans ${id} "Opcao"): " && read xption
tput cuu1 && tput dl1
done
case $xption in 
1)
 echo -e "$barra\n\033[33m $(fun_trans ${id} "DESINSTALAR OPENVPN")\n$barra"
   if [[ "$OS" = 'debian' ]]; then
   fun_bar "apt-get remove --purge -y openvpn openvpn-blacklist"
   else
   fun_bar "yum remove openvpn -y"
   fi
   tuns=$(cat /etc/modules | grep -v tun) && echo -e "$tuns" > /etc/modules
   rm -rf /etc/openvpn && rm -rf /usr/share/doc/openvpn*
   echo -e "$barra\n\033[1;33m $(fun_trans ${id} "Procedimento Concluido")\n$barra"
   return 0;;
 2)
   nano /etc/openvpn/client-common.txt
   return 0;;
 3)
   [[ $(mportas|grep -w openvpn) ]] && {
   ps x |grep openvpn |grep -v grep|awk '{print $1}' | while read pid; do kill -9 $pid; done
   killall openvpn &>/dev/null
   systemctl stop openvpn@server.service &>/dev/null
   service openvpn stop &>/dev/null
   } || {
   cd /etc/openvpn
   screen -dmS ovpnscr openvpn --config "server.conf" > /dev/null 2>&1
   cd $HOME
   }
   echo -e "\033[33m $(fun_trans ${id} "Sucesso Procedimento Feito")"
   echo -e "$barra"
   return 0;;
 esac
 exit
 }
[[ -e /etc/squid/squid.conf ]] && instala_ovpn && return 0
[[ -e /etc/squid3/squid.conf ]] && instala_ovpn && return 0
echo -e "$barra\n\033[1;33m $(fun_trans ${id} "Squid Nao Encontrado")"
echo -e "\033[33m $(fun_trans ${id} "Prosseguir Com Instalacao?")\n$barra"
read -p " [S/N]: " -e -i n instnosquid && [[ $instnosquid = @(s|S|y|Y) ]] && instala_ovpn || return 1
}
no_port () {
echo -e "\033[33m $(fun_trans ${id} "Antes de instalar o openvpn Instalar um Squid")\n$barra"
echo -e "\033[33m $(fun_trans ${id} "ou Abra um Proxy Socket")\n$barra"
exit 1
}
[[ -z $(mportas|grep squid) ]] && [[ -z $(mportas|grep python) ]] && no_port
fun_openvpn