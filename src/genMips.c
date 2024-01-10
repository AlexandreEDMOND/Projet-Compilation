#include <stdio.h>
#include "genMIPS.h"
#include "file_MIPS.h"
#include "quad.h"
#include "symbol_table.h"
extern FILE* output;
/* Traitement du quad OP_ASSIGN */
void gen_assign(Quad * quad) {
    
    // On met l'opérande dans t2
    //put_int_reg(quad->operand1, "t2");
    // On met t2 dans la variable
    //put_reg_var("t2", quad->result.symbol->position);
}

/* Met un entier dans un registre  */
void put_int_reg(int value, char *reg) {
    fprintf(output,"\t\tli\t$%s,\t%i\n", reg, value);
}
void put_reg_to_reg(char*reg1, char *reg2) {
    fprintf(output,"\t\tli\t$%s,\t%s\n", reg2, reg1);
}
/*Met un registre dans la table des symboles*/
void put_reg_var(char *reg, char*place) {
    fprintf(output, "\t\tsw\t$%s,\t%s($fp)\n", reg, place);
}

void add(char *res, char *reg1, char *reg2) {
    fprintf(output,"\t\tadd\t$%s,\t$%s,\t$%s\n", res, reg1, reg2);
}
void affichage_int(){
    fprintf(output,"\t\tli $v0, 1  \n");
}
void affichage_string(){
    fprintf(output,"\t\tli $v0, 4\n");
}
void charger_addresse(){
    fprintf(output,"\t\tla $a0, result_msg  # Charger l'adresse du message\n");
}
void affichageMIPS(char *reg){
    fprintf(output,"\t\tmove $a0, $%s       # Mettre la valeur de c dans $a0\n",reg);
}
void print_int(char* res){
     fprintf(output,"\t\tmove $a0, $%s       # Mettre la valeur de c dans $a0\n",res);
}
void exitMIPS(){
    fprintf(output,"\t\tli $v0, 10      # syscall pour terminer l'exécution\n");
}
void gen_txt(){
    fprintf(output,".text\n");
}
void gen_main(){
    fprintf(output,"    main:\n");
}
void gen_syscall(){
    fprintf(output,"\t\tsyscall\n ");
}
