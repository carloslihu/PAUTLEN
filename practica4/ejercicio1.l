%{
	#include <stdio.h>
	#include "tokens.h"
	#include "y.tab.h"
	int fil=1;
	int col=1;
	extern FILE* output;
%}

%option noyywrap



%%

[ \t]	; // ignore all whitespace
"(" {printf("TOKEN: (\n"); return yytext[0];}
")" {printf("TOKEN: )\n"); return yytext[0];}	
"+" {printf("TOKEN: +\n"); return yytext[0];}
- {printf("TOKEN: - \n"); return yytext[0];}
"/" {printf("TOKEN: /\n"); return yytext[0];}
"*" {printf("TOKEN: *\n"); return yytext[0];}


[0-9]+ {printf("TOKEN: %s\n",yytext); return TOK_CTE_ENTERA;}
[0-9]+"."[0-9]+ {printf("TOKEN: %s\n",yytext); return TOK_CTE_REAL;}


. {
fprintf(stderr, "****Error en [lin %d, col %d]: simbolo no permitido (%s)\n", fil, col, yytext);
col+=yyleng; return TOK_ERROR;}
%%