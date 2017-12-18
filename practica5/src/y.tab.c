/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "src/alfa.y" /* yacc.c:339  */

#define ERROR_SEMANTICO "error semantico\n"
#define MAX_TAM_VECTOR 64
#include <stdio.h>
	/*#include "tokens.h"*/
#include "../includes/alfa.h"
#include "../includes/y.tab.h"
//#include "../includes/generacion.h"

	//extern tipo_atributos yylval;
	extern int yylex();
	extern FILE* output;
	extern int fil;
	extern int col;
	extern int yyleng;

	int tipo_actual;
	int clase_actual;
	int tam_actual;//README esta variable global la uso para poder heredar el tamanio del vector en las declaraciones
	int cuantos = 0;
	int en_exp_list = FALSE;//esta variable es un flag que indica si la compilacion se encuentra en una lista de expresiones (llamada a funcion)
	int pos_parametro_actual = 0;
	int num_parametros_actual = 0;
	int pos_variable_local_actual = 1;//README este es 1 o deberia ser 0 y la otra global de posiciones deberia ser 1 ??? ver generacion codigo t 81
	int num_variables_local_actual = 0;
	int num_retornos = 0;
	/*int cuantos_bloque = 0;*/
	//TODO quiza crear una variable global que sea un flag para indicar si estamos en ambito global o local (?)

	int yyerror(char* s) {
		//TODO liberar las tablas de simbolos en caso de error
		if (yylval.atributos.tipo != -1){
			if(strcmp(s, "syntax error"))
				fprintf(stderr,"****Error semantico en [lin %d col %d]: %s\n",fil, col-yyleng, s);
			else
				fprintf(stderr, "****Error sintactico en [lin %d col %d]\n", fil, col - yyleng);
		}
		return -1;
	}

#line 107 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOK_MAIN = 258,
    TOK_INT = 259,
    TOK_BOOLEAN = 260,
    TOK_ARRAY = 261,
    TOK_FUNCTION = 262,
    TOK_IF = 263,
    TOK_ELSE = 264,
    TOK_WHILE = 265,
    TOK_SCANF = 266,
    TOK_PRINTF = 267,
    TOK_RETURN = 268,
    TOK_PUNTOYCOMA = 269,
    TOK_COMA = 270,
    TOK_PARENTESISIZQUIERDO = 271,
    TOK_PARENTESISDERECHO = 272,
    TOK_CORCHETEIZQUIERDO = 273,
    TOK_CORCHETEDERECHO = 274,
    TOK_LLAVEIZQUIERDA = 275,
    TOK_LLAVEDERECHA = 276,
    TOK_ASIGNACION = 277,
    TOK_MAS = 278,
    TOK_MENOS = 279,
    TOK_DIVISION = 280,
    TOK_ASTERISCO = 281,
    TOK_AND = 282,
    TOK_OR = 283,
    TOK_NOT = 284,
    TOK_IGUAL = 285,
    TOK_DISTINTO = 286,
    TOK_MENORIGUAL = 287,
    TOK_MAYORIGUAL = 288,
    TOK_MENOR = 289,
    TOK_MAYOR = 290,
    TOK_IDENTIFICADOR = 291,
    TOK_CONSTANTE_ENTERA = 292,
    TOK_TRUE = 293,
    TOK_FALSE = 294,
    MENOSU = 295
  };
#endif
/* Tokens.  */
#define TOK_MAIN 258
#define TOK_INT 259
#define TOK_BOOLEAN 260
#define TOK_ARRAY 261
#define TOK_FUNCTION 262
#define TOK_IF 263
#define TOK_ELSE 264
#define TOK_WHILE 265
#define TOK_SCANF 266
#define TOK_PRINTF 267
#define TOK_RETURN 268
#define TOK_PUNTOYCOMA 269
#define TOK_COMA 270
#define TOK_PARENTESISIZQUIERDO 271
#define TOK_PARENTESISDERECHO 272
#define TOK_CORCHETEIZQUIERDO 273
#define TOK_CORCHETEDERECHO 274
#define TOK_LLAVEIZQUIERDA 275
#define TOK_LLAVEDERECHA 276
#define TOK_ASIGNACION 277
#define TOK_MAS 278
#define TOK_MENOS 279
#define TOK_DIVISION 280
#define TOK_ASTERISCO 281
#define TOK_AND 282
#define TOK_OR 283
#define TOK_NOT 284
#define TOK_IGUAL 285
#define TOK_DISTINTO 286
#define TOK_MENORIGUAL 287
#define TOK_MAYORIGUAL 288
#define TOK_MENOR 289
#define TOK_MAYOR 290
#define TOK_IDENTIFICADOR 291
#define TOK_CONSTANTE_ENTERA 292
#define TOK_TRUE 293
#define TOK_FALSE 294
#define MENOSU 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 43 "src/alfa.y" /* yacc.c:355  */

	tipo_atributos atributos;

#line 231 "y.tab.c" /* yacc.c:355  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 246 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   154

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  44
/* YYNRULES -- Number of rules.  */
#define YYNRULES  82
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  151

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   295

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   145,   145,   157,   171,   181,   184,   187,   197,   201,
     213,   224,   228,   240,   258,   261,   270,   271,   282,   300,
     314,   344,   345,   354,   355,   364,   367,   388,   389,   408,
     409,   418,   419,   428,   429,   430,   431,   440,   444,   456,
     475,   496,   518,   522,   527,   540,   551,   557,   565,   573,
     592,   603,   615,   624,   632,   640,   648,   657,   666,   675,
     685,   713,   718,   723,   728,   740,   759,   772,   776,   788,
     789,   798,   808,   818,   828,   838,   848,   865,   870,   883,
     890,   905,   919
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TOK_MAIN", "TOK_INT", "TOK_BOOLEAN",
  "TOK_ARRAY", "TOK_FUNCTION", "TOK_IF", "TOK_ELSE", "TOK_WHILE",
  "TOK_SCANF", "TOK_PRINTF", "TOK_RETURN", "TOK_PUNTOYCOMA", "TOK_COMA",
  "TOK_PARENTESISIZQUIERDO", "TOK_PARENTESISDERECHO",
  "TOK_CORCHETEIZQUIERDO", "TOK_CORCHETEDERECHO", "TOK_LLAVEIZQUIERDA",
  "TOK_LLAVEDERECHA", "TOK_ASIGNACION", "TOK_MAS", "TOK_MENOS",
  "TOK_DIVISION", "TOK_ASTERISCO", "TOK_AND", "TOK_OR", "TOK_NOT",
  "TOK_IGUAL", "TOK_DISTINTO", "TOK_MENORIGUAL", "TOK_MAYORIGUAL",
  "TOK_MENOR", "TOK_MAYOR", "TOK_IDENTIFICADOR", "TOK_CONSTANTE_ENTERA",
  "TOK_TRUE", "TOK_FALSE", "MENOSU", "$accept", "programa", "escritura1",
  "escritura2", "declaraciones", "declaracion", "clase", "clase_escalar",
  "tipo", "clase_vector", "identificadores", "funciones", "funcion",
  "fn_declaration", "fn_name", "parametros_funcion",
  "resto_parametros_funcion", "parametro_funcion", "idpf",
  "declaraciones_funcion", "sentencias", "sentencia", "sentencia_simple",
  "bloque", "asignacion", "elemento_vector", "condicional", "if_exp",
  "if_exp_sentencias", "while", "while_exp", "bucle", "lectura",
  "escritura", "retorno_funcion", "exp", "idf_llamada_fn",
  "lista_expresiones", "resto_lista_expresiones", "comparacion",
  "constante", "constante_logica", "constante_entera", "identificador", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

#define YYPACT_NINF -37

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-37)))

#define YYTABLE_NINF -67

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      -1,     0,    18,    69,   -37,   -37,   -37,     2,   -37,    69,
     -11,   -37,   -37,   -37,     3,    22,   -37,   -37,    17,    23,
      -5,     2,   -37,    22,    35,    25,   -37,   -11,   -37,    30,
       6,    35,   -37,    56,    60,    50,    61,    61,   -13,    67,
      35,    87,   -37,   -37,    81,   -37,    35,    95,    61,    35,
     -37,   -37,   -37,   -37,     2,   -37,   -37,   -37,    84,    61,
     -37,   -37,    61,    61,    61,    -2,   -37,   -37,   -37,    28,
      98,   -37,   -37,   -37,    28,    61,    61,   -37,   -37,   -37,
      61,   101,   103,   104,   105,    89,   117,   121,   -37,   116,
      85,   119,   -37,   -37,    61,    61,    61,    61,    61,    61,
      61,    68,    28,    28,   128,    35,   118,   -37,   -37,   -37,
     125,     2,   -37,   126,   -37,    61,    61,    61,    61,    61,
      61,   -37,   -15,   -15,   -37,   -37,    11,    11,    42,   130,
     -37,   127,   -37,    69,   121,   -37,    28,    28,    28,    28,
      28,    28,    61,   -37,   -37,   -37,   -37,   -37,   -37,    42,
     -37
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     1,    11,    12,     0,     3,     5,
       0,     8,    10,     9,     0,    17,     6,    82,     0,    14,
       0,     0,     4,    17,     0,     0,     7,     0,    81,     0,
       0,     0,    16,     0,     0,     0,     0,     0,     0,     0,
      29,     0,    32,    33,     0,    37,     0,     0,     0,     0,
      38,    34,    35,    36,    22,    15,    13,    20,     0,     0,
      46,    49,     0,     0,     0,    60,    79,    80,    64,    50,
       0,    61,    77,    78,    51,     0,     0,    18,    30,    31,
       0,     0,     0,     0,     0,     0,     0,    24,     2,     0,
       0,     0,    56,    59,     0,     0,     0,     0,     0,     0,
      68,     0,    39,    40,    43,     0,     0,    48,    26,    25,
       0,     0,    21,     0,    62,     0,     0,     0,     0,     0,
       0,    63,    52,    53,    54,    55,    57,    58,    70,     0,
      41,     0,    47,    28,    24,    44,    71,    72,    73,    74,
      75,    76,     0,    67,    65,    42,    27,    19,    23,    70,
      69
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -37,   -37,   -37,   -37,    -9,   -37,   -37,   -37,    -4,   -37,
     122,   129,   -37,   -37,   -37,   -37,    16,    40,   -37,   -37,
     -27,   -37,   -37,   -37,   -37,   -16,   -37,   -37,   -37,   -37,
     -37,   -37,   -37,   -37,   -37,   -36,   -37,   -37,     4,   -37,
     -37,   -37,   134,   -37
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,    15,    31,     8,     9,    10,    11,    12,    13,
      18,    22,    23,    24,    25,    86,   112,    87,   109,   147,
      39,    40,    41,    42,    43,    68,    45,    46,    47,    48,
      49,    50,    51,    52,    53,    69,    70,   129,   143,    91,
      71,    72,    73,    19
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      16,    74,     1,    14,    58,    75,     5,     6,    44,    76,
      96,    97,    83,    78,   -66,    44,    75,    30,     4,    81,
       3,    20,    84,    89,    44,    17,    90,    92,    93,    21,
      44,    26,    28,    44,    94,    95,    96,    97,    27,   101,
     102,    54,    57,    33,   103,    34,    35,    36,    37,    56,
      85,    94,    95,    96,    97,    98,    99,   142,   122,   123,
     124,   125,   126,   127,   128,    94,    95,    96,    97,    98,
      99,    38,    59,     5,     6,     7,    60,    62,   131,   136,
     137,   138,   139,   140,   141,    63,    61,   130,    77,    44,
      64,    94,    95,    96,    97,    98,    99,    65,    28,    66,
      67,    79,   114,    80,    82,    88,   149,    85,    94,    95,
      96,    97,    98,    99,   100,   115,   116,   117,   118,   119,
     120,   106,   104,   105,   146,   108,   107,    94,    95,    96,
      97,    98,    99,   113,   110,   111,   121,   -45,   132,    94,
      95,    96,    97,    98,    99,   133,   135,   144,   145,    55,
     148,   134,    32,   150,    29
};

static const yytype_uint8 yycheck[] =
{
       9,    37,     3,     7,    31,    18,     4,     5,    24,    22,
      25,    26,    48,    40,    16,    31,    18,    21,     0,    46,
      20,    18,    49,    59,    40,    36,    62,    63,    64,     7,
      46,    14,    37,    49,    23,    24,    25,    26,    15,    75,
      76,    16,    36,     8,    80,    10,    11,    12,    13,    19,
      54,    23,    24,    25,    26,    27,    28,    15,    94,    95,
      96,    97,    98,    99,   100,    23,    24,    25,    26,    27,
      28,    36,    16,     4,     5,     6,    16,    16,   105,   115,
     116,   117,   118,   119,   120,    24,    36,    19,    21,   105,
      29,    23,    24,    25,    26,    27,    28,    36,    37,    38,
      39,    14,    17,    22,     9,    21,   142,   111,    23,    24,
      25,    26,    27,    28,    16,    30,    31,    32,    33,    34,
      35,    17,    21,    20,   133,    36,    21,    23,    24,    25,
      26,    27,    28,    17,    17,    14,    17,     9,    20,    23,
      24,    25,    26,    27,    28,    20,    20,    17,    21,    27,
     134,   111,    23,   149,    20
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    42,    20,     0,     4,     5,     6,    45,    46,
      47,    48,    49,    50,    49,    43,    45,    36,    51,    84,
      18,     7,    52,    53,    54,    55,    14,    15,    37,    83,
      49,    44,    52,     8,    10,    11,    12,    13,    36,    61,
      62,    63,    64,    65,    66,    67,    68,    69,    70,    71,
      72,    73,    74,    75,    16,    51,    19,    36,    61,    16,
      16,    36,    16,    24,    29,    36,    38,    39,    66,    76,
      77,    81,    82,    83,    76,    18,    22,    21,    61,    14,
      22,    61,     9,    76,    61,    49,    56,    58,    21,    76,
      76,    80,    76,    76,    23,    24,    25,    26,    27,    28,
      16,    76,    76,    76,    21,    20,    17,    21,    36,    59,
      17,    14,    57,    17,    17,    30,    31,    32,    33,    34,
      35,    17,    76,    76,    76,    76,    76,    76,    76,    78,
      19,    61,    20,    20,    58,    20,    76,    76,    76,    76,
      76,    76,    15,    79,    17,    21,    45,    60,    57,    76,
      79
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    41,    42,    43,    44,    45,    45,    46,    47,    47,
      48,    49,    49,    50,    51,    51,    52,    52,    53,    54,
      55,    56,    56,    57,    57,    58,    59,    60,    60,    61,
      61,    62,    62,    63,    63,    63,    63,    64,    64,    65,
      65,    66,    67,    67,    68,    69,    70,    71,    72,    73,
      74,    75,    76,    76,    76,    76,    76,    76,    76,    76,
      76,    76,    76,    76,    76,    76,    77,    78,    78,    79,
      79,    80,    80,    80,    80,    80,    80,    81,    81,    82,
      82,    83,    84
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     8,     0,     0,     1,     2,     3,     1,     1,
       1,     1,     1,     5,     1,     3,     2,     0,     3,     6,
       3,     2,     0,     3,     0,     2,     1,     1,     0,     1,
       2,     2,     1,     1,     1,     1,     1,     1,     1,     3,
       3,     4,     5,     3,     5,     3,     2,     4,     3,     2,
       2,     2,     3,     3,     3,     3,     2,     3,     3,     2,
       1,     1,     3,     3,     1,     4,     1,     2,     0,     3,
       0,     3,     3,     3,     3,     3,     3,     1,     1,     1,
       1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 145 "src/alfa.y" /* yacc.c:1646  */
    {
	//TODO liberar las tablas de simbolos en caso de compilacion correcta
		escribir_fin(output);
		fprintf(output, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");
	}
#line 1448 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 157 "src/alfa.y" /* yacc.c:1646  */
    {
		escribir_subseccion_data(output);
		escribir_cabecera_bss(output);
		printTablaGlobal(output);
		escribir_segmento_codigo(output);
		fprintf(output, ";Rescritura1:\t <escritura1> ::= \n");
	}
#line 1460 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 171 "src/alfa.y" /* yacc.c:1646  */
    {
		escribir_inicio_main(output);
	}
#line 1468 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 181 "src/alfa.y" /* yacc.c:1646  */
    {
		fprintf(output, ";R2:\t<declaraciones> ::= <declaracion>\n");
	}
#line 1476 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 184 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
#line 1482 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 187 "src/alfa.y" /* yacc.c:1646  */
    {
		fprintf(output, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");
	}
#line 1490 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 197 "src/alfa.y" /* yacc.c:1646  */
    {
		clase_actual = ESCALAR;
		fprintf(output, ";R5:\t<clase> ::= <clase_escalar>\n");
	}
#line 1499 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 201 "src/alfa.y" /* yacc.c:1646  */
    {
		clase_actual = VECTOR;
		fprintf(output, ";R7:\t<clase> ::= <clase_vector>\n");
	}
#line 1508 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 213 "src/alfa.y" /* yacc.c:1646  */
    {
		tam_actual = 1;
		fprintf(output, ";R9:\t<clase_escalar> ::= <tipo>\n");
		}
#line 1517 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 224 "src/alfa.y" /* yacc.c:1646  */
    {
		tipo_actual = ENTERO;
		fprintf(output, ";R10:\t<tipo> ::= int\n");
	}
#line 1526 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 228 "src/alfa.y" /* yacc.c:1646  */
    {
		tipo_actual = BOOLEANO;
		fprintf(output, ";R11:\t<tipo> ::= boolean\n");
	}
#line 1535 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 240 "src/alfa.y" /* yacc.c:1646  */
    {
		//README, el tipo del vector se guarda en la variable global tipo_actual al reducir la regla "tipo" que es $2 en este caso
		//		por hacer analogía a como lo manejamos en clase_escalar, no hacemos nada con "tipo", pues ya haremos uso de tipo_actual al insertar en la tabla de simbolos
		if((yyvsp[-1].atributos).valor_entero > MAX_TAM_VECTOR){
			return yyerror("error semantico: tamano de vector demasiado grande");
		} else if((yyvsp[-1].atributos).valor_entero <= 0){
			return yyerror("error semantico: tamano de vector demasiado pequeno");
		}
		tam_actual = (yyvsp[-1].atributos).valor_entero;
		fprintf(output, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
		}
#line 1551 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 258 "src/alfa.y" /* yacc.c:1646  */
    {
			fprintf(output, ";R18:\t<identificadores> ::= <identificador>\n");
		}
#line 1559 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 261 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
#line 1565 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 270 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R:20\t<funciones> ::= <funcion> <funciones>\n");}
#line 1571 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 271 "src/alfa.y" /* yacc.c:1646  */
    {
		fprintf(output, ";R21:\t<funciones> ::= \n");
	}
#line 1579 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 282 "src/alfa.y" /* yacc.c:1646  */
    {
		INFO_SIMBOLO *info;
		setAmbito(GLOBAL);
		info = buscar((yyvsp[-2].atributos).lexema);
		if(info == NULL){
			return yyerror("FATAL ERROR: encontrar el identificador de una funcion!!");
		}
		info->n_param = num_parametros_actual;
		info->n_locales = num_variables_local_actual;
		if(num_retornos == 0){
			fprintf(stderr, "\nWARNING: no hay retorno de funcion %s\n", (yyvsp[-2].atributos).lexema);
			escribir_fin_funcion(output);
		}
		//info->n_param = num_parametros_actual;
		num_retornos = 0;
		fprintf(output, ";R22:\t<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }\n");
}
#line 1601 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 300 "src/alfa.y" /* yacc.c:1646  */
    {
	INFO_SIMBOLO * info = buscar((yyvsp[-5].atributos).lexema);
	if(info == NULL){
		return yyerror("FATAL ERROR: encontrar el identificador de una funcion!!");
	}
	info->n_param = num_parametros_actual;
	info->n_locales = num_variables_local_actual;
	//TODO generar codigo comienzo funcion
	escribir_principio_funcion(output, info->lexema);
	declarar_locales(output, num_variables_local_actual);
	printf("simbolo encontrado: %s\nn_param: %d\nn_local: %d\n", info->lexema, info->n_param, info->n_locales);
	strcpy((yyval.atributos).lexema, (yyvsp[-5].atributos).lexema);
}
#line 1619 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 314 "src/alfa.y" /* yacc.c:1646  */
    {
	INFO_SIMBOLO * info;
	info = buscar((yyvsp[0].atributos).lexema);
	if(info != NULL){
		return yyerror("error semantico: nombre de identificador ya usado");
	}
	//README asumo que la clase de la funcion es siempre escalar
	//README segun las transparencias: en un principio la informacion disponible ahora mismo del id de la funcion es solo el tipo del retorno.
	//			mas adelante se completara esta informacion
	insertar((yyvsp[0].atributos).lexema, FUNCION, tipo_actual, ESCALAR, 1, 0, 0, 0, 0);
	//README importante: si insertas un funcion esta es automaticamente insertada en el ambito global y luego en el local!! ademas te deja el ambito a LOCAL
	//setAmbito(LOCAL);
	//antes hemos insertado en el ambito global pero tambien hay que insertar en el ambito local el id de la funcion
	//insertar($3.lexema, FUNCION, tipo_actual, ESCALAR, 1, 0, 0, 0, 0);
	//seteamos las variables que llevan la cuenta de numeros y posiciones variables locales y parametros
	num_variables_local_actual = 0;
	pos_variable_local_actual = 1;
	num_parametros_actual = 0;
	pos_parametro_actual = 0;
	num_retornos = 0;
	clase_actual = ESCALAR;

	strcpy((yyval.atributos).lexema, (yyvsp[0].atributos).lexema);
}
#line 1648 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 344 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
#line 1654 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 345 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R24:\t<parametros_funcion> ::= \n");}
#line 1660 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 354 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
#line 1666 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 355 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R26:\t<resto_parametros_funcion> ::= \n");}
#line 1672 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 364 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R:27\t<parametro_funcion> ::= <tipo> <identificador>\n");}
#line 1678 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 367 "src/alfa.y" /* yacc.c:1646  */
    {
	INFO_SIMBOLO * info;
	info = buscar((yyvsp[0].atributos).lexema);
	if (info != NULL){
		return yyerror("error semantico: identificador ya utilizado");
	}
	
	//README la clase de un parametro puede ser vector? en principio voy a asumir que no
	//README realmente en esta insercion, el num_parametros_actual no hace falta insertarlo (porque es info para la funcion)
	if(insertar((yyvsp[0].atributos).lexema, PARAMETRO, tipo_actual, ESCALAR, 1, -1, -1, num_parametros_actual, pos_parametro_actual) == ERR)
		return yyerror("error al insertar en la tabla de simbolos");
	num_parametros_actual++;
	pos_parametro_actual++;
}
#line 1697 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 388 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
#line 1703 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 389 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R29:\t<declaraciones_funcion> ::= \n");}
#line 1709 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 408 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R30:\t<sentencias> ::= <sentencia>\n");}
#line 1715 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 409 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
#line 1721 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 418 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
#line 1727 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 419 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R33:\t<sentencia> ::= <bloque>\n");}
#line 1733 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 428 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
#line 1739 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 429 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
#line 1745 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 430 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
#line 1751 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 431 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
#line 1757 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 440 "src/alfa.y" /* yacc.c:1646  */
    {
		//TODO escribir final del bloque (?)
		fprintf(output, ";R40:\t<bloque> ::= <condicional>\n");
		}
#line 1766 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 444 "src/alfa.y" /* yacc.c:1646  */
    {
		//TODO escribir final del bloque (?)
		fprintf(output, ";R41:\t<bloque> ::= <bucle>\n");
		}
#line 1775 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 456 "src/alfa.y" /* yacc.c:1646  */
    {
			INFO_SIMBOLO* info = buscar((yyvsp[-2].atributos).lexema);
			if(info == NULL){
				return yyerror(ERROR_SEMANTICO);
			} else if(info->categoria == FUNCION){
				return yyerror("error semantico: asignacion a funcion");
			} else if(info->clase == VECTOR){
				return yyerror("error semantico: asignacion de clases incompatibles");
			} else if(info->tipo != (yyvsp[0].atributos).tipo){
				return yyerror("error semantico: asignacion de tipos incompatibles");
			} else if(info->categoria == PARAMETRO){
				return yyerror("error semantico: asignacion de a un parametro prohibida");
			} else if (getAmbito() == GLOBAL){
				asignar(output, (yyvsp[-2].atributos).lexema, (yyvsp[0].atributos).es_direccion);
			} else {//estamos asignando una variable local
				asignar_local(output, info->pos_local, (yyvsp[0].atributos).es_direccion);
			}
			fprintf(output, ";R43:\t<asignacion> ::= <identificador> = <exp>\n");
		}
#line 1799 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 475 "src/alfa.y" /* yacc.c:1646  */
    {
			INFO_SIMBOLO* info = buscar((yyvsp[-2].atributos).lexema);
			if(info == NULL){
				return yyerror(ERROR_SEMANTICO);
			} else if(info->categoria == FUNCION){
				return yyerror("error semantico: asignacion a funcion");
			} else if(info->clase == ESCALAR){
				return yyerror("error semantico: asignacion de clases incompatibles");
			} else if(info->tipo != (yyvsp[0].atributos).tipo){
				return yyerror("error semantico: asignacion de tipos incompatibles");
			}
			asignar_vector(output, (yyvsp[0].atributos).es_direccion);
			fprintf(output, ";R43.2:\t<asignacion> ::= <elemento_vector> = <exp>\n");
		}
#line 1818 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 496 "src/alfa.y" /* yacc.c:1646  */
    {
		//cuando nos encontramos con un elemento vector, tenemos que comprobar que exp
		//entra dentro del rango del vector. En caso contrario, saltar a la gesiton del
		//error. Por ello, printeamos el siguiente codigo ensamblador
		INFO_SIMBOLO* info = buscar((yyvsp[-3].atributos).lexema);
		if(info == NULL){
			return yyerror("error semantico: no existe el elemento_vector");
		} else if(getAmbito() == LOCAL){
			return yyerror("error semantico: no se puden utilizar parametros o variables locales como vectores");
		} else {
			escribir_elemento_vector(output, (yyvsp[-3].atributos).lexema, (yyvsp[-1].atributos).es_direccion, info->tam-1);//el -1 es porque el array va desde 0 hasta tamanio-1. En la generacion de codigo no se gestiona esa logica
			(yyval.atributos).es_direccion = TRUE;
		}
		fprintf(output, ";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
		}
#line 1838 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 518 "src/alfa.y" /* yacc.c:1646  */
    {
			escribir_end_else(output, (yyvsp[-4].atributos).etiqueta);
			fprintf(output, ";\t<condicional> ::= <if_exp_sentencias> else { <sentencias> } ");
		}
#line 1847 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 522 "src/alfa.y" /* yacc.c:1646  */
    {
			escribir_end_if(output, (yyvsp[-2].atributos).etiqueta);
			fprintf(output, ";\t<condicional> ::= <if_exp> }\n");
		}
#line 1856 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 527 "src/alfa.y" /* yacc.c:1646  */
    {
		//TODO transparencias en torno a la 59
		//comprobamos que sea distinto de cero.
		//si no se cumple, saltamos al final del if
		//ejecutamos instrucciones de dentro del if
		//final del if
		if((yyvsp[-2].atributos).tipo != BOOLEANO)
			return yyerror("error semantico: condicion no booleana");
		(yyval.atributos).etiqueta = cuantos++;
		escribir_if(output, (yyvsp[-2].atributos).es_direccion, (yyval.atributos).etiqueta);
		fprintf(output, ";R50:\t<if_exp> ::= if ( <exp> ) { \n");
		}
#line 1873 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 540 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).etiqueta = (yyvsp[-2].atributos).etiqueta;
		escribir_else(output, (yyval.atributos).etiqueta);
		fprintf(output, ";R50:\t<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>\n");
		}
#line 1883 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 551 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).etiqueta = cuantos++;
		escribir_inicio_while(output, (yyval.atributos).etiqueta);
		//TODO generacion codigo
	}
#line 1893 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 557 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != BOOLEANO){
			return yyerror("error semantico: condicion de while no es booleana");
		}
		(yyval.atributos).etiqueta = (yyvsp[-3].atributos).etiqueta;
		escribir_condicion_while(output, (yyvsp[-2].atributos).es_direccion, (yyval.atributos).etiqueta);
	}
#line 1905 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 565 "src/alfa.y" /* yacc.c:1646  */
    {
	escribir_fin_while(output, (yyvsp[-2].atributos).etiqueta);
	fprintf(output, ";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
	}
#line 1914 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 573 "src/alfa.y" /* yacc.c:1646  */
    {
	INFO_SIMBOLO* aux = buscar((yyvsp[0].atributos).lexema);
	if(!aux){
		return yyerror("error semantico: variable sin declarar");
	} else if(aux->clase != ESCALAR){
		return yyerror("error semantico: ");
	} else if (aux->categoria != VARIABLE){
		return yyerror("error semantico: ");
	}
	leer(output, (yyvsp[0].atributos).lexema, (yyvsp[0].atributos).tipo);
	fprintf(output, ";R54:\t<lectura> ::= scanf <identificador>\n");
	}
#line 1931 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 592 "src/alfa.y" /* yacc.c:1646  */
    {
	escribir(output, (yyvsp[0].atributos).es_direccion, (yyvsp[0].atributos).tipo);
	fprintf(output, ";R56:\t<escritura> ::= printf <exp>\n");
	}
#line 1940 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 603 "src/alfa.y" /* yacc.c:1646  */
    {
		fprintf(output, ";R61:\t<retorno_funcion> ::= return <exp>\n");
		num_retornos = 1;
		escribir_fin_funcion(output);
	}
#line 1950 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 615 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: suma de tipos incompatibles");
		}
		sumar(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = ENTERO;
		fprintf(output, ";R72:\t<exp> ::= <exp> + <exp>\n");
		}
#line 1964 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 624 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: resta de tipos incompatibles");
		}
		restar(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = ENTERO;
		fprintf(output, ";R73:\t<exp> ::= <exp> - <exp>\n");}
#line 1977 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 632 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: division de tipos incompatibles");
		}
		dividir(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = ENTERO;
		fprintf(output, ";R74:\t<exp> ::= <exp> / <exp>\n");}
#line 1990 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 640 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		multiplicar(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = ENTERO;
		fprintf(output, ";R75:\t<exp> ::= <exp> * <exp>\n");}
#line 2003 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 648 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[0].atributos).tipo != ENTERO){
			return yyerror("error semantico: cambio de signo de tipo incompatible");
		}
		cambiar_signo(output, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = ENTERO;
		fprintf(output, ";R76:\t<exp> ::= - <exp>\n");
		}
#line 2017 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 657 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != BOOLEANO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		y(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R77:\t<exp> ::= <exp> && <exp>\n");
		}
#line 2031 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 666 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != BOOLEANO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		o(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion);
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R78:\t<exp> ::= <exp> || <exp>\n");
		}
#line 2045 "y.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 675 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[0].atributos).tipo != BOOLEANO){
			return yyerror("error semantico: negacion de tipos incompatibles");
		}
		no(output, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R79:\t<exp> ::= ! <exp>\n");
		}
#line 2060 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 685 "src/alfa.y" /* yacc.c:1646  */
    {
		//TODO comprobar si estamos en lista de expresiones (llamada a funcion) o no
		INFO_SIMBOLO* info = buscar((yyvsp[0].atributos).lexema);
		if(info == NULL){
			return yyerror("error semantico: identificador sin declarar");
		}
		else if(info->categoria == FUNCION){
			return yyerror("error semantico: el identificador es una funcion");
		} else if(info->clase == VECTOR){
			return yyerror("error semantico: el identificador es un vector");
		}
		(yyval.atributos).tipo = info->tipo;
		(yyval.atributos).es_direccion = TRUE;
		if(getAmbito()== GLOBAL) {//si no estamos en una llamada a funcion y el ambito es global
			escribir_operando(output, (yyvsp[0].atributos).lexema, TRUE);
		} else {
			if(info->categoria == VARIABLE){//si no estamos en una llamada a funcion pero la variable es local
				escribir_operando_local(output, info->pos_local);
			} else {//si no estamos en una llamada a funcion pero la variable es un parametro
				escribir_operando_parametro(output, num_parametros_actual, info->pos_param);
			}
		}
		if(en_exp_list){
			(yyval.atributos).es_direccion = FALSE;
			escribir_contenido_del_top(output);
		}
		fprintf(output, ";R80:\t<exp> ::= <identificador>\n");
		}
#line 2093 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 713 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = (yyvsp[0].atributos).tipo;
		(yyval.atributos).es_direccion = (yyvsp[0].atributos).es_direccion;
		fprintf(output, ";R81:\t<exp> ::= <constante>\n");
	}
#line 2103 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 718 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = (yyvsp[-1].atributos).tipo;
		(yyval.atributos).es_direccion = (yyvsp[-1].atributos).es_direccion;
		fprintf(output, ";R82:\t<exp> ::= ( <exp> )\n");
		}
#line 2113 "y.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 723 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = (yyvsp[-1].atributos).tipo;
		(yyval.atributos).es_direccion = (yyvsp[-1].atributos).es_direccion;
		fprintf(output, ";R83:\t<exp> ::= ( <comparacion> )\n");
		}
#line 2123 "y.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 728 "src/alfa.y" /* yacc.c:1646  */
    {
		//TODO comprobar si estamos en lista de expresiones (llamada a funcion) o no
		(yyval.atributos).tipo = (yyvsp[0].atributos).tipo;
		if (en_exp_list){//si estamos en la llamada a una funcion
			//README hay que indicar que ahora lo que hay en la cima de la pila no es una direccion
			(yyval.atributos).es_direccion = FALSE;
			escribir_contenido_del_top(output);
		} else {
			(yyval.atributos).es_direccion = (yyvsp[0].atributos).es_direccion;
		}
		fprintf(output, ";R85:\t<exp> ::= <elemento_vector>\n");
		}
#line 2140 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 740 "src/alfa.y" /* yacc.c:1646  */
    {
		INFO_SIMBOLO* info = buscar((yyvsp[-3].atributos).lexema);
		printf("simbolo encontrado: %s\nn_param: %d\nn_local: %d\n", info->lexema, info->n_param, info->n_locales);
		printf("numero esperado: %d\nnumero resultante: %d\n", info->n_param, (yyvsp[-1].atributos).valor_entero);
		if(info == NULL){
			return yyerror("error semantico: funcion sin declarar");
		} else if(info->categoria != FUNCION){
			return yyerror("error semantico: no es una funcion");
		} else if(info->n_param != (yyvsp[-1].atributos).valor_entero){//README usamos valor entero en este caso para almacenar el numero de expresiones de lista_expresiones
			return yyerror("error semantico: numero de argumentos erroneo en la llamada a la funcion");
		}
		escribir_llamada_funcion(output, info->lexema, info->n_param);
		(yyval.atributos).tipo = info->tipo;
		(yyval.atributos).es_direccion = FALSE;
		en_exp_list = FALSE;//marcamos el flag a false para indicar que hemos terminado de procesar la lista de expresiones
		fprintf(output, ";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");
	}
#line 2162 "y.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 759 "src/alfa.y" /* yacc.c:1646  */
    {
	//TODO mirar tabla de simbolos el nombre del id (que sera la funcion)
	strcpy((yyval.atributos).lexema, (yyvsp[0].atributos).lexema);
	en_exp_list = TRUE;
}
#line 2172 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 772 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).valor_entero = 1 + (yyvsp[0].atributos).valor_entero;
		fprintf(output, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");
		}
#line 2181 "y.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 776 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).valor_entero = 0;
		fprintf(output, ";R90:\t<lista_expresiones> ::=\n");
		}
#line 2190 "y.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 788 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R91:\t<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>\n");}
#line 2196 "y.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 789 "src/alfa.y" /* yacc.c:1646  */
    {fprintf(output, ";R92:\t<resto_lista_expresiones> ::=\n");}
#line 2202 "y.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 798 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		igual(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
		}
#line 2217 "y.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 808 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		distinto(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
		}
#line 2232 "y.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 818 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		menor_igual(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
		}
#line 2247 "y.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 828 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		mayor_igual(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
		}
#line 2262 "y.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 838 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		menor(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;
		fprintf(output, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
		}
#line 2277 "y.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 848 "src/alfa.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].atributos).tipo != (yyvsp[0].atributos).tipo || (yyvsp[-2].atributos).tipo != ENTERO){
			return yyerror("error semantico: comparacion de tipos incompatibles");
		}
		mayor(output, (yyvsp[-2].atributos).es_direccion, (yyvsp[0].atributos).es_direccion, cuantos);
		cuantos++;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).tipo = BOOLEANO;fprintf(output, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
		}
#line 2291 "y.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 865 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = (yyvsp[0].atributos).tipo;
		(yyval.atributos).es_direccion = (yyvsp[0].atributos).es_direccion;
		fprintf(output, ";R99:\t<constante> ::= <constante_logica>\n");
		}
#line 2301 "y.tab.c" /* yacc.c:1646  */
    break;

  case 78:
#line 870 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = (yyvsp[0].atributos).tipo;
		(yyval.atributos).es_direccion = (yyvsp[0].atributos).es_direccion;
		fprintf(output, ";R100:\t<constante> ::= <constante_entera>\n");
	}
#line 2311 "y.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 883 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = BOOLEANO;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).valor_entero = TRUE;
		escribir_operando(output, "1", 0);
		fprintf(output, ";R102:\t<constante_logica> ::= true\n");
		}
#line 2323 "y.tab.c" /* yacc.c:1646  */
    break;

  case 80:
#line 890 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = BOOLEANO;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).valor_entero = FALSE;
		escribir_operando(output, "0", 0);
		fprintf(output, ";R103:\t<constante_logica> ::= false\n");
		}
#line 2335 "y.tab.c" /* yacc.c:1646  */
    break;

  case 81:
#line 905 "src/alfa.y" /* yacc.c:1646  */
    {
		(yyval.atributos).tipo = ENTERO;
		(yyval.atributos).es_direccion = FALSE;
		(yyval.atributos).valor_entero = (yyvsp[0].atributos).valor_entero;
		escribir_operando(output, (yyvsp[0].atributos).lexema, 0);//README $1.lexema es un truco sucio para no jugar con memoria
		fprintf(output, ";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
	}
#line 2347 "y.tab.c" /* yacc.c:1646  */
    break;

  case 82:
#line 919 "src/alfa.y" /* yacc.c:1646  */
    {
		AMBITO amb = getAmbito();
		fprintf(output, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
		if (buscar((yyvsp[0].atributos).lexema)){
			return yyerror("ya existe ese identificador!!");
		}
		else{
			if(amb == GLOBAL){
				if(insertar((yyvsp[0].atributos).lexema, VARIABLE, tipo_actual, clase_actual, tam_actual, -1, -1, -1, -1) == ERR)
					return yyerror("acho que no inserta!\n");
			} else {
				//tratamos de insertar una variable local
				if(insertar((yyvsp[0].atributos).lexema, VARIABLE, tipo_actual, clase_actual, tam_actual, num_variables_local_actual, pos_variable_local_actual, -1, -1) == ERR)
					return yyerror("acho que no inserta!\n");
				//actualizamos las variables que llevan la cuenta de las posiciones y numeros de las variables locales
				pos_variable_local_actual++;
				num_variables_local_actual++;
			}
		}
	}
#line 2372 "y.tab.c" /* yacc.c:1646  */
    break;


#line 2376 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 940 "src/alfa.y" /* yacc.c:1906  */
