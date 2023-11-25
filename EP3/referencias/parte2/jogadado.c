#include <stdio.h>
#include <stdlib.h>

#define NTentativas 10

int main() {
    int i, r;
    for (i = 0; i < NTentativas; i++) {
        r = rand();
        if (r < RAND_MAX / 6)
            printf ("1\n");
        else if (r < RAND_MAX / 6 * 2)
            printf ("2\n");
        else if (r < RAND_MAX / 6 * 3)
            printf ("3\n");
        else if (r < RAND_MAX / 6 * 4)
            printf ("4\n");
        else if (r < RAND_MAX / 6 * 5)
            printf ("5\n");
        else
            printf ("6\n");
    }
    return 0;
}

