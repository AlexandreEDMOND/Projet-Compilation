#include <stdlib.h>
#include <stdio.h>
//#include "operand.h"


// // Fonction pour initialiser un pointeur vers Operand
// Operand* createOperand(char*operchar*value,char*id,symbol*Symbol) {
//     Operand* op = (Operand*)malloc(sizeof(Operand));
//     if (op != NULL) { 
//         if (Symbol->type=='i'){
//             op->value_int = value_int;      // Initialiser le champ value_int
//         }
//         if (Symbol->type=='f'){
//             op->value_float = value_float;  // Initialiser le champ value_float
//         }
//         op->id=id;
//     }
//     return op;  // Retourne le pointeur vers le nouvel Operand
// }

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