#include <stdio.h>
#include <stdlib.h>

#define NTentativas 10 // Usado para criar macros em C (substituídas antes da compilação)

int main() {
   int i;

   printf("Neste computador, RAND_MAX = %d.\n", RAND_MAX);
   printf("Eis os resultados de %d chamadas a rand:\n", NTentativas);
   for (i = 0; i < NTentativas; i++)
       printf("%10d\n", rand());
   return 0;
}
