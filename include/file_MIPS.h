#pragma once
#include "symbol_table.h"
#include "quad.h"
extern FILE *output;
void gen_mips(symbol_table *table,Ql* quad_list);
void gen_data(FILE*output,symbol_table *table);
void exitMIPS();