#include "hashliza.h"

/* É para ser uma biblioteca estática. Para compilar e gerar o .a:
 * gcc -Wall -c -o hashliza.o hashliza.c
 * ar -rcv libhashliza.a hashliza.o
 */ 
char * ep1Passo1Preenche(char * stringEntrada) {
    /* Verifica se é múltiplo de 16 e devolve string sim ou nao */
    if (strlen(stringEntrada)%16 != 0) {
        strcpy(stringEntrada,"naonao ");
        return stringEntrada;
    }
    else {
        strcpy(stringEntrada,"simsim ");
        return stringEntrada;
    }
}
