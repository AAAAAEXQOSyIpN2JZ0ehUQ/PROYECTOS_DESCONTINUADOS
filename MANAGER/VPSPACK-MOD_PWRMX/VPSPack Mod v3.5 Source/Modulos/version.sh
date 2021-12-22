eval clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
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
echo -ne "  \033[1;33mVERIFICANDO \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo ""
vrs1=$(cat /etc/VpsPackdir/version)
vrs2=$(wget -qO- https://pwr.org.mx/v/version | sed -n '1 p')
[[ ! -e /etc/VpsPackdir/version ]]
echo -e "\033[1;32m   VERIFICANDO SI HAY ACTUALIZACION\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
fun_bar 'sleep 4'
sleep 2
echo ""
if [ "$vrs1" = "$vrs2" ]; then
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
echo -e " \033[1;31m SU SCRIPT ESTA ACTUALIZADO\033[1;32m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
echo -ne "\n\033[1;31mPRESIONE ENTER PARA REGRESAR A \033[1;32mVPSPACK\033[0m"; read
vpspack
else
echo -e "\033[1;31mEXISTE UNA ACTUALIZACION DISPONIBLE!\033[1;33m"
echo -e "\033[1;33mSOLICITE SU ENLACE DE INSTALACION\033[0m"
echo -e "\033[1;33mTELEGRAM : @PowerMX\033[0m"
echo -e "\033[1;31mPRESIONE ENTER PARA REGRESAR\033[0m"
read -p " "
fi
