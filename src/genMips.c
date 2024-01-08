#include <stdio.h>
#include "genMIPS.h"
#include "file_MIPS.h"
#include "quad.h"
#include "symbol_table.h"
extern FILE* output;
/* Traitement du quad OP_ASSIGN */
void gen_assign(Quad * quad) {
    
    // On met l'opérande dans t2
    //put_int_reg(quad->operand1, "t2");
    // On met t2 dans la variable
    //put_reg_var("t2", quad->result.symbol->position);
}

/* Met un entier dans un registre  */
void put_int_reg(int value, char *reg) {
    fprintf(output,"\t\tli\t$%s,\t%i\n", reg, value);
}
void add(char *res, char *reg1, char *reg2) {
    fprintf(output,"\t\tadd\t$%s,\t$%s,\t$%s\n", res, reg1, reg2);
}

