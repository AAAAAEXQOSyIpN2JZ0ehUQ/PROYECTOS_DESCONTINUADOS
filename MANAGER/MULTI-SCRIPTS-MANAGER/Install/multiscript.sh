#!/bin/bash
rm -rf .bash_history
#CREADO /17/SEP/2020
#BY [ ALEXMOD-TEAM ]
#COLABORADOR [ GILILLO GONZALEZ ]
#CREADO PARA EL GRUPO @CONECTEDMX_VIP

#
#QUEDA PROIBIDO SU VENTA
#
#SCRIPT INTERNO BY KALIX1
#SCRIPT DANKELTHAHER
#SCRIPT POWER MX V3.5
#SCRIPT SSHPLUS BY CRAZY VPN
#adm-mx reaper
#TESTIANDO SCRIPT

fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
update(){
echo -e "\e[1;37m ACTUALIZANDO SISTEMA...."
apt-get update -y &>/dev/null
apt-get upgrade -y &>/dev/null
#apt-get install figlet -y &>/dev/null
}
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="\e[0;31m========================================\e[0m" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="\e[1;31m——————————————————————————————————————————————————————" && echo -e "${cor}${SEMCOR}";;
 esac
}
df(){
echo "
 ╭━━━╮╭━━━╮╭━━━╮╭━━╮╭━━━╮╭━━━━╮
┃╭━╮┃┃╭━╮┃┃╭━╮┃╰┫┣╯┃╭━╮┃┃╭╮╭╮┃
┃╰━━╮┃┃╱╰╯┃╰━╯┃╱┃┃╱┃╰━╯┃╰╯┃┃╰╯
╰━━╮┃┃┃╱╭╮┃╭╮╭╯╱┃┃╱┃╭━━╯╱╱┃┃╱╱
┃╰━╯┃┃╰━╯┃┃┃┃╰╮╭┫┣╮┃┃╱╱╱╱╱┃┃╱╱
╰━━━╯╰━━━╯╰╯╰━╯╰━━╯╰╯╱╱╱╱╱╰╯╱╱
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱

              "
              }
IP=$(wget -qO- ipv4.icanhazip.com)
systema () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}
scriptmx(){
echo -e "\e[1;33m SCRIPT VPS-MX\n             SELECIONADO"
rm -rf multiscript.sh
rm -rf .bash_history
sleep 3
wget https://raw.githubusercontent.com/casitadelterror/scripts/master/instalador/instalscript.sh &> /dev/null; chmod +x instalscript.sh* && ./instalscript.sh*
rm -rf multiscript.sh instalscript.sh
rm -rf .bash_history
}
power(){
rm -rf multiscript.sh
rm -rf .bash_history
wget https://www.dropbox.com/s/s6ybopqsz3wq4fx/instalador && chmod +x instalador && ./instalador
rm -rf multiscript.sh instalador
rm -rf .bash_history
}
dankel(){
echo -e "\e[1;33m SCRIPT dankelthaher\n             SELECIONADO"
rm -rf multiscript.sh
rm -rf .bash_history
sleep 3
wget https://raw.githubusercontent.com/casitadelterror/dankeladm/master/instalador/instala.sh && chmod +x instala.sh && ./instala.sh
rm -rf multiscript.sh instala.sh
rm -rf .bash_history
}

sshplus(){
echo -e "\e[1;33m SCRIPT SSHPLUS\n             SELECIONADO"
rm -rf .bash_history
rm -rf multiscript.sh
sleep 3
wget https://raw.githubusercontent.com/scriptsmx/script/master/PLUSX/Plus; chmod +x Plus; ./Plus
rm -rf multiscript.sh
rm -rf Plus
}
reaper(){
echo -e "\e[1;33m SCRIPT MOD ADM-MX -SIXREAPER\n             SELECIONADO"
sleep 3
rm -rf .bash_history multiscript.sh
wget https://raw.githubusercontent.com/casitadelterror/scripts/master/gamo/instalador && chmod +x instalador && ./instalador
rm instalador
}
#testiando
kaliofc(){
#!/bin/bash
fun_ip
clear
msg -bar
msg -verm " ESPERE UN MOMENTO"
msg -bar
dpkg --configure -a &>/dev/null
apt-get install software-properties-common -y &>/dev/null
apt-add-repository universe -y &>/dev/null
SCPdir="/etc/newadm" #&& [[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
SCPinstal="$HOME/install" && [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user" #&& [[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
SCPfrm="/etc/ger-frm" #&& [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="/etc/ger-inst" #&& [[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
mkdir -p /etc/B-ADMuser &>/dev/null
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime &>/dev/null
inst_components () {
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
}
funcao_idioma () {
msg -bar2
figlet "    -VPS MX-" | lolcat 
echo -e "     ESTE SCRIPT ESTA OPTIMIZADO A IDIOMA ESPAÑOL"
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}
install_fim () {
msg -ama "               Finalizando Instalacion" && msg bar2
[[ $(find /etc/newadm/ger-user -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/newadm/ger-user/nombre.log https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/nombre.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/newadm/ger-user/IDT.log https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/IDT.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name tiemlim.log|grep -w "tiemlim.log"|head -1) ]] || wget -O /etc/newadm/ger-user/tiemlim.log https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/tiemlim.log &>/dev/null
msg -bar
echo -e " CAMBIO DE RESELLER (recomendado)"
msg -bar
read -p " SU NUEVO RESELLER SERÁ? : " mensaje
echo "$mensaje" > ${SCPdir}/message.txt
sleep 3.s
echo -e " MENSAJE CAMBIADO CON ÉXITO"
msg -bar
echo -e " SU NUEVO RESELLER ES:\e[33m $(cat ${SCPdir}/message.txt)"
msg bar
read -p "enter para finalizar"
msg -bar
sleep 4.s
wget -O /bin/rebootnb https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/Vercion &>/dev/null
msg -bar2
wget -O ${SCPfrm}/ADMbot.sh https://github.com/VPS-MX/VPS-MX-8.0/raw/master/Parches-TEM/ADMbot.sh &>/dev/null
chmod +x ${SCPfrm}/ADMbot.sh
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'echo ""' >> .bashrc
echo 'echo -e "\033[91m      __     ______  ____        __  ____  __ " '>> .bashrc
echo 'echo -e "\033[91m      \ \   / /  _ \/ ___|      |  \/  \ \/ / " '>> .bashrc
echo 'echo -e "\033[91m       \ \ / /| |_) \___ \ _____| |\/| |\  /  " '>> .bashrc
echo 'echo -e "\033[91m        \ V / |  __/ ___) |_____| |  | |/  \  " '>> .bashrc
echo 'echo -e "\033[91m         \_/  |_|   |____/      |_|  |_/_/\_\ " '>> .bashrc
echo 'echo "" '>> .bashrc
echo 'mess1="$(less /etc/newadm/message.txt)" ' >> .bashrc
echo 'echo "" '>> .bashrc
echo 'echo -e "\033[92m        RESELLER : $mess1 "'>> .bashrc
echo 'echo "" '>> .bashrc                                               
echo 'echo -e "\033[97m   PARA MOSTAR PANEL BASH ESCRIBA:  sudo menu "'>> .bashrc
#echo 'wget -O /etc/versin_script_new https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/Vercion &>/dev/null'>> .bashrc
echo 'echo ""'>> .bashrc
echo -e "         COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
echo -e "\033[1;41m                     sudo menu                        \033[0;37m" && msg -bar2
sleep 5
}
verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
case $1 in
"menu"|"message.txt")ARQ="${SCPdir}/";; #Menu
"usercodes")ARQ="${SCPusr}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPinst}/";; #Instalacao
"openssh.sh")ARQ="${SCPinst}/";; #Instalacao
"squid.sh")ARQ="${SCPinst}/";; #Instalacao
"dropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPinst}/";; #Instalacao 
"v2ray.sh")ARQ="${SCPinst}/";; #Instalacao
"budp.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

echo -e "        INSTALANDO PAQUETES........"
apt-get install lsof >/dev/null 2>&1
apt-get install sudo >/dev/null 2>&1
apt-get install cowsay -y >/dev/null 2>&1
apt-get install lolcat -y >/dev/null 2>&1
apt-get install figlet -y >/dev/null 2>&1
apt install python python3 python-pip python3-pip -y >/dev/null 2>&1
inst_components
link=https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/SCRIPT
wget -O /usr/bin/trans https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
wget -O /bin/monitor.sh https://raw.githubusercontent.com/casitadelterror/rex/master/moni/monitor.sh &> /dev/null
chmod +x /bin/monitor.sh
wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/Monitor-Service/estilos.css &> /dev/null
msg -bar2
msg -bar2
msg -ama "     [ VPS - MX - SCRIPT \033[1;97m ❌ MOD By @? ❌\033[1;33m ]"
msg -ama "  \033[1;96m      🔰Usar Ubuntu 18 a 64 De Preferencia🔰 "
msg -bar2
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
NOTIFY () {
msg -bar
msg -ama " Notify-BOT (Notificasion Remota)| VPS-MX  "
msg -bar
echo -e "\033[1;94m Es una opcion para notificar cuando\n un usuario sea bloquedo o este expirado, e info de VPS."
echo -e "\033[1;97m Deve usar el BOT de Telegram @Noti_VPSMX_Bot"
echo -e "\033[1;92m Para sacar su ID solo Meta el comando /MENU en el BOT @USA1_BOT"
echo -e "\033[1;92m Aparesera un pequeño menu donde aparesera su  👤 ID"
msg -bar
echo -e "\033[1;97mIgrese un nombre para el VPS:\033[0;37m"; read -p " " nombr
echo "${nombr}" > /etc/newadm/ger-user/nombre.log
echo -e "\033[1;97mIgrese su ID 👤:\033[0;37m"; read -p " " idbot
echo "${idbot}" > /etc/newadm/ger-user/IDT.log 
msg -bar
echo -e "\033[1;32m         ID AGREGADO CON EXITO"
msg -bar
NOM="$(less /etc/newadm/ger-user/nombre.log)"
NOM1="$(echo $NOM)"
IDB1=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB2=`echo $IDB1` > /dev/null 2>&1

KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
👉 MENSAJE DE PRUEBA
🔰 EXITOSO... SALUDOS"
curl -s --max-time 10 -d "chat_id=$IDB2&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null

echo -e "\033[1;34mSE ENVIO MENSAJE DE PRUEBA SI NO LLEGA CONTACTE A @? "
}
pontos="*"
_repomx=("ADMbot.sh" "C-SSR.sh" "Crear-Demo.sh" "PDirect.py" "PGet.py" "POpen.py" "PPriv.py" "PPub.py" "Shadowsocks-R.sh" "Shadowsocks-libev.sh" "Unlock-Pass-VULTR.sh" "apacheon.sh" "blockBT.sh" "budp.sh" "dns-netflix.sh" "dropbear.sh" "fai2ban.sh" "gestor.sh" "menu" "message.txt" "openvpn.sh" "paysnd.sh" "ports.sh" "shadowsocks.sh" "sockspy.sh" "speed.sh" "speedtest.py" "squid.sh" "squidpass.sh" "ssl.sh" "tcp.sh" "ultrahost" "usercodes" "utils.sh" "v2ray.sh")
for _archi in ${_repomx[@]}; do
   stopping="Iniciando Descarga"
   msg -verm "${stopping}${pontos}"
   tput cuu1 && tput dl1
   pontos+="*"
	[[ -e ${SCPinstal}/${_archi} ]] && rm -rf ${SCPinstal}/${_archi} >/dev/null 2>&1
	wget -O ${SCPinstal}/${_archi} $link/${_archi} &>/dev/null && verificar_arq "${_archi}"
done
sleep 1s
msg -bar
Key="ScriptFree-Casita-Kalix1-Oficial/12345*456*"
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/adm && chmod +x /usr/bin/adm
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   echo -e "${cor[2]}         DESEAS INSTALAR NOTI-BOT?(Default n)"
   echo -e "\033[1;34m  (Deves tener Telegram y el BOT: @Noti_VPSMX_Bot)"
   msg -bar2
   read -p " [ s | n ]: " NOTIFY   
   [[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   msg -bar
   [[ ${byinst} = "true" ]] && install_fim
}
#
clear
#figlet  *SCRIPT*
#figlet  *FREE*
#figlet  *2020*
df
echo ""
msg -bar
echo -e "\e[1;37m	MENÚ DE OPCIONES"
echo -e "\e[33m     MAQUINA            SISTEMA"
echo -e "\e[33m  IP : \e[31m$IP\e[0m   \e[33m OS : \e[31m$(systema)"
echo -e "\e[1;31m \e[1;100m@conectedmx_vip   =    @conectedmx\e[0m"
msg -bar
#
echo -e "\e[1;37m	INSTALACION SIN KEY"
msg -bar
echo -e "\e[1;31m {-1-} \e[1;33m VPSMX BY KALIX1 -(CASITA)"
echo -e "\e[1;31m {-2-} \e[1;33m VPSMX BY KALIX1 -(OFICIAL)"
echo -e "\e[1;31m {-3-} \e[1;33m NEWADM by DANKELTHAHER"
echo -e "\e[1;31m {-4-} \e[1;33m VPSPACK By powermx"
#echo -e "\e[1;31m {-4-} \e[1;33m ADM-GOLDEN-pro By alexmod80"
echo -e "\e[1;31m {-5-} \e[1;33m SSHPLUS (ESPAÑOL) -(CASITA)"
echo -e "\e[1;31m {-6-} \e[1;33m ADM-MX MOD BY (SIXREAPER)"
echo -e "\e[1;31m {-7-} \e[1;37m ACTUALIZAR PAQUETES -UPDATE -(opcional)"
echo -e "\e[1;31m {-0-} \e[1;37m SALIR"
echo -ne "\e[1;37m SELECIONE UNA OPCION: \e[1;33m"; read casitax
case $casitax in
#
0)exit;;
1)scriptmx;;
2)kaliofc;;
3)dankel;;
4)power;;
#4)golden ;;
5)sshplus;;
6)reaper ;;
7)update;;
*)echo -e "\e[1;37m POR FAVOR SELECIONE EL NÚMERO CORRECTO"
rm -rf multiscript.sh
rm -rf .bash_history
read -p " ENTER PARA VOLVER "
mix
;;
#
esac
rm -rf multiscript.sh
rm -rf .bash_history