#!/bin/bash
payload="/etc/squid/payload.txt"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Remover Host de Squid3" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Archivo $payload no encontrado" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "Domínios atuais no arquivo $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Introduzca el dominio que desea eliminar de la lista: " host
	if [[ -z $host ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un dominio vacío o inexistente!" ; echo "" ; tput sgr0
			exit 1
		else
		if [[ `grep -c "^$host" $payload` -ne 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "el domínio $host no fue encontrado en el arquivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Archivo $payload atualizado, el domínio fue removido con exito:" ; tput sgr0
			tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
			if [ ! -f "/etc/init.d/squid" ]
			then
				service squid reload
			else
				/etc/init.d/squid reload
			fi	
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "el Proxy Squid3 fue recarregado con exito!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi