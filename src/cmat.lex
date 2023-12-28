%{
    #include <stdio.h>
    #include "cmat.tab.h"
    #include "utils.h"
%}

%option noyywrap

IDENTIFIER [a-zA-Z][a-zA-Z0-9_]*
FLOAT [0-9]*\.[0-9]*
INT [1-9][0-9]*|[0]
COMMENTS        "//"([^\n])*"\n"
LONG_COMMENTS   "/*"([^*]|\*[^/])*\*"/"
STRING  ["].*["]

%%
[ \t] {}
{LONG_COMMENTS} {}
{COMMENTS} {}
[\n] {}

"==" {return EQ;}
"!=" {return NE;}
"<" {return LT;}
">" {return GT;}
"<=" {return LE;}
">=" {return GE;}
"&&" {return AND;}
"||" {return OR;}
"!" {return NOT;}

"++" {return INC;}
"--" {return DEC;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return TIMES;}
"/" {return DIVIDE;}
"~" {return TRANSPOSE;}
"=" {return ASSIGN;}

"(" {return OPAR;}
")" {return CPAR;}
"[" {return OBRACK;}
"]" {return CBRACK;}
"{" {return OBRACE;}
"}" {return CBRACE;}
"," {return COMMA;}
";" {return SEMICOLON;}

"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"for" {return FOR;}
"return" {return RETURN;}

"printf" {return PRINTF;}
"print" {return PRINT;}
"printmat" {return PRINTMAT;}
"main" {return MAIN;}

"int" {return INT;}
"float" {return FLOAT;}
"matrix" {return MATRIX;}

{INT}  {
    yylval.intval = atoi(yytext);
    return INT_NUMBER;
    }
{FLOAT} {return FLOAT_NUMBER;}
{STRING} {
    yylval.stringval = strdup(yytext);
    return STRING;}

{IDENTIFIER} {
    yylval.stringval = strdup(yytext);
    return IDENTIFIER;
    }

.               {raler(0, "Invalid character : %s", yytext);}

%%