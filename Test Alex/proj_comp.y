%{
void yyerror (const char *s);
int yylex();
#include <stdio.h> 
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <string.h>

#define MAX_VARIABLES 100

typedef struct {
    char name[50];
    char value[50];
    char type[50];
} Variable;

Variable variables[MAX_VARIABLES];
int variableCount = 0;

void incrementer_variable(char* name, int valeur){
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            int valeur_variable = atoi(variables[i].value);
            valeur_variable += valeur;
            sprintf(variables[i].value, "%d", valeur_variable);
            return;
        }
    }
}

void modifier_variable(char* name, int valeur){
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            sprintf(variables[i].value, "%d", valeur);
            return;
        }
    }
}

char* findVariable(char* name) {
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].value;
        }
    }
    return NULL;
}

void addVariable(char* name, char* value, char* type) {
    strcpy(variables[variableCount].name, name);
    if(value != NULL)
        strcpy(variables[variableCount].value, value);
    strcpy(variables[variableCount].type, type);
    variableCount++;
}

%}

%define parse.error verbose
%union {int num; float flottant; char id; char* string_value;} 
%start programme

%token INC_PLUS INC_MOINS PRINTF PRINT MATRIX RETURN
%token <string_value> STRING_CONSTANT
%token <num> INT_VALUE
%token <flottant> FLOAT_VALUE
%token INT FLOAT MAIN
%type <num> affectation

%%

programme   : main '{' expression return '}' 
            ;

main        : type MAIN '(' ')' {printf("\nDétection fonction main\n");}
            ;

expression  : affichage ';'
            | declaration_variable ';'
            | operation ';'
            | expression expression
            ;

affichage : PRINTF '(' STRING_CONSTANT ')'       {printf("%s", $3);}
            | PRINT '(' affectation ')'            {printf("%d\n", $3);}
            ;

return : RETURN INT_VALUE ';' {printf("Détection return\n");
                                printf("Valeur return : %i\n", $2);}
        ;

declaration_variable    : type STRING_CONSTANT {
                            addVariable($2, NULL, "int");
                            printf("Déclaration variable");
                            }
                        | type STRING_CONSTANT '=' affectation {
                            printf("Déclaration variable avec valeur\n");
                            char str[50];
                            sprintf(str, "%d", $4);
                            printf("Test affichage : %s\n", str);
                            addVariable($2, str, "int");
                            }
                        ;

affectation : INT_VALUE     {$$ = $1;}
            | FLOAT_VALUE   {$$ = $1;}
            | STRING_CONSTANT     {$$ = atoi(findVariable($1));}
            | affectation '+' affectation     {$$ = ($1+$3);}
            | affectation '-' affectation     {$$ = ($1-$3);}
            | affectation '*' affectation     {$$ = ($1*$3);}
            | affectation '/' affectation     {if($3 != 0){$$ = ($1/$3);}}
            ;


operation : STRING_CONSTANT INC_PLUS    {incrementer_variable($1, 1);
                                        printf("Incrémentation variable +\n");}
          | STRING_CONSTANT INC_MOINS   {incrementer_variable($1, -1);
                                        printf("Incrémentation variable -\n");}
          | STRING_CONSTANT '=' affectation {modifier_variable($1, $3);
                                        printf("Modif valeur variable\n");}
          ;

type        : INT       {;}
            | FLOAT     {;}

%%



int main (void) {
    yyparse();
    return 0;
}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
