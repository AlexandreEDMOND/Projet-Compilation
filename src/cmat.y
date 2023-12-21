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

%token INT FLOAT MATRIX RETURN
%token PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN INCREMENT DECREMENT
%token IF ELSE WHILE FOR OPENPAR CLOSEPAR OPENBRACK CLOSEBRACK OPENBRACE CLOSEBRACE SEMICOLON COMMA QUOTE
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

instructions :
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
  | RETURN value

block:
  control OPENBRACE instructions CLOSEBRACE

declaration:
  type IDENTIFIER ASSIGN expression

affectation:
  IDENTIFIER ASSIGN expression
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
  IF OPENPAR condition CLOSEPAR
  | WHILE OPENPAR condition CLOSEPAR
  | FOR OPENPAR declaration SEMICOLON condition SEMICOLON affectation CLOSEPAR
  | ELSE

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

value:
  INT_NUMBER
  | FLOAT_NUMBER
%%

