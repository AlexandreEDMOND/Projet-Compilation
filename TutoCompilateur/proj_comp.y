%{

    void yyerror (const char *s);
    int yylex();
    #include <stdio.h> 
    #include <stdlib.h>
    #include <ctype.h>
    #include <stdint.h>
    #include <string.h>

    void add(char);
    int search(char *);

    struct dataType {
        char * id_name;
        char * data_type;
        char * type;
    } symbol_table[40];

    int count = 0;

    int q;
    char type[10];
    char name[100];
%}

%define parse.error verbose
%start program
%token VOID CHARACTER PRINTFF INT FLOAT CHAR NUMBER FLOAT_NUM ID STR ADD MULTIPLY DIVIDE SUBTRACT UNARY RETURN 
%token MAIN PRINT

%%

program: main '(' ')' '{' body '}'
;


main: datatype MAIN
;

datatype: INT 
| FLOAT 
| CHAR
| VOID
;

body: statement ';'
| body body 
| PRINTFF '(' STR ')' ';'
| PRINT '(' ID ')' ';' 
| RETURN value ';'
;

statement: datatype ID init
| ID '=' expression
| ID UNARY
;

init: '=' value
|
;

expression: expression arithmetic expression
| value
;

arithmetic: ADD 
| SUBTRACT 
| MULTIPLY
| DIVIDE
;


value: NUMBER 
| FLOAT_NUM
| CHARACTER 
| ID
;


%%

int main() {
  yyparse();
  return 0;
}

int search(char *nom_variable) {
	int i;
	for(i=count-1; i>=0; i--) {
		if(strcmp(symbol_table[i].id_name, nom_variable)==0) {
			return -1;
		}
	}
	return 0;
}

void add(char c) {
    if(c == 'V') {
            symbol_table[count].id_name=strdup(name);
            symbol_table[count].data_type=strdup(type);
            symbol_table[count].type=strdup("Variable");
            count++;
        }
}


void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 