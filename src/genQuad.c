#include <stdio.h>
#include "symbol_table.h"
#include "quad.h"
#include "genQuad.h"
extern Ql* quad_list;
void assignation(symbol_table *table, char *id, char type) {
    if (type=='i'){
        add_symbol(table,id,NULL, 'i');
    }
    if (type=='f'){
        add_symbol(table,id,NULL, 'f');
    }
   add_quad(quad_list,gencode('=',"empty","empty",id)); 
}

void assignation_Expression(symbol_table *table, char *id, char *data_type, char type) {
   if (type=='i'){
        add_symbol(table,id,data_type, 'i');
    }
    if (type=='f'){
        add_symbol(table,id,data_type, 'f');
    }
   //add_symbol(table,id, data_type, type);
   add_quad(quad_list,gencode('=',data_type,"empty",id)); 
}