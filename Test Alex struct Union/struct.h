#ifndef STRUCT_H
#define STRUCT_H

#include <stdio.h> 
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <string.h>

#define MAX_VARIABLES 100

typedef struct {
    union {
        int intValue;
        float floatValue;
    } value;
    char type;
} InfoVariable;

typedef struct {
    char name[50];
    InfoVariable info_variable;
} Variable;


void modifier_variable(char* name, InfoVariable new_info_variable){}
InfoVariable findVariable(char* name) {}
void addVariable(char* name, char* value, char type) {}

#endif