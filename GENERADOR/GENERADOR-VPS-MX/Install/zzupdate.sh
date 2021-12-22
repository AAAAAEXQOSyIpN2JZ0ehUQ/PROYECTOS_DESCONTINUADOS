#!/bin/bash

### COLORES Y BARRA 
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}
rm -rf instalscript.sh
## Script name
SCRIPT_NAME=vpsmxup

## Title and graphics
msg -bar2
echo "         VPS-MX - $(date)"
msg -bar2
sleep 5s

## Enviroment variables
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
HOSTNAME="$(hostname)"

## Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT_FULLPATH=$(readlink -f "$0")
SCRIPT_HASH=`md5sum ${SCRIPT_FULLPATH} | awk '{ print $1 }'`

## Absolute path this script is in, thus /home/user/bin
SCRIPT_DIR=$(dirname "$SCRIPT_FULLPATH")/

## Config files
CONFIGFILE_NAME=$SCRIPT_NAME.conf
CONFIGFILE_FULLPATH_DEFAULT=/usr/local/vpsmxup/vpsmxup.default.conf
CONFIGFILE_FULLPATH_ETC=/etc/vpsmxup/$CONFIGFILE_NAME
CONFIGFILE_FULLPATH_DIR=${SCRIPT_DIR}$CONFIGFILE_NAME

## Title printing function
function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}

## root check
if ! [ $(id -u) = 0 ]; then

		echo ""
		echo "vvvvvvvvvvvvvvvvvvvv"
		echo "    Erro Fatal!!"
		echo "^^^^^^^^^^^^^^^^^^^^"
		echo "Este script debe ejecutarse como root!"

		printTitle "How to fix it?"
		echo "Ejecute el script así:"
		echo "sudo $SCRIPT_NAME"

		printTitle "The End"
		echo $(date)
		msg -bar2
		exit
fi

## Profile requested
if [ ! -z "$1" ]; then

	CONFIGFILE_PROFILE_NAME=${SCRIPT_NAME}.profile.${1}.conf
	CONFIGFILE_PROFILE_FULLPATH_ETC=/etc/vpsmxup/$CONFIGFILE_PROFILE_NAME
	CONFIGFILE_PROFILE_FULLPATH_DIR=${SCRIPT_DIR}$CONFIGFILE_PROFILE_NAME

	if [ ! -f "$CONFIGFILE_PROFILE_FULLPATH_ETC" ] && [ ! -f "$CONFIGFILE_PROFILE_FULLPATH_DIR" ]; then

		echo ""
		echo "vvvvvvvvvvvvvvvvvvvv"
		echo "Catastrophic error!!"
		echo "^^^^^^^^^^^^^^^^^^^^"
		echo "Profile config file(s) not found:"
		echo "[X] $CONFIGFILE_PROFILE_FULLPATH_ETC"
		echo "[X] $CONFIGFILE_PROFILE_FULLPATH_DIR"

		printTitle "How to fix it?"
		echo "Create a config file for this profile:"
		echo "sudo cp $CONFIGFILE_FULLPATH_DEFAULT $CONFIGFILE_PROFILE_FULLPATH_ETC && sudo nano $CONFIGFILE_PROFILE_FULLPATH_ETC && sudo chmod ugo=rw /etc/vpsmxup/*.conf"

		printTitle "The End"
		echo $(date)
		msg -bar2
		exit
	fi
fi


for CONFIGFILE_FULLPATH in "$CONFIGFILE_FULLPATH_DEFAULT" "$CONFIGFILE_MYSQL_FULLPATH_ETC" "$CONFIGFILE_FULLPATH_ETC" "$CONFIGFILE_FULLPATH_DIR" "$CONFIGFILE_PROFILE_FULLPATH_ETC" "$CONFIGFILE_PROFILE_FULLPATH_DIR"
do
	if [ -f "$CONFIGFILE_FULLPATH" ]; then
		source "$CONFIGFILE_FULLPATH"
	fi
done
	
printTitle "Actualización automática"
INSTALL_DIR_PARENT="/usr/local/vpsmxup/"


SCRIPT_HASH_AFTER_UPDATE=`md5sum ${SCRIPT_FULLPATH} | awk '{ print $1 }'`
if [ "$SCRIPT_HASH" != "$SCRIPT_HASH_AFTER_UPDATE" ]; then
		echo ""
		echo "vvvvvvvvvvvvvvvvvvvvvv"
		echo "Self-update installed!"
		echo "^^^^^^^^^^^^^^^^^^^^^^"
		echo "zzupdate itself has been updated!"
		echo "Please run zzupdate again to update your system."

		printTitle "The End"
		echo $(date)
		msg -bar2
		exit
fi


if [ "$SWITCH_PROMPT_TO_NORMAL" = "1" ]; then

	printTitle "Switching to the 'normal' release channel (if 'never' or 'lts')"
	sed -i -E 's/Prompt=(never|lts)/Prompt=normal/g' "/etc/update-manager/release-upgrades"
	
else

	printTitle "La conmutación de canales está deshabilitada"
	
fi


printTitle "Limpieza de caché local"
apt-get clean

printTitle "Actualizar información de paquetes disponibles"
apt-get update

printTitle "PAQUETES DE ACTUALIZACIÓN"
apt-get dist-upgrade -y

if [ "$VERSION_UPGRADE" = "1" ] && [ "$VERSION_UPGRADE_SILENT" = "1" ]; then

	printTitle "Actualice silenciosamente a una nueva versión, si la hay"
	do-release-upgrade -f DistUpgradeViewNonInteractive
	
elif [ "$VERSION_UPGRADE" = "1" ] && [ "$VERSION_UPGRADE_SILENT" = "0" ]; then

	printTitle "Actualice interactivamente a una nueva versión, si la hay"
	do-release-upgrade
	
else

	printTitle "Nueva versión omitida (deshabilitada en la configuración)"
	
fi

if [ "$COMPOSER_UPGRADE" = "1" ]; then

	printTitle "Compositor de actualización automática"
	
	if ! [ -x "$(command -v composer)" ]; then
		echo "Composer no está instalado"
	else
		composer self-update
	fi
fi

if [ "$SYMFONY_UPGRADE" = "1" ]; then

	printTitle "Symfony con actualización automática"
	
	if ! [ -x "$(command -v symfony)" ]; then
		echo "Symfony is not installed"
	else
		symfony self:update --yes
	fi
fi

printTitle "Limpieza de paquetes (eliminación automática de paquetes no utilizados)"
apt-get autoremove -y

printTitle "Versión actual"
lsb_release -d

printTitle "Tiempo que tomó Actulizacion de Repositorios de UBUNTU"
echo "$((($(date +%s)-$TIME_START)/60)) min."
msg -bar2
echo -e "\033[93m         -- ACTULIZACION DE UBUNTU COMPLETA -- "
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/GENERADOR-VPS-MX/Install/VPS-MX.sh -O /usr/bin/VPS-MX &> /dev/null
chmod +x /usr/bin/VPS-MX
if [ "$REBOOT" = "1" ]; then
	printTitle "        SU VPS SE REINICIARA EN 20 SEGUNDOS           "
	
	while [ $REBOOT_TIMEOUT -gt 0 ]; do
	   echo -ne "                         -$REBOOT_TIMEOUT-\033[0K\r"
	   sleep 1
	   : $((REBOOT_TIMEOUT--))
	done
	reboot
fi

printTitle "Se procede a Instalar VPS-MX"
echo $(date)
msg -bar2
sleep 7s
clear
VPS-MX