#include "utils.h"
#include "args.h"
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
  args_options *options = parse_args(argc, argv);

  printf("show_tos: %d\n", options->show_tos);
  printf("output_file: %s\n", options->output_file);

  free(options);
  return 0;
}