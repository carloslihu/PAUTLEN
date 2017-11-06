#include <stdio.h>
#include "tokens.h"

extern int yylex();
extern FILE* yyin;
extern int yyleng;
extern char* yytext;
extern int fil;
extern int col;
FILE *output;
int main(int argc, char**argv) {

	long int retVal;
	if (argc == 2) {
		yyin = fopen(argv[1], "r");
		output = stdout;
	} else if (argc == 3) {
		yyin = fopen(argv[1], "r");
		output = fopen(argv[2], "w");
	} else {
		fprintf(stderr, "formato incorrecto:\n./ejecutable input.txt output.txt\n");
		return 1;
	}

	retVal = yylex();
	while (retVal) {
		switch (retVal) {

		/* Palabras reservadas */
		case TOK_MAIN:
			fprintf(output, "TOK_MAIN\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_INT:
			fprintf(output, "TOK_INT\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_BOOLEAN:
			fprintf(output, "TOK_BOOLEAN\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_ARRAY:
			fprintf(output, "TOK_ARRAY\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_FUNCTION:
			fprintf(output, "TOK_FUNCTION\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_IF:
			fprintf(output, "TOK_IF\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_ELSE:
			fprintf(output, "TOK_ELSE\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_WHILE:
			fprintf(output, "TOK_WHILE\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_SCANF:
			fprintf(output, "TOK_SCANF\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_PRINTF:
			fprintf(output, "TOK_PRINTF\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_RETURN:
			fprintf(output, "TOK_RETURN\t%ld\t%s\n", retVal, yytext);
			break;

		/* Símbolos */
		case TOK_PUNTOYCOMA:
			fprintf(output, "TOK_PUNTOYCOMA\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_COMA:
			fprintf(output, "TOK_COMA\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_PARENTESISIZQUIERDO:
			fprintf(output, "TOK_PARENTESISIZQUIERDO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_PARENTESISDERECHO:
			fprintf(output, "TOK_PARENTESISDERECHO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_CORCHETEIZQUIERDO:
			fprintf(output, "TOK_CORCHETEIZQUIERDO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_CORCHETEDERECHO:
			fprintf(output, "TOK_CORCHETEDERECHO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_LLAVEIZQUIERDA:
			fprintf(output, "TOK_LLAVEIZQUIERDA\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_LLAVEDERECHA:
			fprintf(output, "TOK_LLAVEDERECHA\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_ASIGNACION:
			fprintf(output, "TOK_ASIGNACION\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MAS:
			fprintf(output, "TOK_MAS\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MENOS:
			fprintf(output, "TOK_MENOS\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_DIVISION:
			fprintf(output, "TOK_DIVISION\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_ASTERISCO:
			fprintf(output, "TOK_ASTERISCO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_AND:
			fprintf(output, "TOK_AND\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_OR:
			fprintf(output, "TOK_OR\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_NOT:
			fprintf(output, "TOK_NOT\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_IGUAL:
			fprintf(output, "TOK_IGUAL\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_DISTINTO:
			fprintf(output, "TOK_DISTINTO\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MENORIGUAL:
			fprintf(output, "TOK_MENORIGUAL\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MAYORIGUAL:
			fprintf(output, "TOK_MAYORIGUAL\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MENOR:
			fprintf(output, "TOK_MENOR\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_MAYOR:
			fprintf(output, "TOK_MAYOR\t%ld\t%s\n", retVal, yytext);
			break;
		/* Identificadores  */
		case TOK_IDENTIFICADOR:
			fprintf(output, "TOK_IDENTIFICADOR\t%ld\t%s\n", retVal, yytext);
			break;

		/* Constantes */
		case TOK_CONSTANTE_ENTERA:
			fprintf(output, "TOK_CONSTANTE_ENTERA\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_TRUE:
			fprintf(output, "TOK_TRUE\t%ld\t%s\n", retVal, yytext);
			break;
		case TOK_FALSE:
			fprintf(output, "TOK_FALSE\t%ld\t%s\n", retVal, yytext);
			break;

		/* Errores */
		case TOK_ERROR:
			fclose(output);
			fclose(yyin);
			return 0;
			break;
		}
		retVal = yylex();
	}
	fclose(output);
	fclose(yyin);
	return 0;
}