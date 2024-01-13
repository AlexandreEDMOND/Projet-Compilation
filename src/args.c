#include <stdio.h>
#include <string.h>
#include <utils.h>
#include "args.h"

args_options *parse_args(int argc, char *argv[])
{
  args_options *options;
  NCHK(options = malloc(sizeof(args_options)));
  options->output_file = NULL;

  // Parcours des arguments
  for (int i = 1; i < argc; i++)
  {
    // Affichage des crédits
    if (strcmp(argv[i], "-version") == 0)
      show_credits();

    // Affichage de la table des symboles
    else if (strcmp(argv[i], "-tos") == 0)
      options->show_tos = 1;

    // Spécification du fichier de sortie
    else if (strcmp(argv[i], "-o") == 0)
    {
      if (i + 1 >= argc)
        raler(0, "Missing output file name\n");

      options->output_file = argv[i + 1];
      i++;
    }

    // Erreur si l'option n'est pas reconnue
    else
      raler(0, "Unknown option: %s\n", argv[i]);
  }

  return options;
}

void show_credits()
{
  printf("Credits\n");
}