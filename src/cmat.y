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

%token INT FLOAT MATRIX
%token PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN INCREMENT DECREMENT
%token IF ELSE WHILE FOR OPENPAR CLOSEPAR OPENBRACK CLOSEBRACK OPENBRACE CLOSEBRACE SEMICOLON COMMA QUOTE
%token EQUAL NOTEQUAL GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL
%token PRINTF PRINT PRINTMAT

%type <intval> line instruction declaration affectation controle

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS
%nonassoc EQUAL NOTEQUAL GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL

%start line

%% 
line:
  %empty
  | instructions
  ;

instructions :
  instruction
  | instructions instruction
  ;

instruction:
  declaration
  | affectation
  | controle
  ;

declaration:
  type IDENTIFIER ASSIGN value
  ;

type:
  INT
  | FLOAT
  ;

value:
  INT_NUMBER
  | FLOAT_NUMBER
  ;

affectation:
  IDENTIFIER ASSIGN expression
  | IDENTIFIER INCREMENT
  | IDENTIFIER DECREMENT
  ;

expression:
  IDENTIFIER
  | expression PLUS expression
  | expression MINUS expression
  | expression TIMES expression
  | expression DIVIDE expression
  | MINUS expression %prec UMINUS
  ;

controle:
  IF OPENPAR condition CLOSEPAR OPENBRACE instructions CLOSEBRACE
  | IF OPENPAR condition CLOSEPAR OPENBRACE instructions CLOSEBRACE ELSE OPENBRACE instructions CLOSEBRACE
  | WHILE OPENPAR condition CLOSEPAR OPENBRACE instructions CLOSEBRACE
  | FOR OPENPAR declaration SEMICOLON condition SEMICOLON affectation CLOSEPAR OPENBRACE instructions CLOSEBRACE
  ;

condition:
  expression EQUAL expression
  | expression NOTEQUAL expression
  | expression GREATERTHAN expression
  | expression LESSTHAN expression
  | expression GREATERTHANEQUAL expression
  | expression LESSTHANEQUAL expression
  ;
%%

