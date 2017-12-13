#include "../includes/generacion.h"


/**
 * @brief: escribe en el fichero la cabecera de compatibilidad para que el codigo nasm funcione tambien en otros SO
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_cabecera_compatibilidad(FILE* fpasm)
{
	/* FUNCIÓN PARA PODER HACER EL CÓDIGO MULTIPLATAFORMA U OTROS PARÁMETROS GENERALES TAL VEZ SE PUEDA QUEDAR VACÍA */
}



/**
 * @brief: escribe la subseccion .data del codigo ensamblador con los mensajes de error en caso de division por cero y de acceso a un array fuera de su rango
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_subseccion_data(FILE* fpasm)
{
	/* FUNCIÓN PARA ESCRIBIR LA SECCIÓN .data:
		MENSAJES GENERALES (TEXTOS)
		VARIABLES AUXILIARES NECESARIAS EN EL COMPILADOR QUE DEBAN TENER UN VALOR CONCRETO */
	/* Variables auxiliares para mensajes de errores en tiempo de ejecución */
	fprintf(fpasm, "segment .data\n\tmsg_error_division db \"error: divison by zero\", 0\n\tmsg_error_range db \"error: index out of range\", 0\n");
}



/**
 * @brief: escribe la cabecera de la subseccion .bss del codigo ensamblador donde se declaran las variables de uso global. Tambien declara por defecto la variable auxiliar __esp
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_cabecera_bss(FILE* fpasm)
{
	/* FUNCIÓN PARA ESCRIBIR EL INICIO DE LA SECCIÓN .bss:
		AL MENOS HAY QUE DECLARAR LA VARIABLE AUXILIAR PARA GUARDAR EL PUNTERO DE PILA __esp
	*/
	fprintf(fpasm, "segment .bss\n");
	fprintf(fpasm, "\t__esp resd 1\n");
}



/**
 * @brief: escribe, en la subseccion .bss, una variable global, dado un tipo y un tamano (si resulta ser un array)
 * @param: fpams: el archivo donde se va a escribir
 * @param: nombre: el nombre de la variable a declarar
 * @param: tipo: el tipo de dato de la variable a declarar. puede ser ENTERO o BOOLEANO
 * @param: tamano: el tamano que ocupa la variable a declarar. deberia ser 1 si se trata de un escalar. De lo contrario, el numero de elementos del array
 */
void declarar_variable(FILE* fpasm, char * nombre,  int tipo,  int tamano)
/* tipo no hace falta porque para nosotros todo es entero en esta versión, se deja por compatibilidad con futuras versiones*/
{
	/* GENERA EL CÓDIGO ASOCIADO EN LA SECCIÓN .bss PARA DECLARAR UNA VARIABLE CON
		SU NOMBRE (HAY QUE PRECEDER DE _)
		EL TAMANO (1 PARA VARIABLES QUE NO SEAN VECTORES O SU TAMANO EN OTRO CASO )
		TIPO NOSOTROS USAREMOS ESTE AÑO ENTERO O BOOLEANO
	*/
	fprintf(fpasm, "\t_%s resd %d\n", nombre,  tamano);
}



/**
 * @brief: escribe el comienzo del segmento de codigo, con las declaraciones de las funciones de alfalib.o
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_segmento_codigo(FILE* fpasm)
{
	/* ESCRIBE EL INICIO DE LA SECCIÓN DE CÓDIGO
		DECLARACIONES DE FUNCIONES QUE SE TOMARAN DE OTROS MODULOS
		DECLARACION DE main COMO ETIQUETA VISIBLE DESDE EL EXTERIOR
	*/
	fprintf(fpasm, "segment .text\n\tglobal main\n\textern scan_int, print_int, scan_float, print_float, scan_boolean, print_boolean\n\textern print_endofline, print_blank, print_string\n\textern alfa_malloc, alfa_free, ld_float\n");
}



/**
 * @brief: escribe la etiquieta de inicio: main y ademas guarda en [__esp] la direccion actual de la pila (esp) para poder recuperarla en caso de error
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_inicio_main(FILE* fpasm)
{
	/* ESCRIBE EL PRINCIPIO DEL CÓDIGO PROPIAMENTE DICHO
		ETIQUETA DE INICIO
		SALVAGUARDA DEL PUNTERO DE PILA (esp) EN LA VARIABLE A TAL EFECTO (__esp)
	*/
	fprintf( fpasm, "\nmain:\n\tmov dword [__esp], esp\n");
}



/**
 * @brief:escribe el final del codigo ensamblador, con la gestion de errores (como division por 0 o acceso fuera del rango de un vector)
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_fin(FILE* fpasm)
{
	/* ESCRITURA DEL FINAL DEL PROGRAMA
		GESTIÓN DE ERROR EN TIEMPO DE EJECUCIÓN (DIVISION POR 0)
		RESTAURACION DEL PUNTERO DE PILA A PARTIR DE LA VARIABLE __esp
		SENTENCIA DE RETORNO DEL PROGRAMA
	*/
	fprintf(fpasm, "\tmov dword esp, [__esp]\n\tret\n");
	fprintf(fpasm, "gestion_error_div_cero:\n");
	fprintf(fpasm, "\tpush dword msg_error_division\n");
	fprintf(fpasm, "\tcall print_string\n");
	fprintf(fpasm, "\tadd esp, 4\n");
	fprintf(fpasm, "\tcall print_endofline\n");
	fprintf(fpasm, "\tmov dword esp, [__esp]\n");
	fprintf(fpasm, "\tret\n");
	fprintf(fpasm, "gestion_error_range:\n");
	fprintf(fpasm, "\tpush dword msg_error_range\n");
	fprintf(fpasm, "\tcall print_string\n");
	fprintf(fpasm, "\tadd esp, 4\n");
	fprintf(fpasm, "\tcall print_endofline\n");
	fprintf(fpasm, "\tmov dword esp, [__esp]\n");
	fprintf(fpasm, "\tret\n");
}



/**
 * @brief: escribe en la pila un operando, que puede ser un valor o el contenido de una direccion de memoria
 * @param: fpams: el archivo donde se va a escribir
 * @param: nombre: el nombre del operando a escribir. si fuera un numero, sería el string de dicho numero p.e "27". De lo contrario es el nombre de la variable
 * @param: es_var: un flag que indica si el operando es un literal (FALSE) o si es una variable (TRUE) en cuyo caso se escribe su valor
 */
void escribir_operando(FILE * fpasm, char * nombre, int es_var)
{
	/* SE INTRODUCE EL OPERANDO nombre EN LA PILA
		SI ES UNA VARIABLE (es_var == 1) HAY QUE PRECEDER EL NOMBRE DE _
		EN OTRO CASO, SE ESCRIBE TAL CUAL
	*/
	if (es_var == 1) {
		fprintf(fpasm, "\tpush dword  _%s \n", nombre);
	}
	else {
		fprintf(fpasm, "\tpush dword  %s \n", nombre);

	}
}

/**
 * @brief: escribe en la pila un operando, que va a ser siempre el valor, ya sea de un literal o de una variable
 * @param: fpams: el archivo donde se va a escribir
 * @param: nombre: el nombre del operando a escribir. si fuera un numero, sería el string de dicho numero p.e "27". De lo contrario es el nombre de la variable
 * @param: es_var: un flag que indica si el operando es un literal (FALSE) o si es una variable (TRUE)
 */
void escribir_parametro_funcion(FILE* fpasm, char* nombre, int es_var){
		if (es_var == 1) {
		fprintf(fpasm, "\tpush dword  [_%s] \n", nombre);
	}
	else {
		fprintf(fpasm, "\tpush dword  %s \n", nombre);

	}
}




/**
 * @brief: escribe en la pila un operando que va a ser la direccion de un elemento de un vector (indexado). Necesariamente, el indice con el que se indexa el vector
 * debe encontrarse en la pila, ya sea como valor o como direccion, pues se puede indexar con o bien como [1] o bien [indice] siendo indice una variable
 * @param: fpams: el archivo donde se va a escribir
 * @param: nombre: el nombre de la base del vector
 * @param: indice_es_direccion: un flag que indica si el indice que hay en la cima de la pila es una direccion (TRUE) o un valor (FALSE)
 * @param: rango: es el ultimo indice valido para el vector. Se utiliza para comprobar que no hay error de acceso (tratar de acceder fuera de los limites del vector)
 */
void escribir_elemento_vector(FILE* fpasm, char* nombre, int indice_es_direccion, int rango){
	//el indice de acceso al array deberia estar en el tope de la pila
	fprintf(fpasm,"\tpop dword eax\n");
	if(indice_es_direccion == TRUE)
		fprintf(fpasm, "\tmov dword eax, [eax]\n");
	fprintf(fpasm, "\tcmp eax, 0\n");
	fprintf(fpasm, "\tjl near gestion_error_range\n");//si el indice es menor que 0 en tiempo de ejecucion
	fprintf(fpasm, "\tcmp eax, %d\n", rango);
	fprintf(fpasm, "\tjg near gestion_error_range\n");//si el indice es mayor que el rango en tiempo de ejecucion
	fprintf(fpasm, "\tmov dword edx, _%s\n", nombre);//pillamos en edx la direccion base del array
	fprintf(fpasm, "\tlea eax, [edx + eax*4]\n");//*4 porque usamos 4 bytes para las palabras
	fprintf(fpasm, "\tpush dword eax\n");//pusheamos la direccion del elemento vector
}




/**
 * @brief: escribe el codigo nasm para asignar a una variable aquello que haya en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: nombre: es el nombre de la variable donde se va a realizar la asignacion (parte derecha de la asignacion)
 * @param: es_referencia: es un flag que determina si lo que hay en la cima de la pila es una direccion (TRUE) o un valor (FALSE)
 */
void asignar(FILE * fpasm, char * nombre, int es_referencia)
{
	/* ESCRIBE EL CÓDIGO PARA REALIZAR UNA ASIGNACIÓN DE LO QUE ESTÉ EN LA CIMA DE LA PILA A LA VARIABLE nombre
		SE RECUPERA DE LA PILA LO QUE HAYA POR EJEMPLO EN EL REGISTRO eax
		SI es_referencia == 0 (ES UN VALOR) DIRECTAMENTE SE ASIGNA A LA VARIABLE _nombre
		EN OTRO CASO es_referencia == 1 (ES UNA DIRECCIÓN, UN NOMBRE DE VARIABLE) HAY QUE OBTENER SU VALOR DESREFERENCIANDO
	EL VALOR ES [eax]
	*/
	if (es_referencia == 0)
		fprintf(fpasm, "\tpop dword eax\n\tmov dword [_%s], eax\n", nombre);
	else
		fprintf(fpasm, "\tpop dword eax\n\tmov eax, dword [eax]\n\tmov dword [_%s], eax\n", nombre);
}




/**
 * @brief: escribe el codigo nasm para asignar a un elemento de un vector. En la cima de la pila debe estar la parte derecha de la asignacion y debajo de esta, la
 * direccion en donde se va a asignar (la parte izquierda de la asignacion)
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia: un flag que determina si la parte derecha de la asignacion es una direccion (TRUE) o es un valor (FALSE)
 */
void asignar_vector(FILE * fpasm, int es_referencia){
	/*
	en la cima de la pila se encuentran:
	exp
	elem_vector
	de lo contrario esto va a generar codigo que da un sigsev
	*/
	//cargamos en eax la parte derecha de la asignacion (exp)
	fprintf(fpasm,"\tpop dword eax\n");
	if(es_referencia)
		fprintf(fpasm,"\tmov dword eax, [eax]\n");
	//cargamos en edx la parte izquierda de la asignacion, que es una direccion!!
	fprintf(fpasm,"\tpop edx\n");
	//hacemos la asignacion efectiva
	fprintf(fpasm,"\tmov dword [edx], eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la suma de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void sumar(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* GENERA EL CÓDIGO PARA SUMAR LO QUE HAYA EN LAS DOS PRIMERAS (DESDE LA CIMA)
	POSICIONES DE LA PILA, TENIENDO EN CUENTA QUE HAY QUE INDICAR SI SON
	REFERENCIAS A VALORES O NO (VER ASIGNAR) ¡¡¡CUIDADO CON EL ORDEN !! EL ARGUMENTO
	QUE SE REFIERE AL SEGUNDO OPERANDO SERÁ EL QUE NOS ENCONTREMOS EN LA PILA PRIMERO

	   pop dword eax
	   pop dword edx
	   add eax, edx
	   push dword eax
	*/
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tadd eax, edx\n");
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la operacion de cambio de signo sobre el operando que se encuentra en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia: un flag que determina si el elemento que esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void cambiar_signo(FILE * fpasm, int es_referencia)
{
	/* GENERA EL CÓDIGO PARA CAMBIAR DE SIGNO LO QUE HAYA EN LA CIMA DE LA PILA
	TENIENDO EN CUENTA QUE PUEDE SER UN VALOR INMEDIATO O UNA REFERENCIA
	A UN VALOR INMEDIATO (VER ASIGNAR)
	*/
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia == 1) {
		fprintf(fpasm, "\tmov eax, [eax]\n");
	}
	fprintf(fpasm, "\tneg eax\n");
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la operacion de negacion sobre el operando que se encuentra en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia: un flag que determina si el elemento que esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: cuantos_no: es un contador para el salto interno que requiere esta operacion.
 */
void no(FILE * fpasm, int es_referencia, int cuantos_no)
{
	/* GENERA EL CÓDIGO PARA NEGAR COMO VALOR LÓGICO LO QUE HAYA EN LA CIMA DE LA PILA
	TENIENDO EN CUENTA QUE PUEDE SER UN VALOR INMEDIATO O UNA REFERENCIA A UN VALOR
	INMEDIATO (VER ASIGNAR)
	COMO ES NECESARIO UTILIZAR ETIQUETAS, SE SUPONE QUE LA VARIABLE cuantos_no ES UN
	CONTADOR QUE ASEGURA QUE UTILIZARLO COMO AÑADIDO AL NOMBRE DE LAS ETIQUETAS QUE
	USEMOS (POR EJEMPLO cierto: O falso: ) NOS ASEGURARÁ QUE CADA LLAMADA A no
	UTILIZA UN JUEGO DE ETIQUETAS ÚNICO
	*/
	/* BASICAMENTE HAY QUE GENERAR ESTO
	        cmp eax, 0
	        je _uno
	        push dword 0
	        jmp _fin_not
	_uno:   push dword 1
	_fin_not:
	*/
	fprintf(fpasm, "\tpop eax\n");
	if (es_referencia == 1) {
		fprintf(fpasm, "\tcmp dword [eax], 0\n");
	} else {
		fprintf(fpasm, "\tcmp eax, 0\n");
	}
	fprintf(fpasm, "\tje _uno_%d\n", cuantos_no);
	fprintf(fpasm, "\tpush dword 0\n");
	fprintf(fpasm, "\tjmp _fin_negar_%d\n", cuantos_no);
	fprintf(fpasm, "_uno_%d:   push dword 1\n", cuantos_no);
	fprintf(fpasm, "_fin_negar_%d:\n", cuantos_no);
}




/**
 * @brief: escribe el codigo nasm para realizar una llamada a la funcion de alfalib.o que lee de stdin
 * @param: fpams: el archivo donde se va a escribir
 * @param: tipo: es un flag que indica si el valor que se va a leer es de tipo entero (ENTERO) o booleano (BOOLEANO)
 */
void leer(FILE * fpasm, char * nombre, int tipo)
{
	/* GENERA EL CÓDIGO PARA LEEER UNA VARIABLE DE NOMBRE nombre Y TIPO tipo (ESTE
	AÑO SÓLO USAREMOS ENTERO Y BOOLEANO) DE CONSOLA LLAMANDO A LAS CORRESPONDIENTES
	FUNCIONES DE ALFALIB (scan_int Y scan_boolean)
	*/
	fprintf(fpasm, "\tpush dword _%s\n", nombre);
	if (tipo == ENTERO)
		fprintf(fpasm, "\tcall scan_int\n");
	else
		fprintf(fpasm, "\tcall scan_boolean\n");
	fprintf(fpasm, "\tadd esp, 4\n");
}




/**
 * @brief: escribe el codigo nasm para realizar una llamada a la funcion de alfalib.o que escribe en stdout
 * @param: fpams: el archivo donde se va a escribir
 * @param: tipo: es un flag que indica si el valor que se va a escribir es de tipo entero (ENTERO) o booleano (BOOLEANO)
 */
void escribir(FILE * fpasm, int es_referencia, int tipo)
{
	/* GENERA EL CÓDIGO PARA ESCRIBIR POR PANTALLA LO QUE HAYA EN LA CIMA DE LA PILA
	TENIENDO EN CUENTA QUE PUEDE SER UN VALOR INMEDIATNO (es_referencia == 0) O UNA
	REFERENCIA A UN VALOR INMEDIANTO (es_referencia == 1) Y QUE HAY QUE LLAMAR A LA CORRESPONDIENTE
	FUNCIÓN DE ALFALIB (print_int O print_boolean) DEPENDIENTO DEL TIPO (tipo == BOOLEANO
	O ENTERO )
	*/
	if (es_referencia == 1)
		fprintf(fpasm, "\tpop eax\n\tpush dword [eax]\n");
	if (tipo != ENTERO)
		fprintf(fpasm, "\tcall print_boolean\n");
	else
		fprintf(fpasm, "\tcall print_int\n");
	fprintf(fpasm, "\tadd esp, 4\n");
	fprintf(fpasm, "\tcall print_endofline\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la resta de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void restar(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tsub eax, edx\n");
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la multiplicacion de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void multiplicar(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR (CUIDADO CON edx PORQUE LA MULTIPILICACIÓN DEJA EL RESULTADO
	EN edx:eax) */
	/* pop dword eax
	   pop dword ebx
	   push dword edx ; salvar edx
	   imul ebx
	   pop dword edx
	   push dword eax	Basta no usar edx; no hace falta preservarlo
	*/
	/*Sacamos los operandos de la pila*/
	fprintf(fpasm, "\tpop dword ebx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1)
		fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2)
		fprintf(fpasm, "\tmov ebx, dword [ebx]\n");
	/*multiplicacion edx:eax = eax*ebx */
	fprintf(fpasm, "\timul ebx\n");
	/*metemos el resultado en la pila*/
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la division de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void dividir(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A MULTIPLICAR (CUIDADO CON LA EXTENSIÓN DE SIGNO PREVIA
	QUE IMPLICA EL USO DE edx YA QUE cdq EXTIENDE EL SIGNO A edx:eax)
	Y CUIDADO TAMBIÉN CON CONTROLAR EN TIEMPO DE EJECUCIÓN LA
	DIVISIÓN ENTRE 0 */
	fprintf(fpasm, "\tpop dword ebx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1)
		fprintf(fpasm, "\tmov eax, [eax]\n");
	/* b.4.19 cbw , cwd , cdq , cwde : sign extensions */
	fprintf(fpasm, "\tcdq\n");
	/* b.4.117 idiv : signed integer divide */
	if (es_referencia_2) {
		fprintf(fpasm, "\tcmp dword [ebx], 0\n");
		fprintf(fpasm, "\tje gestion_error_div_cero\n");
		fprintf(fpasm, "\tidiv dword [ebx]\n");
	}
	else {
		fprintf(fpasm, "\tcmp ebx, 0\n");
		fprintf(fpasm, "\tje gestion_error_div_cero\n");
		fprintf(fpasm, "\tidiv ebx\n");
	}
	/* apilamos unicamente el cociente */
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la operacion or de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void o(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tor eax, edx\n");
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la operacion and de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void y(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tand eax, edx\n");
	fprintf(fpasm, "\tpush dword eax\n");
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion de igualdad de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void igual(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
		fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tje _igual_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 0\n");//si son distintos haceesto
	fprintf(fpasm, "\tjmp _fin_igual_%d\n", cuantos_if);
	fprintf(fpasm, "_igual_%d:   push dword 1\n", cuantos_if);//si son iguales hace esto
	fprintf(fpasm, "_fin_igual_%d:\n", cuantos_if);
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion de desigualdad de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void distinto(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tjne _distinto_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 0\n");//si son iguales hace esto
	fprintf(fpasm, "\tjmp _fin_distinto_%d\n", cuantos_if);
	fprintf(fpasm, "_distinto_%d:   push dword 1\n", cuantos_if);//si son distintos hace esto
	fprintf(fpasm, "_fin_distinto_%d:\n", cuantos_if);
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion "mayor que" de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void mayor(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tjg _mayor_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 0\n");//si eax <= edx
	fprintf(fpasm, "\tjmp _fin_mayor_%d\n", cuantos_if);
	fprintf(fpasm, "_mayor_%d:   push dword 1\n", cuantos_if);//si eax > edx
	fprintf(fpasm, "_fin_mayor_%d:\n", cuantos_if);
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion "mayor o igual que" de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void mayor_igual(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tjl _no_mayor_igual_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 1\n");//si eax >= edx
	fprintf(fpasm, "\tjmp _fin_mayor_igual_%d\n", cuantos_if);
	fprintf(fpasm, "_no_mayor_igual_%d:   push dword 0\n", cuantos_if);//si eax < edx
	fprintf(fpasm, "_fin_mayor_igual_%d:\n", cuantos_if);
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion "menor que" de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void menor(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tjl _menor_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 0\n");//si eax >= edx
	fprintf(fpasm, "\tjmp _fin_menor_%d\n", cuantos_if);
	fprintf(fpasm, "_menor_%d:   push dword 1\n", cuantos_if);//si eax < edx
	fprintf(fpasm, "_fin_menor_%d:\n", cuantos_if);
}




/**
 * @brief: escribe el codigo nasm para realizar la comparacion "menor o igual que" de los dos operandos que se deben encontrar en la cima de la pila
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_1: un flag que determina si el elemento que NO esta en la cima es una direccion (TRUE) o un valor (FALSE)
 * @param: es_referencia_2: un flag que determina si el elemento que SI esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void menor_igual(FILE* fpasm, int es_referencia_1, int es_referencia_2, int cuantos_if){
	fprintf(fpasm, "\tpop dword edx\n");
	fprintf(fpasm, "\tpop dword eax\n");
	if (es_referencia_1) fprintf(fpasm, "\tmov eax, dword [eax]\n");
	if (es_referencia_2) fprintf(fpasm, "\tmov edx, dword [edx]\n");
	fprintf(fpasm, "\tcmp eax, edx\n");
	fprintf(fpasm, "\tjg _no_menor_igual_%d\n", cuantos_if);
	fprintf(fpasm, "\tpush dword 1\n");//si eax <= edx
	fprintf(fpasm, "\tjmp _fin_menor_igual_%d\n", cuantos_if);
	fprintf(fpasm, "_no_menor_igual_%d:   push dword 0\n", cuantos_if);//si eax > edx
	fprintf(fpasm, "_fin_menor_igual_%d:\n", cuantos_if);
}

/**
 * @brief: escribe el codigo nasm para realizar el comienzo de un if. Obtiene el valor de la condicion de la pila, si es false (0) salta al final del bloque
 * del if (IMPORTANTE: no olvides llamar a la funcion escribir_end_if para imprimir la etiqueta donde acaba el bloque del if)
 * @param: fpams: el archivo donde se va a escribir
 * @param: es_referencia_: un flag que determina si el elemento que esta en la cima es una direccion (TRUE) o un valor (FALSE)
 */
void escribir_if(FILE* fpasm, int es_referencia, int cuantos_if){
	fprintf(fpasm,"\tpop eax\n");
	if(es_referencia)
		fprintf(fpasm,"\tmov eax, [eax]\n");
	fprintf(fpasm,"\tcmp eax, 0\n");
	fprintf(fpasm,"\tje near end_if_%d\n", cuantos_if);
}

/**
 * @brief: escribe el codigo nasm la etiqueta de finalizacion de un salto if
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_end_if(FILE* fpasm, int cuantos_if){
	fprintf(fpasm,"end_if_%d:\n", cuantos_if);
}

/**
 * @brief: escribe el codigo nasm para realizar el comienzo de un else. (IMPORTANTE: no olvides llamar a la funcion escribir_end_else para imprimir la etiqueta donde acaba
 * el bloque else)
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_else(FILE* fpasm, int cuantos_if){
	fprintf(fpasm,"\tjmp near end_else_%d\n", cuantos_if);
	fprintf(fpasm,"end_if_%d:\n", cuantos_if);
}

/**
 * @brief: escribe el codigo nasm la etiqueta de finalizacion de un salto else
 * @param: fpams: el archivo donde se va a escribir
 */
void escribir_end_else(FILE * fpasm, int cuantos_if){
	fprintf(fpasm,"end_else_%d:\n", cuantos_if);
}

void escribir_condicion_while(FILE* fpasm, int es_referencia, int cuantos){
	fprintf(fpasm, "\tpop eax\n");
	if(es_referencia)
		fprintf(fpasm, "\tmov eax, [eax]\n");
	fprintf(fpasm, "\tcmp eax, 0\n");
	fprintf(fpasm, "\tje near end_while_%d\n", cuantos);
}

void escribir_inicio_while(FILE* fpasm, int cuantos){
	fprintf(fpasm, "start_while_%d:\n", cuantos);
}

void escribir_fin_while(FILE* fpasm, int cuantos){
	fprintf(fpasm, "\tjmp near start_while_%d\n", cuantos);
	fprintf(fpasm, "end_while_%d\n", cuantos);
}
