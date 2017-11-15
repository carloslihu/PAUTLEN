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

programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(output, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");}

declaraciones: declaracion {fprintf(output, ";R2:\t<declaraciones> ::= <declaracion>\n");}
	| declaracion declaraciones {fprintf(output, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
	;

declaracion: clase identificadores TOK_PUNTOYCOMA {fprintf(output, ";R4:\t<declaracion> ::= <clase> <identificadores>\n");}

clase: clase_escalar {fprintf(output, ";R5:\t<clase> ::= <clase_escalar>\n");}
	| clase_vector {fprintf(output, ";R7:\t<clase> ::= <clase_vector>\n");}
	;

clase_escalar: tipo {fprintf(output, ";R9:\t<clase_escalar> ::= <tipo>\n");}

tipo: TOK_INT {fprintf(output, ";R10:\t<tipo> ::= int\n");}
	| TOK_BOOLEAN {fprintf(output, ";R11:\t<tipo> ::= boolean\n");}
	;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {fprintf(output, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");}

identificadores: identificador {fprintf(output, ";R18:\t<identificadores> ::= <identificador>\n");}
	| identificador TOK_COMA identificadores {fprintf(output, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
	;

funciones: funcion funciones {fprintf(output, ";R:20\t<funciones> ::= <funcion> <funciones>\n");}
	| {fprintf(output, ";R:\t<funciones> ::= \n");}
	;

funcion: TOK_FUNCTION tipo identificador TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA declaraciones_funcion sentencias TOK_LLAVEDERECHA {fprintf(output, ";R22:\t<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }\n");}

parametros_funcion: parametro_funcion resto_parametros_funcion {fprintf(output, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
	| {fprintf(output, ";R24:\t<parametros_funcion> ::= \n");}
	;

resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(output, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
	| {fprintf(output, ";R26:\t<resto_parametros_funcion> ::= \n");}
	;

parametro_funcion: tipo identificador {fprintf(output, ";R:27\t<parametro_funcion> ::= <tipo> <identificador>\n");}

declaraciones_funcion: declaraciones {fprintf(output, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
	| {fprintf(output, ";R29:\t<declaraciones_funcion> ::= \n");}
	;

sentencias: sentencia {fprintf(output, ";R30:\t<sentencias> ::= <sentencia>\n");}
	| sentencia sentencias {fprintf(output, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
	;

sentencia: sentencia_simple TOK_PUNTOYCOMA {fprintf(output, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
	| bloque {fprintf(output, ";R33:\t<sentencia> ::= <bloque>\n");}
	;

sentencia_simple: asignacion {fprintf(output, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
	| lectura {fprintf(output, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
	| escritura {fprintf(output, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
	| retorno_funcion {fprintf(output, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
	;

bloque: condicional {fprintf(output, ";R40:\t<bloque> ::= <condicional>\n");}
	| bucle {fprintf(output, ";R41:\t<bloque> ::= <bucle>\n");}
	;

asignacion: identificador TOK_ASIGNACION exp {fprintf(output, ";R43:\t<asignacion> ::= <identificador> = <exp>\n");}
	| elemento_vector TOK_ASIGNACION exp {fprintf(output, ";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");}
	;

elemento_vector: identificador TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO {fprintf(output, ";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");}

condicional: TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");}
	| TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");}
	;

bucle: TOK_WHILE TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");}

lectura: TOK_SCANF identificador {fprintf(output, ";R54:\t<lectura> ::= scanf <identificador>\n");}

escritura: TOK_PRINTF exp {fprintf(output, ";R56:\t<escritura> ::= printf <exp>\n");}

retorno_funcion: TOK_RETURN exp {fprintf(output, ";R61:\t<retorno_funcion> ::= return <exp>\n");}

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