#include "struct.h"

Variable variables[MAX_VARIABLES];
int variableCount = 0;


void modifier_variable(char* name, InfoVariable new_info_variable){
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            variables[i].info_variable = new_info_variable;
            return;
        }
    }
}

InfoVariable findVariable(char* name) {
    for (int i = 0; i < variableCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].info_variable;
        }
    }
}

void addVariable(char* name, char* value, char type) {
    strcpy(variables[variableCount].name, name);
    variables[variableCount].info_variable.type = type;
    if(value != NULL){    
        if(type == 'i'){
            variables[variableCount].info_variable.value.intValue = atoi(value);
        }
        else if(type == 'f'){
            variables[variableCount].info_variable.value.floatValue = atof(value);
        }
    }
    variableCount++;
}