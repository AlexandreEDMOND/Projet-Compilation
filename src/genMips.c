#include <stdio.h>
#include "genMIPS.h"
#include "quad.h"
#include "symbol_table.h"

/* Traitement du quad OP_ASSIGN */
void gen_assign(Quad * quad) {
    
    // On met l'opérande dans t2
    put_int_reg(quad->operand1, "t2");
    // On met t2 dans la variable
    //put_reg_var("t2", quad->result.symbol->position);
}

/* Met un entier dans un registre  */
void put_int_reg(char* value, char *reg) {
    printf("\t\tli\t$%s,\t%s\n", reg, value);
}
