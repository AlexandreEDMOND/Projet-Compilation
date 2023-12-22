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
%token <stringval> IDENTIFIER STRING

%token INT FLOAT MATRIX RETURN EXIT
%token PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN INCREMENT DECREMENT
%token IF ELSE WHILE FOR OPENPAR CLOSEPAR OPENBRACK CLOSEBRACK OPENBRACE CLOSEBRACE SEMICOLON COMMA
%token EQUAL NOTEQUAL GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL
%token PRINTF PRINT PRINTMAT

%type <intval> program instructions instruction

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS
%nonassoc EQUAL NOTEQUAL GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL

%start program

%% 
program:
  %empty
  | instructions
  ;

instructions:
  instruction
  | instructions instruction
  ;

instruction:
  line SEMICOLON
  | block
  ;

line:
  declaration
  | affectation
  | RETURN expression
  | affichage

block:
  control OPENBRACE instructions CLOSEBRACE
  | if_control OPENBRACE instructions CLOSEBRACE ELSE OPENBRACE instructions CLOSEBRACE

declaration:
  type IDENTIFIER ASSIGN expression
  | type IDENTIFIER

affectation:
  IDENTIFIER ASSIGN expression { printf("Affectation de %s\n", $1);}
  | IDENTIFIER INCREMENT
  | IDENTIFIER DECREMENT

expression:
  IDENTIFIER
  | INT_NUMBER
  | FLOAT_NUMBER
  | expression PLUS expression
  | expression MINUS expression
  | expression TIMES expression
  | expression DIVIDE expression
  | MINUS expression %prec UMINUS

control:
  if_control
  | WHILE OPENPAR condition CLOSEPAR
  | FOR OPENPAR declaration SEMICOLON condition SEMICOLON affectation CLOSEPAR
  | type IDENTIFIER OPENPAR params_or_empty CLOSEPAR

if_control:
  IF OPENPAR condition CLOSEPAR


affichage:
  PRINTF OPENPAR STRING CLOSEPAR
  PRINT OPENPAR expression CLOSEPAR

params_or_empty:
  params
  | %empty

params:
  | params COMMA declaration
  | declaration

condition:
  expression EQUAL expression
  | expression NOTEQUAL expression
  | expression GREATERTHAN expression
  | expression LESSTHAN expression
  | expression GREATERTHANEQUAL expression
  | expression LESSTHANEQUAL expression

type:
  INT
  | FLOAT
%%

