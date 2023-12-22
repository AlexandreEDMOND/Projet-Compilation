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

%token EQ NE GT LT GE LE AND OR NOT
%token INC DEC PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN
%token OPAR CPAR OBRACK CBRACK OBRACE CBRACE SEMICOLON COMMA
%token IF ELSE WHILE FOR RETURN
%token PRINTF PRINT PRINTMAT MAIN
%token INT FLOAT MATRIX

%type <intval> program

%left PLUS MINUS
%left TIMES DIVIDE
%right TRANSPOSE
%right UMINUS
%nonassoc EQUAL NOTEQUAL GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL

%start program

%% 
program:
  datatype MAIN OPAR CPAR OBRACE instructions CBRACE {printf("Programme correctement compilé\n"); exit(0);}
  ;

instructions:
  instructions instruction
  | instruction
  ;

instruction:
  statement SEMICOLON
  | control OBRACE instructions CBRACE

statement:
  declaration {printf("Déclaration\n");}
  | affectation {printf("Affectation\n");}
  | call {printf("Appel de fonction\n");}
  | RETURN expression {printf("Retour de fonction\n");}
  ;

declaration:
  datatype IDENTIFIER
  | datatype IDENTIFIER ASSIGN expression
  ;

affectation:
  IDENTIFIER ASSIGN expression
  | IDENTIFIER unary
  ;

call:
  PRINTF OPAR STRING CPAR
  | PRINT OPAR expression CPAR
  ;

control:
  IF OPAR condition CPAR {printf("Block if\n");}
  | ELSE
  | WHILE OPAR condition CPAR control {printf("Block while\n");}
  | FOR OPAR affectation SEMICOLON condition SEMICOLON statement CPAR control {printf("Block for\n");}
  ;

expression:
  INT_NUMBER
  | FLOAT_NUMBER
  | IDENTIFIER
  | expression PLUS expression
  | expression MINUS expression
  | expression TIMES expression
  | expression DIVIDE expression
  | MINUS expression %prec UMINUS
  | OPAR expression CPAR
  ;

condition:
  expression EQUAL expression
  | expression NOTEQUAL expression
  | expression GREATERTHAN expression
  | expression LESSTHAN expression
  | expression GREATERTHANEQUAL expression
  | expression LESSTHANEQUAL expression
  | condition AND condition
  | condition OR condition
  | NOT condition
  ;

unary:
  INC
  | DEC
  ;

datatype:
  INT
  | FLOAT
  ;
%%

