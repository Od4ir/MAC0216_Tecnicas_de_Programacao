#!/bin/bash

# LOOP COM 'while'
CONTADOR=0
while [ ${CONTADOR} -le 1 ]; do  
    # Sempre que trabalhar com números
    # é necessário trabalhar com palavras 
    # reservadas:
    #   MENOR QUE: -lt
    #   MAIOR QUE: -gt
    #   MENOR OU IGUAL: -le
    #   MAIOR OU IGUAL: -ge
    #   IGUAL: -eq
    #   DIFERENTE: -ne

    # ==, !=, > funcionam com strings;

    echo "O contador vale ${CONTADOR}"
    let CONTADOR=CONTADOR+1
done

# LOOP COM 'until'
CONTADOR=2
until [ ${CONTADOR} -lt 10 ]; do
    echo "${CONTADOR}"
    let CONTADOR=CONTADOR-1

done


# LOOP COM 'for'
for ARQUIVO in $(ls -1); do
    echo "Tem um arquivo chamado ${ARQUIVO} aqui"
done
exit 0
