#!/bin/bash

gcc -Wall -c -o hashliza.o hashliza.c && gcc -Wall -c -o main.o main.c &&  gcc -c -fPIC -o shannon.o shannon.c && gcc -o libshannon.so -shared shannon.o -lm && gcc -Wall -o teste hashliza.o shannon.o main.o -lm

gcc -c fPIC -o shannon.o shannon.c -lcurl &&
gcc -o libshannon.so -shared shannon.o -lcurl &&
gcc -o shannon shannon.c -L${PWD} -lshannon

if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    exit 0
fi