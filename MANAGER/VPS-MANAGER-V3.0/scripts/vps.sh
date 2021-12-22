#!/bin/bash
if [ $(id -u) -eq 0 ]
then
	clear
else
	if echo $(id) |grep sudo > /dev/null
	then
	clear
	echo "Voce não é root"
	echo "Seu usuario esta no grupo sudo"
	echo -e "Para virar root execute \033[1;31msudo su\033[0m"
	exit
	else
	clear
	echo -e "Vc nao esta como usuario root, nem com seus direitos (sudo)\nPara virar root execute \033[1;31msu\033[0m e digite sua senha root"
	exit
	fi
fi
if [ "$1" = "" ]; then
clear
echo -e "\033[0;34m ===================================\033[0m"
echo -e "\033[1;31m ∆ \033[1;37mOFICIAL VPS-SERVER\033[0m"
echo -e "\033[1;31m √ \033[1;37mVPS-MANAGER v3.0\033[0m"
echo -e "\033[0;34m ===================================\033[0m"
sso=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
echo -e "\033[1;31m ° \033[1;37m SU SISTEMA \033[1;31m$sso"
echo -e "\033[0;34m ===================================\033[0m"
echo -e "\033[1;31m ∆ \033[1;33m¡BIENVENIDO AL MENÚ!\033[0m"
echo -e "\033[0;34m ===================================\033[0m"
echo -e " \033[1;31m|\033[1;36m01\033[1;31m| \033[1;32m> \033[1;37mCREAR USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m02\033[1;31m| \033[1;32m> \033[1;37mALTERAR CONTRASEÑA USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m03\033[1;31m| \033[1;32m> \033[1;37mMODIFICAR FECHA USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m04\033[1;31m| \033[1;32m> \033[1;37mALTERAR LIMITE USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m05\033[1;31m| \033[1;32m> \033[1;37mELIMINAR USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m06\033[1;31m| \033[1;32m> \033[1;37mELIMINAR USUARIOS VENCIDOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m07\033[1;31m| \033[1;32m> \033[1;37mVERIFICAR USUARIOS ONLINE\033[01;37m"
echo -e " \033[1;31m|\033[1;36m08\033[1;31m| \033[1;32m> \033[1;37mKILL MULTILOGUIN\033[01;37m"
echo -e " \033[1;31m|\033[1;36m09\033[1;31m| \033[1;32m> \033[1;37mAGREGAR HOST\033[01;37m"
echo -e " \033[1;31m|\033[1;36m10\033[1;31m| \033[1;32m> \033[1;37mELIMINAR HOST\033[01;37m"
echo -e " \033[1;31m|\033[1;36m11\033[1;31m| \033[1;32m> \033[1;37mBADVPN UDP\033[01;37m"
echo -e " \033[1;31m|\033[1;36m12\033[1;31m| \033[1;32m> \033[1;37mBACKUP USUARIOS\033[01;37m"
echo -e " \033[1;31m|\033[1;36m13\033[1;31m| \033[1;32m> \033[1;37mTESTAR VELOCIDAD\033[01;37m"
echo -e " \033[1;31m|\033[1;36m14\033[1;31m| \033[1;32m> \033[1;37mTCP SPEED\033[01;37m"
echo -e " \033[1;31m|\033[1;36m15\033[1;31m| \033[1;32m> \033[1;37mOPENVPN TCP/UDP\033[01;37m"
echo -e " \033[1;31m|\033[1;36m16\033[1;31m| \033[1;32m> \033[1;31mDESINTALAR VPS-MANAGER\033[01;37m"
echo -e "\033[0;34m ===================================\033[0m"
echo -e "\033[1;35m Opción\033[0m"
read -p " : " op
else
op="$1"
fi
case $op in
0 | 00 )
/bin/squid
;;
1 | 01 )
/bin/crearusuario
;;
2 | 02 )
/bin/alterarclaveusuario
;;
3 | 03 )
/bin/mudardata
;;
4 | 04 )
/bin/alterarlimite
;;
5 | 05 )
/bin/remover
;;
6 | 06 )
/bin/expcleaner
;;
7 | 07 )
/bin/sshmonitor
;;
8 | 08 )clear
/bin/sshlimiter
exit
;;
9)
/bin/addhost
exit
;;
10)
/bin/delhost
exit
;;
11)
/bin/badvpnsetup
exit
;;
12)
/bin/userbackup
exit
;;
13)
/bin/speedtest.py
exit
;;
14)
/bin/tcptweaker
exit
;;
15)
/bin/openvpn-install
exit
;;
16)
rm -rf /etc/squid3/payload.txt 2>/dev/null
rm -rf /bin/terminos 2>/dev/null
rm -rf /bin/addhost 2>/dev/null
rm -rf /bin/alterarclaveusuario 2>/dev/null
rm -rf /bin/socked 2>/dev/null
rm -rf /bin/shadowsocks 2>/dev/null
rm -rf /bin/crearusuario 2>/dev/null
rm -rf /bin/delhost 2>/dev/null
rm -rf /bin/expcleaner 2>/dev/null
rm -rf /bin/mudardata 2>/dev/null
rm -rf /bin/remover 2>/dev/null
rm -rf /bin/sshlimiter 2>/dev/null
rm -rf /bin/alterarlimite 2>/dev/null
rm -rf /bin/vps 2>/dev/null
rm -rf /bin/sshmonitor 2>/dev/null
rm -rf /bin/speedtest.py 2>/dev/null
rm -rf /bin/badvpnsetup 2>/dev/null
rm -rf /bin/userbackup 2>/dev/null
rm -rf /bin/openvpn-install 2>/dev/null
rm -rf /bin/tcptweaker 2>/dev/null
rm -rf /bin/ajuda 2>/dev/null
sed -i 's/Port 22222/Port 22/g' /etc/ssh/sshd_config  > /dev/null 2>&1
service ssh restart  > /dev/null 2>&1
apt-get purge squid -y
apt-get purge squid3 -y
#apt-get purge squid3 bc screen nano unzip dos2unix wget -y
echo 3 > /proc/sys/vm/drop_caches &>/dev/null
sleep 1s
sysctl -w vm.drop_caches=3 &>/dev/null
apt-get autoclean -y &>/dev/null
sleep 1s
apt-get clean -y &>/dev/null
rm /tmp/* &>/dev/null
touch /tmp/abc
sleep 0.5s
exit
;;
*)
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%44s%s%-20s\n' "OPCIÓN INVÁLIDA..." ; tput sgr0
sleep 1
vps
exit
;;
esac
exit

