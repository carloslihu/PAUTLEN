#include <stdio.h>
#include "../includes/generacion_codigo.h"


void declarar_data_string(FILE* fp, char* nombre, char* str){
	fprintf(fp,"_%s db \"%s\", 0\n",nombre,str);
}

void escribir_string(FILE* fp, char* nombre){
	fprintf(fp,"\tpush dword _%s\n\tcall print_string\n");
}

int main (int argc, char ** argv)
{
	/*codigo que deberia resultar*/
	int x;
	int y;
	int z;
	
	x = 6;

	printf("probando todos los casos de suma\n");
	scanf("%d",y);
	z = 1 + x + x + y;
	printf("%d\n",z);
	z = x + 1
	printf("%d\n",z);

	printf("\nprobando todos los casos de resta\n");
	z = 1 - x - x - y
	printf("%d\n",z);
	z = x - 1
	printf("%d\n",z);

	printf("\nprobando todos los casos de cambiar signo\n");
	printf("%d\n",-1);
	z = -z;
	printf("%d\n",z);

	printf("\nprobando todos los casos de no\n");
	printf("%d\n",!1);
	z = 0;
	printf("%d\n",!z);

	printf("\nprobando todos los casos de multiplicar\n");
	z = 2*x*x*y;
	printf("%d\n",z);
	z = x*2;
	printf("%d\n",z);

	printf("\nprobando todos los casos de dividir\n");
	y=3;
	z = 10/x/y;
	printf("%d\n",z);
	z = x/3;
	printf("%d\n",z);
	z = 12/x;
	printf("%d\n",z);

	printf("\nprobando todos los casos de or\n");
	z = 1 || 0
	printf("%d\n",z);
	z = z || 0;
	printf("%d\n",z);
	x = 0;
	z = 0 || x;
	printf("%d\n",z);
	z = z || x
	printf("%d\n",z);

	printf("\nprobando todos los casos de and\n");
	z = 1 && 0
	printf("%d\n",z);
	z = z && 0;
	printf("%d\n",z);
	x = 0;
	z = 0 && x;
	printf("%d\n",z);
	z = z && x
	printf("%d\n",z);

	FILE * salida;

	if (argc != 2) {fprintf (stdout, "ERROR POCOS ARGUMENTOS\n"); return -1;}
	

	salida = fopen(argv[1],"w");


	escribir_cabecera_compatibilidad(salida);
	escribir_subseccion_data(salida);
	declarar_data_string(salida,"suma","probando todos los casos de suma\n");
	declarar_data_string(salida,"resta","probando todos los casos de suma\n");
	declarar_data_string(salida,"cambiarSigno","probando todos los casos de cambiar signo\n");
	declarar_data_string(salida,"no","probando todos los casos de no\n");
	declarar_data_string(salida,"multiplicar","probando todos los casos de multiplicar\n");
	declarar_data_string(salida,"dividir","probando todos los casos de dividir\n");
	declarar_data_string(salida,"or","probando todos los casos de or\n");
	declarar_data_string(salida,"and","probando todos los casos de and\n");
	escribir_cabecera_bss(salida);



	declarar_variable(salida, "x", ENTERO, 1);
	declarar_variable(salida, "y", ENTERO, 1);
	declarar_variable(salida, "z", ENTERO, 1);


	escribir_segmento_codigo(salida);
	escribir_inicio_main(salida);

	/* x=8; */

	escribir_operando(salida,"8",0);
	asignar(salida,"x",0);

	/* scanf y; */
	escribir(salida,1,ENTERO);
	leer(salida,"y",ENTERO);

	/* z = x + y */
	//suma
	escribir_string(salida,"suma");
	escribir_operando(salida,"1",0);
	escribir_operando(salida,"x",1);
	escribir_operando(salida,"x",1);
	escribir_operando(salida,"y",1);
	sumar(salida,1,1);
	sumar(salida,0,1);
	sumar(salida,0,0);
	asignar(salida,"z",0);
	escribir_operando(salida, "z", 1);
	escribir(salida,1,ENTERO);
	escribir_operando(salida,"1",0);
	escribir_operando(salida,"x",1);
	sumar(salida,1,0);
	asignar(salida,"z",0);
	escribir_operando(salida, "z", 1);
	/* printf z; */
	//resta
	escribir_string(salida,"resta");
	escribir_operando(salida,"1",0);
	escribir_operando(salida,"x",1);
	escribir_operando(salida,"x",1);
	escribir_operando(salida,"y",1);
	restar(salida,1,1);
	restar(salida,0,1);
	restar(salida,0,0);
	asignar(salida,"z",0);
	escribir_operando(salida, "z", 1);
	escribir(salida,1,ENTERO);
	escribir_operando(salida,"1",0);
	escribir_operando(salida,"x",1);
	restar(salida,1,0);
	asignar(salida,"z",0);
	escribir_operando(salida, "z", 1);
	/* printf z; */
	//cambio de signo
	escribir_string(salida, "cambiarSigno");
	escribir_operando(salida,1,ENTERO);
	cambiar_signo(0);
	escribir(salida,0,ENTERO);
	escribir_operando(salida, "z",1);
	cambiar_signo(1);
	escribir(salida,0,ENTERO);
	//no
	



	escribir_fin(salida);

	fclose(salida);
	return 0;


}
