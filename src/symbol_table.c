#include "symbol_table.h"
#include "utils.h"

#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 10

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

  strcpy(s->id, id);
  if(data_type != NULL){
      if(type == 'i'){
      s->value.int_value = atoi(data_type);
    }
    if(type == 'f'){
      s->value.float_value = atof(data_type);
    }
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
  }

  free(table->symbols);
  free(table);
}