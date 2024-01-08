#pragma once
#define INIT_QUAD_LIST_CAPACITY 100
#include "operand.h"
// Définit un quad
typedef struct Quad {
    char op; // + - =
    char * operand1; // 1 2
    char * operand2;
    char *result;
    int idx;  // Index du quad
} Quad;

// Liste de quads
typedef struct Ql {
    Quad **data;
    int size;
    int capacity;
} Ql;

/* Crée une quad_list */
Ql *init_quad_list();

/* Crée une quad list et l'initialise avec un premier quad */
Ql *create_list(Quad *quad);

/* Crée un quad et l'ajoute dans la liste principale
* Alias : gencode
*/
Quad *gencode(
    char op, char * operand1, char * operand2, char* result);

/* Génère une liste avec un goto indéterminé */
//Ql *init_goto();

/* Ajout un quad dans une liste */
void add_quad(Ql *ql, Quad *quad);

/* On affiche la table des quad */
void print_quad_list(Ql *ql);

/* Affiche un quad */
void print_quad(Quad * quad);

/* Renvoie l'index de prochain quad */
int nextquad(Ql *quad_list);

/* Concatène deux listes de quads */
Ql * concat(Ql *ql1, Ql *ql2);

/* Complète une liste de quad avec l'index passé en paramètres */
//void complete(Ql *ql, int idx);

/* Récupère l'index du dernier quad de la liste */
int last_quad_idx(Ql *ql);

/* Supprime la quad_list */
void destroy_quad_list(Ql *ql);
