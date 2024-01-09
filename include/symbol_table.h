#pragma once

// Structure de la table des symboles
typedef struct
{
  char *id;
  char* value;
  char type;
  char *reg;
  int ligne;
  int global_variable;
} symbol;

typedef struct
{
  int display;
  symbol* symbols;
  int size;
  int capacity;
} symbol_table;

// Fonctions de gestion de la table des symboles
symbol_table *create_symbol_table(int display);

void add_symbol(symbol_table *table, char *id, char *data_type, char type);

symbol *get_symbol(symbol_table *table, char *id);
void set_symbol(symbol_table *table, char *id, char *new_value);

void free_symbol_table(symbol_table *table);

void do_arithmetiques(char* res, const char* operande1, const char* operande2, char operation);
void print_symbol_table(const symbol_table *table);
void set_registre(symbol_table *table, char *id, char *reg);