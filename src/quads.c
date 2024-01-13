#include "quads.h"

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

void gencode_old(char op, char* operande1, char* operande2, char* result){
    
    dinguerie* op1;
    dinguerie* op2;
    dinguerie* res;
    NCHK(op1 = malloc(sizeof(dinguerie)));
    NCHK(op2 = malloc(sizeof(dinguerie)));
    NCHK(res = malloc(sizeof(dinguerie)));
    
    strcpy(op1->valeur, operande1);
    strcpy(op2->valeur, operande2);
    strcpy(res->valeur, result);
    gencode(op, op1, op2, res);

}

/* Crée un quad */
void gencode(char op, dinguerie* operande1, dinguerie* operande2, dinguerie* result) {
    Quad * quad;
    NCHK(quad = malloc(sizeof(Quad)));
    NCHK(quad->operand1 = malloc(sizeof(dinguerie)));
    NCHK(quad->operand2 = malloc(sizeof(dinguerie)));
    NCHK(quad->result = malloc(sizeof(dinguerie)));
    quad->op = op;
    quad->operand1 = operande1;
    quad->operand2 = operande2;
    quad->result = result;
    
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
    printf("| OPERATEUR\n");
    printf("%c\n",quad->op);
    printf("| OPERANDE 1\n");
    printf("%s\n",quad->operand1->valeur);
    printf("%i\n",quad->operand1->stockage);
    printf("%c\n",quad->operand1->type);
    printf("| OPERANDE 2\n");
    printf("%s\n",quad->operand2->valeur);
    printf("%i\n",quad->operand2->stockage);
    printf("%c\n",quad->operand2->type);
    printf("| RESULT\n");
    printf("%s\n",quad->result->valeur);
    printf("%i\n",quad->result->stockage);
    printf("%c\n",quad->result->type);
    printf("\n");
}

void print_list_quad_MIPS(Quad_list* quad_list){
    find_max_pile_and_create(quad_list);
    for(int i=0; i<quad_list_main->size; i++){
        print_quad_MIPS(quad_list_main->data[i]);
    }
}

int is_arithmetique_sign(char sign){
    
    if (sign == '+' || sign == '-' || sign == '*' || sign == '/') {
        return 0;
    }
    return 1;
}


void find_max_pile_and_create(Quad_list* quad_list){
    int max_long = 0;

    for(int i=0; i<quad_list_main->size; i++){
        int longueur = 0;
        while(is_arithmetique_sign(quad_list_main->data[i + longueur]->op) == 0){
            longueur++;
            if(i + longueur == quad_list_main->size){
                break;
            }
        }
        if(longueur > max_long){
            max_long = longueur;
        }
    }
    if(max_long > 0){
        printf("\t\t# On alloue de la memoire pour la pile (longueur = %i)\n", max_long);
        printf("\t\taddiu	$sp,	$sp,	-%i\n", 4*(max_long+2));
        printf("\t\tsw		$fp,	%i($sp)\n", 4*(max_long+1));
        printf("\t\tmove	$fp,	$sp\n\n");
    }
    
}



void print_quad_MIPS(Quad* quad){
    
    if(quad->op == 'p'){
        if(strcmp(quad->operand2->valeur, "cst_string") == 0){
            printf("\t\t# Afficher le texte\n");
            printf("\t\tli $v0, 4           # Code de service pour l'affichage de chaîne\n");
            printf("\t\tla $a0, %s     # Charger l'adresse de la chaîne à afficher dans $a0\n\t\tsyscall\n\n", quad->operand1->valeur);
        }
        else{
            if(quad->operand1->type == 'i'){
                printf("\t\t# Afficher d'un int\n");
                printf("\t\tlw $a0, %s   # Charger la valeur de l'entier depuis la mémoire\n", quad->operand1->valeur);
                printf("\t\tli $v0, 1             # Code de service pour afficher un entier\n");
                printf("\t\tsyscall\n\n");
            }
            if(quad->operand1->type == 'f'){
                printf("\t\t# Afficher d'un float\n");
                printf("\t\tlwc1 $f0, %s   # Charger la valeur du flottant depuis la mémoire\n", quad->operand1->valeur);
                printf("\t\tmov.s $f12, $f0\n");
                printf("\t\tli $v0, 2             # Code de service pour afficher un flottant\n");
                printf("\t\tsyscall\n\n");
            }
            
            
        }
    }
    if(quad->op == 'e'){
        printf("\t\t# Terminer le programme\n");
        printf("\t\tli $v0, 10          # Code de service pour la sortie de programme\n");
        printf("\t\tsyscall\n");
    
    }
    if(quad->op == '='){
        // On charge une valeur brut dans une variable de .data
        if(quad->operand2->stockage == 0){
            if(quad->operand1->type == 'i'){
                printf("\t\tla  $t0,    %s\n", quad->operand1->valeur);
                printf("\t\tla  $t1,    %s\n", quad->operand2->valeur);
                printf("\t\tsw  $t1,    0($t0)\n\n");
            }
            else{
                printf("\t\tla  $t0,    %s\n", quad->operand1->valeur);
                printf("\t\tlwc1  $f0,    %i($fp)\n", (quad->operand2->stockage-1)*4);
                printf("\t\ts.s  $f0,    0($t0)\n\n");
            }
        }
        if(quad->operand2->stockage > 0){
            if(quad->operand1->type == 'i'){
                printf("\t\tla  $t0,    %s\n", quad->operand1->valeur);
                printf("\t\tlwc1  $f0,  %i($fp)\n", (quad->operand2->stockage-1)*4);
                printf("\t\tcvt.w.s $f0, $f0\n");
                printf("\t\tmfc1 $t1, $f0\n");
                printf("\t\tsw  $t1,    0($t0)\n\n");
            }
            else{
                printf("\t\tla  $t0,    %s\n", quad->operand1->valeur);
                printf("\t\tlwc1  $f0,    %i($fp)\n", (quad->operand2->stockage-1)*4);
                printf("\t\ts.s  $f0,    0($t0)\n\n");
            }
        }
        
        
        printf("\t\t# On mets la valeur contenu dans %s dans %s\n\n", quad->result->valeur, quad->operand1->valeur);
    }
    if(quad->op == '+' || quad->op == '-' || quad->op == '*' || quad->op == '/'){
        if(quad->operand1->stockage == 0){
            if(quad->operand1->type == 'i'){
                printf("\t\tli	$t0,	%s\n", quad->operand1->valeur);
                printf("\t\tmtc1 $t0, $f0\n");
                printf("\t\tcvt.s.w $f0, $f0\n");
            }
            else{
                printf("\t\tli.s    $f0,	%s\n", quad->operand1->valeur);
            }
        }
        if(quad->operand1->stockage > 0){
            printf("\t\tlwc1	$f0,	%i($fp)\n", (quad->operand1->stockage-1)*4);
        }
        if(quad->operand1->stockage == -1){
            printf("\t\tlwc1	$f0,	%s\n", quad->operand1->valeur);
        }

        if(quad->operand2->stockage == 0){
            if(quad->operand2->type == 'i'){
                printf("\t\tli	$t1,	%s\n", quad->operand2->valeur);
                printf("\t\tmtc1 $t1, $f1\n");
                printf("\t\tcvt.s.w $f1, $f1\n");
            }
            else{
                printf("\t\tli.s    $f1,	%s\n", quad->operand2->valeur);
            }
        }
        if(quad->operand2->stockage > 0){
            printf("\t\tlwc1	$f1,	%i($fp)\n", (quad->operand2->stockage-1)*4);
        }
        if(quad->operand2->stockage == -1){
            printf("\t\tlwc1	$f1,	%s\n", quad->operand2->valeur);
        }
        printf("\t\t# Opération de type %c entre %s (type %c) (reg%i) et %s (type %c) (reg%i)\n", quad->op, quad->operand1->valeur,  quad->operand1->type, quad->operand1->stockage, quad->operand2->valeur, quad->operand2->type , quad->operand2->stockage);
        printf("\t\t");
        switch (quad->op) {
            case '+':
                printf("add.s");
                break;
            case '-':
                printf("sub.s");
                break;
            case '*':
                printf("mul.s");
                break;
            case '/':
                printf("div.s");
                break;
        }
        printf(" $f0,   $f0,    $f1\n");
        printf("\t\ts.s	$f0,	%i($fp)\n\n", (quad->result->stockage-1)*4);
        
        //printf("\t\tStockage de %s dans %i\n\n",  quad->result->valeur ,quad->result->stockage);
    }
}