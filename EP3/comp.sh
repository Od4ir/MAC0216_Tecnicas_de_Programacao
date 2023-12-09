#!/bin/bash

export LD_LIBRARY_PATH=/home/od4ir/Documentos/Estudos/MAC-0216/EP3:$LD_LIBRATY_PATH

gcc -Wall -c -fPIC -o shannon.o shannon.c 

gcc -shared -o libshannon.so shannon.o -lm 

gcc -Wall -c -o hashliza.o hashliza.c 
gcc -Wall -c -o teste.o teste.c 
gcc -Wall -o teste hashliza.o teste.o -L${PWD} -lshannon -lm

if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    exit 0
fi