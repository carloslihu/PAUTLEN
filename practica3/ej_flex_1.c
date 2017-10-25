#include <stdio.h>
#include "tokens.h"

extern int yylex();
extern FILE* yyin;
extern int yylen;
extern char* yytext;
extern int fil;
extern int col;

int main(int argc, char**argv){
	FILE *output;
	long int retVal;
	if(argc == 2){
		yyin = fopen(argv[1],"r");
		output = stdout;
	} else if(argc == 3){
		yyin = fopen(argv[1],"r");
		output = fopen(argv[2],"w");
	} else {
		fprintf(stderr,"formato incorrecto:\n./ejecutable input.txt output.txt\n");
		return 1;
	}

	retVal = yylex();
	while(retVal){
		fprintf(output,"RECONOCIDO %ld:%s",retVal,yytext);
		retVal = yylex();
	}

	printf("%d\n",yylex());
	return 0;
}