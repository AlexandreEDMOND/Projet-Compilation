#pragma once

// Structure de la table des symboles
typedef struct
{
  char *id;
  char *data_type;
  char *type;
  int line_number;
} symbol;

typedef struct
{
  int display;
  symbol *symbols;
  int size;
  int capacity;
} symbol_table;

// Fonctions de gestion de la table des symboles
symbol_table *create_symbol_table(int display);

void add_symbol(symbol_table *table, char *id, char *data_type, char *type, int line_number);

symbol *get_symbol(symbol_table *table, char *id);

void free_symbol_table(symbol_table *table);