#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "hashliza.h"
#include "shannon.h"
int vetorMagico[] = {122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,
114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,
245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,
195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,
64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,
220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,
139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,
214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,
199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,
71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,
187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,
140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,
186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,
212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,
202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,
68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,
180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70};

int main() {
    /*int seed;
    scanf("%d", &seed);
    char * vetor;

    vetor = ep3CriaVetorMagico(seed);
    printf("%d\n", vetor[0]); */


    char nome[100005];
    // Leitura da entrada: 
    printf("Digite uma string: \n");
    fgets(nome, 100005, stdin);

    /* 
    double f = ep3CalculaEntropiaShannon(nome, 256);
    printf("%f\n", f);
    // Verificação da função de validar vetorMagico:
    */

    // Remoção do '\n' que é lido junto da entrada: 
    int tam = (int) strlen(nome);
    nome[(int)strlen(nome) - 1] = 0;
    tam = strlen(nome); 
    printf("Tamanho: %d\n", tam);

    // Aplicação do PASSO 1:
    char * saida;
    saida = ep1Passo1Preenche(nome);
    tam = (int) strlen(saida);
    //printa_int(saida, tam);

    // Aplicação do PASSO 2:
    saida = ep1Passo2XOR(saida, vetorMagico, &tam);
    //printf("P2: ");
    //printa_int(saida, tam);

    // Aplicação do PASSO 3:
    saida = ep1Passo3Comprime(saida, vetorMagico, tam);
    //printf("P3: ");
    //printa_int(saida, 49);

    saida = ep1Passo4Hash(saida);
    //printa_int(saida);

    saida = ep1Passo4HashEmHexa(saida);
    printf("%s\n", saida);

    return 0;
}