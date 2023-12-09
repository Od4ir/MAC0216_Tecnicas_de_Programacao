#include "shannon.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

long double ep3CalculaEntropiaShannon(char * stringEntrada, int base) {
    int tam = strlen(stringEntrada);
    int menor = 10000000, maior = -10000000;
    for(int i = 0; i < tam; i++) {
        int atual = stringEntrada[i];
        if(atual < 0) {
            atual = 256 + atual;
        }
        if(atual > maior) {
            maior = atual;
        }
        if(atual < menor) {
            menor = atual;
        }
    }
    // Se só tem um mesmo elemento, então:
    // log(probabilidade = 1) = 0, logo o valor vai ser 0;
    if(maior == menor) return 0;

    int * probabilidades;
    probabilidades = malloc(sizeof(int) * (maior - menor + 1));

    for(int i = 0; i < tam; i++) {
        probabilidades[stringEntrada[i] - menor] += 1;
    }

    long double resp = 0;
    for(int i = 0; i < maior - menor + 1; i++) {
        double prob = (double) probabilidades[i] / tam;
        if(prob != 0) {
            resp += prob * log(prob) / log((double) base);
        }
        
    }
    return -1 * resp;
}
