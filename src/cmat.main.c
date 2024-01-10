#include "utils.h"
#include "args.h"
#include "symbol_table.h"
#include <stdio.h>
#include <string.h>
#include "quad.h"
#include "file_MIPS.h"

extern int yyparse();
symbol_table* table_of_symbol;
Ql *quad_list;
FILE *f;
int main(int argc, char *argv[])
{
  args_options *options = parse_args(argc, argv);
  table_of_symbol = create_symbol_table(options->show_tos);
  quad_list=init_quad_list();
  int r = 0;
  while (r == 0)
  {
    r = yyparse();
  }
  free(options);
  free_symbol_table(table_of_symbol);
  return 0;
}