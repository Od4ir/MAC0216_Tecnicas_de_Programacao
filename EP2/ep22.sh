#!/bin/bash

function list {
    echo "You wanna list?"
}

FUNCAO1="list"

read -a op
echo ${op[1]}

OPCOES="op1 op2 op3"