#pragma once
#include "symbol_table.h"
#include "quad.h"
void assignation_Expression(symbol_table *table, char* operand1,char *operand2, char type);
void assignation(symbol_table *table, char *id, char type);
void assignation_Affectation(symbol_table *table, char *id,char *data_type);
void operation_arithmetique(char*operande1,char*operande2,char operation,symbol_table *table);