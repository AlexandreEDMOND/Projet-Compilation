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
STRING  \"([^\\\"]|\\.)*\"

%%
[ \t] {}
{LONG_COMMENTS} {}
{COMMENTS} {}
[\n] {}

"+" {return PLUS;}
"-" {return MINUS;}
"*" {return TIMES;}
"/" {return DIVIDE;}
"~" {return TRANSPOSE;}
"++" {return INCREMENT;}
"--" {return DECREMENT;}

"==" {return EQUAL;}
"!=" {return NOTEQUAL;}
"<" {return LESSTHAN;}
">" {return GREATERTHAN;}
"<=" {return LESSTHANEQUAL;}
">=" {return GREATERTHANEQUAL;}
"=" {return ASSIGN;}

"(" {return OPENPAR;}
")" {return CLOSEPAR;}
"[" {return OPENBRACK;}
"]" {return CLOSEBRACK;}
"{" {return OPENBRACE;}
"}" {return CLOSEBRACE;}
"," {return COMMA;}
";" {return SEMICOLON;}

"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"for" {return FOR;}

"printf" {return PRINTF;}
"print" {return PRINT;}
"printmat" {return PRINTMAT;}

"int" {return INT;}
"float" {return FLOAT;}
"matrix" {return MATRIX;}
"return" {return RETURN;}

{INT}  {return INT_NUMBER;}
{FLOAT} {return FLOAT_NUMBER;}
{STRING} {return STRING;}

{IDENTIFIER} {return IDENTIFIER;}

.               {raler(0, "Invalid character : %s", yytext);}

%%