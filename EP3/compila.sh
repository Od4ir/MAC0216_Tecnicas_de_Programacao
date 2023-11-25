#!/bin/bash

gcc -Wall -c -o hashliza.o hashliza.c && gcc -Wall -c -o main.o main.c && gcc -Wall -o teste hashliza.o main.o 

if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    exit 0
fi