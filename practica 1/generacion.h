#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BOOLEAN 0
#define ENTERO 1

#define TRUE 1
#define FALSE 0


void escribir_cabecera_compatibilidad(FILE* fpasm);
void escribir_subseccion_data(FILE* fpasm);
void escribir_cabecera_bss(FILE* fpasm);
void declarar_variable(FILE* fpasm, char * nombre,  int tipo,  int tamano);
void escribir_segmento_codigo(FILE* fpasm);
void escribir_inicio_main(FILE* fpasm);
void escribir_fin(FILE* fpasm);
void escribir_operando(FILE * fpasm, char * nombre, int es_var);
void asignar(FILE * fpasm, char * nombre, int es_referencia);
void sumar(FILE * fpasm, int es_referencia_1, int es_referencia_2);
void cambiar_signo(FILE * fpasm, int es_referencia);
void no(FILE * fpasm, int es_referencia, int cuantos_no);
void leer(FILE * fpasm, char * nombre, int tipo);
void escribir(FILE * fpasm, int es_referencia, int tipo);
void restar(FILE * fpasm, int es_referencia_1, int es_referencia_2);
void multiplicar(FILE * fpasm, int es_referencia_1, int es_referencia_2);
void dividir(FILE * fpasm, int es_referencia_1, int es_referencia_2);
void o(FILE * fpasm, int es_referencia_1, int es_referencia_2);
void y(FILE * fpasm, int es_referencia_1, int es_referencia_2);