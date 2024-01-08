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

void yyerror(const char *msg)
{
    raler(0, "\033[31mErreur de syntaxe : %s\n", msg);
}