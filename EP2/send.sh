#!/bin/bash

read -p "Digite o nome do canal: " pipe

if [[ ! -p $pipe ]]; then
    echo "Reader not running"
    exit 1
fi

while [ 1 ]; do
    read -a msg
    if [[ "${msg[*]}" ]]; then
        if [ "${msg[*]}" == 'sair' ]; then
            break
        else 
            echo "${msg[*]}" >$pipe
        fi
    else
        echo "Hello from $$" >$pipe
    fi
done

exit 0