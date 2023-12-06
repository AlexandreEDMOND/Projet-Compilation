%{
void yyerror (const char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>

%}

%define parse.error verbose
%union {int num; char id; char* string_value;}         /* Yacc definitions */
%start programme

%token PLUS MOINS MULT DIV INC_PLUS INC_MOINS PRINTF PAR_OPEN PAR_CLOSE POINT_VIRG MATRIX GUIL_OPEN GUIL_CLOSE RETURN
%token <string_value> STRING_CONSTANT
%token <num> INT_VALUE
%token INT, FLOAT, MAIN

%%

programme   : type MAIN PAR_OPEN PAR_CLOSE GUIL_OPEN expression GUIL_CLOSE {printf("\nDétection fonction main\n");} 
            ;

expression  : PRINTF PAR_OPEN STRING_CONSTANT PAR_CLOSE POINT_VIRG  {printf("%s", $3);}
            | RETURN INT_VALUE POINT_VIRG {;}
            | expression expression
            ;

type        : INT       {;}
            | FLOAT     {;}

%%



int main (void) {
    yyparse();
    return 0;
}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
