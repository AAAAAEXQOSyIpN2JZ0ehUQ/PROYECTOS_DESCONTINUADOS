#!/bin/bash
database="/root/usuarios.db"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%20s%s\n' "   Cambiar el límite de conexiones simultáneas de SSH   " ; tput sgr0
if [ ! -f "$database" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "No se encontró el $database " ; echo "" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "Limitar las conexiones simultáneas para los usuarios:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $database ; echo "" ; tput sgr0
	read -p "Nome de usuário para alterar o limite: " usuario
	if [[ -z $usuario ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un nombre de usuario vacío que no existente en la lista
!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$usuario " $database` -gt 0 ]]
		then
			read -p "Número de conexiones simultáneas que se permite al usuario: " sshnum
			if [[ -z $sshnum ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un número no válido!" ; echo "" ; tput sgr0
				exit 1
			else
				if (echo $sshnum | egrep [^0-9] &> /dev/null)
				then
					tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un número no válido!" ; echo "" ; tput sgr0
					exit 1
				else
					if [[ $sshnum -lt 1 ]]
					then
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Debe introducir un mayor número de conexiones simultáneas que el cero!" ; echo "" ; tput sgr0
						exit 1
					else
						grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
						sleep 1
						mv /tmp/a /root/usuarios.db
						echo $usuario $sshnum >> /root/usuarios.db
						tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "El número de conexiones simultáneas permitidas para el usuario $ usuario ha cambiado:" ; tput sgr0
						tput setaf 3 ; tput bold ; echo "" ; cat $database ; echo "" ; tput sgr0
						exit
					fi
				fi
			fi			
		else
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O el usuario $ usuario no se encuentra en la lista!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi