#!/bin/bash

gcc -Wall -o parouimpar paridade.c main.c

# gcc -Wall -c -o paridade.o paridade.c && gcc -Wall -c -o main.o main.c && gcc -Wall -o parouimpar paridade.o main.o

if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    exit 0
fi

