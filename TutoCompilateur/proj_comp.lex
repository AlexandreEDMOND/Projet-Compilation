%option noyywrap

%{
#include "y.tab.h"
#include <ctype.h>
void yyerror (char *s);
int yylex();


%}

%%

"printf"                    { return PRINTFF; }
"print"                     { return PRINT; }
"int"                       { return INT; }
"float"                     { return FLOAT; }
"char"                      { return CHAR; }
"void"                      { return VOID; }
"return"                    { return RETURN; }
"main"                      { return MAIN; }
[-]?[0-9]+                  { return NUMBER; }
[-]?[0-9]+\.[0-9]{1,6}      { return FLOAT_NUM; }
[a-zA-Z]([a-zA-Z]|[0-9])*   { return ID; }
"++"|"--"                   { return UNARY; }
"+"                         { return ADD; }
"-"                         { return SUBTRACT; }
"/"                         { return DIVIDE; }
"*"                         { return MULTIPLY; }
"("                         { return yytext[0]; }
")"                         { return yytext[0]; }
"{"                         { return yytext[0]; }
"}"                         { return yytext[0]; }
";"                         { return yytext[0]; }
"="                         { return yytext[0]; }
["].*["]                    { return STR; }
['].[']                     { return CHARACTER; }
\/\*([^*]|(\*+[^*\/]))*\*+\/ {printf("Detection d'un commentaire");}
.                           {}

%%