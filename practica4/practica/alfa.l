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

main {col+=yyleng; return TOK_MAIN;}
int {col+=yyleng; return TOK_INT;}
boolean {col+=yyleng; return TOK_BOOLEAN;}
array {col+=yyleng;  return TOK_ARRAY;}
function {col+=yyleng;  return TOK_FUNCTION;}
if {col+=yyleng;  return TOK_IF;}
else {col+=yyleng;  return TOK_ELSE;}
while {col+=yyleng; return TOK_WHILE;}
scanf {col+=yyleng; return TOK_SCANF;}
printf {col+=yyleng; return TOK_PRINTF;}
return {col+=yyleng; return TOK_RETURN;}
true {col+=yyleng; return TOK_TRUE;}
false {col+=yyleng; return TOK_FALSE;}


; {col+=yyleng; return TOK_PUNTOYCOMA;}
, {col+=yyleng; return TOK_COMA;}
"(" {col+=yyleng; return TOK_PARENTESISIZQUIERDO;}
")" {col+=yyleng; return TOK_PARENTESISDERECHO;}	
"[" {col+=yyleng; return TOK_CORCHETEIZQUIERDO;}
"]" {col+=yyleng; return TOK_CORCHETEDERECHO;}
"{" {col+=yyleng; return TOK_LLAVEIZQUIERDA;}
"}" {col+=yyleng; return TOK_LLAVEDERECHA;}
= {col+=yyleng; return TOK_ASIGNACION;}
"+" {col+=yyleng; return TOK_MAS;}
- {col+=yyleng; return TOK_MENOS;}
"/" {col+=yyleng; return TOK_DIVISION;}
"*" {col+=yyleng; return TOK_ASTERISCO;}
&& {col+=yyleng; return TOK_AND;}
"||" {col+=yyleng; return TOK_OR;}
! {col+=yyleng; return TOK_NOT;}
== {col+=yyleng; return TOK_IGUAL;}
!= {col+=yyleng; return TOK_DISTINTO;}
"<"= {col+=yyleng; return TOK_MENORIGUAL;}
>= {col+=yyleng; return TOK_MAYORIGUAL;}
"<" {col+=yyleng; return TOK_MENOR;}   
> {col+=yyleng; return TOK_MAYOR;}

\n {fil++; col=1;}

[ \t] {col+=yyleng;}

"//"[^\n]*\n {fil++; col=1;}

[0-9]+ {col+=yyleng; return TOK_CONSTANTE_ENTERA;}

[a-zA-Z][0-9a-zA-Z_]* {		
	if (yyleng > 100) {
		fprintf(stderr, "****Error en [lin %d, col %d]: identificador demasiado largo (%s)\n", fil, col, yytext);
		return TOK_ERROR;
		}
	col+=yyleng; return TOK_IDENTIFICADOR;}


. {
fprintf(stderr, "****Error en [lin %d, col %d]: simbolo no permitido (%s)\n", fil, col, yytext);
col+=yyleng; return TOK_ERROR;}
%%