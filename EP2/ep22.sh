#!/bin/bash

function list {
    echo "You wanna list?"
}

FUNCAO1="list"

read -a op
echo ${op[1]}

OPCOES="op1 op2 op3"

select opt in ${OPCOES}; do
    if [ "$opt" == "op1" ]; then
        echo "oi"
    elif [ "$opt" == "op2" ]; then
        echo "op2"
    elif [ "$opt" == "op3" ]; then
        echo "op3"
    else 
        echo "Inválido"
    fi 
done