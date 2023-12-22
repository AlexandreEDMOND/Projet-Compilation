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
    union {
        int intValue;
        float floatValue;
    } value;
    char type;
} InfoVariable;

typedef struct {
    char name[50];
    InfoVariable info_variable;
} Variable;


Variable variables[MAX_VARIABLES];
int variableCount = 0;


void modifier_variable(char* name, InfoVariable new_info_variable){
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            variables[i].info_variable = new_info_variable;
            return;
        }
    }
}

InfoVariable findVariable(char* name) {
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].info_variable;
        }
    }
}

void addVariable(char* name, char* value, char type) {
    strcpy(variables[variableCount].name, name);
    variables[variableCount].info_variable.type = type;
    if(value != NULL){    
        if(type == 'i'){
            variables[variableCount].info_variable.value.intValue = atoi(value);
        }
        else if(type == 'f'){
            variables[variableCount].info_variable.value.floatValue = atof(value);
        }
    }
    variableCount++;
}

%}

%define parse.error verbose
%union {
    InfoVariable t_info;
    int num; 
    float flottant; 
    char id; 
    char* string_value;
} 
%start programme

%token INC_PLUS INC_MOINS PRINTF PRINT MATRIX RETURN
%token <string_value> STRING_CONSTANT
%token <num> INT_VALUE
%token <flottant> FLOAT_VALUE
%token INT FLOAT MAIN
%type <t_info> affectation

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
            | PRINT '(' affectation ')'             {if($3.type == 'i'){
                                                        printf("%i\n", $3.value.intValue);
                                                    }
                                                    if($3.type == 'f'){
                                                        printf("%f\n", $3.value.floatValue);
                                                    }
                                                    }
            ;

return : RETURN INT_VALUE ';' {printf("Détection return\n");
                                printf("Valeur return : %i\n", $2);}
        ;

declaration_variable    : type STRING_CONSTANT {
                            addVariable($2, NULL, 'i');
                            printf("Déclaration variable");
                            }
                        | type STRING_CONSTANT '=' affectation {
                            printf("Déclaration variable avec valeur\n");
                            addVariable($2, affectation.value, affectation.type);
                            }
                        ;

affectation : INT_VALUE     {affectation.value.intValue = $1; affectation.type = 'i';}
            | FLOAT_VALUE   {affectation.value.floatValue = $1; affectation.type = 'f';}
            | STRING_CONSTANT     {InfoVariable info = findVariable($1);
                                    affectation.value = info.value;
                                    affectation.type = info.type;
                                    }
            | affectation '+' affectation     {}
            | affectation '-' affectation     {}
            | affectation '*' affectation     {}
            | affectation '/' affectation     {}
            ;


operation : STRING_CONSTANT '=' affectation {modifier_variable($1, $3);
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
