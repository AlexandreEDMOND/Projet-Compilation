#include "quads.h"
#include "gencode.h"
#include "symbol_table.h"

void gencode_if(
		Ctrl_ql *test_block, // Contient les quads du test
		int first_true,
		Quad_list *list_false, // Goto vers le premier quad si faux
		Quad_list *else_part	 // Index du premier quad vrai
)
{ // Quads de l'instruction else
	list_false = concat(else_part, list_false);
	complete(list_false, nextquad());
	complete(test_block->Faux, last_quad_idx(list_false) + 1);
	complete(test_block->Vrai, first_true);
}

Quad_list *gencode_while(
		Ctrl_ql *test_block, // Contient les quads du test
		int first_cond,			 // index du premier quad de la condition
		int first_true)
{ // Index du premier quad vrai
	dinguerie *while_dinguerie;
	NCHK(while_dinguerie = malloc(sizeof(dinguerie)));
	while_dinguerie->type = 'i';
	while_dinguerie->stockage = 1; // 1 parce que while pardi

	gencode('T', while_dinguerie, empty(), empty());
	complete(test_block->Faux, nextquad());
	complete(test_block->Vrai, first_true);
	return test_block->Faux;
}

Ctrl_ql *gencode_test(
		char operator, dinguerie * op1, dinguerie *op2)
{
	// On génère le quad, la destination (result) sera déterminée plus tard
	Ctrl_ql *res;
	NCHK(res = malloc(sizeof(res)));
	Quad *t;
	op1->stockage = 0;
	if (op2 == NULL)
		t = gencode(operator, op1, empty(), emptyTest());
	else
		t = gencode(operator, op1, op2, emptyTest());
	res->Vrai = create_list(t);
	// On génère le quad faux, la destination sera déterminée plus tard
	dinguerie *if_dinguerie;
	NCHK(if_dinguerie = malloc(sizeof(dinguerie)));
	if_dinguerie->type = 'i';
	if_dinguerie->stockage = 0; // 0 c'est if (citation de barack obama)
	Quad *f = gencode('g', if_dinguerie, empty(), emptyTest());
	res->Faux = create_list(f);
	return res;
}

Ctrl_ql *gencode_test_while(
		char operator, dinguerie * op1, dinguerie *op2)
{
	// On génère le quad, la destination (result) sera déterminée plus tard
	Ctrl_ql *res;
	NCHK(res = malloc(sizeof(res)));
	Quad *t;
	op1->stockage = 1;
	if (op2 == NULL)
		t = gencode(operator, op1, empty(), emptyTest());
	else
		t = gencode(operator, op1, op2, emptyTest());
	res->Vrai = create_list(t);
	// On génère le quad faux, la destination sera déterminée plus tard
	dinguerie *if_dinguerie;
	NCHK(if_dinguerie = malloc(sizeof(dinguerie)));
	if_dinguerie->type = 'i';
	if_dinguerie->stockage = 0; // 0 c'est if (citation de barack obama)
	Quad *f = gencode('g', if_dinguerie, empty(), emptyTest());
	res->Faux = create_list(f);
	return res;
}

Quad_list *concat(Quad_list *ql1, Quad_list *ql2)
{
	Quad_list *ql = ql1;
	for (int i = 0; i < ql2->size; i++)
	{
		add_quad(ql, ql2->data[i]);
	}
	return ql;
}

void gencode_or(
		Ctrl_ql *test_expr, Ctrl_ql *test_expr2, int first_true, Ctrl_ql *res)
{
	complete(test_expr->Faux, first_true);
	res->Faux = test_expr2->Faux;
	res->Vrai = concat(test_expr->Vrai, test_expr2->Vrai);
}
void gencode_and(
		Ctrl_ql *test_expr, Ctrl_ql *test_expr2, int first_true, Ctrl_ql *res)
{
	complete(test_expr->Vrai, first_true);
	res->Faux = concat(test_expr->Faux, test_expr2->Faux);
	res->Vrai = test_expr2->Vrai;
}

/* Génère le code relatif à une opération NOT */
void gencode_not(Ctrl_ql *test_expr, Ctrl_ql *res)
{
	res->Faux = test_expr->Vrai;
	res->Vrai = test_expr->Faux;
}
