#!/bin/bash
clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "     \033[1;33mESPERE UN MOMENTO... \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "     \033[1;33mESPERE UN MOMENTO...\033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo -e "\033[0m\e[31m======================================================\033[1;37m"
echo -e "\033[0m\e[36m                Optimizar Servidor                "
echo -e "\033[0m\e[31m======================================================\033[1;37m"
echo ""
#
echo -e "\033[1;32m               Actualizando servicios\033[0m"
echo ""
fun_bar 'apt-get update -y' 'apt-get upgrade -y'
echo ""
echo -e "\033[1;32m      Corrigiendo problemas de dependencias"
echo""
fun_bar 'apt-get -f install'
# Corregir problemas de dependencias, concluir instalacion de paquetes pendientes otros errores
echo""
echo -e "\033[1;32m            Removendo paquetes inútiles"
echo ""
fun_bar 'apt-get autoremove -y' 'apt-get autoclean -y'
# Eliminar paquetes instalados automaticamente  que no tengas utilizado para el sistema
# Eliminar paquetes antigous o duplicados
echo ""
# Eliminar archivos inútiles del cache, donde registra las cópias de actualizaciones que entan instaladas pero del gerenciador de paquetes

echo -e "\033[1;32m        Removendo paquetes con problemas"
echo ""
fun_bar 'apt-get -f remove -y' 'apt-get clean -y'
#Remover paquetes con problemas
#Limpar  cache de la memoria RAM
clear
echo -e "\033[0m\e[31m======================================================\033[1;37m"
echo ""
MEM1=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})

echo -e "\033[1;31m•\033[1;32mMemoria RAM\033[1;31m•\033[0m                    \033[1;31m•\033[1;32mSwap\033[1;31m•\033[0m"
echo -e " \033[1;33mTotal: \033[1;37m$ram1                   \033[1;33mTotal: \033[1;37m$swap1"
echo -e " \033[1;33mEn Uso: \033[1;37m$ram3                  \033[1;33mEn Uso: \033[1;37m$swap3"
echo -e " \033[1;33mLibre: \033[1;37m$ram2                   \033[1;33mLibre: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37mMemória \033[1;32mRAM \033[1;37mAntes de Otimizacion:\033[1;36m" $MEM1% 
echo ""
echo -e "\033[0m\e[31m======================================================\033[1;37m"
sleep 3
echo ""
fun_limpram () {
sync 
echo 3 > /proc/sys/vm/drop_caches
sleep 4
sync && sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=0
swapoff -a
swapon -a
sleep 4
}
function aguarde {
sleep 1
helice ()
{
	fun_limpram > /dev/null 2>&1 & 
	tput civis
	while [ -d /proc/$! ]
	do
		for i in / - \\ \|
		do
			sleep .1
			echo -ne "\e[1D$i"
		done
	done
	tput cnorm
}
echo -ne "\033[1;37mLIMPANDO MEMORIA \033[1;32mRAM \033[1;37me \033[1;32mSWAP\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
helice
echo -e "\e[1DOk"
}
aguarde
sleep 1.5s
clear
echo -e "\033[0m\e[31m======================================================\033[1;37m"
echo ""
MEM2=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})

echo -e "\033[1;31m•\033[1;32mMemoria RAM\033[1;31m•\033[0m                    \033[1;31m•\033[1;32mSwap\033[1;31m•\033[0m"
echo -e " \033[1;33mTotal: \033[1;37m$ram1                   \033[1;33mTotal: \033[1;37m$swap1"
echo -e " \033[1;33mEn Uso: \033[1;37m$ram3                  \033[1;33mEn Uso: \033[1;37m$swap3"
echo -e " \033[1;33mLibre: \033[1;37m$ram2                   \033[1;33mLibre: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37mMemória \033[1;32mRAM \033[1;37mahora en la Otimizacion:\033[1;36m" $MEM2% 
echo ""
echo -e "\033[1;37mEconomia de :\033[1;31m `expr $MEM1 - $MEM2`%\033[0m"

echo -e "\033[0m\e[31m======================================================\033[1;37m"
