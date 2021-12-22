#!/bin/bash
SERVICE="badvpn-udpgw"
if pgrep -x "$SERVICE" >/dev/null
then
    echo "$SERVICE is running"
    notify -t "Service BadVPN is running" 1> /dev/null 2> /dev/null
else
    echo "$SERVICE stopped"
    screen -dmS badux badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
    notify -t "Service BadVPN Stopped - Reloading" 1> /dev/null 2> /dev/null
fi
