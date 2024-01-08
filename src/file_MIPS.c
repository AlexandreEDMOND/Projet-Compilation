#include <stdio.h>
#include "symbol_table.h"
#include "file_MIPS.h"
#include <string.h>

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
    fclose(output);
}

void gen_mips(symbol_table *table) {
    FILE *file = fopen("Fichier.asm/test.asm", "w");
    gen_data(file,table);
}


