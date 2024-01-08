#pragma once
#include "symbol_table.h"

// Opérande
typedef struct Operand {
	//Type_operand type;
	Symbol *symbol;	 // Symbole associé à l'opérande (si id ou une constante)
    float value_float;
	int value_int;	
} Operand;

// Liste d'opérandes
typedef struct Op_list {
	Operand *operand;
	int size;
	int capacity;
} Op_list;
