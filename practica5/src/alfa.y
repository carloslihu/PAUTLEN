%{
#define ERROR_SEMANTICO "error semantico\n"
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
	int cuantos_no = 0;
	int cuantos_if = 0;

	int yyerror(char* s) {
		fprintf(stderr,"%s",s);
		if (yylval.atributos.tipo != -1)
			fprintf(stderr, "****Error sintactico en [lin %d col %d]\n", fil, col - yyleng);
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

programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones escritura1 funciones escritura2 sentencias TOK_LLAVEDERECHA {
	escribir_fin(output);
	fprintf(output, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");
}

escritura1: {
	escribir_subseccion_data(output);
	escribir_cabecera_bss(output);
	printTablaGlobal(output);
	escribir_segmento_codigo(output);
	fprintf(output, ";Rescritura1:\t <escritura1> ::= \n");
}

escritura2: {
	escribir_inicio_main(output);
}

declaraciones: declaracion {
	fprintf(output, ";R2:\t<declaraciones> ::= <declaracion>\n");
}
| declaracion declaraciones {fprintf(output, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
;

declaracion: clase identificadores TOK_PUNTOYCOMA {
	fprintf(output, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");
}

clase: clase_escalar {
	clase_actual = ESCALAR;
	fprintf(output, ";R5:\t<clase> ::= <clase_escalar>\n");
}
| clase_vector {
	clase_actual = VECTOR;
	fprintf(output, ";R7:\t<clase> ::= <clase_vector>\n");
}
;

clase_escalar: tipo {fprintf(output, ";R9:\t<clase_escalar> ::= <tipo>\n");}

tipo: TOK_INT {
	tipo_actual = ENTERO;
	fprintf(output, ";R10:\t<tipo> ::= int\n");
}
| TOK_BOOLEAN {
	tipo_actual = BOOLEANO;
	fprintf(output, ";R11:\t<tipo> ::= boolean\n");
}
;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {fprintf(output, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");}

identificadores: identificador {
			fprintf(output, ";R18:\t<identificadores> ::= <identificador>\n");
		}
	| identificador TOK_COMA identificadores {fprintf(output, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
	;

funciones: funcion funciones {fprintf(output, ";R:20\t<funciones> ::= <funcion> <funciones>\n");}
	| {
		fprintf(output, ";R21:\t<funciones> ::= \n");
	}
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

asignacion: TOK_IDENTIFICADOR TOK_ASIGNACION exp {
		INFO_SIMBOLO* info = buscar($1.lexema);
		if(info == NULL){
			return yyerror(ERROR_SEMANTICO);
		} else if(info->categoria == FUNCION){
			return yyerror("error semantico: asignacion a funcion");
		} else if(info->clase == VECTOR){
			return yyerror("error semantico: asignacion de clases incompatibles");
		} else if(info->tipo != $3.tipo){
			return yyerror("error semantico: asignacion de tipos incompatibles");
		}
		asignar(output, $1.lexema, $3.es_direccion);
		fprintf(output, ";R43:\t<asignacion> ::= <identificador> = <exp>\n");
	}

elemento_vector: identificador TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO {fprintf(output, ";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");}

condicional: TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");}
	| TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");}
	;

bucle: TOK_WHILE TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(output, ";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");}

lectura: TOK_SCANF identificador {fprintf(output, ";R54:\t<lectura> ::= scanf <identificador>\n");}

escritura: TOK_PRINTF exp {
	escribir(output, $2.es_direccion, $2.tipo);
	fprintf(output, ";R56:\t<escritura> ::= printf <exp>\n");
	}

retorno_funcion: TOK_RETURN exp {fprintf(output, ";R61:\t<retorno_funcion> ::= return <exp>\n");}

exp: exp TOK_MAS exp  {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("error semantico: suma de tipos incompatibles");
		}
		sumar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R72:\t<exp> ::= <exp> + <exp>\n");
		}
	| exp TOK_MENOS exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("error semantico: resta de tipos incompatibles");
		}
		restar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R73:\t<exp> ::= <exp> - <exp>\n");}
	| exp TOK_DIVISION exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("error semantico: division de tipos incompatibles");
		}
		dividir(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R74:\t<exp> ::= <exp> / <exp>\n");}
	| exp TOK_ASTERISCO exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		multiplicar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R75:\t<exp> ::= <exp> * <exp>\n");}
	| TOK_MENOS exp %prec MENOSU {
		if($2.tipo != ENTERO){
			return yyerror("error semantico: cambio de signo de tipo incompatible");
		}
		cambiar_signo(output, $2.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R76:\t<exp> ::= - <exp>\n");
		}
	| exp TOK_AND exp {
		if($1.tipo != $3.tipo || $1.tipo != BOOLEANO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		y(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R77:\t<exp> ::= <exp> && <exp>\n");
		}//TODO
	| exp TOK_OR exp {
		if($1.tipo != $3.tipo || $1.tipo != BOOLEANO){
			return yyerror("error semantico: multiplicacion de tipos incompatibles");
		}
		o(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		fprintf(output, ";R78:\t<exp> ::= <exp> || <exp>\n");
		}//TODO
	| TOK_NOT exp {
		if($2.tipo != BOOLEANO){
			return yyerror("error semantico: negacion de tipos incompatibles");
		}
		no(output, $2.es_direccion, cuantos_no);
		cuantos_no++;
		$$.es_direccion = FALSE;
		fprintf(output, ";R79:\t<exp> ::= ! <exp>\n");
		}//TODO
	| TOK_IDENTIFICADOR {
		INFO_SIMBOLO* info = buscar($1.lexema);
		if(info == NULL){
			return yyerror("error semantico: identificador sin declarar");
		}
		else if(info->categoria == FUNCION){
			return yyerror("error semantico: el identificador es una funcion");
		} else if(info->clase == VECTOR){
			return yyerror("error semantico: el identificador es un vector");
		}
		$$.tipo = info->tipo;
		$$.es_direccion = TRUE;
		escribir_operando(output, $1.lexema, TRUE);
		fprintf(output, ";R80:\t<exp> ::= <identificador>\n");
		}
	| constante {
		$$.tipo = $1.tipo;
		$$.es_direccion = $1.es_direccion;
		fprintf(output, ";R81:\t<exp> ::= <constante>\n");
	}
	| TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO {
		$$.tipo = $2.tipo;
		$$.es_direccion = $2.es_direccion;
		fprintf(output, ";R82:\t<exp> ::= ( <exp> )\n");
		}
	| TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO {
		$$.tipo = $2.tipo;
		$$.es_direccion = $2.es_direccion;
		fprintf(output, ";R83:\t<exp> ::= ( <comparacion> )\n");
		}
	| elemento_vector {
		$$.tipo = $1.tipo;
		$$.es_direccion = $1.es_direccion;
		fprintf(output, ";R85:\t<exp> ::= <elemento_vector>\n");
		}
	| identificador TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {fprintf(output, ";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");}//TODO
	;

lista_expresiones: exp resto_lista_expresiones {fprintf(output, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");}
	| {fprintf(output, ";R90:\t<lista_expresiones> ::=\n");}
	;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones {fprintf(output, ";R91:\t<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>\n");}
	| {fprintf(output, ";R92:\t<resto_lista_expresiones> ::=\n");}
	;

comparacion: exp TOK_IGUAL exp {fprintf(output, ";R93:\t<comparacion> ::= <exp> == <exp>\n");}
	| exp TOK_DISTINTO exp {fprintf(output, ";R94:\t<comparacion> ::= <exp> != <exp>\n");}
	| exp TOK_MENORIGUAL exp {fprintf(output, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");}
	| exp TOK_MAYORIGUAL exp {fprintf(output, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");}
	| exp TOK_MENOR exp {fprintf(output, ";R97:\t<comparacion> ::= <exp> < <exp>\n");}
	| exp TOK_MAYOR exp {fprintf(output, ";R98:\t<comparacion> ::= <exp> > <exp>\n");}
	;

constante: constante_logica {
		$$.tipo = $1.tipo;
		$$.es_direccion = $1.es_direccion;
		fprintf(output, ";R99:\t<constante> ::= <constante_logica>\n");
		}
	| constante_entera {
		$$.tipo = $1.tipo;
		$$.es_direccion = $1.es_direccion;
		fprintf(output, ";R100:\t<constante> ::= <constante_entera>\n");
	}
	;

constante_logica: TOK_TRUE {
		$$.tipo = BOOLEANO;
		$$.es_direccion = FALSE;
		fprintf(output, ";R102:\t<constante_logica> ::= true\n");
		}
	| TOK_FALSE {
		$$.tipo = BOOLEANO;
		$$.es_direccion = FALSE;	
		fprintf(output, ";R103:\t<constante_logica> ::= false\n");
		}
	;

constante_entera: TOK_CONSTANTE_ENTERA {
		$$.tipo = ENTERO;
		$$.es_direccion = FALSE;
		$$.valor_entero = $1.valor_entero;
		escribir_operando(output, $1.lexema, 0);//README $1.lexema es un truco sucio para no jugar con memoria
		fprintf(output, ";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
	}

identificador: TOK_IDENTIFICADOR {
		fprintf(output, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
		if (buscar($1.lexema)){
			return yyerror("ya existe ese identificador!!");
		}
		else{
			if(insertar($1.lexema, VARIABLE, tipo_actual, clase_actual, 1, 1, 1, 1, 1) == ERR)
				return yyerror("acho que no inserta!\n");
		}
	}

%%