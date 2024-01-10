#include <stdlib.h>
#include <stdio.h>
#include "operand.h"
#include "symbol_table.h"


// Fonction pour initialiser un pointeur vers Operand
Operand* createOperand(symbol_table* table, char* id) {
  Operand* op = (Operand*)malloc(sizeof(Operand));
  if (op != NULL) {
    op->Symbol = (symbol*)malloc(sizeof(symbol));
    if (op->Symbol != NULL) {
      symbol *Symbole = get_symbol(table, id);
      if (Symbole != NULL) {
        op->Symbol->type = Symbole->type;
        op->value_int = atoi(Symbole->value);  // Initialiser le champ value_int
        op->id = Symbole->id;
      } else {
        // Gérer l'erreur si le symbole n'est pas trouvé
      }
    }
  }
  return op;  // Retourne le pointeur vers le nouvel Operand
}

/* Crée operande de type variable temporaire */
void to_operand_temp(Operand *op) {
	op->Symbol = add_temp_st();
	op->type = TEMP_T;
}


/* Transforme une chaine de caractère en operande constante */
void to_operand_const(Operand *op, char *value) {
	op->Symbol = add_const_st(value);
	op->type = CONST_T;
}


void print_operator(Operand *operande){
    if (operande!=NULL){
        if (operande->Symbol->type =='i'){
            printf("value:%i",operande->value_int);
        }
        if (operande->id!=NULL){
            printf("\tid:%s",operande->id);
        }
    }

}