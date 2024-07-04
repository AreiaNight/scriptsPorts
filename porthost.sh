#!/bin/bash

#Ctr+c
trap ctrl_c SIGINT

function ctrl_c(){

    echo -e "\n[!]Exiting"
    tput cnorm;
    exit 1
}

tput civis
for i in $(seq 1 254); do
    for port in 21 22 23 25 80 139 443 445 8080;do
        #timeout bash -c "ping -c 1 192.168.184.$i" &>/dev/null && echo "[+] HOST 192.168.184.$i  ACTIVE" &
        timeout bash -c "echo '' /dev/tcp/192.168.184.$i/$port" 2>/dev/null && echo "[+] HOST 192.168.184.$i  ACTIVE | PORT $port OPEN" &
    done
done
tput cnorm;
wait
