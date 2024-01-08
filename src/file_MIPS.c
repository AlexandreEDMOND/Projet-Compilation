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
        symbol* symbol1=get_symbol(table,quad_list->data[i]->operand1);//check le registre
        symbol *symbol2=get_symbol(table,quad_list->data[i]->operand2);//check le registre
        //put_int_reg(atoi(symbol1->value),"t1");//check si c'est un int 
        //put_int_reg(atoi(symbol2->value),"t2");//check si c'est un int 
        add("t3","t1", "t2");//check si le registre est libre 
    }
}
}
void gen_mips(symbol_table *table,Ql* quad_list) {
    output= fopen("Fichier.asm/test.asm", "w");
    gen_data(output,table);
    gen_quad(quad_list,table);
    fclose(output);
}


