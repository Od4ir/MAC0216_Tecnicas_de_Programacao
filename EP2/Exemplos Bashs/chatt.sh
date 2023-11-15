#!/bin/bash

read -p "Digite o nome do canal: " pipe
dest="/tmp/${pipe}"

CONTADOR=0

echo ${dest}

trap "rm -f ${dest}" EXIT

if [[ ! -p ${dest} ]]; then
    mkfifo ${dest}
fi

while true; do
    conteudo=$(cat <${dest})
    echo ${CONTADOR} ${conteudo}
    let CONTADOR=CONTADOR+1
done &

SEGUNDOPLANO=$!

while [ 1 ]; do
    echo "Terceiro Plano"
    sleep 15
done &

TERCEIROPLANO=$!

while [ 1 ]; do
    echo "Digite 'usuário mensagem' -> "
    read -a mensagem 
    user="/tmp/${mensagem[0]}"
    echo "Esse é o destinatário: " ${user}

    if [ "${mensagem[0]}" == 'quit' ]; then
        echo "Saindo"
        kill -15 ${SEGUNDOPLANO}
        kill -15 ${TERCEIROPLANO}
        exit 0
    else
        echo "${mensagem[*]}" >${user}  
    fi
done 

exit 0



