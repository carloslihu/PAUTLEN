%{
	#include <stdio.h>
	#include "tokens.h"
	int fil=1;
	int col=1;
	extern FILE* output;
%}

%option noyywrap



%%

"(" {printf("TOKEN: (\n"); return TOK_PARENTESISIZQUIERDO;}
")" {printf("TOKEN: )\n"); return TOK_PARENTESISDERECHO;}	
"+" {printf("TOKEN: +\n"); return TOK_MAS;}
- {printf("TOKEN: - \n"); return TOK_MENOS;}
"/" {printf("TOKEN: /\n"); return TOK_DIVISION;}
"*" {printf("TOKEN: *\n"); return TOK_ASTERISCO;}


[0-9]+ {col+=yyleng; return TOK_CTE_ENTERA;}
[0-9]+.[0-9]+ {col+=yyleng; return TOK_CTE_REAL;}


. {
fprintf(stderr, "****Error en [lin %d, col %d]: simbolo no permitido (%s)\n", fil, col, yytext);
col+=yyleng; return TOK_ERROR;}
%%