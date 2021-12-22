#!/bin/bash
database="/root/usuarios.db"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%20s%s\n' "   Alterar limite de conexões SSH simultâneas   " ; tput sgr0
if [ ! -f "$database" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Arquivo $database não encontrado" ; echo "" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "Limite de conexões simultâneas dos usuários:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $database ; echo "" ; tput sgr0
	read -p "Nome de usuário para alterar o limite: " usuario
	if [[ -z $usuario ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário vazio ou não existente na lista!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$usuario " $database` -gt 0 ]]
		then
			read -p "Número de conexões simultâneas permitidas para o usuário: " sshnum
			if [[ -z $sshnum ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número inválido!" ; echo "" ; tput sgr0
				exit 1
			else
				if (echo $sshnum | egrep [^0-9] &> /dev/null)
				then
					tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número inválido!" ; echo "" ; tput sgr0
					exit 1
				else
					if [[ $sshnum -lt 1 ]]
					then
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deve digitar um número de conexões simultâneas maior que zero!" ; echo "" ; tput sgr0
						exit 1
					else
						grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
						sleep 1
						mv /tmp/a /root/usuarios.db
						echo $usuario $sshnum >> /root/usuarios.db
						tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "O número de conexões simultâneas permitidas para o usuário $usuario foi alterado:" ; tput sgr0
						tput setaf 3 ; tput bold ; echo "" ; cat $database ; echo "" ; tput sgr0
						exit
					fi
				fi
			fi			
		else
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O usuário $usuario não foi encontrado na lista!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi