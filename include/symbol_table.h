#pragma once


// Type des opérandes
typedef enum Type_operand {
	ID_T,
	CONST_T,
	INTEGER_T,
    TEMP_T,
    TAB_T,
	EMPTY_T
} Type_operand;

typedef enum Type_symbol {
    CONST_S,
    VAR_S,
    TAB_S,
    TEMP_S
} Type_symbol;

// Structure de la table des symboles
typedef struct
{
  char *id;
  char* value;
  Type_symbol type;
  char *reg;
  int ligne;
  int global_variable;
} symbol;

typedef struct
{
  int display;
  symbol* symbols;
  int size;
  int last_temp;  // Dernier temporaire ajouté
  int last_pos;  // Dernière position utilisée dans la pile
  int last_const;  // Dernière constante ajoutée


  int capacity;
} symbol_table;

// Fonctions de gestion de la table des symboles
symbol_table *create_symbol_table(int display);

void add_symbol(symbol_table *table, char *id, char *data_type, char type);

symbol *get_symbol(symbol_table *table, char *id);
void set_symbol(symbol_table *table, char *id, char *new_value);

void free_symbol_table(symbol_table *table);

symbol *add_temp_st(symbol_table *table, char *data_type, char type);
void do_arithmetiques(char* res, const char* operande1, const char* operande2, char operation);
void print_symbol_table(const symbol_table *table);
void set_registre(symbol_table *table, char *id, char *reg);