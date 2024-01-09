#include <stdlib.h>
#include <stdio.h>
#include "operand.h"
#include "symbol_table.h"


// Fonction pour initialiser un pointeur vers Operand
Operand* createOperand(symbol_table*table,char*id) {
    Operand* op = (Operand*)malloc(sizeof(Operand));
    symbol *Symbole=get_symbol(table,id);
    if (op != NULL) {
        op->Symbol->type=Symbole->type;
        op->value_int = atoi(Symbole->value);      // Initialiser le champ value_int
        op->id=Symbole->id;
     }
    return op;  // Retourne le pointeur vers le nouvel Operand
 }

// void print_operator(Operand *operande){
//     if (operande->Symbol->type !='i'){
//         printf("%i\n",operande->value_int);
//     }
//     if (operande->Symbol->type !='f'){
//         printf("%i\n",operande->value_float);
//     }
//     if (operande->id !=NULL){
//         printf("%i\n",operande->id);
//     }

// }