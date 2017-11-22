%{
	#include <stdio.h>
	/*#include "tokens.h"*/
	#include "../includes/alfa.h"
	#include "../includes/y.tab.h"
	
	//extern tipo_atributos yylval;
	extern FILE* output;
	extern int fil;
	extern int col;
	extern int yyleng;

	int yyerror(char* s){
		if(yylval.atributos.tipo != -1)
			fprintf(stderr, "****Error sintactico en [lin %d col %d]\n", fil, col-yyleng);
		return -1;
	}
%}

%union
{
	tipo_atributos atributos;
}

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

%token <atributos> TOK_IDENTIFICADOR

%token <atributos> TOK_CONSTANTE_ENTERA
%token <atributos> TOK_TRUE
%token <atributos> TOK_FALSE



%left TOK_RETURN
%left TOK_ASIGNACION
%left TOK_AND TOK_OR
%left TOK_IGUAL TOK_DISTINTO TOK_MENORIGUAL TOK_MAYORIGUAL TOK_MENOR TOK_MAYOR
%left TOK_MAS TOK_MENOS
%left TOK_ASTERISCO TOK_DIVISION
%right MENOSU TOK_NOT



%type <atributos> programa
%type <atributos> declaraciones
%type <atributos> declaracion
%type <atributos> clase
%type <atributos> clase_escalar
%type <atributos> tipo
%type <atributos> clase_vector
%type <atributos> identificadores
%type <atributos> funciones
%type <atributos> funcion
%type <atributos> parametros_funcion
%type <atributos> resto_parametros_funcion
%type <atributos> parametro_funcion
%type <atributos> declaraciones_funcion
%type <atributos> sentencias
%type <atributos> sentencia
%type <atributos> sentencia_simple
%type <atributos> bloque
%type <atributos> asignacion
%type <atributos> elemento_vector
%type <atributos> condicional
%type <atributos> bucle
%type <atributos> lectura
%type <atributos> escritura
%type <atributos> retorno_funcion
%type <atributos> exp
%type <atributos> lista_expresiones
%type <atributos> resto_lista_expresiones
%type <atributos> comparacion
%type <atributos> constante
%type <atributos> constante_logica
%type <atributos> constante_entera
%type <atributos> identificador




%%

programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(output, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");}

declaraciones: declaracion {fprintf(output, ";R2:\t<declaraciones> ::= <declaracion>\n");}
	| declaracion declaraciones {fprintf(output, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
	;

declaracion: clase identificadores TOK_PUNTOYCOMA {
		//TODO generar codigo de declarar variables
		$2.tipo = $1.tipo;
		fprintf(output, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");
	}

clase: clase_escalar {
		$$.tipo = $1.tipo;
		fprintf(output, ";R5:\t<clase> ::= <clase_escalar>\n");
		}
	| clase_vector {fprintf(output, ";R7:\t<clase> ::= <clase_vector>\n");}
	;

clase_escalar: tipo {fprintf(output, ";R9:\t<clase_escalar> ::= <tipo>\n");}

tipo: TOK_INT {
		$$.tipo = ENTERO;
		fprintf(output, ";R10:\t<tipo> ::= int\n");
		}
	| TOK_BOOLEAN {
		$$.tipo = BOOLEANO;
		fprintf(output, ";R11:\t<tipo> ::= boolean\n");
		}
	;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {fprintf(output, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");}

identificadores: identificador {
		$1.tipo = $$.tipo;
		fprintf(output, ";R18:\t<identificadores> ::= <identificador>\n");
		//TODO generar codigo de declarar variables
		//TODO arreglar fixme
		if(declararGlobal($1.lexema,  VARIABLE, ENTERO, ESCALAR, 0, 0))
			declarar_variable(output,$1.lexema, $1.tipo, 1);//FIXME el ultimo 1 de esta llamada debe ser el tamaño de la variable del identificador
		}
	| identificador TOK_COMA identificadores {fprintf(output, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
	;

funciones: funcion funciones {fprintf(output, ";R:20\t<funciones> ::= <funcion> <funciones>\n");}
	| {fprintf(output, ";R21:\t<funciones> ::= \n");}
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

exp: exp TOK_MAS exp  {fprintf(output,";R72:\t<exp> ::= <exp> + <exp>\n");}
	| exp TOK_MENOS exp {fprintf(output,";R73:\t<exp> ::= <exp> - <exp>\n");}
	| exp TOK_DIVISION exp {fprintf(output,";R74:\t<exp> ::= <exp> / <exp>\n");}
	| exp TOK_ASTERISCO exp {fprintf(output,";R75:\t<exp> ::= <exp> * <exp>\n");}
	| TOK_MENOS exp %prec MENOSU {fprintf(output,";R76:\t<exp> ::= - <exp>\n");}
	| exp TOK_AND exp {fprintf(output,";R77:\t<exp> ::= <exp> && <exp>\n");}
	| exp TOK_OR exp {fprintf(output,";R78:\t<exp> ::= <exp> || <exp>\n");}
	| TOK_NOT exp {fprintf(output,";R79:\t<exp> ::= ! <exp>\n");}
	| identificador {fprintf(output,";R80:\t<exp> ::= <identificador>\n");}
	| constante {fprintf(output,";R81:\t<exp> ::= <constante>\n");}
	| TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO {fprintf(output,";R82:\t<exp> ::= ( <exp> )\n");}
	| TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO {fprintf(output,";R83:\t<exp> ::= ( <comparacion> )\n");}
	| elemento_vector {fprintf(output,";R85:\t<exp> ::= <elemento_vector>\n");}
	| identificador TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {fprintf(output,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");}
	;

lista_expresiones: exp resto_lista_expresiones {fprintf(output,";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");}
	| {fprintf(output,";R90:\t<lista_expresiones> ::=\n");}
	;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones {fprintf(output,";R91:\t<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>\n");}
	| {fprintf(output,";R92:\t<resto_lista_expresiones> ::=\n");}
	;

comparacion: exp TOK_IGUAL exp {fprintf(output,";R93:\t<comparacion> ::= <exp> == <exp>\n");}
	| exp TOK_DISTINTO exp {fprintf(output,";R94:\t<comparacion> ::= <exp> != <exp>\n");}
	| exp TOK_MENORIGUAL exp {fprintf(output,";R95:\t<comparacion> ::= <exp> <= <exp>\n");}
	| exp TOK_MAYORIGUAL exp {fprintf(output,";R96:\t<comparacion> ::= <exp> >= <exp>\n");}
	| exp TOK_MENOR exp {fprintf(output,";R97:\t<comparacion> ::= <exp> < <exp>\n");}
	| exp TOK_MAYOR exp {fprintf(output,";R98:\t<comparacion> ::= <exp> > <exp>\n");}
	;

constante: constante_logica {fprintf(output,";R99:\t<constante> ::= <constante_logica>\n");}
	| constante_entera {fprintf(output,";R100:\t<constante> ::= <constante_entera>\n");}
	;

constante_logica: TOK_TRUE {fprintf(output, ";R102:\t<constante_logica> ::= true\n");}
	| TOK_FALSE {fprintf(output, ";R103:\t<constante_logica> ::= false\n");}
	;

constante_entera: TOK_CONSTANTE_ENTERA {
		$$.tipo = ENTERO;
		$$.valor_entero = $1.valor_entero;
		fprintf(output,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
	}

identificador: TOK_IDENTIFICADOR {
		strcpy($$.lexema, $1.lexema);
		fprintf(output, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
		}

%%