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
  int num_registre = 0;

%}

%union 
{
  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER
  char charval; // Info pour le type de variable stockée en table des symboles
  symbol info_symbol;
  dinguerie* alex_le_fou;
}

%token <stringval> INT_NUMBER FLOAT_NUMBER IDENTIFIER STRING

%token EQ NE GT LT GE LE AND OR NOT
%token INC DEC PLUS MINUS TIMES DIVIDE TRANSPOSE ASSIGN
%token OPAR CPAR OBRACK CBRACK OBRACE CBRACE SEMICOLON COMMA
%token IF ELSE WHILE FOR RETURN
%token PRINTF PRINT PRINTMAT MAIN
%token INT FLOAT MATRIX

%type <intval> program
%type <charval> datatype unary plus-ou-moins fois-ou-div

%type <alex_le_fou> somme-entiere produit-entier operande-entier

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
  | RETURN somme-entiere {
    gencode_old('e', "", "", "");
  }
  ;

// Stockage des variables déclarées
// MIPS : Modification dans le .data
declaration:
  datatype IDENTIFIER {
      add_symbol(table_of_symbol, $2, NULL, $1);
      printf("\t\t%s: .word 0\n",$2);
    }
  | datatype IDENTIFIER ASSIGN somme-entiere {
      add_symbol(table_of_symbol, $2, $4->valeur, $1);

      if($4->stockage == 0){
        printf("\t\t%s: .word %i\n",$2, atoi($4->valeur));
      }
      else{
        printf("\t\t%s: .word 0\n",$2);
        char str[50];
        sprintf(str, "%i", $4->stockage);
        gencode_old('=', $2, $4->valeur, str);
        //printf("//%s doit avoir la valeur stocker dans le registre %i\n", $2, $4->stockage);
      }
      num_registre = 0;
    }
  ;


affectation:
  //MIPS : Il n'y a que l'info de la valeur dans "somme-entiere"
  //Pouvoir récupérer le type de "somme-entiere"
  //Yacc fait toute l'arithmétiques mais pas le MIPS avec cette structure
  //Faire une fonction pour chaque ligne
  IDENTIFIER ASSIGN somme-entiere {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    strcpy(symbole->value, $3->valeur);
    //Modification de la valeur de IDENTIFIER avec la valeur de somme-entiere
    //Comment faire si la valeur de somme-entiere vient d'un calcul arithmétique
      //Faire le calcul avant?
    num_registre = 0;
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

    gencode_old('p', string_name, "cst_string", "");
    }
  | PRINT OPAR IDENTIFIER CPAR {
      gencode_old('p', $3, "id", "");
    }
  ;
  | PRINT OPAR somme-entiere CPAR {
      char string_name[100];
      sprintf(string_name, "tempo_var%i", compteur_string_const);
      compteur_string_const++;

      printf("\t\t%s: .word %i\n",string_name, atoi($3->valeur));

      gencode_old('p', string_name, "somme-entiere", "");
      num_registre = 0;
    }
  ;

somme-entiere		: somme-entiere plus-ou-moins produit-entier           {
                                            $$ = do_arithmetiques($1, $3, $2, num_registre);
                                            gencode($2, $1, $3, $$);
                                            num_registre++;
                                            }
                    | produit-entier        { $$ = $1; }
                
produit-entier      : produit-entier fois-ou-div operande-entier      {
                                            $$ = do_arithmetiques($1, $3, $2, num_registre);
                                            gencode($2, $1, $3, $$);
                                            num_registre++;
                                            }
                    | operande-entier       { $$ = $1; }

operande-entier     : INT_NUMBER {
                      //printf("Je lis %s\n", $1);
                      strcpy($$->valeur, $1);
                      $$->stockage = 0;
                    }
                    | IDENTIFIER {
                      symbol* symbole = get_symbol(table_of_symbol, $1);
                      strcpy($$->valeur, symbole->value);
                      $$->stockage = -1;
                    }
                    | OPAR somme-entiere CPAR {$$ = $2;}     

plus-ou-moins       : PLUS                                             { $$ = '+'; }
                    | MINUS                                            { $$ = '-'; }

fois-ou-div        : TIMES                                            { $$ = '*'; }
                    | DIVIDE                                           { $$ = '/'; }

unary:
  INC {$$ = '+';}
  | DEC {$$ = '-';}
  ;

datatype:
  INT {$$ = 'i';}
  | FLOAT {$$ = 'f';}
  ;
%%
