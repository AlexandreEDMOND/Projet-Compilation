#pragma once
// Structure de la table des symboles
typedef struct
{
  char *id;    // Nom de la variable
  char *value; // Valeur de la variable (NULL si pas définie)
  // Faire un enum pour le type
  char type; // 'i' : int / 'f' : float / 'm' : matrix
} symbol;

typedef struct
{
  int display;
  symbol *symbols;
  int size;
  int capacity;
} symbol_table;

typedef struct
{
  char valeur[50];
  int stockage; // 0 = Valeur brut (4 8 -9) / >0 = Stocker dans la pile / -1 = Variable .data
  char type;
  int index;
} dinguerie;

// Fonctions de gestion de la table des symboles
symbol_table *create_symbol_table(int display);

void add_symbol(symbol_table *table, char *id, char *data_type, char type);

symbol *get_symbol(symbol_table *table, char *id);

void free_symbol_table(symbol_table *table);

dinguerie *do_arithmetiques(dinguerie *q_1, dinguerie *q_2, char operation, int num_registre);
dinguerie *integer(int value);
dinguerie *empty();
dinguerie *emptyTest();
void print_symbol_table(const symbol_table *table);