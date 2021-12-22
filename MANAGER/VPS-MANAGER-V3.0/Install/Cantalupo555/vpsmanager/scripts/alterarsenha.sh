#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Alterar Senha de Usuário" ; tput sgr0
tput bold ; echo "" ; echo "Lista de usuários:" ; echo "" ; tput sgr0
tput setaf 3 ; tput bold ; awk -F : '$3 >= 500 { print $1 }' /etc/passwd | grep -v '^nobody' ; echo "" ; tput sgr0
read -p "Nome do usuário para alterar a senha: " user
if [[ -z $user ]]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário vazio ou inválido!" ; echo "" ; tput sgr0
	exit 1
else
	if [[ `grep -c /$user: /etc/passwd` -ne 0 ]]
	then
		read -p "Digite uma nova senha para o usuário: " password
		sizepass=$(echo ${#password})
		if [[ $sizepass -lt 6 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "A senha não foi alterada!" ; echo "Você digitou uma senha muito curta!" ; echo "Para manter o usuário seguro use no mínimo 6 caracteres" ; echo "combinando diferentes letras e números." ; echo "" ; tput sgr0
			exit 1
		else
			ps x | grep $user | grep -v grep | grep -v pt > /tmp/rem
			if [[ `grep -c $user /tmp/rem` -eq 0 ]]
			then
				echo "$user:$password" | chpasswd
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "A senha do usuário $user foi alterada para: $password" ; echo "" ; tput sgr0
				exit 1
			else
				echo ""
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "Usuário conectado. Desconectando..." ; tput sgr0
				pkill -f $user
				echo "$user:$password" | chpasswd
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "A senha do usuário $user foi alterada para: $password" ; echo "" ; tput sgr0
				exit 1
			fi
		fi
	else
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O usuário $user não existe!" ; echo "" ; tput sgr0
	fi
fi