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
  char typeval; // Info pour le type de variable stockée en table des symboles
  symbol info_symbol;
}

%token <info_symbol> INT_NUMBER, FLOAT_NUMBER, IDENTIFIER 
%token <stringval> STRING

%token EQ NE GT LT GE LE AND OR NOT
%token INC DEC PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN
%token OPAR CPAR OBRACK CBRACK OBRACE CBRACE SEMICOLON COMMA
%token IF ELSE WHILE FOR RETURN
%token PRINTF PRINT PRINTMAT MAIN
%token INT FLOAT MATRIX

%type <intval> program
%type <typeval> datatype unary
%type <info_symbol> expression

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
  datatype IDENTIFIER {add_symbol(table_of_symbol, $2.id, NULL, $1);}
  | datatype IDENTIFIER ASSIGN expression {add_symbol(table_of_symbol, $2.id, $4.value, $1);}
  ;

affectation:
  IDENTIFIER ASSIGN expression {
    symbol* symbole = get_symbol(table_of_symbol, $1.id);
    strcpy(symbole->value, $3.value);
  }
  | IDENTIFIER unary {
    if($2 == '+'){
      symbol* symbole = get_symbol(table_of_symbol, $1.id);
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
      if($3.type == 'i'){
        printf("%i\n", atoi($3.value));
      }
      if($3.type == 'f'){
        printf("%f\n", atof($3.value));
      }
    }
  ;

expression:
  INT_NUMBER {
    strcpy($$.value, $1.value);
    $$.type = 'i';
    }
  | FLOAT_NUMBER {
    strcpy($$.value, $1.value);
    $$.type = 'f';
    }
  | IDENTIFIER {
    symbol* symbole = get_symbol(table_of_symbol, $1.id);
    strcpy($$.value, symbole->value);
    $$.type = symbole->type;
  }
  | expression PLUS expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1.value, $3.value, '+'));
    strcpy($$.value, str);
  }
  | expression MINUS expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1.value, $3.value, '-'));
    strcpy($$.value, str);
  }
  | expression TIMES expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1.value, $3.value, '*'));
    strcpy($$.value, str);
  }
  | expression DIVIDE expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1.value, $3.value, '/'));
    strcpy($$.value, str);
  }
  | MINUS expression %prec UMINUS
  | OPAR expression CPAR {$$ = $2;}
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
