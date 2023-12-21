#include "utils.h"
#include "args.h"
#include <stdio.h>
#include <string.h>

extern int yyparse();

int main(int argc, char *argv[])
{
  args_options *options = parse_args(argc, argv);

  int r = 0;
  while (r == 0)
  {
    r = yyparse();
  }

  free(options);
  return 0;
}