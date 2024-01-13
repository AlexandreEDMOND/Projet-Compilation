#pragma once

typedef enum
{
  OP_ADD = 1, // +
  OP_SUB,     // -
  OP_MUL,     // *
  OP_DIV,     // /
  OP_INC = 1, // ++
  OP_DEC,     // --
  OP_ASSIGN,  // =
  OP_PRINT,
  OP_EXIT,
} op_t;

typedef enum
{
  DATATYPE_INT = 1,
  DATATYPE_FLOAT,
  DATATYPE_MATRIX
} datatype_t;