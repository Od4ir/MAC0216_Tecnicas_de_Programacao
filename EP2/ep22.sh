#!/bin/bash

function list {
    echo "You wanna list?"
}

FUNCAO1="list"

read -a op
echo ${op[1]}