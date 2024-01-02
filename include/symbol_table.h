#pragma once

// Structure de la table des symboles
typedef struct
{
  char* id; //Nom de la variable
  char* value; //Valeur de la variable (NULL si pas définie)
  // Faire un enum pour le type
  char type; // 'i' : int / 'f' : float / 'm' : matrix
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

void free_symbol_table(symbol_table *table);

float do_arithmetiques(char* symbole_1, char* symbole_2, char operation);

float convert_minus_sign(char* symbole);