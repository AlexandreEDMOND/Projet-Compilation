#pragma once
#include "quads.h"
#include "symbol_table.h"

void gencode_if(
	Ctrl_ql * test_block,  // Contient les quads du test
	int first_true,
	Quad_list * list_false,  // Goto vers le premier quad si faux
	Quad_list * else_part,int compteur_global  // Index du premier quad vrai 
 );

Ctrl_ql * gencode_test(
	char operator, dinguerie * op1, dinguerie * op2);
    
Quad_list* concat(Quad_list *ql1, Quad_list *ql2);
void gencode_or(
	Ctrl_ql * test_expr, Ctrl_ql * test_expr2, int first_true, Ctrl_ql * res) ;
    void gencode_and(
	Ctrl_ql * test_expr, Ctrl_ql * test_expr2, int first_true, Ctrl_ql * res);
    void gencode_not(Ctrl_ql * test_expr, Ctrl_ql * res);

	void gencode_decla_tab(char * name, char * size);