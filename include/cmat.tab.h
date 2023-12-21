/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_INCLUDE_CMAT_TAB_H_INCLUDED
# define YY_YY_INCLUDE_CMAT_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INT_NUMBER = 258,              /* INT_NUMBER  */
    FLOAT_NUMBER = 259,            /* FLOAT_NUMBER  */
    IDENTIFIER = 260,              /* IDENTIFIER  */
    PLUS = 261,                    /* PLUS  */
    MINUS = 262,                   /* MINUS  */
    TIMES = 263,                   /* TIMES  */
    DIVIDE = 264,                  /* DIVIDE  */
    TRANSPOSE = 265,               /* TRANSPOSE  */
    INCREMENT = 266,               /* INCREMENT  */
    DECREMENT = 267,               /* DECREMENT  */
    EQUAL = 268,                   /* EQUAL  */
    NOTEQUAL = 269,                /* NOTEQUAL  */
    LESSTHAN = 270,                /* LESSTHAN  */
    GREATERTHAN = 271,             /* GREATERTHAN  */
    LESSTHANEQUAL = 272,           /* LESSTHANEQUAL  */
    GREATERTHANEQUAL = 273,        /* GREATERTHANEQUAL  */
    ASSIGN = 274,                  /* ASSIGN  */
    OPENPAR = 275,                 /* OPENPAR  */
    CLOSEPAR = 276,                /* CLOSEPAR  */
    OPENBRACK = 277,               /* OPENBRACK  */
    CLOSEBRACK = 278,              /* CLOSEBRACK  */
    COMMA = 279,                   /* COMMA  */
    SEMICOLON = 280,               /* SEMICOLON  */
    QUOTE = 281,                   /* QUOTE  */
    IF = 282,                      /* IF  */
    ELSE = 283,                    /* ELSE  */
    WHILE = 284,                   /* WHILE  */
    FOR = 285,                     /* FOR  */
    PRINTF = 286,                  /* PRINTF  */
    PRINT = 287,                   /* PRINT  */
    PRINTMAT = 288,                /* PRINTMAT  */
    INT = 289,                     /* INT  */
    FLOAT = 290,                   /* FLOAT  */
    MATRIX = 291,                  /* MATRIX  */
    EOL = 292                      /* EOL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "src/cmat.y"

  int intval; // déclaration du type associé à INT_NUMBER
  float floatval; // déclaration du type associé à FLOAT_NUMBER
  char *stringval; // déclaration du type associé à IDENTIFIER

#line 107 "include/cmat.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_INCLUDE_CMAT_TAB_H_INCLUDED  */
