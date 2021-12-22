#!/bin/bash
datenow=$(date +%s)
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%45s%-10s%-5s\n' "Removedor de contas expiradas" ""
printf '%-20s%-25s%-20s\n' "Usuário" "Data de expiração" "Estado/Ação" ; echo "" ; tput sgr0
for user in $(awk -F: '{print $1}' /etc/passwd); do
	expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
	echo $expdate|grep -q never && continue
	datanormal=$(date -d"$expdate" '+%d/%m/%Y')
	tput setaf 3 ; tput bold ; printf '%-20s%-21s%s' $user $datanormal ; tput sgr0
	expsec=$(date +%s --date="$expdate")
	diff=$(echo $datenow - $expsec|bc -l)
	tput setaf 2 ; tput bold
	echo $diff|grep -q ^\- && echo "Ativo (Não removido)" && continue
	tput setaf 1 ; tput bold
	echo "Expirado (Removido)"
	pkill -f $user
	userdel $user
	grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
done
tput sgr0 
echo ""