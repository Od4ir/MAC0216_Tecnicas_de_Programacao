#include <stdio.h>
#include <stdlib.h>
#include "paridade.h"

int main (int argc, char **argv) {
    int num;
    if (argc != 2) {
        fprintf(stderr,"Uso: %s <numero>\n", argv[0]);
        fprintf(stderr,"     Imprime se o número inteiro 'num' é par ou ímpar\n");
        exit(1);
    }
    num=atoi(argv[1]);
    if (paridade(num))
        printf("%d é ímpar\n", num);
    else
        printf("%d é par\n", num);
    exit(0);
}
