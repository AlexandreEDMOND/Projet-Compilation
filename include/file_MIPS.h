#pragma once
#include "symbol_table.h"
void gen_mips(symbol_table *table);
void gen_data(FILE*output,symbol_table *table);