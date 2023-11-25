#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "hashliza.h"

#define SIZE_BLOCO 16

void printa_int(char * aux) {
    int n = strlen(aux);
    for(int i = 0; i < n; i++) {
        printf("%d ", aux[i]);
    }
}

void printa_char(char * aux) {
    int n = strlen(aux);
    for(int i = 0; i < n; i++) {
        printf("%c ", aux[i]);
    }
}

/*printa_char(saidaPassoUm);
printf("\n");
printa_int(saidaPassoUm);
printf("\n");
printf("%d\n", (int) strlen(saidaPassoUm));*/

char * ep1Passo1Preenche(char * stringEntrada) {
    if(stringEntrada == NULL) {
        return NULL;
    }
    int tam_entrada = (int) strlen(stringEntrada);
    printf("%d\n", tam_entrada);

    int new_pos = SIZE_BLOCO - (tam_entrada % SIZE_BLOCO);

    char * saidaPassoUm = malloc(sizeof(char) * (tam_entrada + new_pos));
    strcpy(saidaPassoUm, stringEntrada);
    printf("%s\n", saidaPassoUm);

    if(new_pos != SIZE_BLOCO) {
        for(int i = 0; i < new_pos; i++) {
            saidaPassoUm[tam_entrada + i] = (char) new_pos;
        }
    }
    return saidaPassoUm;
}