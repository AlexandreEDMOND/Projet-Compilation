%option noyywrap

%{
#include "y.tab.h"
#include <ctype.h>
void yyerror (char *s);
int yylex();
%}

%%

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Mot : %s\n", yytext);
}

%%