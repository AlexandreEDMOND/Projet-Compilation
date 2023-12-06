%{
void yyerror (const char *s);
int yylex();
#include <stdio.h> 
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>

%}

%define parse.error verbose
%union {int num; char id; char* string_value;} 
%start programme

%token INC_PLUS INC_MOINS PRINTF PRINT MATRIX RETURN
%token <string_value> STRING_CONSTANT
%token <num> INT_VALUE
%token INT, FLOAT, MAIN

%%

programme   : type MAIN '(' ')' '{' expression '}' {printf("\nDétection fonction main\n");} 
            ;

expression  : PRINTF '(' STRING_CONSTANT ')' ';'  {printf("%s", $3);}
            | RETURN INT_VALUE ';' {printf("Détection return\n");}
            | declaration_variable ';'
            | expression expression
            ;

declaration_variable    : type STRING_CONSTANT {printf("Déclaration variable");}
                        | type STRING_CONSTANT '=' INT_VALUE {printf("Déclaration variable avec valeur");}

type        : INT       {;}
            | FLOAT     {;}

%%



int main (void) {
    yyparse();
    return 0;
}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
