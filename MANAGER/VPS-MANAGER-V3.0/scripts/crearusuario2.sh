#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "Crear Usuário SSH" ; tput sgr0
echo ""
read -p "nombre de elusuário: " username
awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$username" /tmp/users
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Este usuario ya existe. Crear un usuario con otro nombre." ; echo "" ; tput sgr0
	exit 1	
else
	if (echo $username | egrep [^a-zA-Z0-9.-_] &> /dev/null)
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "ha introducido un nombre de usuario válido!" ; tput setab 1 ; echo "utilizar sólo letras, números, puntos y rayas." ; tput setab 4 ; echo "No utilice espacios, acentos o caracteres especiales!" ; echo "" ; tput sgr0
		exit 1
	else
		sizemin=$(echo ${#username})
		if [[ $sizemin -lt 2 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un nombre de usuario muy corto," ; echo "utilizar al menos dos caracteres!" ; echo "" ; tput sgr0
			exit 1
		else
			sizemax=$(echo ${#username})
			if [[ $sizemax -gt 32 ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un nombre de usuario muy grande," ; echo "utilizar no más de 32 caracteres!" ; echo "" ; tput sgr0
				exit 1
			else
				if [[ -z $username ]]
				then
					tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un nombre de usuario vacío!" ; echo "" ; tput sgr0
					exit 1
				else	
					read -p "contraseña: " password
					if [[ -z $password ]]
					then
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido una contraseña vacía!" ; echo "" ; tput sgr0
						exit 1
					else
						sizepass=$(echo ${#password})
						if [[ $sizepass -lt 6 ]]
						then
							tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido una contraseña muy corto!" ; echo "Para mantener el uso seguro del usuario al menos 6 caracteres" ; echo "la combinación de diferentes letras y números!" ; echo "" ; tput sgr0
							exit 1
						else	
							read -p "Dias para expirar: " dias
							if (echo $dias | egrep '[^0-9]' &> /dev/null)
							then
								tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un número no válido de días!" ; echo "" ; tput sgr0
								exit 1
							else
								if [[ -z $dias ]]
								then
									tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Dejaste el número de días para la cuenta expira vacía!" ; echo "" ; tput sgr0
									exit 1
								else	
									if [[ $dias -lt 1 ]]
									then
										tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "debe introducir un número de días superior a cero!" ; echo "" ; tput sgr0
										exit 1
									else
										read -p "Nº de conexiones simultaneas permitidas: " sshlimiter
										if (echo $sshlimiter | egrep '[^0-9]' &> /dev/null)
										then
											tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un número no válido de conexiones!" ; echo "" ; tput sgr0
											exit 1
										else
											if [[ -z $sshlimiter ]]
											then
												tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Dejaste el número de conexiones simultáneas vacías!" ; echo "" ; tput sgr0
												exit 1
											else
												if [[ $sshlimiter -lt 1 ]]
												then
													tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Debe introducir un mayor número de conexiones simultáneas que el cero!" ; echo "" ; tput sgr0
													exit 1
												else
													final=$(date "+%Y-%m-%d" -d "+$dias days")
													gui=$(date "+%d/%m/%Y" -d "+$dias days")
													pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
													useradd -e $final -M -s /bin/false -p $pass $username
													[ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo "Usuário $username creado" ; echo "Data de expiracion: $gui" ; echo "Nº de conexiones simultaneas permitidas: $sshlimiter" ; echo "" || echo "No se pudo crear el usuario!" ; tput sgr0
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