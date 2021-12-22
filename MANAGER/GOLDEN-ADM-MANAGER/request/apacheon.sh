#!/bin/bash
fun_trans () { 
local texto
local retorno
declare -A texto
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z $(echo ${texto[$2]}) ]]; then
ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
  while [[ -z $retorno ]]; do
    NUM="$(($RANDOM%${#ENGINES[@]}))"
    retorno="$(source trans -e ${ENGINES[$NUM]} -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
  done
 echo "texto[$2]='$retorno'"  >> /etc/texto-adm
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}
declare -A cor=( [0]="\033[33m" [1]="\033[33m" [2]="\033[33m" [3]="\033[33m" [4]="\033[1;32m" )
barra="\033[0m\e[33m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
}
IP="$(fun_ip)"
echo -e "${cor[4]} [1] >${cor[3]} $(fun_trans ${id} "Colocar Arquivo Online")"
echo -e "${cor[4]} [2] >${cor[3]} $(fun_trans ${id} "Remover Arquivo Online")"
echo -e "${cor[4]} [3] >${cor[3]} $(fun_trans ${id} "Ver Links dos Arquivos Online")"
echo -e "$barra"
while [[ ${arquivoonlineadm} != @([1-3]) ]]; do
read -p "[1-3]: " arquivoonlineadm
tput cuu1 && tput dl1
done
case ${arquivoonlineadm} in
3)
[[ -z $(ls /var/www/html) ]] && echo -e "$barra"  || {
    for my_arqs in `ls /var/www/html`; do
    [[ "$my_arqs" = "index.html" ]] && continue
    [[ "$my_arqs" = "index.php" ]] && continue
    [[ -d "$my_arqs" ]] && continue
    echo -e "\033[33m[$my_arqs] \033[33mhttp://$IP:81/$my_arqs\033[0m"
    done
    echo -e "$barra"
    }
;;
2)
i=1
[[ -z $(ls /var/www/html) ]] && echo -e "$barra"  || {
    for my_arqs in `ls /var/www/html`; do
    [[ "$my_arqs" = "index.html" ]] && continue
    [[ "$my_arqs" = "index.php" ]] && continue
    [[ -d "$my_arqs" ]] && continue
    select_arc[$i]="$my_arqs"
    echo -e "${cor[2]}[$i] > ${cor[3]}$my_arqs - \033[1;36mhttp://$IP:81/$my_arqs\033[0m"
    let i++
    done
    echo -e "$barra"
    echo -e "${cor[5]}$(fun_trans ${id} "Selecione o Arquivo a Ser Apagado")"
    echo -e "$barra"
    while [[ -z ${select_arc[$slct]} ]]; do
    read -p " [1-$i]: " slct
    tput cuu1 && tput dl1
    done
    arquivo_move="${select_arc[$slct]}"
    [[ -d /var/www/html ]] && [[ -e /var/www/html/$arquivo_move ]] && rm -rf /var/www/html/$arquivo_move > /dev/null 2>&1
    [[ -e /var/www/$arquivo_move ]] && rm -rf /var/www/$arquivo_move > /dev/null 2>&1
    echo -e "${cor[5]}$(fun_trans ${id} "Sucesso!")"
    echo -e "$barra"
    }
;;    
1)
i="1"
[[ -z $(ls $HOME) ]] && echo -e "$barra"  || {
    for my_arqs in `ls $HOME`; do
    [[ -d "$my_arqs" ]] && continue
    select_arc[$i]="$my_arqs"
    echo -e "${cor[2]} [$i] > ${cor[3]}$my_arqs"
    let i++
    done
    i=$(($i - 1))
    echo -e "${cor[5]}$(fun_trans ${id} "selecione o arquivo")"
    echo -e "$barra"
    while [[ -z ${select_arc[$slct]} ]]; do
    read -p " [1-$i]: " slct
    tput cuu1 && tput dl1
    done
    arquivo_move="${select_arc[$slct]}"
    [ ! -d /var ] && mkdir /var
    [ ! -d /var/www ] && mkdir /var/www
    [ ! -d /var/www/html ] && mkdir /var/www/html
    [ ! -e /var/www/html/index.html ] && touch /var/www/html/index.html
    [ ! -e /var/www/index.html ] && touch /var/www/index.html
    chmod -R 755 /var/www
    cp $HOME/$arquivo_move /var/www/$arquivo_move
    cp $HOME/$arquivo_move /var/www/html/$arquivo_move
    echo -e "\033[1;36m http://$IP:81/$arquivo_move\033[0m"
    echo -e "$barra"
    echo -e "${cor[5]}$(fun_trans ${id} "Sucesso!")"
    echo -e "$barra"
    }
;;
esac