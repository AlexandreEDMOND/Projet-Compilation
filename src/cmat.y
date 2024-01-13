%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>
  
  #include "symbol_table.h"
  #include "quads.h"
  #include "utils.h" // Définit yyerror et yylex
  #include "const.h"

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

%type <intval> program datatype unary plus-ou-moins fois-ou-div

%type <alex_le_fou> somme-entiere produit-entier operande-entier

%left PLUS MINUS
%left TIMES DIVIDE
%right TRANSPOSE
%right UMINUS

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
  | block
  ;



statement:
  declaration {}
  | affectation {}
  | affichage {}
  | RETURN somme-entiere {
    gencode_old(OP_EXIT, "", "", "");
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
        gencode_old(OP_ASSIGN, $2, $4->valeur, str);
        //printf("//%s doit avoir la valeur stocker dans le registre %i\n", $2, $4->stockage);
      }
      num_registre = 0;
    }
  ;


affectation:
  
  IDENTIFIER ASSIGN somme-entiere {
    symbol* symbole = get_symbol(table_of_symbol, $1);
    strcpy(symbole->value, $3->valeur);

    dinguerie* op1;
    NCHK(op1 = malloc(sizeof(dinguerie)));
    strcpy(op1->valeur, $1);
    op1->stockage = -1;
    gencode(OP_ASSIGN, op1, $3,NULL);

    num_registre = 0;
  }

  | IDENTIFIER unary {
    //Reviens à faire une affectation avec la valeur de IDENTIFIER avec IDENTIFIER +1 ou -1
    symbol* symbole = get_symbol(table_of_symbol, $1);
    float nombre;
    if(symbole->type == DATATYPE_INT){
      nombre = atoi(symbole->value);
    }
    if(symbole->type == DATATYPE_FLOAT){
      nombre = atof(symbole->value);
    }
    if($2 == OP_INC){
      nombre++;
    }
    if($2 == OP_DEC){
      nombre--;
    }
    char str[50];
    if(symbole->type == DATATYPE_INT){
      int conversion = nombre;
      sprintf(str, "%i", conversion);
    }
    if(symbole->type == DATATYPE_FLOAT){
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

    gencode_old(OP_PRINT, string_name, "cst_string", "");
    }
  | PRINT OPAR IDENTIFIER CPAR {
      gencode_old(OP_PRINT, $3, "id", "");
    }
  ;
  | PRINT OPAR somme-entiere CPAR {
      char string_name[100];
      sprintf(string_name, "tempo_var%i", compteur_string_const);
      compteur_string_const++;

      printf("\t\t%s: .word %i\n",string_name, atoi($3->valeur));

      gencode_old(OP_PRINT, string_name, "somme-entiere", "");
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
                    | FLOAT_NUMBER {
                      //printf("Je lis %s\n", $1);
                      strcpy($$->valeur, $1);
                      $$->stockage = 0;
                    }
                    | IDENTIFIER {
                      symbol* symbole = get_symbol(table_of_symbol, $1);
                      strcpy($$->valeur, symbole->id);
                      $$->stockage = -1;
                    }
                    | OPAR somme-entiere CPAR {$$ = $2;}     

plus-ou-moins       : PLUS                                             { $$ = OP_ADD; }
                    | MINUS                                            { $$ = OP_SUB; }

fois-ou-div        : TIMES                                            { $$ = OP_MUL; }
                    | DIVIDE                                           { $$ = OP_DIV; }
                    ;


block:
  IF OPAR condition CPAR OBRACE instructions CBRACE ELSE OBRACE instructions CBRACE
  | control OBRACE instructions CBRACE
  ;

declaration-or-affectation:
  declaration
  | affectation
  ;

control:
  IF OPAR condition CPAR
  | WHILE OPAR condition CPAR
  | FOR OPAR declaration-or-affectation SEMICOLON condition SEMICOLON affectation CPAR
  ;

condition:
  condition AND condition
  | condition OR condition
  | NOT condition
  | OPAR condition CPAR
  | condition EQ condition
  | condition NE condition
  | condition GT condition
  | condition LT condition
  | condition GE condition
  | condition LE condition
  | somme-entiere
  ;

unary:
  INC {$$ = OP_INC;}
  | DEC {$$ = OP_DEC;}
  ;

datatype:
  INT {$$ = DATATYPE_INT;}
  | FLOAT {$$ = DATATYPE_FLOAT;}
  ;
%%
