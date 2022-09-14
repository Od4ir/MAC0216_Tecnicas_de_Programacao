#include <stdio.h>
#define MAX 999999936

int eh_primo(int n);
void modo_0(int n);
void modo_1(int n);


int main() {
    int modo, n, i, primo = 0;
    scanf("%d", &modo);
    scanf("%d", &n);

    if(!modo) {
        for(i = n + 1; (i < MAX)&&(!primo); i++) {
                primo = eh_primo(i);
                if(primo) printf("%d\n",i);
            }
        }
    }
    else {
        int x, y;
        int p = 0;

        for(x = 2; (n/x >= 2)&&(!p); x++) {
            if((eh_primo(x))&&(n % x == 0)){
                y = n/x;
                if(eh_primo(y)) {
                    printf("%d %d\n", x, y);
                    p = 1;
                }
            }
        }
    }
    return 0;
}

int eh_primo(int n) {
    int div, p = 1;

    if (n == 1) return 0;
    else {   
        for(div = 2; (div*div <= n)&&(p); div++) {
            if(n % div == 0) {
                p = 0;
            }
        } 
        return (p == 1);
    }
}
