#pragma once
#include "symbol_table.h"

// Opérande
typedef struct Operand {
    float value_float;
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
Operand* createOperand(char*value,char*id,symbol*Symbol);