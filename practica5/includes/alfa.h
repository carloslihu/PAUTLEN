#ifndef _ALFA_H
#define _ALFA_H

#include "generacion_codigo.h"

#define MAX_LONG_ID 100
#define MAX_TAMANIO_VECTOR 64


typedef struct{
	char lexema[MAX_LONG_ID + 1];
	int tipo;
	int valor_entero;
	int es_direccion;
	int etiqueta;
} tipo_atributos;

#endif