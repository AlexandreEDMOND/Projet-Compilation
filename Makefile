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

TARGET = $(BIN_PATH)/$(PREFIX).bin


all: $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(BIN_PATH)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJECTS): $(OBJ_PATH)/%.o : $(SRC_PATH)/%.c
	@mkdir -p $(OBJ_PATH)
	$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE_PATH)

clean:
	rm -r $(OBJ_PATH) $(BIN_PATH)