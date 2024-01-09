#include <stdio.h>
#include "symbol_table.h"
#include "quad.h"
#include "genQuad.h"
#include <stdlib.h>
#include <string.h>
#include "operand.h"
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
   add_quad(quad_list,gencode('=',data_type,"empty",id)); 
}

void assignation_Affectation(symbol_table *table, char *id,char *data_type){
    set_symbol(table,id,data_type);
    add_quad(quad_list,gencode('=',data_type,"empty",id));
}

void operation_arithmetique(char*operande1,char*operande2,char operation){
    char str[50];
    char *res = malloc(sizeof(char*));
    //Operand *operande1= createOperand(symbol_table*table,char*id);
    Quad*quad=gencode(operation,operande1,operande2,res);
    add_quad(quad_list,quad);
}