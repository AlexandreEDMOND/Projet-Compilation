#include "quads.h"
#include "gencode.h"
#include "symbol_table.h"
#include "const.h"

extern Quad_list *quad_list_main;

void gencode_if(
		Ctrl_ql *test_block, // Contient les quads du test
		int first_true,
		Quad_list *list_false,										// Goto vers le premier quad si faux
		Quad_list *else_part, int compteur_global // Index du premier quad vrai
)
{ // Quads de l'instruction else
	list_false = concat(else_part, list_false);
	complete(list_false, nextquad());
	complete(test_block->Faux, last_quad_idx(list_false) + 1);
	complete(test_block->Vrai, first_true);
	for (int i = 0; i < test_block->Vrai->size; i++)
	{
		test_block->Vrai->data[i]->idxIF = compteur_global;
		test_block->Faux->data[i]->idxIF = compteur_global;
		test_block->Vrai->data[i]->type = 0;
		test_block->Faux->data[i]->type = 0;
	}
}

Quad_list *gencode_while(
		Ctrl_ql *test_block, // Contient les quads du test
		int first_cond,			 // index du premier quad de la condition
		int first_true,
		int compteur_global)
{ // Index du premier quad vrai
	gencode('j', empty(), empty(), integer(first_cond), 1);
	quad_list_main->data[last_quad_idx(quad_list_main)]->idxIF = compteur_global;
	complete(test_block->Faux, nextquad());
	complete(test_block->Vrai, first_true);
	for (int i = 0; i < test_block->Vrai->size; i++)
	{
		test_block->Vrai->data[i]->idxIF = compteur_global;
		test_block->Faux->data[i]->idxIF = compteur_global;
		test_block->Vrai->data[i]->type = 1;
		test_block->Faux->data[i]->type = 1;
	}
	return test_block->Faux;
}

Ctrl_ql *gencode_test(
		char operator, dinguerie * op1, dinguerie *op2, int compteur_global, int type)
{
	// On génère le quad, la destination (result) sera déterminée plus tard
	Ctrl_ql *res;
	NCHK(res = malloc(sizeof(res)));
	Quad *t;
	if (op2 == NULL)
		t = gencode(operator, op1, empty(), emptyTest(), type);
	else
		t = gencode(operator, op1, op2, emptyTest(), type);
	res->Vrai = create_list(t);
	// On génère le quad faux, la destination sera déterminée plus tard
	Quad *f = gencode('g', empty(), empty(), emptyTest(), type);
	f->type = type;
	t->type = type;
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
