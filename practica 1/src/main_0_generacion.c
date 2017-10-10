#include <stdio.h>
#include "../includes/generacion_codigo.h"


void declarar_data_string(FILE* fp, char* nombre, char* str) {
	fprintf(fp, "\t_%s db \"%s\", 0\n", nombre, str);
}

void escribir_string(FILE* fp, char* nombre) {
	fprintf(fp, "\tpush dword _%s\n\tcall print_string\n", nombre);
}

int main (int argc, char ** argv)
{

	FILE * salida;

	if (argc != 2) {fprintf (stdout, "ERROR POCOS ARGUMENTOS\n"); return -1;}


	salida = fopen(argv[1], "w");


	escribir_cabecera_compatibilidad(salida);
	escribir_subseccion_data(salida);
	declarar_data_string(salida, "suma", "probando todos los casos de suma");
	declarar_data_string(salida, "resta", "probando todos los casos de suma");
	declarar_data_string(salida, "cambiarSigno", "probando todos los casos de cambiar signo");
	declarar_data_string(salida, "no", "probando todos los casos de no");
	declarar_data_string(salida, "multiplicar", "probando todos los casos de multiplicar");
	declarar_data_string(salida, "dividir", "probando todos los casos de dividir");
	declarar_data_string(salida, "or", "probando todos los casos de or");
	declarar_data_string(salida, "and", "probando todos los casos de and");
	escribir_cabecera_bss(salida);



	declarar_variable(salida, "x", ENTERO, 1);
	declarar_variable(salida, "y", ENTERO, 1);
	declarar_variable(salida, "z", ENTERO, 1);


	escribir_segmento_codigo(salida);
	escribir_inicio_main(salida);

	/* x=6; */
	escribir_operando(salida, "6", 0);
	asignar(salida, "x", 0);

	/* scanf y; */
	leer(salida, "y", ENTERO);
	//printf("%d\n%d", y, x);
	escribir_operando(salida, "y", 1);
	escribir(salida, 1, ENTERO);
	escribir_operando(salida, "x", 1);
	escribir(salida, 1, ENTERO);



	//EMPEZAMOS A PROBAR LAS OPERACIONES ARITMETICAS

	/*NOTA: todos los "//printf("1000001\n");" que hay mas abajo son para tener unas "etiquetas" por las que guiarse al ver tanto el output
	como el codigo asm generado. Su proposito es unicamente de debug. Nada más*/

	//--------------------------------------------------------
	//suma
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//z = y+x+x+1;
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "y", 1);
	//		[_y] + [_x]
	sumar(salida, 1, 1);
	//		noref + [_x]
	sumar(salida, 1, 0);
	//		noref+noref
	sumar(salida, 0, 0);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//z = x+1;
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "x", 1);
	//		[_x] + noref
	sumar(salida, 0, 1);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//resta
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//z = y - x - x - 1;
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "y", 1);
	//		[_y] - [_x]
	restar(salida, 1, 1);
	//		noref - [_x]
	restar(salida, 1, 0);
	//		noref - noref
	restar(salida, 0, 0);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//z = x-1;
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "x", 1);
	//		[_x] - 1
	restar(salida, 0, 1);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//cambio de signo
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	////printf("%d\n",-1);
	escribir_operando(salida, "1", 0);
	cambiar_signo(salida, 0);
	escribir(salida, 0, ENTERO);
	////printf("%d\n",-z);
	escribir_operando(salida, "z", 1);
	cambiar_signo(salida, 1);
	escribir(salida, 0, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//no
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//printf("%d\n",!1);
	escribir_operando(salida, "1", 0);
	no(salida, 0, 0);
	escribir(salida, 0, ENTERO);
	//z=0;
	escribir_operando(salida, "0", 0);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	no(salida, 1, 1);
	escribir(salida, 0, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//multiplicar
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//z = y*x*x*2
	escribir_operando(salida, "2", 0);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "y", 1);
	//		[_y]*[_x]
	multiplicar(salida, 1, 1);
	//		noref*[_x]
	multiplicar(salida, 1, 0);
	//		noref*noref
	multiplicar(salida, 0, 0);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//z = x*2;
	escribir_operando(salida, "2", 0);
	escribir_operando(salida, "x", 1);
	//		[_x]*noref
	multiplicar(salida, 0, 1);
	asignar(salida, "z", 0);
	//printf("%d\n",z);
	escribir_operando(salida, "z", 1);
	escribir(salida, 1, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//dividir
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//y=3;
	escribir_operando(salida, "3", 0);
	asignar(salida, "y", 0);
	//z=6;
	escribir_operando(salida, "6", 0);
	asignar(salida, "z", 0);
	//x=z;
	escribir_operando(salida, "z", 1);
	asignar(salida, "x", 1);
	//printf("%d\n",x/y/2);
	escribir_operando(salida, "2", 0);
	escribir_operando(salida, "y", 1);
	escribir_operando(salida, "x", 1);
	//		[_x]/[_y]
	dividir(salida, 1, 1);
	//		noref/noref
	dividir(salida, 0, 0);
	escribir(salida, 0, ENTERO);
	//printf("%d\n",x/3);
	escribir_operando(salida, "3", 0);
	escribir_operando(salida, "x", 1);
	//		[_x]/noref
	dividir(salida, 0, 1);
	escribir(salida, 0, ENTERO);
	//printf("%d\n",12/x);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "12", 0);
	//		noref/[_x]
	dividir(salida, 1, 0);
	escribir(salida, 0, ENTERO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//or
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//printf("%d\n",1||0);
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "0", 0);
	//		noref || noref
	o(salida, 0, 0);
	escribir(salida, 0, BOOLEANO);
	//z=0;
	escribir_operando(salida, "0", 0);
	asignar(salida, "z", 0);
	//printf("%d\n",1||z);
	escribir_operando(salida, "z", 1);
	escribir_operando(salida, "1", 0);
	//		noref || [_z]
	o(salida, 1, 0);
	escribir(salida, 0, BOOLEANO);
	//printf("%d\n",z||0);
	escribir_operando(salida, "0", 0);
	escribir_operando(salida, "z", 1);
	//		[_z] || noref
	o(salida, 0, 1);
	escribir(salida, 0, BOOLEANO);
	//x=0;
	escribir_operando(salida, "0", 0);
	asignar(salida, "x", 0);
	//printf("%d\n",z||x);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "z", 1);
	//		[_z] || [_x]
	o(salida, 1, 1);
	escribir(salida, 0, BOOLEANO);
	//--------------------------------------------------------


	//--------------------------------------------------------
	//and
	//printf("1000001\n");
	escribir_operando(salida, "1000001", 0);
	escribir(salida, 0, ENTERO);
	//printf("%d\n",1&&1);
	escribir_operando(salida, "1", 0);
	escribir_operando(salida, "1", 0);
	//		noref && noref
	y(salida, 0, 0);
	escribir(salida, 0, BOOLEANO);
	//z=0;
	escribir_operando(salida, "0", 0);
	asignar(salida, "z", 0);
	//printf("%d\n",1&&z);
	escribir_operando(salida, "z", 1);
	escribir_operando(salida, "1", 0);
	//		noref && [_z]
	y(salida, 1, 0);
	escribir(salida, 0, BOOLEANO);
	//printf("%d\n",z&&0);
	escribir_operando(salida, "0", 0);
	escribir_operando(salida, "z", 1);
	//		[_z] && noref
	y(salida, 0, 1);
	escribir(salida, 0, BOOLEANO);
	//x=1;
	escribir_operando(salida, "1", 0);
	asignar(salida, "x", 0);
	//z=1;
	escribir_operando(salida, "1", 0);
	asignar(salida, "z", 0);
	//printf("%d\n",z&&x);
	escribir_operando(salida, "x", 1);
	escribir_operando(salida, "z", 1);
	y(salida, 1, 1);
	escribir(salida, 0, BOOLEANO);
	//--------------------------------------------------------


	escribir_fin(salida);

	fclose(salida);
	return 0;


}
