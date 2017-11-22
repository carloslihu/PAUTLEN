/*#ifndef​ GENERACION_CODIGO_H
#define​ GENERACION_CODIGO_H*/
#include "types.h"


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
void cambiar_signo(FILE * fpasm, int es_referencia);//probar
void no(FILE * fpasm, int es_referencia, int cuantos_no);//probar
void leer(FILE * fpasm, char * nombre, int tipo);
void escribir(FILE * fpasm, int es_referencia, int tipo);
void restar(FILE * fpasm, int es_referencia_1, int es_referencia_2);//probar
void multiplicar(FILE * fpasm, int es_referencia_1, int es_referencia_2);//probar
void dividir(FILE * fpasm, int es_referencia_1, int es_referencia_2);//probar
void o(FILE * fpasm, int es_referencia_1, int es_referencia_2);//probar
void y(FILE * fpasm, int es_referencia_1, int es_referencia_2);//probar

/*#endif  */