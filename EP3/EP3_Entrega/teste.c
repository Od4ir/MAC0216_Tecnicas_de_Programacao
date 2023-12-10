#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "hashliza.h"
#include "shannon.h"
#include <sys/time.h>

double tempos[7][10];

double calcula_tempo(struct timeval inicio, struct timeval fim) {
    double tempo = (fim.tv_sec - inicio.tv_sec) + (fim.tv_usec - inicio.tv_usec) / 1e6;
    return tempo;
}

double testa_funcoes(char * teste) {
    struct timeval inicio, fim;
    double tempo_atual, entropia;
    int * vetorMagico;

    // Função 0 - ep3CriaVetorMagico:
    gettimeofday(&inicio, NULL);
    vetorMagico = ep3CriaVetorMagico(1);
    gettimeofday(&fim, NULL);

    tempo_atual = calcula_tempo(inicio, fim);
    tempos[0][0] = tempo_atual;


    // Função 1 - ep3CalculaEntropiaShannon:
    gettimeofday(&inicio, NULL);
    entropia = ep3CalculaEntropiaShannon(teste, 256);
    gettimeofday(&fim, NULL);

    tempo_atual = calcula_tempo(inicio, fim);
    tempos[1][0] = tempo_atual;

    for(int i = 0; i < 10; i++) {
        // Função 2 - ep1Passo1Preenche:
        gettimeofday(&inicio, NULL);
        teste = ep1Passo1Preenche(teste);
        gettimeofday(&fim, NULL);

        tempo_atual = calcula_tempo(inicio, fim);
        tempos[2][i] = tempo_atual;
        int tamanho = strlen(teste);

        // Função 3 - ep1Passo2XOR:
        gettimeofday(&inicio, NULL);
        teste = ep1Passo2XOR(teste, vetorMagico, &tamanho);
        gettimeofday(&fim, NULL);

        tempo_atual = calcula_tempo(inicio, fim);
        tempos[3][i] = tempo_atual;

        // Função 4 - ep1Passo3Comprime:
        gettimeofday(&inicio, NULL);
        teste = ep1Passo3Comprime(teste, vetorMagico, tamanho);
        gettimeofday(&fim, NULL);

        tempo_atual = calcula_tempo(inicio, fim);
        tempos[4][i] = tempo_atual;

        // Função 5 - ep1Passo4Hash:
        gettimeofday(&inicio, NULL);
        teste = ep1Passo4Hash(teste);
        gettimeofday(&fim, NULL);

        tempo_atual = calcula_tempo(inicio, fim);
        tempos[5][i] = tempo_atual;

        // Função 6 - ep1Passo4HashEmHexa:
        gettimeofday(&inicio, NULL);
        teste = ep1Passo4HashEmHexa(teste);
        gettimeofday(&fim, NULL);

        tempo_atual = calcula_tempo(inicio, fim);
        tempos[6][i] = tempo_atual;
    }
    printf("Hexadecimal: %s\n", teste);
    return entropia;
}

char * gera_string(int tamanho, int seed) {
    char * string_nova;
    string_nova = malloc(sizeof(char) * tamanho);
    srand(seed);

    int i = 0;
    while(i < tamanho) { 
        int aux = rand() % 256;
        if(aux != 0) {
            string_nova[i] = aux;
            i++;
        }
    }
    return string_nova;
}

double tempo_func(int func) {
    double maior = -1, menor = 1e6, soma = 0;
    for(int j = 0; j < 10; j++) {
        soma += tempos[func][j];
        if(tempos[func][j] < menor) {
            menor = tempos[func][j];
        }
        if(tempos[func][j] > maior) {
            maior = tempos[func][j];
        }
    }
    printf(" > Função %d: %.6f  ; %.6f  ;  %.6f\n", func, soma/10, menor, maior);
    return soma;
}

void printa_tempos(int tamanho) {
    printf("Teste com string de tamanho: %d\n\n", tamanho);
    printf(" >>> Tempo:   (médio)      (menor)     (maior)\n");
    double soma = 0;
    for(int i = 0; i < 7; i++) {
        soma += tempo_func(i);
    }
    printf(">>> Tempo TOTAL: %.6f\n", soma);
    printf("\n");
}


int main() {
    int tamanho = 10, seed = 1, num_testes = 5, fator_aumento_tamanho = 10;

    for(int i = 0; i < num_testes; i++) {
        printf("TESTE %d:\n", i + 1);
        for(int k = 0; k < 7; k++) {
            for(int j = 0; j < 10; j++) {
                tempos[k][j] = 0;
            }
        }
        char * teste;
        teste = gera_string(tamanho, seed);
        //printa_int(teste, tamanho);
        double entropia = testa_funcoes(teste);
        printf("Entropia: %f\n", entropia);
        printa_tempos(tamanho);
        tamanho = tamanho * fator_aumento_tamanho;
    }

    printf("Legenda Funções: \n");
    printf(" Função 0: int * ep3CriaVetorMagico(int);\n");
    printf(" Função 1: char * ep1Passo1Preenche(char * );\n");
    printf(" Função 2: long double ep3CalculaEntropiaShannon(char *, int);\n");
    printf(" Função 3: char * ep1Passo2XOR(char *, int *, int *); \n");
    printf(" Função 4: char * ep1Passo3Comprime(char *, int *, int); \n");
    printf(" Função 5: char * ep1Passo4Hash(char *);\n");
    printf(" Função 6: char * ep1Passo4HashEmHexa(char *);\n\n");

    return 0;
}
