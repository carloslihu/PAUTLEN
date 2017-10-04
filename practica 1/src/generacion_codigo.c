#include "../includes/generacion_codigo.h"



/**********************************************************************************/

void escribir_cabecera_compatibilidad(FILE* fpasm)
{
	/* FUNCIÓN PARA PODER HACER EL CÓDIGO MULTIPLATAFORMA U OTROS PARÁMETROS GENERALES TAL VEZ SE PUEDA QUEDAR VACÍA */

	/* G1 */

}
/**********************************************************************************/

void escribir_subseccion_data(FILE* fpasm)
{
	/* FUNCIÓN PARA ESCRIBIR LA SECCIÓN .data:
		MENSAJES GENERALES (TEXTOS)
		VARIABLES AUXILIARES NECESARIAS EN EL COMPILADOR QUE DEBAN TENER UN VALOR CONCRETO */
	/* Variables auxiliares para mensajes de errores en tiempo de ejecución */
	fprintf(fpasm, "SEGMENT .DATA\n\tMSG_ERROR_DIVISION DB \"ERROR: DIVISON BY ZERO\", 0\n");

	/* G2 */

}
/**********************************************************************************/
void escribir_cabecera_bss(FILE* fpasm)
{
	/* FUNCIÓN PARA ESCRIBIR EL INICIO DE LA SECCIÓN .bss:
		AL MENOS HAY QUE DECLARAR LA VARIABLE AUXILIAR PARA GUARDAR EL PUNTERO DE PILA __esp
	*/
	fprintf(fpasm, "SEGMENT .BSS\n");
	fprintf(fpasm, "\t__ESP RESD 1\n");


	/* G3 */

}
/**********************************************************************************/
void declarar_variable(FILE* fpasm, char * nombre,  int tipo,  int tamano)
/* tipo no hace falta porque para nosotros todo es entero en esta versión, se deja por compatibilidad con futuras versiones*/
{
	/* GENERA EL CÓDIGO ASOCIADO EN LA SECCIÓN .bss PARA DECLARAR UNA VARIABLE CON
		SU NOMBRE (HAY QUE PRECEDER DE _)
		EL TAMANO (1 PARA VARIABLES QUE NO SEAN VECTORES O SU TAMANO EN OTRO CASO )
		TIPO NOSOTROS USAREMOS ESTE AÑO ENTERO O BOOLEANO

	*/


	/* G4 */
	fprintf(fpasm, "\t_%s RESD %d\n", nombre,  tamano);


}

/************************************************************************************/

void escribir_segmento_codigo(FILE* fpasm)
{
	/* ESCRIBE EL INICIO DE LA SECCIÓN DE CÓDIGO
		DECLARACIONES DE FUNCIONES QUE SE TOMARAN DE OTROS MODULOS
		DECLARACION DE main COMO ETIQUETA VISIBLE DESDE EL EXTERIOR
	*/

	/* G5 */
	fprintf(fpasm, "SEGMENT .TEXT\n\tGLOBAL MAIN\n\tEXTERN SCAN_INT, PRINT_INT, SCAN_FLOAT, PRINT_FLOAT, SCAN_BOOLEAN, PRINT_BOOLEAN\n\tEXTERN PRINT_ENDOFLINE, PRINT_BLANK, PRINT_STRING\n\tEXTERN ALFA_MALLOC, ALFA_FREE, LD_FLOAT\n");


}

/**********************************************************************************/

void escribir_inicio_main(FILE* fpasm)
{
	/* ESCRIBE EL PRINCIPIO DEL CÓDIGO PROPIAMENTE DICHO
		ETIQUETA DE INICIO
		SALVAGUARDA DEL PUNTERO DE PILA (esp) EN LA VARIABLE A TAL EFECTO (__esp)

	*/


	/* G6 */
	fprintf( fpasm, "\nMAIN:\n\tMOV DWORD [__ESP], ESP\n");
}

/**********************************************************************************/

void escribir_fin(FILE* fpasm)
{
	/* ESCRITURA DEL FINAL DEL PROGRAMA
		GESTIÓN DE ERROR EN TIEMPO DE EJECUCIÓN (DIVISION POR 0)
		RESTAURACION DEL PUNTERO DE PILA A PARTIR DE LA VARIABLE __esp
		SENTENCIA DE RETORNO DEL PROGRAMA
	*/


	fprintf(fpasm, "\tMOV DWORD ESP, [__ESP]\n\tRET\nGESTION_ERROR_DIV_CERO:\n\tPUSH DWORD MSG_ERROR_DIVISION\n\tCALL PRINT_STRING\n\tADD ESP, 4\n\tCALL PRINT_ENDOFLINE\n\tRET\n");


	/* G7 */

}

/**********************************************************************************/

void escribir_operando(FILE * fpasm, char * nombre, int es_var)
{
	/* SE INTRODUCE EL OPERANDO nombre EN LA PILA
		SI ES UNA VARIABLE (es_var == 1) HAY QUE PRECEDER EL NOMBRE DE _
		EN OTRO CASO, SE ESCRIBE TAL CUAL

	*/

	/* G8 */
	if (es_var == 1) {
		fprintf(fpasm, "\tPUSH DWORD  _%s \n", nombre);
	}
	else {
		fprintf(fpasm, "\tPUSH DWORD  %s \n", nombre);

	}




}

void asignar(FILE * fpasm, char * nombre, int es_referencia)
{
	/* ESCRIBE EL CÓDIGO PARA REALIZAR UNA ASIGNACIÓN DE LO QUE ESTÉ EN LA CIMA DE LA PILA A LA VARIABLE nombre
		SE RECUPERA DE LA PILA LO QUE HAYA POR EJEMPLO EN EL REGISTRO eax
		SI es_referencia == 0 (ES UN VALOR) DIRECTAMENTE SE ASIGNA A LA VARIABLE _nombre
		EN OTRO CASO es_referencia == 1 (ES UNA DIRECCIÓN, UN NOMBRE DE VARIABLE) HAY QUE OBTENER SU VALOR DESREFERENCIANDO
	EL VALOR ES [eax]


	*/


	if (es_referencia == 0)
		fprintf(fpasm, "\tPOP DWORD EAX\n\tMOV DWORD [_%s], EAX\n", nombre);

	else if (es_referencia == 1)
		/*OPCION A*/fprintf(fpasm, "\tPOP DWORD EAX\n\tMOV EAX, DWORD [EAX]\n\tMOV DWORD [_NOMBRE], EAX\n");
	///*OPCION B*/fprintf(fpasm,"pop dword eax\n mov  dword [_nombre], dword [eax]");
	/*podeis votar  */
//ninguna es valida->
//Ambas validas-> I
//A -> I I I
//B ->
	else; //caso error de parametro entrada es_referencia
}


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
	/* G10 */
	fprintf(fpasm, "\tPOP DWORD EDX\n");
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	if (es_referencia_1) fprintf(fpasm, "\tMOV EAX, DWORD [EAX]\n");
	if (es_referencia_2) fprintf(fpasm, "\tMOV EDX, DWORD [EDX]\n");
	fprintf(fpasm, "\tADD EAX, EDX\n");
	fprintf(fpasm, "\tPUSH DWORD EAX\n");

}


void cambiar_signo(FILE * fpasm, int es_referencia)
{
	/* GENERA EL CÓDIGO PARA CAMBIAR DE SIGNO LO QUE HAYA EN LA CIMA DE LA PILA
	TENIENDO EN CUENTA QUE PUEDE SER UN VALOR INMEDIATO O UNA REFERENCIA
	A UN VALOR INMEDIATO (VER ASIGNAR)
	*/
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	if (es_referencia == 1) {
		fprintf(fpasm, "\tMOV EAX, [EAX]\n");
	}
	fprintf(fpasm, "\tNEG EAX\n");


	/* G11 */


}

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

	fprintf(fpasm, "\tPOP EAX\n");
	if (es_referencia == 1) {
		fprintf(fpasm, "\tCMP [EAX], 0\n");
	} else {
		fprintf(fpasm, "\tCMP EAX, 0\n");
	}
	fprintf(fpasm, "\tJE _UNO_%d\n", cuantos_no);
	fprintf(fpasm, "\tPUSH DWORD 0\n");
	fprintf(fpasm, "\tJMP _FIN_NEGAR_%d\n", cuantos_no);
	fprintf(fpasm, "_UNO_%d:   PUSH DWORD 1\n", cuantos_no);
	fprintf(fpasm, "_FIN_NEGAR_%d:\n", cuantos_no);


	/* G12 */

}


void leer(FILE * fpasm, char * nombre, int tipo)
{
	/* GENERA EL CÓDIGO PARA LEEER UNA VARIABLE DE NOMBRE nombre Y TIPO tipo (ESTE
	AÑO SÓLO USAREMOS ENTERO Y BOOLEANO) DE CONSOLA LLAMANDO A LAS CORRESPONDIENTES
	FUNCIONES DE ALFALIB (scan_int Y scan_boolean)
	*/

	fprintf(fpasm, "\tPUSH DWORD _%s\n", nombre);

	if (tipo == ENTERO)
		fprintf(fpasm, "\tCALL SCAN_INT\n");
	else
		fprintf(fpasm, "\tCALL SCAN_BOOLEAN\n");

	fprintf(fpasm, "\tADD ESP, 4\n");


	/* G13 */

}


void escribir(FILE * fpasm, int es_referencia, int tipo)
{
	/* GENERA EL CÓDIGO PARA ESCRIBIR POR PANTALLA LO QUE HAYA EN LA CIMA DE LA PILA
	TENIENDO EN CUENTA QUE PUEDE SER UN VALOR INMEDIATNO (es_referencia == 0) O UNA
	REFERENCIA A UN VALOR INMEDIANTO (es_referencia == 1) Y QUE HAY QUE LLAMAR A LA CORRESPONDIENTE
	FUNCIÓN DE ALFALIB (print_int O print_boolean) DEPENDIENTO DEL TIPO (tipo == BOOLEANO
	O ENTERO )
	*/

	if (es_referencia == 1)
		fprintf(fpasm, "\tPOP EAX\n\tPUSH DWORD [EAX]\n");
	if (tipo != ENTERO)
		fprintf(fpasm, "\tCALL PRINT_BOOLEAN\n");
	else
		fprintf(fpasm, "\tCALL PRINT_INT\n");

	if (es_referencia == 1)
		fprintf(fpasm, "\tADD ESP, 4\n");

	fprintf(fpasm, "\tCALL PRINT_ENDOFLINE\n");
	/* G14 */


}



void restar(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */
	fprintf(fpasm, "\tPOP DWORD EDX\n");
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	if (es_referencia_1) fprintf(fpasm, "\tMOV EAX, DWORD [EAX]\n");
	if (es_referencia_2) fprintf(fpasm, "\tMOV EDX, DWORD [EDX]\n");
	fprintf(fpasm, "\tSUB EAX, EDX\n");
	fprintf(fpasm, "\tPUSH DWORD EAX\n");
}

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
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	fprintf(fpasm, "\tPOP DWORD EBX\n");
	if (es_referencia_1)
		fprintf(fpasm, "\tMOV EAX, DWORD [EAX]\n");
	if (es_referencia_2)
		fprintf(fpasm, "\tMOV EBX, DWORD [EBX]\n");

	/*Multiplicacion edx:eax = eax*ebx */
	fprintf(fpasm, "\tIMUL EBX\n");

	/*Metemos el resultado en la pila*/
	fprintf(fpasm, "\tPUSH DWORD EAX\n");


	/* G15 */



}

void dividir(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A MULTIPLICAR (CUIDADO CON LA EXTENSIÓN DE SIGNO PREVIA
	QUE IMPLICA EL USO DE edx YA QUE cdq EXTIENDE EL SIGNO A edx:eax)
	Y CUIDADO TAMBIÉN CON CONTROLAR EN TIEMPO DE EJECUCIÓN LA
	DIVISIÓN ENTRE 0 */


	/* G16 */

	fprintf(fpasm, "\tPOP DWORD EBX\n");
	fprintf(fpasm, "\tPOP DWORD EAX\n");

	if (es_referencia_1)
		fprintf(fpasm, "\tMOV EAX, [EAX]\n");

	/* B.4.19 CBW , CWD , CDQ , CWDE : Sign Extensions */
	fprintf(fpasm, "\tCDQ\n");

	/* B.4.117 IDIV : Signed Integer Divide */

	/* Aqui habria que comprobar que ebx o [ebx] no es 0 y saltar
	   donde corresponda si lo es */

	if (es_referencia_2)
		fprintf(fpasm, "\tIDIV [EBX]\n");
	else
		fprintf(fpasm, "\tIDIV EBX\n");

	/* Apilamos unicamente el cociente */
	fprintf(fpasm, "\tPUSH DWORD EAX\n");



}

void o(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */

	fprintf(fpasm, "\tPOP DWORD EDX\n");
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	if (es_referencia_1) fprintf(fpasm, "\tMOV EAX, DWORD [EAX]\n");
	if (es_referencia_2) fprintf(fpasm, "\tMOV EDX, DWORD [EDX]\n");
	fprintf(fpasm, "\tOR EAX, EDX\n");
	fprintf(fpasm, "\tPUSH DWORD EAX\n");


}


void y(FILE * fpasm, int es_referencia_1, int es_referencia_2)
{
	/* SIMILAR A SUMAR */
	fprintf(fpasm, "\tPOP DWORD EDX\n");
	fprintf(fpasm, "\tPOP DWORD EAX\n");
	if (es_referencia_1) fprintf(fpasm, "\tMOV EAX, DWORD [EAX]\n");
	if (es_referencia_2) fprintf(fpasm, "\tMOV EDX, DWORD [EDX]\n");
	fprintf(fpasm, "\tAND EAX, EDX\n");
	fprintf(fpasm, "\tPUSH DWORD EAX\n");

}


