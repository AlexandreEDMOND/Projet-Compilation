#include "quads.h"
#include "utils.h"

#include <stdlib.h>
#include <string.h>

#define INIT_QUAD_LIST_CAPACITY 100

extern Quad_list* quad_list_main;

Quad_list* init_quad_list(){
    Quad_list* quad_list;
    NCHK(quad_list = malloc(sizeof(Quad_list)));
    quad_list->size = 0;
    quad_list->capacity = INIT_QUAD_LIST_CAPACITY;
    NCHK(quad_list->data = calloc(quad_list->capacity, sizeof(Quad)));
    return quad_list;
}

/* Crée une quad list et l'initialise avec un premier quad */
Quad_list *create_list(Quad *quad) {
    Quad_list *quad_list = init_quad_list();
    add_quad(quad_list, quad);
    return quad_list;
}

/* Crée un quad */
void gencode(char op, char* operande1, char* operande2) {
    Quad * quad;
    NCHK(quad = malloc(sizeof(Quad)));
    NCHK(quad->operand1 = malloc(100));
    NCHK(quad->operand2 = malloc(100));
    quad->op = op;
    strcpy(quad->operand1, operande1);
    strcpy(quad->operand2, operande2);
    add_quad(quad_list_main, quad);
}

/* Ajout un quad dans une liste */
void add_quad(Quad_list *quad_list, Quad *quad) {
    if (quad_list->size == quad_list->capacity) {
        quad_list->capacity *= 2;
            quad_list->data = realloc(
                quad_list->data, quad_list->capacity * sizeof(Quad));
    }
    quad_list->data[quad_list->size] = quad;
    quad_list->size++;
}

/* Supprime la quad_list */
void free_quad_list(Quad_list *quad_list) {
    free(quad_list->data);
    free(quad_list);
}

/* On affiche la table des quad */
void print_quad_list(Quad_list *quad_list) {
    printf("\n──────────────── Liste des quadruplets ────────────────\n");
    printf("Nombre d'éléments : %d\n", quad_list->size);
    printf("Taille de la table : %d\n\n", quad_list->capacity);

    for (int i = 0; i < quad_list->size; i++) {
        printf("Case n°%d:\n", i);
        print_quad(quad_list->data[i]);
    }
}

/* Affiche un quad */
void print_quad(Quad * quad) {
    printf("| OPERATEUR\t");
    printf("%c\n",quad->op);
    printf("\n| OPERANDE 1\t");
    printf("%s\n",quad->operand1);
    printf("\n");
    printf("| OPERANDE 2\t");
    printf("%s\n",quad->operand2);
    printf("\n");
}

void print_list_quad_MIPS(Quad_list* quad_list){
    for(int i=0; i<quad_list_main->size; i++){
        print_quad_MIPS(quad_list_main->data[i]);
    }
}

void print_quad_MIPS(Quad* quad){
    if(quad->op == 'p'){
        if(strcmp(quad->operand2, "cst_string") == 0){
            printf("\t\t# Afficher le texte\n");
            printf("\t\tli $v0, 4           # Code de service pour l'affichage de chaîne\n");
            printf("\t\tla $a0, %s     # Charger l'adresse de la chaîne à afficher dans $a0\n\t\tsyscall\n\n", quad->operand1);
        }
        else{
            printf("\t\t# Afficher d'un int\n");
            printf("\t\tlw $a0, %s   # Charger la valeur de l'entier depuis la mémoire\n", quad->operand1);
            printf("\t\tli $v0, 1             # Code de service pour afficher un entier\n");
            printf("\t\tsyscall\n\n");
        }
    }
    if(quad->op == 'e'){
        printf("\t\t# Terminer le programme\n");
        printf("\t\tli $v0, 10          # Code de service pour la sortie de programme\n");
        printf("\t\tsyscall\n");
    
    }
}