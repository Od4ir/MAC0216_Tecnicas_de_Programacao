#include <stdio.h>
#include "aleatorio.h"

#define NTentativas 10

double Sorteia(void) {
    return RealAleatorio(1, 6);
}

int main() {
    int i;
    for (i = 0; i < NTentativas; i++) 
        printf("%lf\n", Sorteia());
    return 0;
}
