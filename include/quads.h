#pragma once
#include "symbol_table.h"
#include "utils.h"

#include <stdlib.h>
#include <string.h>

// Définit un quad
typedef struct Quad {
    char op; // = (pour déclaration ou affectation) ou p (pour print)
    dinguerie * operand1; 
    dinguerie * operand2;
    dinguerie * result;
    int idx;
} Quad;

// Liste de quads
typedef struct Quad_list {
    Quad **data;
    int size;
    int capacity;
} Quad_list;

typedef struct Ctrl_ql{
	Quad_list *Vrai;  // Liste des quads incomplets à exécuter si Vrai
	Quad_list *Faux;  // Liste des quads incomplets à exécuter si Faux
	Quad_list *next;  // Liste des quads incomplets à exécuter après
}Ctrl_ql;

Quad_list* init_quad_list();

Quad_list *create_list(Quad *quad);

Quad* gencode(char op, dinguerie* operande1, dinguerie* operande2, dinguerie* result);

void gencode_old(char op, char* operande1, char* operande2, char* result);

void add_quad(Quad_list *quad_list, Quad *quad);

void free_quad_list(Quad_list *quad_list);

void print_quad_list(Quad_list *quad_list);

int is_arithmetique_sign(char sign);

void find_max_pile_and_create(Quad_list* quad_list);

void print_quad(Quad * quad);

void print_list_quad_MIPS(Quad_list* quad_list,symbol_table*table);

void print_quad_MIPS(Quad*quad,symbol_table*table);

void complete(Quad_list *ql, int idx); 
int last_quad_idx(Quad_list *ql); 
int nextquad();
Quad_list *init_goto();
int print_IF_MIPS(Quad*quad,symbol_table*table);
