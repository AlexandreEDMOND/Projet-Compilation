%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  #include "utils.h" // Définit yyerror et yylex
%}

%union 
{
  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER
}

%token<intval> INT_NUMBER
%token <floatval> FLOAT_NUMBER
%token <stringval> IDENTIFIER
%token PLUS MINUS TIMES DIVIDE TRANSPOSE INCREMENT DECREMENT EQUAL NOTEQUAL LESSTHAN GREATERTHAN LESSTHANEQUAL GREATERTHANEQUAL ASSIGN OPENPAR CLOSEPAR OPENBRACK CLOSEBRACK COMMA SEMICOLON QUOTE IF ELSE WHILE FOR PRINTF PRINT PRINTMAT INT FLOAT MATRIX EOL

%type <intval> line instruction

%start line

%% 
line:
  %empty
  | instruction EOL

instruction:
%%

