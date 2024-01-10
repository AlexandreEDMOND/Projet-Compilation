#pragma once
#include "quad.h"

void put_reg_to_reg(char*reg1, char *reg2);
void put_int_reg(int value, char *reg);
void gen_assign(Quad * quad);
void add(char *res, char *reg1, char *reg2);
void affichageMIPS(char *reg);
void affichage_int();
void affichage_string();
void charger_addresse();
void gen_txt();
void gen_main();
void gen_syscall();