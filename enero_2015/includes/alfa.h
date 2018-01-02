#ifndef _ALFA_H
#define _ALFA_H

#include "types.h"
#include "generacion.h"
#include "tablaSimbolos.h"


typedef struct{
	char lexema[MAX_LONG_ID + 1];
	int tipo;
	int valor_entero;
	int es_direccion;
	int etiqueta;
} tipo_atributos;

#endif