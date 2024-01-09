%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>
  
  #include "symbol_table.h"
  #include "quads.h"
  #include "utils.h" // Définit yyerror et yylex

  extern symbol_table* table_of_symbol;
  extern Quad_list* quad_list;
  int compteur_string_const = 0;

%}

%union 
{
  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER
  char charval; // Info pour le type de variable stockée en table des symboles
  symbol info_symbol;
}

%token <stringval> INT_NUMBER FLOAT_NUMBER IDENTIFIER STRING

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
  datatype MAIN OPAR CPAR OBRACE instructions CBRACE {
  return 1;}
  ;

instructions:
  instructions instruction
  | instruction
  ;

instruction:
  statement SEMICOLON
  ;


statement:
  declaration {}
  | affectation {}
  | affichage {}
  | RETURN expression {
    gencode('e', "", "");
  }
  ;

// Stockage des variables déclarées
// MIPS : Modification dans le .data
declaration:
  datatype IDENTIFIER {
    add_symbol(table_of_symbol, $2, NULL, $1);
     printf("\t\t%s: .word %i\n",$2, 0);
    //Ajout dans le .data et plus jamais on y touche
    }
  | datatype IDENTIFIER ASSIGN expression {
    add_symbol(table_of_symbol, $2, $4, $1);
    //Ajout dans le .data et plus jamais on y touche
    printf("\t\t%s: .word %s\n",$2, $4);
    }
  ;


affectation:
  //MIPS : Il n'y a que l'info de la valeur dans "expression"
  //Pouvoir récupérer le type de "expression"
  //Yacc fait toute l'arithmétiques mais pas le MIPS avec cette structure
  //Faire une fonction pour chaque ligne
  IDENTIFIER ASSIGN expression {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    strcpy(symbole->value, $3);
    //Modification de la valeur de IDENTIFIER avec la valeur de expression
    //Comment faire si la valeur de expression vient d'un calcul arithmétique
      //Faire le calcul avant?
  }

  | IDENTIFIER unary {
    //Reviens à faire une affectation avec la valeur de IDENTIFIER avec IDENTIFIER +1 ou -1
    symbol* symbole = get_symbol(table_of_symbol, $1);
    float nombre;
    if(symbole->type == 'i'){
      nombre = atoi(symbole->value);
    }
    if(symbole->type == 'f'){
      nombre = atof(symbole->value);
    }
    if($2 == '+'){
      nombre++;
    }
    if($2 == '-'){
      nombre--;
    }
    char str[50];
    if(symbole->type == 'i'){
      int conversion = nombre;
      sprintf(str, "%i", conversion);
    }
    if(symbole->type == 'f'){
      sprintf(str, "%f", nombre);
    }
    strcpy(symbole->value, str);
  }
  ;

affichage:
  PRINTF OPAR STRING CPAR {

    char string_name[100];
    sprintf(string_name, "str_const%i", compteur_string_const);
    compteur_string_const++;

    printf("\t\t%s: .asciiz %s\n",string_name, $3);

    gencode('p', string_name, "cst_string");
    }
  | PRINT OPAR IDENTIFIER CPAR {
      gencode('p', $3, "id");
    }
  ;
  | PRINT OPAR expression CPAR {
      char string_name[100];
      sprintf(string_name, "tempo_var%i", compteur_string_const);
      compteur_string_const++;

      printf("\t\t%s: .word %i\n",string_name, atoi($3));

      gencode('p', string_name, "expression");
    }
  ;

expression:
  expression arithmetiques expression {
    char str[50];
    sprintf(str, "%f", do_arithmetiques($1, $3, $2));
    strcpy($$, str);
  }
  | MINUS expression %prec UMINUS {
    if($2[0] != '-'){
      char signe_moins[] = "-";
      strcat(signe_moins, $2);
      $$ = signe_moins;
    }
    else{
      char* signe_moins= $2 + 1;
      $$ = signe_moins;
    }
  }
  | valeur {strcpy($$, $1);}
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
