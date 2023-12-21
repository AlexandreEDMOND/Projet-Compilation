#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <stdnoreturn.h>
#include <stdarg.h>

#define TCHK(op)            \
  do                        \
  {                         \
    if ((errno = (op)) > 0) \
      raler(1, #op);        \
  } while (0)

#define CHK(op)      \
  do                 \
  {                  \
    if ((op) == -1)  \
      raler(1, #op); \
  } while (0)

#define NCHK(op)      \
  do                  \
  {                   \
    if ((op) == NULL) \
      raler(1, #op);  \
  } while (0)

noreturn void raler(int syserr, const char *msg, ...);

void afficher_bit(unsigned int n, int taille);