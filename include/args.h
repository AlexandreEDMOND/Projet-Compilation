extern char *output_file;
extern int show_tos;

typedef struct
{
  char *output_file;
  int show_tos;
} args_options;

args_options *parse_args(int argc, char *argv[]);

void show_credits();