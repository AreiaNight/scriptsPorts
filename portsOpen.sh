#!/bin/bash

function ctrl_c(){

    echo -e "\n[!]Exiting\n"
    tput cnorm;
    exit 1
}

declare -a ports=$(seq 1 65535)

#Ctrl+C
trap ctrl_c SIGINT

tput civis
#Funcion para ports 
function checkPort(){
    (exec 3<> /dev/tcp/$1/$2) 2>/dev/null #Abrimos el descriptor de archivo con permisos de lectura y escritura que se comunique al dev/tcp
    if [ $? -eq 0 ];then
        echo -e "\n[!] Host $1 port $2 is open\n"
    fi
    exec 3>&-
    exec 3<&-
}

#Loop para verificar puertos abiertos
if [ $1 ]; then
    for port in ${ports[@]};do  
        checkPort $1 $port &
        
    done
else 
    echo -e "\n[!]Use: $0 <ip_Idress>\n"
fi 
