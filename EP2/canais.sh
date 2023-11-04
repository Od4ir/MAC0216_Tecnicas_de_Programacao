#!/bin/bash


read nome_canal
mkfifo "${nome_canal}"

echo "Você está no canal ${nome_canal}"

while [ 1 ]; do
    read op
    if [ ${op} == "sair" ]; then
        echo "Tchauu"
        break
    fi
    read message 
    echo "${message}" > "${op}"

    echo "Conteúdo lido do canal ${op}:"
    while read -r line; do
        echo "$line"
    done < "${op}"
done

rm -f "${nome_canal}"

exit 0