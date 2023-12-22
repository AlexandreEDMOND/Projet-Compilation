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
"+"         return yytext[0];
"-"         return yytext[0];
"*"         return yytext[0];
"/"         return yytext[0];
"++"        return INC_PLUS;
"--"        return INC_MOINS;
"main"      return MAIN;
"printf"    return PRINTF;
"print"     return PRINT;
"matrix"    return MATRIX;
"("         return yytext[0];
")"         return yytext[0];
"{"         return yytext[0];
"}"         return yytext[0];
";"         return yytext[0];
"return"    return RETURN;
"="         return yytext[0];

[0-9]+ {
    yylval.num = atoi(yytext); 
    return INT_VALUE;
}

[0-9]+"."[0-9]+ {
    yylval.flottant = atof(yytext); 
    return FLOAT_VALUE;
}


\/\*([^*]|(\*+[^*\/]))*\*+\/ {printf("Detection d'un commentaire");}

\"[^"]+\"   {
                yylval.string_value = strdup(yytext + 1);  // Skip the first character (quote)
                yylval.string_value[strlen(yylval.string_value) - 1] = '\0';  // Remove the last character (quote)
                return STRING_CONSTANT;
            }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.string_value = strdup(yytext);
    return STRING_CONSTANT;
}

. {}

%%