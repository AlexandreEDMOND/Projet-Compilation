#include "utils.h"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <stdnoreturn.h>
#include <stdarg.h>

noreturn void raler(int syserr, const char *msg, ...)
{
    va_list ap;

    va_start(ap, msg);
    vfprintf(stderr, msg, ap);
    fprintf(stderr, "\n");
    va_end(ap);

    if (syserr == 1)
        perror("");

    exit(EXIT_FAILURE);
}

void afficher_bit(unsigned int n, int taille)
{
    printf("{ ");
    for (int i = 0; i < taille; i++)
        if (n & (1 << i))
            printf("%d, ", i + 1);

    printf("}\n");
}