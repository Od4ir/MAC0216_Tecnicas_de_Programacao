#!/bin/bash

# Lista de todos os arquivos com .h no projeto:
arquivos_h=$(find . -type f -name "*.h")
echo ${arquivos_h}

# Geração da documentação usando Doxygen:
doxygen - <<EOF
INPUT = $arquivos_c
OUTPUT_DIRECTORY = doc
EOF

# Compilação do arquivo teste.c com as bibliotecas utilizadas:
gcc -Wall -c -fPIC -o shannon.o shannon.c 
gcc -shared -o libshannon.so shannon.o -lm 

gcc -Wall -c -o hashliza.o hashliza.c 
gcc -Wall -c -o teste.o teste.c 
gcc -Wall -o teste hashliza.o teste.o -L${PWD} -lshannon -lm

# Verificação se a compilação deu certo:
if [ $? -ne 0 ]; then
    echo "Xi, a compilação falhou :-("
    exit 1
else
    echo "Compilação bem-sucedida!"
    exit 0
fi
