#!/bin/bash

gcc -Wall -c -o hashliza.o hashliza.c && gcc -Wall -c -o teste.o teste.c &&  gcc -c -fPIC -o shannon.o shannon.c && gcc -o libshannon.so -shared shannon.o -lm && gcc -Wall -o panda hashliza.o shannon.o teste.o -lm

if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    exit 0
fi