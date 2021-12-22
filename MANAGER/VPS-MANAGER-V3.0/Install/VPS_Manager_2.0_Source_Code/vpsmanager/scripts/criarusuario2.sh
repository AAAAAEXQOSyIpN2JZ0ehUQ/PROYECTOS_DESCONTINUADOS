#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "Criar Usuário SSH" ; tput sgr0
echo ""
read -p "Nome do usuário: " username
awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$username" /tmp/users
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Este usuário já existe. Crie um usuário com outro nome." ; echo "" ; tput sgr0
	exit 1	
else
	if (echo $username | egrep [^a-zA-Z0-9.-_] &> /dev/null)
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário inválido!" ; tput setab 1 ; echo "Use apenas letras, números, pontos e traços." ; tput setab 4 ; echo "Não use espaços, acentos ou caracteres especiais!" ; echo "" ; tput sgr0
		exit 1
	else
		sizemin=$(echo ${#username})
		if [[ $sizemin -lt 2 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário muito curto," ; echo "use no mínimo dois caracteres!" ; echo "" ; tput sgr0
			exit 1
		else
			sizemax=$(echo ${#username})
			if [[ $sizemax -gt 32 ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário muito grande," ; echo "use no máximo 32 caracteres!" ; echo "" ; tput sgr0
				exit 1
			else
				if [[ -z $username ]]
				then
					tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário vazio!" ; echo "" ; tput sgr0
					exit 1
				else	
					read -p "Senha: " password
					if [[ -z $password ]]
					then
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou uma senha vazia!" ; echo "" ; tput sgr0
						exit 1
					else
						sizepass=$(echo ${#password})
						if [[ $sizepass -lt 6 ]]
						then
							tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou uma senha muito curta!" ; echo "Para manter o usuário seguro use no mínimo 6 caracteres" ; echo "combinando diferentes letras e números!" ; echo "" ; tput sgr0
							exit 1
						else	
							read -p "Dias para expirar: " dias
							if (echo $dias | egrep '[^0-9]' &> /dev/null)
							then
								tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número de dias inválido!" ; echo "" ; tput sgr0
								exit 1
							else
								if [[ -z $dias ]]
								then
									tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deixou o número de dias para a conta expirar vazio!" ; echo "" ; tput sgr0
									exit 1
								else	
									if [[ $dias -lt 1 ]]
									then
										tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deve digitar um número de dias maior que zero!" ; echo "" ; tput sgr0
										exit 1
									else
										read -p "Nº de conexões simultâneas permitidas: " sshlimiter
										if (echo $sshlimiter | egrep '[^0-9]' &> /dev/null)
										then
											tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número de conexões inválido!" ; echo "" ; tput sgr0
											exit 1
										else
											if [[ -z $sshlimiter ]]
											then
												tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deixou o número de conexões simultâneas vazio!" ; echo "" ; tput sgr0
												exit 1
											else
												if [[ $sshlimiter -lt 1 ]]
												then
													tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deve digitar um número de conexões simultâneas maior que zero!" ; echo "" ; tput sgr0
													exit 1
												else
													final=$(date "+%Y-%m-%d" -d "+$dias days")
													gui=$(date "+%d/%m/%Y" -d "+$dias days")
													pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
													useradd -e $final -M -s /bin/false -p $pass $username
													[ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo "Usuário $username criado" ; echo "Data de expiração: $gui" ; echo "Nº de conexões simultâneas permitidas: $sshlimiter" ; echo "" || echo "Não foi possível criar o usuário!" ; tput sgr0
													echo "$username $sshlimiter" >> /root/usuarios.db
												fi
											fi
										fi
									fi
								fi
							fi
						fi
					fi
				fi
			fi
		fi
	fi	
fi