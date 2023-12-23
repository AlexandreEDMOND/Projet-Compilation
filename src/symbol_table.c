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

void add_symbol(symbol_table *table, char *id, char *data_type, char *type, int line_number)
{
  if (table->size == table->capacity)
  {
    table->capacity *= 2;
    NCHK(table->symbols = realloc(table->symbols, table->capacity * sizeof(symbol)));
  }

  symbol *s = &table->symbols[table->size++];

  NCHK(s->id = malloc(strlen(id) + 1));
  NCHK(s->data_type = malloc(strlen(data_type) + 1));
  NCHK(s->type = malloc(strlen(type) + 1));

  strcpy(s->id, id);
  strcpy(s->data_type, data_type);
  strcpy(s->type, type);
  s->line_number = line_number;

  if (table->display)
  {
    printf("Ajout de la variable %s de type %s à la ligne %d\n", id, data_type, line_number);
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
    free(table->symbols[i].data_type);
    free(table->symbols[i].type);
  }

  free(table->symbols);
  free(table);
}