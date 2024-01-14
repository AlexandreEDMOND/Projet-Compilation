#include "quads.h"
#include "symbol_table.h"

void gen_MIPS_EQ(Quad *quad, symbol_table *table)
{
    if (quad->op == '@')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tbeq $t3, $t4, if_block%i   # Si a == c, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tbeq $t3, $t4, while_block%i   # Si a == c, aller à while_block\n", quad->idxIF);
        }
    }
}

void gen_MIPS_SUP(Quad *quad, symbol_table *table)
{
    if (quad->op == '>')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tbgt $t3, $t4, if_block%i   # Si a > 5, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tbgt $t3, $t4, while_block%i   # Si a > 5, aller à while_block\n", quad->idxIF);
        }
    }
}

void gen_MIPS_MIN(Quad *quad, symbol_table *table)
{
    if (quad->op == '<')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tblt $t3, $t4, if_block%i   # Si a > 5, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tblt $t3, $t4, while_block%i   # Si a > 5, aller à while_block\n", quad->idxIF);
        }
    }
}

void gen_MIPS_INFEGAL(Quad *quad, symbol_table *table)
{
    if (quad->op == 'h')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tble $t3, $t4, if_block%i   # Si a > 5, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tble $t3, $t4, while_block%i   # Si a > 5, aller à while_block\n", quad->idxIF);
        }
    }
}

void gen_MIPS_SUPEGAL(Quad *quad, symbol_table *table)
{
    if (quad->op == 'k')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tbge $t3, $t4, if_block%i   # Si a > 5, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tbge $t3, $t4, while_block%i   # Si a > 5, aller à while_block\n", quad->idxIF);
        }
    }
}

void gen_MIPS_NEQ(Quad *quad, symbol_table *table)
{
    if (quad->op == '!')
    {
        int A = 0;
        int B = 0;
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand1->valeur == table->symbols[i].id)
            {
                A = 1;
            }
        }
        if( quad->type == 1){ 
            printf("\t\tcondition%i:\n", quad->idxIF);
        }
        if (A == 1)
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        else
        {
            printf("\t\tlw $t3, %s\n", quad->operand1->valeur);
        }
        for (int i = 0; i < table->size; i++)
        {
            if (quad->operand2->valeur == table->symbols[i].id)
            {
                B = 1;
            }
        }
        if (B == 1)
        {
            printf("\t\tlw $t4, %s\n", quad->operand2->valeur);
        }
        else
        {
            printf("\t\tli $t4, %s\n", quad->operand2->valeur);
        }
        if (quad->type == 0)
        {
            printf("\t\tbne $t3, $t4, if_block%i   # Si a > 5, aller à if_block\n", quad->idxIF);
        }
        else if (quad->type == 1)
        {
            printf("\t\tbne $t3, $t4, while_block%i   # Si a > 5, aller à while_block\n", quad->idxIF);
        }
    }
}