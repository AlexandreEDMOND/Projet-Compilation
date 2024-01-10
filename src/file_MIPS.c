#include <stdio.h>
#include "symbol_table.h"
#include "file_MIPS.h"
#include "genMIPS.h"
#include "quad.h"
#include "genQuad.h"
#include "instruction_MIPS.h"
#include <string.h>
#include <stdlib.h>

FILE *output;

void gen_data(FILE *output,symbol_table *table) {
	fprintf(output, ".data\n");
    for (int i = 0; i < table->size; i++) {
        if (table->symbols[i].value !=NULL){
            if (table->symbols[i].type=='f'){
            fprintf(output, "\t%s: .float\t %s \n",
		    table->symbols[i].id, table->symbols[i].value);
        }
        
        if (table->symbols[i].type=='i'){
            fprintf(output, "\t%s: .word\t %s\n",
            table->symbols[i].id, table->symbols[i].value);
            }
        }        
    }
}
void gen_quad(Ql* quad_list,symbol_table *table){
    for (int i=0;i<quad_list->size;i++){
        if (quad_list->data[i]->op=='+'){
            afficher_op_arith(quad_list->data[i]);
        }
        if (quad_list->data[i]->op=='p'){
            afficher_print(quad_list->data[i]);
        }
    }
}
/* Génère la pile */
void gen_stack() {
	// On alloue la mémoire pour la pile
    fprintf(output, "\n\t# On alloue la mémoire pour la pile\n");
    //fprintf(output, "\taddiu\t$sp,\t$sp,\t-%d\n", symbols_table->last_pos + 4);
    //fprintf(output, "\tsw\t\t$fp,\t%d($sp)\n", symbols_table->last_pos);
    fprintf(output, "\tmove\t$fp,\t$sp\n");
}
void gen_mips(symbol_table *table,Ql* quad_list) {
    output= fopen("Fichier.asm/test.asm", "w");
    //gen_data(output,table);
    gen_txt();
    gen_main();
    gen_quad(quad_list,table);
    exitMIPS();
    gen_syscall();
    fclose(output);
}


