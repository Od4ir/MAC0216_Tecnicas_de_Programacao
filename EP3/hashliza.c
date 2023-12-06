#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "hashliza.h"

#define SIZE_BLOCO 16
char vetorhex[] = {'0', '1', '2', '3', '4', '5', '6' ,'7' ,'8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

void printa_int(char * aux, int tamanho) {
    int n = tamanho;
    for(int i = 0; i < n; i++) {
        printf("%d ", (unsigned char) aux[i]);
    }
    printf("\n");
}

void printa_char(char * aux) {
    int n = strlen(aux);
    for(int i = 0; i < n; i++) {
        printf("%c ", aux[i]);
    }
    printf("\n");
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

    int new_pos = SIZE_BLOCO - (tam_entrada % SIZE_BLOCO);

    char * saidaPassoUm = malloc(sizeof(char) * (tam_entrada + new_pos));
    strcpy(saidaPassoUm, stringEntrada);

    if(new_pos != SIZE_BLOCO) {
        for(int i = 0; i < new_pos; i++) {
            saidaPassoUm[tam_entrada + i] = new_pos;
        }
    }
    return saidaPassoUm;
}

char * ep1Passo2XOR(char * saidaPassoUm, int * vetorMagico, int * tamanho) {
    if(saidaPassoUm == NULL) {
        return NULL;
    }

    char * novoBloco = malloc(sizeof(int) * (SIZE_BLOCO));
    int num_blocos = strlen(saidaPassoUm) / SIZE_BLOCO;
    int novoValor = 0;

    for(int i = 0; i < num_blocos; i++) {
        for(int j = 0; j < SIZE_BLOCO; j++) {
            novoValor = vetorMagico[(saidaPassoUm[i * SIZE_BLOCO + j] ^ novoValor)] ^ novoBloco[j];
            novoBloco[j] = novoValor;
        }
    }
    char * saidaPassoDois = malloc(sizeof(char) * (*tamanho + SIZE_BLOCO + 1));
    memcpy(saidaPassoDois, saidaPassoUm, *tamanho);
    printf(" >> ");
    for(int i = *tamanho; i < *tamanho + SIZE_BLOCO; i++) {
        saidaPassoDois[i] = novoBloco[*tamanho - i];
    }

    printa_int(saidaPassoDois, SIZE_BLOCO + *tamanho);
    printf("\n");

    return saidaPassoDois;    
}

char * ep1Passo3Comprime(char * saidaPassoDois, int * vetorMagico) { 
    if(saidaPassoDois == NULL) {
        return NULL;
    }
    int num_blocos = (int) (strlen(saidaPassoDois) / SIZE_BLOCO);
    char * saidaPassoTres = malloc(sizeof(char) * (SIZE_BLOCO * 3));

    for(int i = 0; i < num_blocos; i++) {
        for(int j = 0; j < SIZE_BLOCO; j++) { 
            saidaPassoTres[SIZE_BLOCO + j] = saidaPassoDois[i * SIZE_BLOCO + j];
            saidaPassoTres[2 * SIZE_BLOCO + j] = (saidaPassoTres[SIZE_BLOCO + j] ^ saidaPassoTres[j]);
        }
        int temp = 0;
        for(int j = 0; j < SIZE_BLOCO + 2; j++) {
            for(int k = 0; k < SIZE_BLOCO * 3; k++) {
                temp = saidaPassoTres[k] ^ vetorMagico[temp];
                if (temp < 0) {
                    temp = (256 + temp);
                }
                saidaPassoTres[k] = temp;
            }
            temp = (temp + j) % 256;
        }
    }
    return saidaPassoTres;
}

char * ep1Passo4Hash(char * saidaPassoTres) {
    char * hash;
    hash = (char *) malloc(sizeof(char) * SIZE_BLOCO);

    for(int i = 0; i < SIZE_BLOCO; i++) {
        hash[i] = saidaPassoTres[i];
    }
    return hash;
}

char * ep1Passo4HashEmHexa(char * saidaEmHash) {
    char * hexac;
    hexac = (char *) malloc(sizeof(char) * (SIZE_BLOCO * 2));
    for(int i = 0; i < SIZE_BLOCO * 2; i++) {
        hexac[i] = '0';
    }
    int div, resto, j = 0, hash_atual;

    for(int i = 0; i < SIZE_BLOCO; i++) {
        hash_atual = saidaEmHash[i];
        if(hash_atual < 0) {
            hash_atual = (256 + hash_atual);
        }
        //printf(" > %d\n", hash_atual);
        div = hash_atual / SIZE_BLOCO;
        resto = hash_atual % SIZE_BLOCO;
        //printf("%d e %d \n", div, resto);
        //printf("%c\n", vetorhex[i]);
        hexac[j] = vetorhex[div];
        hexac[j + 1] = vetorhex[resto];
        j = j + 2;
        //printf("%c %c\n", hexac[j - 1], hexac[j]);
    }

    printf("%s\n", hexac);

    return hexac;
}