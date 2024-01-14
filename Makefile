CC ?= gcc
CFLAGS ?=

PREFIX=cmat

SRC_PATH=src
BIN_PATH=bin
OBJ_PATH=obj
INCLUDE_PATH=include

SOURCES  := $(wildcard $(SRC_PATH)/*.c)
INCLUDES := $(wildcard $(INCLUDE_PATH)/*.h)
OBJECTS  := $(SOURCES:$(SRC_PATH)/%.c=$(OBJ_PATH)/%.o)

all: syntax lex obj $(OBJECTS)
	mkdir -p $(BIN_PATH)
	$(CC) -o $(BIN_PATH)/$(PREFIX).bin $(OBJ_PATH)/$(PREFIX).lex.o $(OBJ_PATH)/$(PREFIX).tab.o $(OBJECTS) -I $(INCLUDE_PATH)
	echo "\033[32m-> Compilation terminée \033[0m"

obj: $(SRC_PATH)/$(PREFIX).main.c
	mkdir -p $(OBJ_PATH)
	$(CC) -o $(OBJ_PATH)/$(PREFIX).tab.o -c $(SRC_PATH)/$(PREFIX).tab.c -I $(INCLUDE_PATH)
	$(CC) -o $(OBJ_PATH)/$(PREFIX).lex.o -c $(SRC_PATH)/$(PREFIX).lex.c -I $(INCLUDE_PATH)

$(OBJECTS): $(OBJ_PATH)/%.o : $(SRC_PATH)/%.c
	$(CC) -o $@ -c $< $(CFLAGS) -I $(INCLUDE_PATH)

syntax: $(SRC_PATH)/$(PREFIX).y
	bison -d -o $(INCLUDE_PATH)/$(PREFIX).tab.h $<
	bison -o $(SRC_PATH)/$(PREFIX).tab.c $<

lex: $(SRC_PATH)/$(PREFIX).lex
	@mkdir -p $(INCLUDE_PATH)
	flex --header-file=$(INCLUDE_PATH)/$(PREFIX).lex.h -o $(SRC_PATH)/$(PREFIX).lex.c $<

clean:
	rm -fr $(OBJ_PATH)
	rm -fr $(BIN_PATH)
	rm -f $(SRC_PATH)/$(PREFIX).lex.c $(SRC_PATH)/$(PREFIX).tab.c $(INCLUDE_PATH)/$(PREFIX).lex.h $(INCLUDE_PATH)/$(PREFIX).tab.h
	find test -type f -name "test.out" -exec rm {} \;
	find test -type f -name "test_MIPS.asm" -exec rm {} \;
	rm -fr out/
