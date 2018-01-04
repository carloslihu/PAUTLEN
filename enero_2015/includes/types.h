#ifndef TYPES_H
#define TYPES_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { GLOBAL = 0, LOCAL = 1 } AMBITO;

#define MAX_LONG_ID 100
#define MAX_TAMANIO_VECTOR 64

#define TRUE 1
#define FALSE 0

#define POS_INI_PARAMS 0        /* posición de inicio de parámetros de función (empiezan a contar en 0) */
#define POS_INI_VARS_LOCALES 1  /* posición de inicio de variables locales de función (empiezan a contar en 1) */

/* Retorno de función error/ok */
typedef enum { ERR = 0, OK = 1 } STATUS;

/* Categoría de un símbolo: variable, parámetro de función o función */
typedef enum { VARIABLE, PARAMETRO, FUNCION } CATEGORIA;

/* Tipo de un símbolo: sólo se trabajará con enteros y booleanos */
typedef enum { ENTERO, BOOLEANO } TIPO;

/* Clase de un símbolo: pueden ser variables atómicas (escalares) o listas/arrays (vectores) */
typedef enum { ESCALAR, VECTOR } CLASE;

#endif