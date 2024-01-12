#include "symbol_table.h"
#include "utils.h"

#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 10
#define MAX_LENGTH 50

symbol_table *create_symbol_table(int display)
{
  symbol_table *table;
  NCHK(table = malloc(sizeof(symbol_table)));
  NCHK(table->symbols = calloc(INITIAL_CAPACITY, sizeof(symbol)));

  table->display = display;
  table->size = 0;
  table->capacity = INITIAL_CAPACITY;

  return table;
}

void add_symbol(symbol_table *table, char *id, char *data_type, char type)
{
  if (table->size == table->capacity)
  {
    table->capacity *= 2;
    NCHK(table->symbols = realloc(table->symbols, table->capacity * sizeof(symbol)));
  }
  
  symbol *s = &table->symbols[table->size++];

  NCHK(s->id = malloc(strlen(id) + 1));
  NCHK(s->value = malloc(sizeof(char)*MAX_LENGTH));


  strcpy(s->id, id);

  if(data_type != NULL){
    strcpy(s->value, data_type);
  }
  else{
    s->value=NULL;
  }
  
  s->type = type;
  s->reg=NULL;
  if (table->display == 1)
  {
    printf("Ajout de la variable %s de valeur %s et de type %c\n", id, data_type, type);
  }
}

symbol *get_symbol(symbol_table *table, char *id)
{
  for (int i = 0; i < table->size; i++)
  {
    if (strcmp(table->symbols[i].id, id) == 0)
    {
      return &table->symbols[i];
    }
  }

  return NULL;
}
void set_global_variable(symbol_table *table, char *id) {
    for (int i = 0; i < table->size; i++) {
        if (strcmp(table->symbols[i].id, id) == 0) {
            table->symbols[i].global_variable = 1;
            break;
        }
    }
}

void set_registre(symbol_table *table, char *id, char *reg) {
  // Find the symbol with the given id
  for (int i = 0; i < table->size; i++) {
    if (strcmp(table->symbols[i].id, id) == 0) {
      // If the symbol already has a register assigned, free it
      if (table->symbols[i].reg != NULL) {
        free(table->symbols[i].reg);
      }

      // Allocate memory for the new register and assign it
      table->symbols[i].reg = malloc(strlen(reg) + 1);
      strcpy(table->symbols[i].reg, reg);

      // Optionally, print a message if the table is set to display
      if (table->display) {
        printf("Registre de '%s' mis à jour à '%s'\n", id, reg);
      }

      return;
    }
  }

  printf("Symbole '%s' non trouvé dans la table des symboles\n", id);
}

void set_symbol(symbol_table *table, char *id, char *new_value)
{
    symbol *s = get_symbol(table, id);
    if (s == NULL)
    {
        printf("Symbole %s non trouvé\n", id);
        return;
    }

    if (s->value != NULL)
    {
        free(s->value);
    }

    NCHK(s->value = malloc(strlen(new_value) + 1));
    strcpy(s->value, new_value);

    if (table->display == 1)
    {
        printf("Modification de la valeur du symbole %s en %s\n", id, new_value);
    }
}


void free_symbol_table(symbol_table *table)
{
  for (int i = 0; i < table->size; i++)
  {
    free(table->symbols[i].id);
    free(table->symbols[i].value);
  }

  free(table->symbols);
  free(table);
}

void do_arithmetiques(char* res, const char* operande1, const char* operande2, char operation) {
    int op1 = atoi(operande1);
    int op2 = atoi(operande2);
    int result;

    switch (operation) {
        case '+':
            result = op1 + op2;
            break;
        case '-':
            result = op1 - op2;
            break;
        case '*':
            result = op1 * op2;
            break;
        case '/':
            if (op2 != 0) {
                result = op1 / op2;
            } else {
                strcpy(res, "Division by zero");
                return;
            }
            break;
        default:
            strcpy(res, "Invalid operation");
            return;
    }

    sprintf(res, "%d", result);
}

void print_symbol_table(const symbol_table *table)
{
    if (table == NULL)
    {
        printf("La table des symboles est vide.\n");
        return;
    }

    printf("Table des symboles:\n");
    printf("ID\tValeur\tType\tGV\n");
    printf("-------------------------\n");

    for (int i = 0; i < table->size; i++)
    {
        symbol *s = &table->symbols[i];
        printf("%s\t%s\t%c\t%i\n", s->id, s->value ? s->value : "NULL", s->type,s->global_variable);
    }
}
