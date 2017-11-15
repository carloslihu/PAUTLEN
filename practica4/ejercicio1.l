%{
	#include <stdio.h>
	#include "tokens.h"
	#include "y.tab.h"
	int fil=1;
	int col=1;
	extern FILE* output;
	extern int ylval;
%}

%option noyywrap



%%

[ \t]	; // ignore all whitespace
"(" {printf("TOKEN: (\n"); yylval = yytext[0]; return yytext[0];}
")" {printf("TOKEN: )\n"); yylval = yytext[0]; return yytext[0];}	
"+" {printf("TOKEN: +\n"); yylval = yytext[0]; return yytext[0];}
- {printf("TOKEN: - \n"); yylval = yytext[0]; return yytext[0];}
"/" {printf("TOKEN: /\n"); yylval = yytext[0]; return yytext[0];}
"*" {printf("TOKEN: *\n"); yylval = yytext[0]; return yytext[0];}


[0-9]+ {printf("TOKEN: %s\n",yytext); yylval = TOK_CTE_ENTERA; return TOK_CTE_ENTERA;}
[0-9]+"."[0-9]+ {printf("TOKEN: %s\n",yytext); yylval = TOK_CTE_REAL; return TOK_CTE_REAL;}

. {
fprintf(stderr, "****Error en [lin %d, col %d]: simbolo no permitido (%s)\n", fil, col, yytext);
col+=yyleng;
yylval = TOK_ERROR; 
return TOK_ERROR;}
%%