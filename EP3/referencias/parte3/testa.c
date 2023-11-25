#include <stdio.h>  // printf
#include <stdlib.h> // exit
#include "shannon.h"
#include "hashliza.h"

int main () {
    char frase[15]="MAC2166MAC2166";
    printf("%s\n", ep1Passo1Preenche(frase));
    printf("%ld\n", ep3CalculaEntropiaShannon(frase,2)); 
    exit(0);
}
