#!/bin/bash

function list {
    echo "You wanna list?"
}

FUNCAO1="list"

read op
if [ ${op} = "list" ]; then
    list
else 
    echo "Not a list"
fi