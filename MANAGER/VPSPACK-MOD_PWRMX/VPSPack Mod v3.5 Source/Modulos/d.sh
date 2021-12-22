#!/bin/bash 
RED='\033[0;31m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
GREEN='\e[32m'
NC='\033[0m'
csrf=$(curl -s https://dnsdumpster.com | grep -Po "csrfmiddlewaretoken' value='\K[^']*")
sub=$(curl -s --cookie "csrftoken=$csrf" -H "Referer: https://dnsdumpster.com" --data  "csrfmiddlewaretoken=$csrf&targetip=$1" https://dnsdumpster.com | grep -Po '<td class="col-md-4">\K[^<]*')
printf "${RED}`figlet -f small "Host / DNS"`${NC}\n";
printf "${GREEN}DNS/Host ${NC}\n";
printf "${GREEN}VPSPack ${NC}\n\n";
if [[ -z "$sub" ]]; then
printf "${RED}[!] No se encontro registro !! :( ${NC}\n";
else
echo $sub | tr " " "\n" >> sub-$1.txt
printf "${GREEN}[*] Encontrado : `cat sub-$1.txt | wc -l` Subdominios ${NC}\n\n";
printf "${ORANGE}`cat sub-$1.txt` ${NC}\n";
printf "${GREEN}Guardado en /root/sub-$1.txt !! ${NC}\n";
cp sub-$1.txt /root/sub-$1.txt
fi
