#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "hashliza.h"
#include "shannon.h"
#include <sys/time.h>

double calcula_tempo(struct timeval inicio, struct timeval fim) {
    double tempo = (fim.tv_sec - inicio.tv_sec) + (fim.tv_usec - inicio.tv_usec) / 1e6;
    printf("%.3f\n", tempo);
    return tempo;
}

void testa_funcoes(char * teste, int ** tempos, int n_teste) {
    struct timeval inicio, fim;
    double tempo_atual, entropia;
    int * vetorMagico;

    // Função 0 - ep3CriaVetorMagico:
    gettimeofday(&inicio, NULL);
    vetorMagico = ep3CriaVetorMagico(1);
    gettimeofday(&fim, NULL);

    tempo_atual = calcula_tempo(inicio, fim);
    tempos[0][n_teste] = tempo_atual;


    // Função 1 - ep3CalculaEntropiaShannon:
    gettimeofday(&inicio, NULL);
    entropia = ep3CalculaEntropiaShannon(teste, 256);
    gettimeofday(&fim, NULL);

    tempo_atual = calcula_tempo(inicio, fim);
    tempos[1][n_teste] = tempo_atual;


    // Função 2 - ep1Passo1Preenche:
    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    tempo_atual = calcula_tempo(inicio, fim);
    tempos[1][n_teste] = tempo_atual;



    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    gettimeofday(&inicio, NULL);
    teste = ep1Passo1Preenche(teste);
    gettimeofday(&fim, NULL);

    return tempo_atual;
}

int main() {
    /* ------ Teste 1 - Strings nulas: ------ */

    struct timeval inicio, fim;
    double tempos[7][10];

    for(int i = 0; i < 7; i++) {
        tempos[i][0] = 1e6;
        tempos[i][1] = -1;
    }

    int i = 0;
    double tempo_atu;

    while(i < 10) {
        char * aux = NULL;

        gettimeofday(&inicio, NULL);
        aux = ep1Passo1Preenche(aux);
        gettimeofday(&fim, NULL);
        tempo_atu = calcula_tempo(inicio, fim);

        if(tempo_atu < tempos[0][0]) {
            tempos[0][0] = tempo_atu;
        }
        if(tempo_atu > tempos[0][1]) {
            tempos[0][1] = tempo_atu;
        }





    }



    /* ------ Teste 2 - */






        return 0;
    }

// https://www.delftstack.com/pt/howto/c/gettimeofday-in-c/