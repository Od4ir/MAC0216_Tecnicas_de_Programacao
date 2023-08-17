#include <stdio.h>
#include <stdlib.h>

//Versão sem a questão dos multiplos de 6;

int eh_primo(int n);

int main() {

    int n;
    scanf("%d", &n);
    printf("É primo? %d\n", eh_primo(n));
    return 0;
}

int eh_primo(int n) {
    int div, p = 1;
    for(div = 2; div*div <= n; div++) {
        if(n % div == 0) {
            return 0;
        }
    }
    if(n == 1) return 0;
    else return 1;
}


