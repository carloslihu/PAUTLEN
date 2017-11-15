%{
	#include <stdio.h>
	/*#include "tokens.h"*/
	#include "y.tab.h"
	extern FILE* output;

	int yyerror(char* s){
		if(yylval != TOK_ERROR)
			printf("%s\n", s);
		printf("\nEXPRESION INCORRECTA\n");
		return -1;
	}
%}


%token TOK_MAIN
%token TOK_INT
%token TOK_BOOLEAN
%token TOK_ARRAY
%token TOK_FUNCTION
%token TOK_IF
%token TOK_ELSE
%token TOK_WHILE
%token TOK_SCANF
%token TOK_PRINTF
%token TOK_RETURN

%token TOK_PUNTOYCOMA
%token TOK_COMA
%token TOK_PARENTESISIZQUIERDO
%token TOK_PARENTESISDERECHO
%token TOK_CORCHETEIZQUIERDO
%token TOK_CORCHETEDERECHO
%token TOK_LLAVEIZQUIERDA
%token TOK_LLAVEDERECHA
%token TOK_ASIGNACION
%token TOK_MAS
%token TOK_MENOS
%token TOK_DIVISION
%token TOK_ASTERISCO
%token TOK_AND
%token TOK_OR
%token TOK_NOT
%token TOK_IGUAL
%token TOK_DISTINTO
%token TOK_MENORIGUAL
%token TOK_MAYORIGUAL
%token TOK_MENOR
%token TOK_MAYOR

%token TOK_IDENTIFICADOR

%token TOK_CONSTANTE_ENTERA
%token TOK_TRUE
%token TOK_FALSE

%token TOK_ERROR



%left TOK_RETURN
%left TOK_ASIGNACION
%left TOK_IGUAL TOK_DISTINTO TOK_MENORIGUAL TOK_MAYORIGUAL TOK_MENOR TOK_MAYOR
%left TOK_AND TOK_OR
%left TOK_MAS TOK_MENOS
%left TOK_ASTERISCO TOK_DIVISION
%right MENOSU TOK_NOT


%%

S: programa {printf("\nEXPRESION CORRECTA\n");}

programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(output, ";R1:\tmain { <declaraciones> <funciones> <sentencias> }\n");}

declaraciones: declaracion {printf("REGLA: declaracion\n");}
	| declaracion declaraciones {printf("REGLA: declaraciones\n");}
	;

declaracion: clase identificadores TOK_PUNTOYCOMA {printf("REGLA: clase identificadores ;\n");}

clase: clase_escalar {printf("REGLA: clase_escalar\n");}
	| clase_vector {printf("REGLA: clase_vector\n");}
	;

clase_escalar: tipo {printf("REGLA: tipo\n");}

tipo: TOK_INT
	| TOK_BOOLEAN
	;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO

identificadores: identificador
	| identificador TOK_COMA identificadores
	;

funciones: funcion funciones
	|
	;

funcion: TOK_FUNCTION tipo identificador TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA declaraciones_funcion sentencias TOK_LLAVEDERECHA

parametros_funcion: tipo identificador

declaraciones_funcion: declaraciones
	|


	;

sentencias: sentencia
	| sentencia sentencias
	;

sentencia: sentencia_simple TOK_PUNTOYCOMA
	| bloque
	;

sentencia_simple: asignacion
	| lectura
	| escritura
	| retorno_funcion
	;

bloque: condicional
	| bucle
	;

asignacion: identificador TOK_ASIGNACION exp
	| elemento_vector TOK_ASIGNACION exp
	;

elemento_vector: identificador TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO

condicional: TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA
	| TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA
	;

bucle: TOK_WHILE TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA

lectura: TOK_SCANF identificador

escritura: TOK_PRINTF exp

retorno_funcion: TOK_RETURN exp

exp: exp TOK_MAS exp  {printf("REGLA: exp: exp + exp\n");}
	| exp TOK_MENOS exp {printf("REGLA: exp: exp - exp\n");}
	| exp TOK_ASTERISCO exp {printf("REGLA: exp: exp * exp\n");}
	| exp TOK_DIVISION exp {printf("REGLA: exp: exp / exp\n");}
	| TOK_MENOS exp %prec MENOSU {printf("REGLA: exp: - exp\n");}
	| exp TOK_AND exp
	| exp TOK_OR exp
	| TOK_NOT exp
	| identificador
	| constante
	| TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO {printf("REGLA: exp: (exp)\n");}
	| TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO
	| elemento_vector
	| identificador TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO
	;

lista_expresiones: exp resto_lista_expresiones
	|
	;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones
	|
	;

comparacion: exp TOK_IGUAL exp
	| exp TOK_DISTINTO exp
	| exp TOK_MENORIGUAL exp
	| exp TOK_MAYORIGUAL exp
	| exp TOK_MENOR exp
	| exp TOK_MAYOR exp
	;

constante: constante_entera
	| constante_logica
	;

constante_entera: TOK_CONSTANTE_ENTERA

constante_logica: TOK_TRUE
	| TOK_FALSE
	;

identificador: TOK_IDENTIFICADOR

%%