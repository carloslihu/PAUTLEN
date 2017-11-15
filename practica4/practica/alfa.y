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

exp: exp TOK_MAS exp  {fprintf(output,";R72:\t<exp> ::= <exp> + <exp>\n")}
	| exp TOK_MENOS exp {fprintf(output,";R73:\t<exp> ::= <exp> - <exp>\n")}
	| exp TOK_DIVISION exp {fprintf(output,";R74:\t<exp> ::= <exp> / <exp>\n")}
	| exp TOK_ASTERISCO exp {fprintf(output,";R75:\t<exp> ::= <exp> * <exp>\n")}
	| TOK_MENOS exp %prec MENOSU {fprintf(output,";R76:\t<exp> ::= - <exp>\n")}
	| exp TOK_AND exp {fprintf(output,";R77:\t<exp> ::= <exp> && <exp>\n")}
	| exp TOK_OR exp {fprintf(output,";R78:\t<exp> ::= <exp> || <exp>\n")}
	| TOK_NOT exp {fprintf(output,";R79:\t<exp> ::= ! <exp>\n")}
	| identificador {fprintf(output,";R80:\t<exp> ::= <identificador>\n")}
	| constante {fprintf(output,";R81:\t<exp> ::= <constante>\n")}
	| TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO {fprintf(output,";R82:\t<exp> ::= ( <exp> )\n")}
	| TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO {fprintf(output,";R83:\t<exp> ::= ( <comparacion> )\n")}
	| elemento_vector {fprintf(output,";R85:\t<exp> ::= <elemento_vector>\n")}
	| identificador TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {fprintf(output,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n")}
	;

lista_expresiones: exp resto_lista_expresiones {fprintf(output,";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n")}
	| {fprintf(output,";R90:\t<lista_expresiones> ::=\n")}
	;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones {fprintf(output,";R91:\t<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>\n")}
	| {fprintf(output,";R92:\t<resto_lista_expresiones> ::=\n")}
	;

comparacion: exp TOK_IGUAL exp {fprintf(output,";R93:\t<comparacion> ::= <exp> == <exp>\n")}
	| exp TOK_DISTINTO exp {fprintf(output,";R94:\t<comparacion> ::= <exp> != <exp>\n")}
	| exp TOK_MENORIGUAL exp {fprintf(output,";R95:\t<comparacion> ::= <exp> <= <exp>\n")}
	| exp TOK_MAYORIGUAL exp {fprintf(output,";R96:\t<comparacion> ::= <exp> >= <exp>\n")}
	| exp TOK_MENOR exp {fprintf(output,";R97:\t<comparacion> ::= <exp> < <exp>\n")}
	| exp TOK_MAYOR exp {fprintf(output,";R98:\t<comparacion> ::= <exp> > <exp>\n")}
	;

constante: constante_logica {fprintf(output,";R99:\t<constante> ::= <constante_logica>\n")}
	| constante_entera {fprintf(output,";R100:\t<constante> ::= <constante_entera>\n")}
	;

constante_logica: TOK_TRUE {fprintf(output, ";R102:\t<constante_logica> ::= true\n");}
	| TOK_FALSE {fprintf(output, ";R103:\t<constante_logica> ::= false\n");}
	;

constante_entera: TOK_CONSTANTE_ENTERA {fprintf(output,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n")}

identificador: TOK_IDENTIFICADOR {fprintf(output, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");}

%%