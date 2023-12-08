LEX_FILES = proj_comp.lex
YACC_FILES = proj_comp.y
NAME_EX = proj_comp

all: mon_compilateur

mon_compilateur: lex.yy.c y.tab.c
	gcc -o $(NAME_EX) lex.yy.c y.tab.c

lex.yy.c: $(LEX_FILES)
	lex $(LEX_FILES)

y.tab.c: $(YACC_FILES)
	yacc -d $(YACC_FILES)

clean:
	rm -f lex.yy.c y.tab.c y.tab.h $(NAME_EX)
