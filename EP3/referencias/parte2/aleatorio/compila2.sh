#!/bin/bash

function verifica {
    if [ $? -ne 0 ]; then
        echo "Xi, a compilação falhou :-("
        exit 1
    fi
}

gcc -Wall -c -o aleatorio.o aleatorio.c
verifica
gcc -Wall -c -o testarand2.o testarand2.c
verifica
gcc -Wall -o testarand2 aleatorio.o testarand2.o
verifica

exit 0
