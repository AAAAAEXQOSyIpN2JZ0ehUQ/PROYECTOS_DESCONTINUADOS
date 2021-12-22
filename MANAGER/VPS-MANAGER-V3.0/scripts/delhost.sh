#!/bin/bash
payload="/etc/squid3/payload.txt"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Retire Host squid3  " ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Archivo $ Payload no encontrado " ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "dominios actuales en el archivo $payload :" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Introduzca el dominio que desea eliminar de la lista: " host
	if [[ -z $host ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Ha introducido un dominio vacío o no existente!" ; echo "" ; tput sgr0
			exit 1
		else
		if [[ `grep -c "^$host" $payload` -ne 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "El dominio $ host no se encontró en el archivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Presentar $payload actualizada, el dominio se ha eliminado con éxito:" ; tput sgr0
			tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
			if [ ! -f "/etc/init.d/squid3" ]
			then
				service squid3 reload
			else
				/etc/init.d/squid3 reload
			fi	
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Proxy squid3 se vuelve a cargar correctamente!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi