%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  
  #include "symbol_table.h"
  #include "utils.h" // Définit yyerror et yylex

  extern symbol_table* table_of_symbol;

%}

%union 
{
  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER
  char charval; // Info pour le type de variable stockée en table des symboles
  symbol info_symbol;
}

%token <stringval> INT_NUMBER, FLOAT_NUMBER, IDENTIFIER, STRING

%token EQ NE GT LT GE LE AND OR NOT
%token INC DEC PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN
%token OPAR CPAR OBRACK CBRACK OBRACE CBRACE SEMICOLON COMMA
%token IF ELSE WHILE FOR RETURN
%token PRINTF PRINT PRINTMAT MAIN
%token INT FLOAT MATRIX

%type <intval> program
%type <charval> datatype unary arithmetiques
%type <stringval> expression valeur

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
  | affectation {}
  | affichage {}
  | RETURN expression {}
  ;

declaration:
  datatype IDENTIFIER {add_symbol(table_of_symbol, $2, NULL, $1);}
  | datatype IDENTIFIER ASSIGN expression {add_symbol(table_of_symbol, $2, $4, $1);}
  ;

affectation:
  IDENTIFIER ASSIGN expression {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    strcpy(symbole->value, $3);
  }
  | IDENTIFIER unary {
    if($2 == '+'){
      symbol* symbole = get_symbol(table_of_symbol, $1);
      if(symbole->type == 'i'){
        int nombre = atoi(symbole->value);
        nombre++;
        char str[50];
        sprintf(str, "%i", nombre);
        strcpy(symbole->value, str);
      }
      if(symbole->type == 'f'){
        float nombre = atof(symbole->value);
        nombre++;
        char str[50];
        sprintf(str, "%f", nombre);
        strcpy(symbole->value, str);
      }
      
    }
  }
  ;

affichage:
  PRINTF OPAR STRING CPAR {printf("%s\n", $3);}
  | PRINT OPAR expression CPAR {
      printf("%s\n", $3);
    }
  ;

expression:
  expression arithmetiques expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1, $3, $2));
    strcpy($$, str);
  }
  | valeur {strcpy($$, $1);}
  // Problème avec le signe moins
  // Voir comment le corriger
  | MINUS expression %prec UMINUS {
    float nombre = atof($2);
    nombre *= -1;
    char str[50];
    sprintf(str, "%f", nombre);
    strcpy($$, str);
  }
  | OPAR expression CPAR {$$ = $2;}
  ;

valeur:
  INT_NUMBER {
    strcpy($$, $1);
    }
  | FLOAT_NUMBER {
    strcpy($$, $1);
    }
  | IDENTIFIER {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    strcpy($$, symbole->value);
  }
  ;

arithmetiques:
  PLUS {$$ = '+';}
  | MINUS {$$ = '-';}
  | TIMES {$$ = '*';}
  | DIVIDE {$$ = '/';}
  ;


unary:
  INC {$$ = '+';}
  | DEC {$$ = '-';}
  ;

datatype:
  INT {$$ = 'i';}
  | FLOAT {$$ = 'f';}
  ;
%%
