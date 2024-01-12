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
} Quad;


// Liste de quads
typedef struct Quad_list {
    Quad **data;
    int size;
    int capacity;
} Quad_list;


Quad_list* init_quad_list();

Quad_list *create_list(Quad *quad);

void gencode(char op, dinguerie* operande1, dinguerie* operande2, dinguerie* result);

void gencode_old(char op, char* operande1, char* operande2, char* result);

void add_quad(Quad_list *quad_list, Quad *quad);

void free_quad_list(Quad_list *quad_list);

void print_quad_list(Quad_list *quad_list);

int is_arithmetique_sign(char sign);

void find_max_pile_and_create(Quad_list* quad_list);

void print_quad(Quad * quad);

void print_list_quad_MIPS(Quad_list* quad_list);

void print_quad_MIPS(Quad* quad);