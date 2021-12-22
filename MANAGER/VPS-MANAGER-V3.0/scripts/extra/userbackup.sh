#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "User Backup 1.2" ; tput sgr0
tput setaf 3 ; tput bold ; echo ""
echo "Atención: Este es un script experimental y sin garantías, utilice por su cuenta y riesgo."
echo "Este script sirve para crear una copia de todos los usuarios y contraseña"
echo "para moverse a un nuevo servidor."
echo "Evitar el trabajo de crear las cuentas de todos los usuarios de nuevo."
echo "Esta copia de seguridad también incluye la contraseña del usuario root!" ; tput sgr0

echo ""
echo "Qué quieres hacer?"
echo ""
echo "1 - CREAR BACKUP"
echo "2 - RESTAURAR BACKUP"
echo "3 - SALIR"
echo ""

read -p "opcion: " -e -i 3 opcao

if [[ "$opcao" = '1' ]]; then
	if [ -f "/root/usuarios.db" ]
	then
		echo ""
		echo "Creando backup..."
		echo ""
		tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow
		echo ""
		echo "Arquivo /root/backup.vps creado con éxito."
		echo ""
	else
		echo ""
		echo "Creando backup..."
		echo ""
		tar cvf /root/backup.vps /etc/shadow /etc/passwd /etc/group /etc/gshadow
		echo ""
		echo "Arquivo /root/backup.vps creado con éxito."
		echo ""
	fi
fi
if [[ "$opcao" = '2' ]]; then
	if [ -f "/root/backup.vps" ]
	then
		echo ""
		echo "Restaurando backup..."
		echo ""
		sleep 1
		cp /root/backup.vps /backup.vps
		cd /
		tar -xvf backup.vps
		rm /backup.vps
		echo ""
		echo "Usuarios y contraseña importados con éxito."
		echo ""
		exit
	else
		echo ""
		echo "O arquivo /root/backup.vps não foi encontrado!"
		echo "Ceritifique-se que ele esteja localizado no diretório /root/ com o nome backup.vps"
		echo ""
		exit
	fi
fi
