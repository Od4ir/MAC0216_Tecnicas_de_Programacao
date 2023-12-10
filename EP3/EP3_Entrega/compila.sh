#!/bin/bash

# Lista de todos os arquivos C no projeto
arquivos_c=$(find . -type f -name "*.h")
echo ${arquivos_c}

# Compilação do código shannon.c para gerar o arquivo objeto shannon.o
gcc -Wall -c -fPIC -o shannon.o shannon.c 

# Geração da documentação usando Doxygen
doxygen - <<EOF
INPUT = $arquivos_c
OUTPUT_DIRECTORY = doc
EOF

# Criação da biblioteca dinâmica libshannon.so
gcc -shared -o libshannon.so shannon.o -lm 

# Compilação do código hashliza.c e teste.c, vinculando com libshannon.so
gcc -Wall -c -o hashliza.o hashliza.c 
gcc -Wall -c -o teste.o teste.c 

# Compilação do teste e vinculação com a biblioteca e a biblioteca de matemática
gcc -Wall -o teste hashliza.o teste.o -L${PWD} -lshannon -lm

# Verifica se a compilação foi bem-sucedida
if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    echo "Compilação bem-sucedida!"
    exit 0
fi
