#include <stdio.h>
#include <stdlib.h>
#define MAX 999999936

//Versão com a questão dos múltiplos de 6;
// Sem loop para y como segundo primo;

int eh_primo(int n);
void modo_0(int n);
void modo_1(int n);


int main() {
    int modo, n, i, primo = 0;
    printf("Por favor, digite o modo que deseja operar: \n");
    printf(" 0 ---> Próximo Número Primo;\n");
    printf(" 1 ---> Múltiplo de Primos;\n Modo --> ");
    scanf("%d", &modo);

    printf("\nPor favor, insira n, com 1 <= n <= 999.999.936: ");
    scanf("%d", &n);

    if(!modo) {
        modo_0(n);
    }
    else {
        modo_1(n);
    }
    return 0;
}

int eh_primo(int n) {
    int div, p = 1;
    if(((n + 1)%6 != 0)&&((n - 1) % 6 != 0)&&(n > 3)) {
        //printf("Olha só!\n");
        return 0;
    }
    for(div = 2; (div*div <= n)&&(p); div++) {
        if(n % div == 0) {
            p = 0;
        }
    }
    if(n == 1) return 0;
    else return (p == 1);
}

void modo_0(int n) {
    int primo = 0;
    int i;

    for(i = n + 1; (i < MAX)&&(!primo); i++) {
        if((((i + 1) % 6 == 0)||((i - 1) % 6 == 0))) {
            primo = eh_primo(i);
            if(primo) printf("O próximo primo superior a %d é %d\n", n, i);
        }
        if(i + 1 == MAX) {
            printf("Não foi possível calcular o próximo primo!");
        }
    }
}

void modo_1(int n) {
    int x, y;
    int p = 0;

    for(x = 2; (n/x >= 2)&&(!p); x++) {
        if((eh_primo(x))&&(n % x == 0)){
            y = n/x;
            if(eh_primo(y)) {
                printf("%d é múltiplo de %d e %d\n", x*y, x, y);
                p = 1;
            }
        }
        if(!p) {
            printf("Não deu certo!\n");
        }
    }
}

