%option noyywrap

%{
#include "y.tab.h"
#include <ctype.h>
void yyerror (char *s);
int yylex();
%}

%%

"int"       return INT;
"float"     return FLOAT;
"+"         return PLUS;
"-"         return MOINS;
"*"         return MULT;
"/"         return DIV;
"++"        return INC_PLUS;
"--"        return INC_MOINS;
"main"      return MAIN;
"printf"    return PRINTF;
"matrix"    return MATRIX;
"("         return PAR_OPEN;
")"         return PAR_CLOSE;
"{"         return GUIL_OPEN;
"}"         return GUIL_CLOSE;
";"         return POINT_VIRG;
"return"    return RETURN;
[0-9]+ {
    yylval.num = atoi(yytext); 
    return INT_VALUE;
}
\/\*([^*]|(\*+[^*\/]))*\*+\/ {printf("Detection d'un commentaire");}
\"[^"]+\"   {
                yylval.string_value = strdup(yytext + 1);  // Skip the first character (quote)
                yylval.string_value[strlen(yylval.string_value) - 1] = '\0';  // Remove the last character (quote)
                return STRING_CONSTANT;
            }


. {}

%%