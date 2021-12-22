#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
[[ ! -e /bin/msm ]] && echo "/root/multiscript2.sh" > /bin/msm && chmod +x /bin/msm #ACCESO RAPIDO
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
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
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
IP=$(cat /etc/IP)
x="ok"
menu ()
{
#TEAM-ILUUMINATI
sshplusfree () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod 777 Plus; ./Plus
}
admmanageralpha () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ALPHA/main/instala.sh; chmod 777 instala.sh* && ./instala.sh*
}
newultimate () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-ULTIMATE-NEW-FREE/master/instalar.sh; chmod 777 instalar.sh* && ./instalar.sh*
}
vpsmanager30 () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPS-MANAGER-V3.0/vpsmanagersetup.sh; chmod +x vpsmanagersetup.sh; ./vpsmanagersetup.sh
}
vpspack20 () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/VPSPACK-SERVER-V2.0/instalarold && bash instalarold
}
dankel () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/ADM-MANAGER-DANKELTHAHER/instala.sh; chmod 777 instala.sh* && ./instala.sh*
}
scriptmx_illuminati () {
    sudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/NEW-ULTIMATE-VPS-MX-8.0/instalscript.sh; chmod 777 instalscript.sh* && ./instalscript.sh*
}
scriptmx_illuminatiUpdate () {
    sudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MX/main/instalscript.sh; chmod 777 instalscript.sh* && ./instalscript.sh*
}

#SCRIPTS DE PAGA
admvps () {
    apt-get update -y; apt-get upgrade -y; wget --no-check-certificate https://www.dropbox.com/s/ahnt8khniflsob3/New; chmod 777 New* && ./New*
}
sshpluskey () {
    apt-get update -y; apt-get upgrade -y; wget sshplus.xyz/script/Plus; chmod 777 Plus; ./Plus
}
cgh () {
    apt-get update -y; apt-get upgrade -y; wget -q https://www.dropbox.com/s/i87udxpj1lj17sa/instala.sh; chmod 777 instala.sh* && ./instala.sh*
}

#LIBERADOS POR EL DEV
newfreeinstaldev () {
    apt-get update -y; apt-get upgrade -y; wget https://www.dropbox.com/s/qhftefty46hz51x/newfreeinstal?dl=0 && bash new*
}

#TEAM-CASITA
scriptmx_casita () {
    sudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/NEW-ULTIMATE-VPS-MX-8.0/Casita/instalscript.sh; chmod +x instalscript.sh* && ./instalscript.sh*
}
power () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/casitadelterror/vpspack5.8/master/instalador/instalavps && chmod +x instalavps && ./instalavps
}
scriptadmmx_reapergamo () {
    apt-get update -y; apt-get upgrade -y; wget --no-check-certificate https://www.dropbox.com/s/s657r7dcaiq9oc9/instala.sh; chmod 777 instala.sh* && ./instala.sh*; passwd
}
sshpluscasitaES () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/scriptsmx/script/master/PLUSX/Plus; chmod 777 Plus; ./Plus
}
dankelcasita () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/casitadelterror/dankeladm/master/instalador/instala.sh; chmod 777 instala.sh* && ./instala.sh*
}

#OPCIONES MULTI INSTALL
keygenplus () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/instala_server; chmod 777 instala_server* && ./instala_server*
}
multiinstallplus () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Multi-Instalador/sshplus.sh; chmod +x sshplus.sh; ./sshplus.sh
}
panelweversiones () {
    apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/Panelweb.sh; chmod +x Panelweb.sh; ./Panelweb.sh
}

#OPCIONES DE SISTEMA
atualizar () {
echo ""
fun_bar "apt-get update -y"
fun_bar "apt-get upgrade -y"
fun_bar "service ssh restart"
rm -rf $HOME/multiscript2.sh* > /dev/null 2>&1; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/MULTI-SCRIPTS-MANAGER/multiscript2.sh > /dev/null 2>&1
echo ""
echo -e "\033[1;33m UPDATE COM SUCESSO -\033[1;32m OK !\033[1;37m"
sleep 4s
chmod +x multiscript2.sh; ./multiscript2.sh
}
remove_multiscripts () {
rm -rf $HOME/multiscript2.sh* && rm -rf /bin/mis
}

while true $x != "ok"
do
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
clear
echo -e "$barra"
echo -e "\E[41;1;37mMULTI-SCRIPTS MANAGER             \033[1;32m[\033[1;37m VERSAO: r090 \033[1;32m]\E[0m"
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;33mSSHPLUS MANAGER                \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;33mADM-MANAGER-ULTIMATE (ALPHA)   \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;33mNEW-ULTIMATE MANAGER           \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;33mVPS-MANAGER-V3.0               \033[1;32m(FREE) " 
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;33mVPSPACK-SERVER-V2.0            \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m06\033[1;31m] \033[1;33mNEWADM MOD DANKELTHAHER        \033[1;32m(FREE) " 
echo -e "\033[1;31m[\033[1;36m07\033[1;31m] \033[1;33mVPSMX BY KALIX1 v8.3.1         \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m08\033[1;31m] \033[1;33mVPSMX BY KALIX1 v8.4           \033[1;32m(FREE) \033[37m∆ "
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m09\033[1;31m] \033[1;33mNEW ADM-VPS OFICIAL            \033[1;31m(KEYS) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m10\033[1;31m] \033[1;33mSSHPLUS MANAGER OFICIAL        \033[1;31m(KEYS) "
echo -e "\033[1;31m[\033[1;36m11\033[1;31m] \033[1;33mADM-MANAGER BY SCHUMOGH        \033[1;31m(KEYS) "
echo -e "\033[1;31m[\033[1;36m12\033[1;31m] \033[1;33mNEW-ULTIMATE OFICIAL-LIV       \033[1;32m(FREE) " 
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m13\033[1;31m] \033[1;33mVPSMX BY KALIX1-CASITA v8.1    \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m14\033[1;31m] \033[1;33mVPSPACK BY POWERMX-CASITA v5.8 \033[1;32m(FREE) " 
echo -e "\033[1;31m[\033[1;36m15\033[1;31m] \033[1;33mADMMX BY SIXREAPER-CASITA      \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m16\033[1;31m] \033[1;33mSSHPLUS MANAGER ES-CASITA      \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m17\033[1;31m] \033[1;33mNEWADM DANKELTHAHER-CASITA     \033[1;32m(FREE) \033[1;31mOFF "
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m18\033[1;31m] \033[1;33mGENERADOR KEY SSHPLUS MANAGER  \033[1;32m(FREE) " 
echo -e "\033[1;31m[\033[1;36m19\033[1;31m] \033[1;33mMULTI-INTALADOR SSHPLUS        \033[1;32m(FREE) " 
echo -e "\033[1;31m[\033[1;36m20\033[1;31m] \033[1;33mPAINEL SSHPLUS WEB (VERSIONES) \033[1;32m(FREE) "
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m21\033[1;31m] \033[1;35m[!] \033[1;32mACTUALIZAR                \033[1;31mRam:\033[1;37m $_usor "
echo -e "\033[1;31m[\033[1;36m22\033[1;31m] \033[1;35m[!] \033[1;31mDESINSTALAR \033[1;35m[\033[1;37m MSM \033[1;35m]       \033[1;31mNucleo:\033[1;37m $_usop "
echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m<                     \033[1;37m@admmanagerfree\033[0m \033[0m"
echo -e "$barra"
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
   1 | 01)
   clear
   sshplusfree
   exit;
   ;;
   2 | 02)
   clear
   admmanageralpha
   exit;
   ;;
   3 | 03)
   clear
   newultimate
   exit;
   ;;
   4 | 04)
   clear
   vpsmanager30
   exit;
   ;;
   5 | 05)
   clear
   vpspack20
   exit;
   ;;      
   6 | 06)
   clear
   dankel
   exit;
   ;;
   7 | 07)
   clear
   scriptmx_illuminati
   exit;
   ;;
   8 | 08)
   clear
   scriptmx_illuminatiUpdate
   exit;
   ;; 
   9 | 09)
   clear
   admvps
   exit;
   ;;
   10 | 10)
   clear
   sshpluskey
   exit;
   ;;     
   11)
   clear
   cgh
   exit;
   ;;     
   12)
   clear
   newfreeinstaldev
   exit;
   ;;
   13)
   clear
   scriptmx_casita
   exit;
   ;;
   14)
   clear
   power
   exit;
   ;;
   15)
   clear
   scriptadmmx_reapergamo
   exit;
   ;;
   16)
   clear
   sshpluscasitaES
   exit;
   ;;
   17)
   clear
   dankelcasita
   exit;
   ;;
   18)
   clear
   keygenplus
   exit;
   ;;
   19)
   clear
   multiinstallplus
   exit;
   ;;
   20)
   clear
   panelweversiones
   exit;
   ;;
   21)
   clear
   atualizar
   exit;
   ;;
   22)
   clear
   remove_multiscripts
   exit;
   ;;
   0 | 00)
echo -e "\033[1;31mSaindo...\033[0m"
sleep 2
clear
exit;
;;
*)
echo -e "\n\033[1;31mOpcao invalida !\033[0m"
esac
done
}
menu
#fim