#include <stdio.h>
#include "symbol_table.h"
#include "file_MIPS.h"
#include "genMIPS.h"
#include "quad.h"
#include "genQuad.h"
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
        //Si pas dans un registre mettre dedans 
            set_registre(table,table->symbols[1].id,"t1");
            put_int_reg(atoi(table->symbols[1].value),"t1");

            set_registre(table,table->symbols[2].id,"t2");
            put_int_reg(atoi(table->symbols[2].value),"t2");
        add("t3","t1", "t2");//check si le registre est libre 
        put_reg_to_reg("t3","v0");
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
    gen_data(output,table);
    gen_quad(quad_list,table);
    gen_exit();
    fclose(output);
}

void gen_exit(){
    fprintf(output,"\t\t\t syscall\n ");
}


