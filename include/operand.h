#pragma once
#include "symbol_table.h"

// Opérande
typedef struct Operand {
	int value_int;
	char *id;	
	symbol* Symbol;
} Operand;

// Liste d'opérandes
typedef struct Op_list {
	Operand *operand;
	int size;
	int capacity;
} Op_list;

// Fonction pour initialiser un pointeur vers Operand
Operand* createOperand(symbol_table*table,char*id);
void print_operator(Operand *operande);