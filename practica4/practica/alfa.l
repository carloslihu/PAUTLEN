%{
	#include <stdio.h>
	/*#include "tokens.h"*/
	#include "y.tab.h"
	int fil=1;
	int col=1;
	extern FILE* output;
%}

%option noyywrap



%%

main {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MAIN;}
int {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_INT;}
boolean {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_BOOLEAN;}
array {col+=yyleng;  fprintf(output, ";D:\t%s\n",yytext); return TOK_ARRAY;}
function {col+=yyleng;  fprintf(output, ";D:\t%s\n",yytext); return TOK_FUNCTION;}
if {col+=yyleng;  fprintf(output, ";D:\t%s\n",yytext); return TOK_IF;}
else {col+=yyleng;  fprintf(output, ";D:\t%s\n",yytext); return TOK_ELSE;}
while {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_WHILE;}
scanf {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_SCANF;}
printf {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_PRINTF;}
return {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_RETURN;}
true {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_TRUE;}
false {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_FALSE;}


; {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_PUNTOYCOMA;}
, {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_COMA;}
"(" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_PARENTESISIZQUIERDO;}
")" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_PARENTESISDERECHO;}	
"[" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_CORCHETEIZQUIERDO;}
"]" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_CORCHETEDERECHO;}
"{" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_LLAVEIZQUIERDA;}
"}" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_LLAVEDERECHA;}
= {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_ASIGNACION;}
"+" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MAS;}
- {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MENOS;}
"/" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_DIVISION;}
"*" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_ASTERISCO;}
&& {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_AND;}
"||" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_OR;}
! {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_NOT;}
== {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_IGUAL;}
!= {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_DISTINTO;}
"<"= {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MENORIGUAL;}
>= {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MAYORIGUAL;}
"<" {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MENOR;}   
> {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_MAYOR;}

\n {fil++; col=1;}

[ \t] {col+=yyleng;}

"//"[^\n]*\n {fil++; col=1;}

[0-9]+ {col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_CONSTANTE_ENTERA;}

[a-zA-Z][0-9a-zA-Z_]* {		
	if (yyleng > 100) {
		fprintf(stderr, "****Error en [lin %d, col %d]: identificador demasiado largo (%s)\n", fil, col, yytext);
		return TOK_ERROR;
		}
	col+=yyleng; fprintf(output, ";D:\t%s\n",yytext); return TOK_IDENTIFICADOR;}


. {
fprintf(stderr, "****Error en [lin %d, col %d]: simbolo no permitido (%s)\n", fil, col, yytext);
col+=yyleng; return TOK_ERROR;}
%%