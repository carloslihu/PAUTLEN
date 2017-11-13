%{
	#include <stdio.h>
	#include "tokens.h"
	#include "y.tab.h"
	extern FILE* output;

	int yyerror(char* s){
		if(yylval != TOK_ERROR)
			printf("%d : %s\n",yylval, s);
		return -1;
	}
%}

%token TOK_CTE_ENTERA
%token TOK_CTE_REAL

%left '+' '-'
%left '*' '/'
%right MENOSU


%%
exp: constante {printf("REGLA: exp: constante\n");}
	| exp '+' exp  {printf("REGLA: exp: exp + exp\n");}
	| exp '-' exp {printf("REGLA: exp: exp - exp\n");}
	| exp '*' exp {printf("REGLA: exp: exp * exp\n");}
	| exp '/' exp {printf("REGLA: exp: exp / exp\n");}
	| '-' exp %prec MENOSU {printf("REGLA: exp: - exp\n");}
	| '(' exp ')' {printf("REGLA: exp: (exp)\n");}
	;
constante: TOK_CTE_ENTERA
	| TOK_CTE_REAL
	;
%%