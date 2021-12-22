#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
barra="\033[0m\e[34m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans http://git.io/trans &> /dev/null
fun_trans () {
declare -A texto
[[ ! -e /etc/texto-dados ]] && touch /etc/texto-dados
source /etc/texto-dados
if [[ -z $(echo ${texto[$2]}) ]]; then
 retorno="$(source trans -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 if [[ $retorno = "" ]];then
 retorno="$(source trans -e bing -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 fi
 if [[ $retorno = "" ]];then 
 retorno="$(source trans -e yandex -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig')"
 fi
 echo "texto[$2]='$retorno'"  >> /etc/texto-dados
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}
net_meter () {
net_dir="/etc/usr_cnx"
usr_text="$(fun_trans ${id} "USUÁRIOS")"
datos_text="$(fun_trans ${id} "USO APROXIMADO")"
porcen_text="$(fun_trans ${id} "CONSUMO TOTAL")"
net_cent="/tmp/porcentagem"
sed -i '/^$/d' $net_dir
 [[ ! -e "$net_cent" ]] && touch $net_cent
 while read cent; do
  echo "$cent" | awk '{print $2}' >> $net_cent
 done < $net_dir
 por_cent=$(paste -sd+ $net_cent | bc)
 rm $net_cent
bb=$(printf '%-18s' "$datos_text")
aa=$(printf '%-19s' "$usr_text")
cc=$(printf '%-18s' "$porcen_text")
echo -e "\033[1;32m $(fun_trans ${id} "MONITOR DE CONSUMO") [NEW-ADM]"
echo -e "$barra"
echo -e "\033[1;33m $aa $bb $cc "
echo -e "$barra"
while read u; do
b=$(printf '%-18s' "$(($(echo $u | awk '{print $2}')/970)) - MB")
a=$(printf '%-19s' "$(echo $u | awk '{print $1}')")
[[ "$por_cent" = "0" || "$por_cent" = "" ]] && por_cent="1"
pip=$(echo $u | awk '{print $2}')
[[ "$pip" = "" || "$pip" = "0" ]] && pip="1"
percent_user=$(($pip*100/$por_cent)) > /dev/null 2>&1
[[ $percent_user = "0" ]] && percent_user="1"
c=$(printf '%-18s' "$percent_user %%")
if [ "$(($(echo $u | awk '{print $2}')/970))" -gt "1" ]; then
echo -e "\033[1;32m $a \033[1;31m$b \033[1;32m$c"
fi
done < $net_dir
[[ "$(cat $net_dir)" = "" ]] && echo -e "\033[1;31m $(fun_trans ${id} "Não há informação de consumo")!"
echo -e "$barra"
unset net_dir
}
fun_net () {
(
log_1="/tmp/tcpdump"
log_2="/tmp/tcpdumpLOG"
usr_dir="/etc/usr_cnx"
[[ -e "$log_1" ]] &&  mv -f $log_1 $log_2
[[ ! -e $usr_dir ]] && touch $usr_dir
#ENCERRA TCP
for pd in `ps x | grep tcpdump | grep -v grep | awk '{print $1}'`; do
kill -9 $pd > /dev/null 2>&1
done
#INICIA TCP
tcpdump -s 50 -n 1> /tmp/tcpdump 2> /dev/null &
[[ ! -e /tmp/tcpdump ]] && touch /tmp/tcpdump
#ANALIZA USER
for user in `awk -F : '$3 > 900 { print $1 }' /etc/passwd | grep -v "nobody" |grep -vi polkitd |grep -vi system-`; do
touch /tmp/$user
ip_openssh $user > /dev/null 2>&1
ip_drop $user > /dev/null 2>&1
sed -i '/^$/d' /tmp/$user
pacotes=$(paste -sd+ /tmp/$user | bc)
rm /tmp/$user
if [ "$pacotes" != "" ]; then
  if [ "$(cat $usr_dir | grep "$user")" != "" ]; then
  pacotesuser=$(cat $usr_dir | grep "$user" | awk '{print $2}')
  [[ $pacotesuser = "" ]] && pacotesuser=0
  [[ $pacotesuser != +([0-9]) ]] && pacotesuser=0
  ussrvar=$(cat $usr_dir | grep -v "$user")
  echo "$ussrvar" > $usr_dir
  pacotes=$(($pacotes+$pacotesuser))
  echo -e "$user $pacotes" >> $usr_dir
  else
  echo -e "$user $pacotes" >> $usr_dir
  fi
fi
unset pacotes
done
) &
}

ip_openssh () {
user="$1"
for ip in `lsof -u $user -P -n | grep "ESTABLISHED" | awk -F "->" '{print $2}' |awk -F ":" '{print $1}' | grep -v "127.0.0.1"`; do
 packet=$(cat $log_2 | grep "$ip" | wc -l)
 echo "$packet" >> /tmp/$user
 unset packet
done
}

ip_drop () {
user="$1"
loguser='Password auth succeeded'
touch /tmp/drop
for ip in `cat /var/log/auth.log | tail -100 | grep "$user" | grep "$loguser" | awk -F "from" '{print $2}' | awk -F ":" '{print $1}'`; do
 if [ "$(cat /tmp/drop | grep "$ip")" = "" ]; then
 packet=$(cat $log_2 | grep "$ip" | wc -l)
 echo "$packet" >> /tmp/$user
 echo "$ip" >> /tmp/drop
 fi
done
rm /tmp/drop
}
fun_net > /dev/null 2>&1 && net_meter