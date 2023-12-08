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
    int value;
    char type[50];
} Variable;

Variable variables[MAX_VARIABLES];
int variableCount = 0;

int findVariable(char* name) {
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].value;
        }
    }
    return -986;
}

void addVariable(char* name, int value, char* type) {
    strcpy(variables[variableCount].name, name);
    variables[variableCount].value = value;
    strcpy(variables[variableCount].type, type);

    variableCount++;
}

%}

%define parse.error verbose
%union {int num; char id; char* string_value;} 
%start programme

%token INC_PLUS INC_MOINS PRINTF PRINT MATRIX RETURN
%token <string_value> STRING_CONSTANT
%token <num> INT_VALUE
%token INT FLOAT MAIN

%%

programme   : type MAIN '(' ')' '{' expression '}' {printf("\nDétection fonction main\n");} 
            ;

expression  : PRINTF '(' STRING_CONSTANT ')' ';'  {printf("%s", $3);}
            | PRINT '(' INT_VALUE ')' ';'   {printf("%i\n", $3);}
            | PRINT '(' STRING_CONSTANT ')' ';'   {printf("%i\n", findVariable($3));}
            | RETURN INT_VALUE ';' {printf("Détection return\n");}
            | declaration_variable ';'
            | expression expression
            ;

declaration_variable    : type STRING_CONSTANT {
                            addVariable($2, 0, "int");
                            printf("Déclaration variable");
                            }
                        | type STRING_CONSTANT '=' valeur {
                            addVariable($2, $4, "int");
                            printf("Déclaration variable avec valeur");
                            }

valeur      : INT_VALUE         {return $1;}
            ;

type        : INT       {;}
            | FLOAT     {;}

%%



int main (void) {
    yyparse();
    return 0;
}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
