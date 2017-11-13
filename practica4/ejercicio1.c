#include "y.tab.h"
#include <stdio.h>
extern FILE* yyin;

int main(int argc, char** argv){ 
	int retVal;
	if (argc == 2) {
		yyin = fopen(argv[1], "r");
	} else {
		fprintf(stderr, "formato incorrecto:\n./ejecutable input.txt output.txt\n");
		return 1;
	}
	while((retVal = yyparse()) == 0);
	if(retVal == 0)
		printf("\nEXPRESION CORRECTA\n");
	else
		printf("\nEXPRESION INCORRECTA\n");
	return 0; 
}