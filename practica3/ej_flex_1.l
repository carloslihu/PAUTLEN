%{
	#include <stdio.h>
	#include "tokens.h"
	int fil;
	int col;
%}

%option noyywrap



%%

main {return TOK_MAIN;}
array {return TOK_ARRAY;}
int {return TOK_INT;}
if {return TOK_IF;}
else {return TOK_ELSE;}
while {return TOK_WHILE;}
. {return TOK_ERROR;}


%%