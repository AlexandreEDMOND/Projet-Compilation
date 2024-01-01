#include "utils.h"
#include "args.h"
#include "symbol_table.h"
#include <stdio.h>
#include <string.h>

extern int yyparse();
symbol_table* table_of_symbol;

int main(int argc, char *argv[])
{

  

  args_options *options = parse_args(argc, argv);
  table_of_symbol = create_symbol_table(options->show_tos);

  // Créez un fichier de sortie pour le code assembleur
  FILE *output_file;
  if(options->output_file != NULL){
    output_file = fopen(options->output_file, "w");
    if (output_file == NULL) {
        perror("Impossible d'ouvrir le fichier de sortie");
        exit(EXIT_FAILURE);
    }

    // Redirige la sortie standard (printf) vers le fichier de sortie
    fflush(stdout); // Vide le tampon de sortie standard
    dup2(fileno(output_file), fileno(stdout));
  }
    
  

  int r = 0;
  while (r == 0)
  {
    r = yyparse();
  }

  free(options);
  free_symbol_table(table_of_symbol);

  if(options->output_file != NULL){
    fclose(output_file);
  }

  return 0;
}