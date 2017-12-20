%{
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

	char str[200];//variable para impresion de errores

	int yyerror(char* s) {
		
		if (yylval.atributos.tipo != -1){
			if(strcmp(s, "syntax error"))
				fprintf(stderr,"****Error semantico en lin %d: %s\n",fil, s);
			else
				fprintf(stderr, "****Error sintactico en [lin %d col %d]\n", fil, col - yyleng);
		}
		limpiarTablas();
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
%type <atributos> if_exp
%type <atributos> if_exp_sentencias
%type <atributos> while
%type <atributos> while_exp
%type <atributos> fn_declaration
%type <atributos> fn_name
%type <atributos> idf_llamada_fn


%%
/*
	REGLA 1
*/
programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones escritura1 funciones escritura2 sentencias TOK_LLAVEDERECHA {
		escribir_fin(output);
		fprintf(output, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");
		limpiarTablas();
	}




/*
	REGLA (escritura) 1
*/
escritura1: {
		escribir_subseccion_data(output);
		escribir_cabecera_bss(output);
		printTablaGlobal(output);
		escribir_segmento_codigo(output);
		fprintf(output, ";Rescritura1:\t <escritura1> ::= \n");
	}




/*
	REGLA (escritura) 2
*/
escritura2: {
		escribir_inicio_main(output);
	}




/*
	REGLAS 2 4
*/
declaraciones: declaracion {
		fprintf(output, ";R2:\t<declaraciones> ::= <declaracion>\n");
	}
	| declaracion declaraciones {fprintf(output, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
	;

declaracion: clase identificadores TOK_PUNTOYCOMA {
		fprintf(output, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");
	}




/*
	REGLAS 5 7
*/
clase: clase_escalar {
		clase_actual = ESCALAR;
		fprintf(output, ";R5:\t<clase> ::= <clase_escalar>\n");
	}
	| clase_vector {
		clase_actual = VECTOR;
		fprintf(output, ";R7:\t<clase> ::= <clase_vector>\n");
	}
	;




/*
	REGLA 9
*/
clase_escalar: tipo {
		tam_actual = 1;
		fprintf(output, ";R9:\t<clase_escalar> ::= <tipo>\n");
		}




/*
	REGLAS 10 11
*/
tipo: TOK_INT {
		tipo_actual = ENTERO;
		fprintf(output, ";R10:\t<tipo> ::= int\n");
	}
	| TOK_BOOLEAN {
		tipo_actual = BOOLEANO;
		fprintf(output, ";R11:\t<tipo> ::= boolean\n");
	}
	;




/*
	REGLA 15
*/
clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {
		//README, el tipo del vector se guarda en la variable global tipo_actual al reducir la regla "tipo" que es $2 en este caso
		//		por hacer analogía a como lo manejamos en clase_escalar, no hacemos nada con "tipo", pues ya haremos uso de tipo_actual al insertar en la tabla de simbolos
		if($4.valor_entero > MAX_TAM_VECTOR || $4.valor_entero <= 0){
			//TODO <nombre_vector>?
			return yyerror("El tamanyo del vector <nombre_vector> excede los limites permitidos (1,64).");
		}
		tam_actual = $4.valor_entero;
		fprintf(output, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
		}




/*
	REGLAS 18 19
*/
identificadores: identificador {
			fprintf(output, ";R18:\t<identificadores> ::= <identificador>\n");
		}
	| identificador TOK_COMA identificadores {fprintf(output, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
	;




/*
	REGLAS 20 21
*/
funciones: funcion funciones {fprintf(output, ";R:20\t<funciones> ::= <funcion> <funciones>\n");}
	| {
		fprintf(output, ";R21:\t<funciones> ::= \n");
	}
	;




/*
	REGLA 22
*/
funcion : fn_declaration sentencias TOK_LLAVEDERECHA {
		INFO_SIMBOLO *info;
		setAmbito(GLOBAL);
		//la tabla de simbolos estara en el ambito global
		info = buscar($1.lexema);
		if(info == NULL){
			return yyerror("Tabla de simbolos corrupta.");
		}
		info->n_param = num_parametros_actual;
		info->n_locales = num_variables_local_actual;
		if(num_retornos == 0){
			//fprintf(stderr, "\nWARNING: no hay retorno de funcion %s\n", $1.lexema);
			sprintf(str, "Funcion %s sin sentencia de retorno.", $1.lexema);
			return yyerror(str);
			//README preguntar si puede haber funciones sin retorno
			//escribir_fin_funcion(output);
		}
		//info->n_param = num_parametros_actual;
		num_retornos = 0;
		fprintf(output, ";R22:\t<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }\n");
}

fn_declaration : fn_name TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA declaraciones_funcion {
	//la tabla de simbolos esta en ambito LOCAL
	INFO_SIMBOLO * info = buscar($1.lexema);
	if(info == NULL){
		return yyerror("Tabla de simbolos corrupta.");
	}
	info->n_param = num_parametros_actual;
	info->n_locales = num_variables_local_actual;
	escribir_principio_funcion(output, info->lexema);
	declarar_locales(output, num_variables_local_actual);
	printf("simbolo encontrado: %s\nn_param: %d\nn_local: %d\n", info->lexema, info->n_param, info->n_locales);
	strcpy($$.lexema, $1.lexema);
}

fn_name : TOK_FUNCTION tipo TOK_IDENTIFICADOR {
	INFO_SIMBOLO * info;
	info = buscar($3.lexema);
	if(info != NULL){
		return yyerror("Declaracion duplicada.");
	}
	//README asumo que la clase de la funcion es siempre escalar
	//README segun las transparencias: en un principio la informacion disponible ahora mismo del id de la funcion es solo el tipo del retorno.
	//			mas adelante se completara esta informacion
	insertar($3.lexema, FUNCION, tipo_actual, ESCALAR, 1, 0, 0, 0, 0);
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

	strcpy($$.lexema, $3.lexema);
}



/*
	REGLAS 23 24
*/
parametros_funcion: parametro_funcion resto_parametros_funcion {fprintf(output, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
	| {fprintf(output, ";R24:\t<parametros_funcion> ::= \n");}
	;




/*
	REGLAS 25 26
*/
resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(output, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
	| {fprintf(output, ";R26:\t<resto_parametros_funcion> ::= \n");}
	;




/*
	REGLA 27
*/
parametro_funcion: tipo idpf {fprintf(output, ";R:27\t<parametro_funcion> ::= <tipo> <identificador>\n");}

//regla para declaracion de parametros de funcion
idpf: TOK_IDENTIFICADOR {
	INFO_SIMBOLO * info;
	info = buscar($1.lexema);
	if (info != NULL){
		return yyerror("Declaracion duplicada.");
	}
	
	//README la clase de un parametro puede ser vector? en principio voy a asumir que no
	//README realmente en esta insercion, el num_parametros_actual no hace falta insertarlo (porque es info para la funcion)
	if(insertar($1.lexema, PARAMETRO, tipo_actual, ESCALAR, 1, -1, -1, num_parametros_actual, pos_parametro_actual) == ERR)
		return yyerror("Tabla de simbolos corrupta.");
	num_parametros_actual++;
	pos_parametro_actual++;
}



/*
	REGLAS 28 29
*/

declaraciones_funcion: declaraciones {fprintf(output, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
	| {fprintf(output, ";R29:\t<declaraciones_funcion> ::= \n");}
	;


/*
declaraciones_funcion: declaracion_funcion declaraciones_funcion
	|
	;

declaracion_funcion: tipo resto_declaracion_funcion TOK_PUNTOYCOMA

resto_declaracion_funcion: TOK_IDENTIFICADOR TOK_COMA resto_declaracion_funcion
	|
	;
*/

/*
	REGLAS 30 31
*/
sentencias: sentencia {fprintf(output, ";R30:\t<sentencias> ::= <sentencia>\n");}
	| sentencia sentencias {fprintf(output, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
	;




/*
	REGLAS 32 33
*/
sentencia: sentencia_simple TOK_PUNTOYCOMA {fprintf(output, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
	| bloque {fprintf(output, ";R33:\t<sentencia> ::= <bloque>\n");}
	;




/*
	REGLAS 34 35 36 38
*/
sentencia_simple: asignacion {fprintf(output, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
	| lectura {fprintf(output, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
	| escritura {fprintf(output, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
	| retorno_funcion {fprintf(output, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
	;




/*
	REGLAS 40 41
*/
bloque: condicional {
		//TODO escribir final del bloque (?)
		fprintf(output, ";R40:\t<bloque> ::= <condicional>\n");
		}
	| bucle {
		//TODO escribir final del bloque (?)
		fprintf(output, ";R41:\t<bloque> ::= <bucle>\n");
		}
	;




/*
	REGLAS 43 43.2
*/
asignacion: TOK_IDENTIFICADOR TOK_ASIGNACION exp {
			INFO_SIMBOLO* info = buscar($1.lexema);
			if(info == NULL){
				sprintf(str,"Acceso a variable no declarada (%s)",$1.lexema);
				return yyerror(str);
			} else if(info->categoria == FUNCION){
				return yyerror("Asignacion incompatible");
			} else if(info->clase == VECTOR){
				return yyerror("Asignacion incompatible");
			} else if(info->tipo != $3.tipo){
				return yyerror("Asignacion incompatible");
			} else if(info->categoria == PARAMETRO){
				//return yyerror("error semantico: asignacion de a un parametro prohibida");//README preguntar al profe si puedes hacer una asignacion a un parametro
				asignar_parametro(output, info->pos_param, num_parametros_actual, $3.es_direccion);
			} else if (getAmbito() == GLOBAL){
				asignar(output, $1.lexema, $3.es_direccion);
			} else {//estamos asignando una variable local
				asignar_local(output, info->pos_local, $3.es_direccion);
			}
			fprintf(output, ";R43:\t<asignacion> ::= <identificador> = <exp>\n");
		}
		| elemento_vector TOK_ASIGNACION exp {
			INFO_SIMBOLO* info = buscar($1.lexema);
			if(info == NULL){
				return yyerror("Tabla de simbolos corrupta.");
			} else if(info->categoria == FUNCION){
				return yyerror("Asignacion incompatible");
			} else if(info->clase == ESCALAR){
				return yyerror("Asignacion incompatible");
			} else if(info->tipo != $3.tipo){
				return yyerror("Asignacion incompatible");
			}
			asignar_vector(output, $3.es_direccion);
			fprintf(output, ";R43.2:\t<asignacion> ::= <elemento_vector> = <exp>\n");
		}




/*
	REGLA 48
*/
elemento_vector: TOK_IDENTIFICADOR TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO {
		//cuando nos encontramos con un elemento vector, tenemos que comprobar que exp
		//entra dentro del rango del vector. En caso contrario, saltar a la gesiton del
		//error. Por ello, printeamos el siguiente codigo ensamblador
		INFO_SIMBOLO* info = buscar($1.lexema);
		if(info == NULL){
			sprintf(str,"Acceso a variable no declarada (%s)",$1.lexema);
			return yyerror(str);
		} else if(getAmbito() == LOCAL){
			return yyerror("Variable local de tipo no escalar.");
		} else {
			escribir_elemento_vector(output, $1.lexema, $3.es_direccion, info->tam-1);//el -1 es porque el array va desde 0 hasta tamanio-1. En la generacion de codigo no se gestiona esa logica
			$$.es_direccion = TRUE;
		}
		strcpy($$.lexema, $1.lexema);
		fprintf(output, ";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
		}




/*
	REGLAS 50 51
*/
condicional : if_exp_sentencias TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {
			escribir_end_else(output, $1.etiqueta);
			fprintf(output, ";\t<condicional> ::= <if_exp_sentencias> else { <sentencias> } ");
		}
	| if_exp sentencias TOK_LLAVEDERECHA {
			escribir_end_if(output, $1.etiqueta);
			fprintf(output, ";\t<condicional> ::= <if_exp> }\n");
		}

if_exp: TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA {
		//TODO transparencias en torno a la 59
		//comprobamos que sea distinto de cero.
		//si no se cumple, saltamos al final del if
		//ejecutamos instrucciones de dentro del if
		//final del if
		if($3.tipo != BOOLEANO)
			return yyerror("Condicional con condicion de tipo int.");
		$$.etiqueta = cuantos++;
		escribir_if(output, $3.es_direccion, $$.etiqueta);
		fprintf(output, ";R50:\t<if_exp> ::= if ( <exp> ) { \n");
		}

if_exp_sentencias: if_exp sentencias TOK_LLAVEDERECHA {
		$$.etiqueta = $1.etiqueta;
		escribir_else(output, $$.etiqueta);
		fprintf(output, ";R50:\t<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>\n");
		}



/*
	REGLA 52
*/
while: TOK_WHILE TOK_PARENTESISIZQUIERDO{
		$$.etiqueta = cuantos++;
		escribir_inicio_while(output, $$.etiqueta);
		//TODO generacion codigo
	}

while_exp: while exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA {
		if($2.tipo != BOOLEANO){
			return yyerror("Condicional con condicion de tipo int.");
		}
		$$.etiqueta = $1.etiqueta;
		escribir_condicion_while(output, $2.es_direccion, $$.etiqueta);
	}

bucle: while_exp sentencias TOK_LLAVEDERECHA {
	escribir_fin_while(output, $1.etiqueta);
	fprintf(output, ";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
	}

/*
	REGLA 54
*/
lectura: TOK_SCANF TOK_IDENTIFICADOR {
	INFO_SIMBOLO* aux = buscar($2.lexema);
	if(!aux){
		sprintf(str,"Acceso a variable no declarada (%s)",$2.lexema);
		return yyerror(str);
	} else if(aux->clase != ESCALAR){
		//TODO que imprimir
		return yyerror("Scanf sobre vector");
	} else if (aux->categoria == FUNCION){
		//TODO que imprimir
		return yyerror("Scanf sobre funcion");
	}
	leer(output, $2.lexema, $2.tipo);
	fprintf(output, ";R54:\t<lectura> ::= scanf <identificador>\n");
	}




/*
	REGLA 56
*/
escritura: TOK_PRINTF exp {
	escribir(output, $2.es_direccion, $2.tipo);
	fprintf(output, ";R56:\t<escritura> ::= printf <exp>\n");
	}




/*
	REGLA 61
*/
	//TODO VAMOS POR AQUI
retorno_funcion: TOK_RETURN exp {
		fprintf(output, ";R61:\t<retorno_funcion> ::= return <exp>\n");
		if(getAmbito() == GLOBAL)
			return yyerror("Sentencia de retorno fuera del cuerpo de una funcion");
		num_retornos = 1;
		escribir_fin_funcion(output);
	}




/*
	REGLAS 72 73 74 75 76 77 78 79 80 81 82 83 85
*/
exp: exp TOK_MAS exp  {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Operacion aritmetica con operandos boolean.");
		}
		sumar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = ENTERO;
		fprintf(output, ";R72:\t<exp> ::= <exp> + <exp>\n");
		}
	| exp TOK_MENOS exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Operacion aritmetica con operandos boolean.");
		}
		restar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = ENTERO;
		fprintf(output, ";R73:\t<exp> ::= <exp> - <exp>\n");}
	| exp TOK_DIVISION exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Operacion aritmetica con operandos boolean.");
		}
		dividir(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = ENTERO;
		fprintf(output, ";R74:\t<exp> ::= <exp> / <exp>\n");}
	| exp TOK_ASTERISCO exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Operacion aritmetica con operandos boolean.");
		}
		multiplicar(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = ENTERO;
		fprintf(output, ";R75:\t<exp> ::= <exp> * <exp>\n");}
	| TOK_MENOS exp %prec MENOSU {
		if($2.tipo != ENTERO){
			return yyerror("Operacion aritmetica con operandos boolean.");
		}
		cambiar_signo(output, $2.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = ENTERO;
		fprintf(output, ";R76:\t<exp> ::= - <exp>\n");
		}
	| exp TOK_AND exp {
		if($1.tipo != $3.tipo || $1.tipo != BOOLEANO){
			return yyerror("Operacion logica con operandos int.");
		}
		y(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R77:\t<exp> ::= <exp> && <exp>\n");
		}
	| exp TOK_OR exp {
		if($1.tipo != $3.tipo || $1.tipo != BOOLEANO){
			return yyerror("Operacion logica con operandos int.");
		}
		o(output, $1.es_direccion, $3.es_direccion);
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R78:\t<exp> ::= <exp> || <exp>\n");
		}
	| TOK_NOT exp {
		if($2.tipo != BOOLEANO){
			return yyerror("Operacion logica con operandos int.");
		}
		no(output, $2.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R79:\t<exp> ::= ! <exp>\n");
		}
	| TOK_IDENTIFICADOR {
		//TODO comprobar si estamos en lista de expresiones (llamada a funcion) o no
		INFO_SIMBOLO* info = buscar($1.lexema);
		if(info == NULL){
			sprintf(str,"Acceso a variable no declarada (%s)",$1.lexema);
			return yyerror(str);
		}
		else if(info->categoria == FUNCION){
			return yyerror("Tipo incorrecto");
		} else if(info->clase == VECTOR){
			return yyerror("Tipo incorrecto");
		}
		$$.tipo = info->tipo;
		$$.es_direccion = TRUE;
		if(getAmbito()== GLOBAL) {//si no estamos en una llamada a funcion y el ambito es global
			escribir_operando(output, $1.lexema, TRUE);
			if(en_exp_list ){
				$$.es_direccion = FALSE;
				escribir_contenido_del_top(output);
			}
		} else {
			if(info->categoria == VARIABLE){//si no estamos en una llamada a funcion pero la variable es local
				escribir_operando_local(output, info->pos_local);
				if(en_exp_list ){
					$$.es_direccion = FALSE;
					escribir_contenido_del_top(output);
				}
			} else {//si no estamos en una llamada a funcion pero la variable es un parametro
				escribir_operando_parametro(output, num_parametros_actual, info->pos_param);
				$$.es_direccion = FALSE;
			}
		}
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
		//TODO comprobar si estamos en lista de expresiones (llamada a funcion) o no
		$$.tipo = $1.tipo;
		if (en_exp_list){//si estamos en la llamada a una funcion
			//README hay que indicar que ahora lo que hay en la cima de la pila no es una direccion
			$$.es_direccion = FALSE;
			escribir_contenido_del_top(output);
		} else {
			$$.es_direccion = $1.es_direccion;
		}
		fprintf(output, ";R85:\t<exp> ::= <elemento_vector>\n");
		}
	| idf_llamada_fn TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {
		INFO_SIMBOLO* info = buscar($1.lexema);
		printf("simbolo encontrado: %s\nn_param: %d\nn_local: %d\n", info->lexema, info->n_param, info->n_locales);
		printf("numero esperado: %d\nnumero resultante: %d\n", info->n_param, $3.valor_entero);
		if(info == NULL){
			sprintf(str,"Acceso a variable no declarada (%s)",$1.lexema);
			return yyerror(str);
		} else if(info->categoria != FUNCION){
			return yyerror("Tipo Incorrecto");
		} else if(info->n_param != $3.valor_entero){//README usamos valor entero en este caso para almacenar el numero de expresiones de lista_expresiones
			return yyerror("Numero incorrecto de parametros en llamada a funcion.");
		}
		escribir_llamada_funcion(output, info->lexema, info->n_param);
		$$.tipo = info->tipo;
		$$.es_direccion = FALSE;
		en_exp_list = FALSE;//marcamos el flag a false para indicar que hemos terminado de procesar la lista de expresiones
		fprintf(output, ";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");
	}
	;

idf_llamada_fn: TOK_IDENTIFICADOR{
	if(en_exp_list == TRUE){
		return yyerror("No esta permitido el uso de llamadas a funciones como parametros de otras funciones");
	}
	//TODO mirar tabla de simbolos el nombre del id (que sera la funcion)
	strcpy($$.lexema, $1.lexema);
	en_exp_list = TRUE;
}



/*
	REGLAS 89 90
*/
	//README tengo que heredar de alguna forma la informacion de la funcion para comprobar los tipos de los argumentos?
	//TODO solo hace falta ir haciendo push de los valores de los argumentos
lista_expresiones: exp resto_lista_expresiones {
		$$.valor_entero = 1 + $2.valor_entero;
		fprintf(output, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");
		}
	| {
		$$.valor_entero = 0;
		fprintf(output, ";R90:\t<lista_expresiones> ::=\n");
		}
	;




/*
	REGLAS 91 92
*/
resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones {
		$$.valor_entero = 1 + $3.valor_entero;
		fprintf(output, ";R91:\t<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>\n");}
	| {
		$$.valor_entero = 0;
		fprintf(output, ";R92:\t<resto_lista_expresiones> ::=\n");}
	;




/*
	REGLAS 93 94 95 96 97 98
*/
comparacion: exp TOK_IGUAL exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		igual(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
		}
	| exp TOK_DISTINTO exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		distinto(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
		}
	| exp TOK_MENORIGUAL exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		menor_igual(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
		}
	| exp TOK_MAYORIGUAL exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		mayor_igual(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
		}
	| exp TOK_MENOR exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		menor(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;
		fprintf(output, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
		}
	| exp TOK_MAYOR exp {
		if($1.tipo != $3.tipo || $1.tipo != ENTERO){
			return yyerror("Comparacion con operandos boolean.");
		}
		mayor(output, $1.es_direccion, $3.es_direccion, cuantos);
		cuantos++;
		$$.es_direccion = FALSE;
		$$.tipo = BOOLEANO;fprintf(output, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
		}
	;




/*
	REGLAS 99 100
*/
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




/*
	REGLAS 102 103
*/
constante_logica: TOK_TRUE {
		$$.tipo = BOOLEANO;
		$$.es_direccion = FALSE;
		$$.valor_entero = TRUE;
		escribir_operando(output, "1", 0);
		fprintf(output, ";R102:\t<constante_logica> ::= true\n");
		}
	| TOK_FALSE {
		$$.tipo = BOOLEANO;
		$$.es_direccion = FALSE;
		$$.valor_entero = FALSE;
		escribir_operando(output, "0", 0);
		fprintf(output, ";R103:\t<constante_logica> ::= false\n");
		}
	;




/*
	REGLA 104
*/
constante_entera: TOK_CONSTANTE_ENTERA {
		$$.tipo = ENTERO;
		$$.es_direccion = FALSE;
		$$.valor_entero = $1.valor_entero;
		escribir_operando(output, $1.lexema, 0);//README $1.lexema es un truco sucio para no jugar con memoria
		fprintf(output, ";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
	}



/*
	REGLA 108
*/
//README solo deberia llegarse a esta regla de identificador desde una declaracion, no desde una expresion.
identificador: TOK_IDENTIFICADOR {
		AMBITO amb = getAmbito();
		fprintf(output, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
		if (buscar($1.lexema)){
			return yyerror("Declaracion duplicada.");
		}
		else{
			if(amb == GLOBAL){
				if(insertar($1.lexema, VARIABLE, tipo_actual, clase_actual, tam_actual, -1, -1, -1, -1) == ERR)
					return yyerror("Tabla de simbolos corrupta");
			} else {
				//tratamos de insertar una variable local
				if(insertar($1.lexema, VARIABLE, tipo_actual, clase_actual, tam_actual, num_variables_local_actual, pos_variable_local_actual, -1, -1) == ERR)
					return yyerror("Tabla de simbolos corrupta");
				//actualizamos las variables que llevan la cuenta de las posiciones y numeros de las variables locales
				pos_variable_local_actual++;
				num_variables_local_actual++;
			}
		}
	}

%%