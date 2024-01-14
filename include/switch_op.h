#pragma once
#include "quads.h"
#include "symbol_table.h"

void gen_MIPS_EQ(Quad*quad,symbol_table*table);
void gen_MIPS_SUP(Quad*quad,symbol_table*table);
void gen_MIPS_MIN(Quad*quad,symbol_table*table);
void gen_MIPS_INFEGAL(Quad*quad,symbol_table*table);
void gen_MIPS_SUPEGAL(Quad*quad,symbol_table*table);
void gen_MIPS_NEQ(Quad*quad,symbol_table*table);