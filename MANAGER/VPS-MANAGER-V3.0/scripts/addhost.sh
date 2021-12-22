#!/bin/bash
payload="/etc/squid3/payload.txt"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Adicionar Host en Squid3" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Arquivo $payload no encontrado" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "dominio actual no encontrado $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Digite o domínio que desea  adicionar a lista: " host
	if [[ -z $host ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "usted digito un dominio que no eciste!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$host" $payload` -eq 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "el domínio $host ya existe en el  archivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			if [[ $host != \.* ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Debe añadir un dominio a partir de un punto!" ; echo "Por exemplo: .seannsvpn.xyz" ; echo "No hay necesidad de añadir subdominios de dominios que ya están en el archivo" ; echo "Es decir, no es necesario añadir recargawap.claro.com.br" ; echo "si el  domínio .claro.com.br yá existe en el archivo." ; echo ""; tput sgr0
				exit 1
			else
				echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo " Archivo actualizado $payload, el dominio ha sido agregado con éxito:" ; tput sgr0
				tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
				if [ ! -f "/etc/init.d/squid3" ]
				then
					service squid3 reload
				else
					/etc/init.d/squid3 reload
				fi	
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Proxy squid3 se vuelve a cargar con éxito!" ; echo "" ; tput sgr0
				exit 1
			fi
		fi
	fi
fi