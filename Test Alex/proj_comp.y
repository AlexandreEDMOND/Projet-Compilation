%{
void yyerror (const char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>

%}

%define parse.error verbose
%union {int num; char id;}         /* Yacc definitions */
%start liste

%%

liste   : /* Empty */               {;} 
        | liste '\n'    {;}
        ;


%%



int main (void) {
    yyparse();
    return 0;
}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
