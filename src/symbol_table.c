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
  
  s->type = type;
  
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

float do_arithmetiques(char* symbole_1, char* symbole_2, char operation){
  float value_1 = atof(symbole_1);
  float value_2 = atof(symbole_2);
  float result;

  switch (operation) {
    case '+':
        result = value_1 + value_2;
        break;
    case '-':
        result = value_1 - value_2;
        break;
    case '*':
        result = value_1 * value_2;
        break;
    case '/':
        if(value_2 != 0){
          result = value_1 / value_2;
        }
        else{
          printf("Division par zero\n");
          exit(1);
        }
        break;
    default:
        printf("Choix invalide fonction do_arithmétiques\n");
        exit(1);
        break;
  }
  printf("Nouvelle valeur par %f %c %f : %f\n", value_1, operation, value_2, result);
  return result;
}