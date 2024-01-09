#pragma once
#include "quad.h"

void put_reg_to_reg(char*reg1, char *reg2);
void put_int_reg(int value, char *reg);
void gen_assign(Quad * quad);
void add(char *res, char *reg1, char *reg2);