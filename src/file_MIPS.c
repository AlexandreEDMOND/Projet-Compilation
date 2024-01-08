#include <stdio.h>
#include "file_MIPS.h"

void gen_data(FILE *output) {
	fprintf(output, ".data\n");
    fclose(output);
}

void gen_mips() {
    FILE *file = fopen("Fichier.asm/test.asm", "w");
    gen_data(file);
}


