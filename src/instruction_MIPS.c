#include <stdio.h>
#include "instruction_MIPS.h"
#include "genMIPS.h"
void afficher_print(Quad*quad){
        //affichage_string();
        //charger_addresse();
        //gen_syscall();
        affichageMIPS("t2");
        affichage_int();
        gen_syscall();     
    
}
void afficher_op_arith(Quad*quad){
        //Si pas dans un registre mettre dedans 
        //set_registre(table,table->symbols[1].id,"t0");
        put_int_reg(quad->operand1->value_int,"t0");
        //set_registre(table,table->symbols[2].id,"t1");
        put_int_reg(quad->operand2->value_int,"t1");
        add("t2","t0", "t1");//check si le registre est libre  
}