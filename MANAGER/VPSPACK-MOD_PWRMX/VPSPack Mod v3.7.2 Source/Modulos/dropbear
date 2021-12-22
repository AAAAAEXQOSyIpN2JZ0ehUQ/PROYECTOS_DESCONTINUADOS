#!/bin/bash
#
# Dropbear & OpenSSH
# ========================
#

data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "=============================================="
echo "Usuarios Conectados en [Dropbear]";
echo "[Buscando, Espere...]";

for PID in "${data[@]}"
do
        #echo "check $PID";
        NUM1=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
        USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
        IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
        if [ $NUM1 -eq 1 ]; then
#                echo "[PID] $PID - [Usuario]: $USER";
                echo "[TOTAL Conectados - $USER]: ► $NUM1";
        fi
done
echo "---";
echo "=============================================="
echo "VPSPack - Dropbear";
echo "=============================================="
