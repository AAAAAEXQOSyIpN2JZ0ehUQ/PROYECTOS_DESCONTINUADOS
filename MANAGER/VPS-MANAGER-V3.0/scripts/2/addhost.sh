#!/bin/bash
payload="/etc/squid/payload.txt"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Adicionar Host al Squid3" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "archivo $payload no encontrado" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "dominios actuales en el archivo $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Digite el domínio que desea adicionar a lista: " host
	if [[ -z $host ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un dominio vacío o inexistente!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$host" $payload` -eq 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "El dominio $host ya existe en el archivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			if [[ $host != \.* ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Debe añadir un dominio a partir de un punto!" ; echo "Por exemplo: .seannsvpn.sytes.xyz" ; echo "No hay necesidad de añadir subdominios de dominios que ya están en el archivo" ; echo "Es decir, no es necesario añadir recargawap.claro.com.br" ; echo "si el dominio  .claro.com.br ya esta en el archivo." ; echo ""; tput sgr0
				exit 1
			else
				echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Archivo actualizado de $payload el dominio ha sido agregado con éxito:" ; tput sgr0
				tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
				if [ ! -f "/etc/init.d/squid" ]
				then
					service squid reload
				else
					/etc/init.d/squid reload
				fi	
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Proxy squid3 se vuelve a cargar con éxito!" ; echo "" ; tput sgr0
				exit 1
			fi
		fi
	fi
fi