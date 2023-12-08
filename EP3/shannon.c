#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "shannon.h"

/* É para ser uma biblioteca estática. Para compilar e gerar o .so:
 * gcc -c -fPIC -o shannon.o shannon.c
 * gcc -o libshannon.so -shared shannon.o
 */ 
long double ep3CalculaEntropiaShannon(char * stringEntrada, int base) {
    int tam = strlen(stringEntrada);
    int menor = 10000000, maior = -10000000;

    for(int i = 0; i < tam; i++) {
        //printf("%d\n", stringEntrada[i]);
        if(stringEntrada[i] > maior) {
            maior = stringEntrada[i];
        }
        if(stringEntrada[i] < menor) {
            menor = stringEntrada[i];
        }
    }

    // Se só tem um mesmo elemento, então:
    // log(probabilidade = 1) = 0, logo o valor vai ser 0;
    if(maior == menor) return 0;

    int * probabilidades;
    probabilidades = malloc(sizeof(int) * (maior - menor + 1));

    for(int i = 0; i < tam; i++) {
        probabilidades[stringEntrada[i] - menor] += 1;
        printf("%c --> %d\n", stringEntrada[i], probabilidades[stringEntrada[i] - menor]);
    }

    long double resp = 0;
    for(int i = 0; i < maior - menor + 1; i++) {
        double prob = (double) probabilidades[i] / tam;
        printf("prob: %f\n", prob);
        if(prob != 0) {
            resp += prob * log(prob) / log((double) base);
        }
        
    }

    return -1 * resp;
}
