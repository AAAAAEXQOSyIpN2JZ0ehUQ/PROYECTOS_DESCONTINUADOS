#!/bin/bash
vpspackversion=3.5k
OS=`uname -m`;
fecha=`date`;
MYIP=`hostname -I | awk '{print $1}'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
if [ $(id -u) != 0 ]
then
echo "Ejecute el script como root"
exit
fi
clear
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
echo -e "\033[1;30mInstalando VPSPack $vpspackversion\033[0m"
echo -e "\033[1;30mEspere por favor\033[0m"
echo -e "\033[1;30mSe instalaran los paquetes necesarios\033[0m"
echo -e "\033[1;30mTOM4NDANTE\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
sleep 5
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m Preparando Sistema\033[1;33m"
function preparar(){
mkdir /etc/VpsPackdir  2>/dev/null
mkdir /etc/VpsPackdir/limite 2>/dev/null
mkdir /etc/VpsPackdir/senha 2>/dev/null
mkdir /etc/VpsPackdir/v 2>/dev/null
rm -rf /etc/VpsPackdir/fecha 2>/dev/null
rm -rf /root/name 2>/dev/null
rm -rf /bin/limite 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/xilgyq612wtarsu/limite > /bin/limite
chmod +x /bin/limite
rm -rf /bin/criarusuario 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/9fhdiqtwyl0qxz0/criarusuario > /bin/criarusuario
chmod +x /bin/criarusuario
rm -rf /bin/deletarusuario 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/ub9m9l18es8ky1g/deletarusuario > /bin/deletarusuario
chmod +x /bin/deletarusuario
rm -rf /bin/redefinirusuario 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/9i2qvamlc3yn3vy/redefinirusuario > /bin/redefinirusuario
chmod +x /bin/redefinirusuario
rm -rf /bin/vpspack 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/dqjmd7akos9ajsc/vpspack > /bin/vpspack
chmod +x /bin/vpspack
rm -rf /bin/speedtest.py 2>/dev/null
wget -o /dev/null -O- https://www.dropbox.com/s/s0fd7nahwtpdn8h/speedtest.py > /bin/speedtest.py
chmod +x /bin/speedtest.py
wget -o /dev/null -O- https://www.dropbox.com/s/pmzfyz36m0r6z4b/toolmaster > /bin/toolmaster
chmod +x /bin/toolmaster
wget -o /dev/null -O- https://www.dropbox.com/s/pnnvare0zm6dw79/pl.sh > /etc/VpsPackdir/pl.sh
chmod +x /etc/VpsPackdir/pl.sh
wget -o /dev/null -O- https://www.dropbox.com/s/zps7s7pdy08hsm5/d.sh > /etc/VpsPackdir/d.sh
chmod +x /etc/VpsPackdir/d.sh
wget -o /dev/null -O- https://www.dropbox.com/s/68xz0se65ktfzw3/dropbear > /root/dropbear
wget -o /dev/null -O- wget https://www.dropbox.com/s/v3ko54mwgkc9v0n/ssl > /etc/VpsPackdir/ssl
wget -o /dev/null -O- wget https://www.dropbox.com/s/3ppph0s350bljiv/shadowsocks.sh > /etc/VpsPackdir/shadowsocks.sh
chmod +x /etc/VpsPackdir/shadowsocks.sh
wget -o /dev/null -O- wget https://www.dropbox.com/s/9ex3n276ztn469f/proxy.py > /root/proxy.py
wget -o /dev/null -O- wget https://www.dropbox.com/s/g5huri4unn73otw/openvpn-install.sh > /etc/VpsPackdir/openvpn-install.sh
chmod +x /etc/VpsPackdir/openvpn-install.sh
wget -o /dev/null -O- wget https://www.dropbox.com/s/lvh1wx274xsf1mk/confdropbear > /etc/VpsPackdir/confdropbear
rm -rf /etc/VpsPackdir/danted.conf 2>/dev/null
wget -o /dev/null -O- wget https://www.dropbox.com/s/e3dgma1ujxjn2vh/danted.conf > /etc/VpsPackdir/danted.conf
wget -o /dev/null -O- wget https://www.dropbox.com/s/nybjjlf8rq94n78/limpieza.sh > /etc/VpsPackdir/limpieza.sh
chmod +x /etc/VpsPackdir/limpieza.sh
wget -o /dev/null -O- wget https://www.dropbox.com/s/5zwq4sis15j8hgv/version > /etc/VpsPackdir/version
if [ -f /etc/banner ];
then
echo "Banner Detectado"
else
wget -o /dev/null -O- wget https://www.dropbox.com/s/8qxr27n6l2qockf/banner > /etc/banner
fi
wget -o /dev/null -O- wget https://www.dropbox.com/s/inx42ucj6cc3zbn/version.sh > /etc/VpsPackdir/v/version.sh
chmod +x /etc/VpsPackdir/v/version.sh
chmod +x /root/dropbear
}
fun_bar 'preparar'
function paquetes(){
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m Instalando Paquetes\033[1;33m"
apt-get -y install build-essential 1> /dev/null 2> /dev/null
apt-get -y install nano 1> /dev/null 2> /dev/null
apt-get -y install unzip 1> /dev/null 2> /dev/null
apt-get -y install htop 1> /dev/null 2> /dev/null
apt-get -y install curl 1> /dev/null 2> /dev/null
apt-get -y install nginx 1> /dev/null 2> /dev/null
apt-get -y install figlet 1> /dev/null 2> /dev/null
apt-get -y install git 1> /dev/null 2> /dev/null
apt-get -y install build-essential libpq-dev libssl-dev openssl libffi-dev zlib1g-dev 1> /dev/null 2> /dev/null
apt-get -y install screen 1> /dev/null 2> /dev/null
apt-get -y install python3-pip 1> /dev/null 2> /dev/null
apt-get -y install python-pip 1> /dev/null 2> /dev/null
apt-get -y install nload 1> /dev/null 2> /dev/null
apt-get -y install dos2unix 1> /dev/null 2> /dev/null
apt-get -y install npm 1> /dev/null 2> /dev/null
yum -y install figlet nano unzip curl 1> /dev/null 2> /dev/null
service apache2 stop 1> /dev/null 2> /dev/null
if cat /etc/apt/sources.list |grep neofetch 1> /dev/null 2> /dev/null; then
echo -e "Ya esta instalado Neofetch"
else
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key
apt-get update 1> /dev/null 2>/dev/null
apt-get install -y neofetch 1> /dev/null 2> /dev/null
fi
rm /etc/nginx/sites-enabled/default 1> /dev/null 2>/dev/null
rm /etc/nginx/sites-available/default 1> /dev/null 2>/dev/null
wget --no-check-certificate -O /etc/nginx/nginx.conf "https://www.dropbox.com/s/f4f8lc12tjvmfca/nginx.conf" 1> /dev/null 2> /dev/null
mkdir -p /home/vps/public_html 1> /dev/null 2> /dev/null
echo "<pre>VPSPACK $vpspackversion</pre>" > /home/vps/public_html/index.html 1> /dev/null 2> /dev/null
wget --no-check-certificate -O /etc/nginx/conf.d/vps.conf "https://www.dropbox.com/s/ywknxk10zffnjfx/vps.conf" 1> /dev/null 2> /dev/null
service nginx restart
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m Instalacion Finalizada\033[1;33m"
}
fun_bar 'paquetes'
sleep 5
clear
if cat /root/.bashrc | grep VPSPack; then
echo -e ":)"
else
echo "clear" >> .bashrc
echo 'DATE=$(date +"%d-%m-%y")' >> .bashrc
echo 'TIME=$(date +"%T")' >> .bashrc
echo 'figlet -k VPSPack' >> .bashrc
echo 'echo -e ""' >> .bashrc
echo 'echo -e "Nombre del Servidor : $HOSTNAME"' >> .bashrc
echo 'echo -e "Fecha del Servidor : $DATE"' >> .bashrc
echo 'echo -e "Hora del Servidor : $TIME"' >> .bashrc
echo 'echo -e ""' >> .bashrc
echo 'echo -e "Bienvenido!"' >> .bashrc
echo 'echo -e "Teclee vpspack para ver el listado de comandos."' >> .bashrc
echo 'echo -e ""' >> .bashrc
fi
clear
figlet -f small VPSPack
echo -e "\033[1;32mInstalacion Finalizada\n\033[1;30m"
echo -e "\n\033[1;32mvpspack     \033[1;30mMENU DE OPCIONES"
echo -e "\033[1;32mOpcion 1    \033[1;30mINSTALAR SQUID/SSH"
echo -e "\033[1;32mOpcion 2    \033[1;30mADMINISTRACION DE USUARIOS"
echo -e "\033[1;32mOpcion 8    \033[1;30mPUERTOS HABILITADOS"
echo -e "\033[1;32mOpcion 10   \033[1;30mINSTALADORES"
echo -e "\033[1;32m@- \033[1;30mGrupo de Telegram : @TOM4NDANTE\033[0m"
echo -e "\033[1;32mVersion     \033[1;30m$vpspackversion \033[0m"
echo -e "$fecha" >> /etc/VpsPackdir/fecha
echo -e "\033[1;32m Personalizacion - Escribe tu Nick:\033[0m"
echo -e "\033[1;32m (Maximo 10 Caracteres)\033[0m"
read -p ": " nickname
echo "$nickname" >> /root/name
rm -rf instalador
vpspack