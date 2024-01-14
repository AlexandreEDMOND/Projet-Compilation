#include "utils.h"
#include "args.h"
#include "symbol_table.h"
#include <unistd.h>
#include "quads.h"
#include <stdio.h>
#include <string.h>

extern int yyparse();
symbol_table *table_of_symbol;
Quad_list *quad_list_main;
int compteur_quads = 0;
int main(int argc, char *argv[])
{

  args_options *options = parse_args(argc, argv);
  table_of_symbol = create_symbol_table(options->show_tos);
  quad_list_main = init_quad_list();

  // Créez un fichier de sortie pour le code assembleur
  FILE *output_file;
  int original_stdout_fd = dup(fileno(stdout));
  if (options->output_file != NULL)
  {
    output_file = fopen(options->output_file, "w");
    if (output_file == NULL)
    {
      perror("Impossible d'ouvrir le fichier de sortie");
      exit(EXIT_FAILURE);
    }

    // Redirige la sortie standard (printf) vers le fichier de sortie
    fflush(stdout); // Vide le tampon de sortie standard
    dup2(fileno(output_file), fileno(stdout));
  }

  // Ecriture du .data
  printf(".data\n");

  int r = 0;
  while (r == 0)
  {
    r = yyparse();
  }

  // print_quad_list(quad_list_main);

  printf("\n.text\nmain:\n");
  print_list_quad_MIPS(quad_list_main, table_of_symbol);

  if (options->show_tos == 1){
    print_symbol_table(table_of_symbol); 
  }

  if (options->output_file != NULL)
  {
    fclose(output_file);
  }
  
  free(options);
  free_quad_list(quad_list_main);
  free_symbol_table(table_of_symbol);

  return 0;
}