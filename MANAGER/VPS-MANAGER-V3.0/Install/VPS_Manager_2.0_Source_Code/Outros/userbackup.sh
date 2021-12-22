#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "User Backup 1.2 by Phreaker56" ; tput sgr0
tput setaf 3 ; tput bold ; echo ""
echo "Atenção: Este é um script experimental e sem garantias, use por sua conta e risco."
echo "Este script serve para criar uma cópia de todos os usuários e senhas"
echo "para ser movido para um novo servidor."
echo "Evitando o trabalho de criar as contas de todos os usuários novamente."
echo "Este backup também inclui a senha do usuário root!" ; tput sgr0

echo ""
echo "O que deseja fazer?"
echo ""
echo "1 - CRIAR BACKUP"
echo "2 - RESTAURAR BACKUP"
echo "3 - SAIR"
echo ""

read -p "Opção: " -e -i 3 opcao

if [[ "$opcao" = '1' ]]; then
	if [ -f "/root/usuarios.db" ]
	then
		echo ""
		echo "Criando backup..."
		echo ""
		tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow
		echo ""
		echo "Arquivo /root/backup.vps criado com sucesso."
		echo ""
	else
		echo ""
		echo "Criando backup..."
		echo ""
		tar cvf /root/backup.vps /etc/shadow /etc/passwd /etc/group /etc/gshadow
		echo ""
		echo "Arquivo /root/backup.vps criado com sucesso."
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
		echo "Usuários e senhas importados com sucesso."
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