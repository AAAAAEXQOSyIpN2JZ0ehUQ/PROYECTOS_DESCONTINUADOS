#!/bin/bash
ofuscate_fun () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")
txt[$i]="#";;
"#")
txt[$i]=".";;
"1")
txt[$i]="@";;
"@")
txt[$i]="1";;
"2")
txt[$i]="?";;
"?")
txt[$i]="2";;
"3")
txt[$i]="&";;
"&")
txt[$i]="3";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

instalar_fun () {
cd /etc/adm-lite && bash cabecalho --instalar
}

elimined_fun () {
text=$(source trans -b pt:${id} "Instalando")
echo -e "${cor[2]} Update"
fun_bar 'apt-get install screen' 'apt-get install python'
echo -e "${cor[2]} Upgrade"
fun_bar 'apt-get install lsof' 'apt-get install python3-pip'
echo -e "${cor[2]} $text Lsof"
fun_bar 'apt-get install python' 'apt-get install unzip'
echo -e "${cor[2]} $text Python3"
fun_bar 'apt-get install zip' 'apt-get install apache2'
echo -e "${cor[2]} $text Unzip"
fun_bar 'apt-get install ufw' 'apt-get install nmap'
echo -e "${cor[2]} $text Screen"
fun_bar 'apt-get install figlet' 'apt-get install bc'
echo -e "${cor[2]} $text Figlet"
fun_bar 'apt-get install lynx' 'apt-get install curl'
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
}
valid_fun () {
echo -e "${cor[2]}$(source trans -b pt:${id} "Opa!, Chave Valida! Instalando...")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
[[ -d /etc/adm-lite ]] && rm -rf /etc/adm-lite
mkdir /etc/adm-lite
cd /etc/adm-lite
echo "cd /etc/adm-lite && bash ./menu" > /bin/menu && chmod +x /bin/menu
echo "cd /etc/adm-lite && bash ./menu" > /bin/adm && chmod +x /bin/adm
_contador="1"
while read arq_adm; do
cd /etc/adm-lite
wget $arq_adm -o /dev/null
_contador=$(($_contador + 1))
done < $HOME/lista
echo -e "${cor[3]}$(source trans -b pt:${id} "Agora Sera Instalado As Dependencias")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
cd /etc/adm-lite
chmod +x ./*
instalar_fun
[[ -e $HOME/lista ]] && rm $HOME/lista
echo "24377" > /etc/adm-lite/versao_script
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]}$(source trans -b pt:${id} "Perfeito Procedimento Feito com Sucesso!")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} |∆| ${cor[2]}$(source trans -b pt:${id} "Agora E So Voce Configurar Sua VPS com o Menu Instalacao")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]}$(source trans -b pt:${id} "Use os Comandos"): menu, adm"
echo -e "${cor[2]}$(source trans -b pt:${id} "e acesse o script, um bom uso!")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne " \033[0m"
}
verify_fun () {
unset serialx
unset serialy
unset serial
unset server
echo -ne "\033[1;33m$(source trans -b pt:${id} "Digite Agora Seu Serial!"): \033[1;37m"; read serial
serialx=$(echo $serial|cut -d'+' -f1)
serialy=$(echo $serial|cut -d'+' -f2)
[[ $serialx != "" ]] || return 1
server=$(echo $(ofuscate_fun "$serialx")|cut -d':' -f1)
request='encapsulate --fd 3 -si4o5 sh -c "cat<&4;echo ${txt}>&5"'
echo -e "txt=$serialy\n$request" > $HOME/tmp && chmod +x $HOME/tmp
var=$(hose ${server} 2000 --fd 3 sh -c "$HOME/tmp" 2> /dev/null)
rm $HOME/tmp
    [[ $var = "" ]] && {
    echo -e "${cor[2]}$(source trans -b pt:${id} "INVALIDA...")"
    echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠\033[0m"
    echo -ne "${cor[2]}$(source trans -b pt:${id} "Tentar Outra Key?") [S/N]: "; read other
    [[ $other = @(S|s|Y|y) ]] && return 1 || {
    echo -e "\033[0m"
    exit 1
      }
    }
echo -e "${cor[2]}Key: ${cor[3]}$serial"
sleep 5s
wget -O lista http://$(ofuscate_fun "$serialx")/${var}/lista -o /dev/null
[[ "$(cat $HOME/lista|grep $link_list/${key[1]})" != "" ]] && return 0
[[ -e $HOME/lista ]] && rm $HOME/lista
 echo -e "${cor[2]}$(source trans -b pt:${id} "INVALIDA...")"
 echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠\033[0m"
 echo -ne "${cor[2]}$(source trans -b pt:${id} "Tentar Outra Key?") [S/N]: "; read other
 [[ $other = @(S|s|Y|y) ]] && return 1 || {
 echo -e "\033[0m"
 exit 1
 }
}
error_fun () {
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;31mYour apt-get Error!"
echo -e "Reboot the System!"
echo -e "Use Command:"
echo -e "\033[1;36mdpkg --configure -a"
echo -e "\033[1;31mVerify your Source.list"
echo -e "For Update Source list use this comand"
echo -e "\033[1;36mwget https://www.dropbox.com/s/sb82ddp9fjcg1ub/apt-source.sh && chmod 777 ./* && ./apt-*"
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne "\033[0m"
exit 1
}
rm $(pwd)/$0
cor[1]="\033[1;36m"
cor[2]="\033[1;33m"
cor[3]="\033[1;31m"
cor[5]="\033[1;32m"
cor[4]="\033[0m"
cd $HOME
#INSTALACOES#
if ! apt-get install at -y > /dev/null 2>&1
then
error_fun
fi
if ! apt-get install netpipes -y > /dev/null 2>&1
then
error_fun
fi
if ! apt-get install gawk -y > /dev/null 2>&1
then
error_fun
fi
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
wget -O trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]}SELECT YOUR LANGUAGE\n${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠\n${cor[2]}[1]-PT-BR\n[2]-EN\n[3]-ES\n[4]-FR"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne " OPC: "; read lang
case $lang in
1)id="pt";;
2)id="en";;
3)id="es";;
4)id="fr";;
*)id="pt";;
esac
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]} $(source trans -b pt:${id} "Utilize o Link de Instalacao Oficial"):\n\033[1;36m (https://www.dropbox.com/s/h4j9w3y52fv2gh7/instala.sh)${cor[2]}\n $(source trans -b pt:${id} "Nao utilize outros Links!")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[5]} $(source trans -b pt:${id} "INSTALADOR ADM-SCRIPTS") ®"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} $(source trans -b pt:${id} "Iniciando Instalação...")"
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne "${cor[4]}"
while true; do
verify_fun
[[ $? = "0" ]] && break
done
valid_fun