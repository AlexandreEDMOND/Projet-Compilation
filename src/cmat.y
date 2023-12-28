%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  #include "utils.h" // Définit yyerror et yylex
  #include "symbol_table.h"

  extern symbol_table* table_of_symbol;

%}

%union 
{
  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER
  char typeval; // Info pour le type de variable stockée en table des symboles
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
%type <typeval> datatype
%type <stringval> expression

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

statement:
  declaration {}
  | affectation {printf("Affectation\n");}
  | affichage {}
  | RETURN expression {printf("Retour de fonction\n");}
  ;

declaration:
  datatype IDENTIFIER {add_symbol(table_of_symbol, $2, NULL, $1);}
  | datatype IDENTIFIER ASSIGN expression {add_symbol(table_of_symbol, $2, $4, $1);}
  ;

affectation:
  IDENTIFIER ASSIGN expression
  | IDENTIFIER unary
  ;

affichage:
  PRINTF OPAR STRING CPAR {printf("%s\n", $3);}
  | PRINT OPAR expression CPAR {printf("%s\n", $3);}
  ;

expression:
  INT_NUMBER {
    char str[20];
    sprintf(str, "%i", $1);
    $$ = str;
    }
  | FLOAT_NUMBER {
    char str[20];
    sprintf(str, "%f", $1);
    $$ = str;
    }
  | IDENTIFIER {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    char str[20];
    if(symbole->type == 'i'){
      sprintf(str, "%i", symbole->value.int_value);
    }
    if(symbole->type == 'f'){
      sprintf(str, "%f", symbole->value.float_value);
    }
    $$ = str;
  }
  | expression PLUS expression
  | expression MINUS expression
  | expression TIMES expression
  | expression DIVIDE expression
  | MINUS expression %prec UMINUS
  | OPAR expression CPAR
  ;

unary:
  INC
  | DEC
  ;

datatype:
  INT {$$='i';}
  | FLOAT {$$='f';}
  ;
%%

