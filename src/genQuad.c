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
   add_quad(quad_list,gencode('=',NULL,NULL,id)); 
}

void assignation_Expression(symbol_table *table, char *id, char *data_type, char type) {
   if (type=='i'){
        add_symbol(table,id,data_type, 'i');
    }
    if (type=='f'){
        add_symbol(table,id,data_type, 'f');
    }
    Operand *operand1= createOperand(table,id);
   add_quad(quad_list,gencode('=',operand1,NULL,id)); 
}

void assignation_Affectation(symbol_table *table, char *id,char *data_type){
    set_symbol(table,id,data_type);
    Operand *operand1= createOperand(table,id);
    add_quad(quad_list,gencode('=',operand1,NULL,id));
}

void assign_quad_print(char *valeur,symbol_table *table){
    int T=0;
    for (int i=0;i<table->size;i++){
        if (strcmp(table->symbols[i].id,valeur)==0){
            Quad*quad=gencode('p',NULL,NULL,table->symbols[i].id);
           add_quad(quad_list,quad); 
           T=1;
        }
    }
    if (T==0){
        Quad*quad=gencode('p',NULL,NULL,valeur);
        add_quad(quad_list,quad); 
    }
}

void operation_arithmetique(char*operande1,char*operande2,char operation,symbol_table *table){
    char str[50];
    char *res = malloc(sizeof(char*));
    Operand *operand1= createOperand(table,operande1);
    Operand *operand2=createOperand(table,operande2);
    Quad*quad=gencode(operation,operand1,operand2,res);
    add_quad(quad_list,quad);
}