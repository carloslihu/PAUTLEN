%{

%}

%token TOK_CTE_ENTERA
%token TOK_CTE_REAL

%left '+' '-'
%left '*' '/'
%right MENOSU


%%
exp: exp '+' exp  {printf("REGLA: exp: exp + exp\n");}
	| exp '-' exp {printf("REGLA: exp: exp - exp\n");}
	| exp '*' exp {printf("REGLA: exp: exp * exp\n");}
	| exp '/' exp {printf("REGLA: exp: exp / exp\n");}
	| '-' exp %prec MENOSU {printf("REGLA: exp: - exp\n");}
	| '('exp')' {printf("REGLA: exp: (exp)\n");}
	| constante {printf("REGLA: exp: constante\n");}
	;
constante: TOK_CTE_ENTERA
	| TOK_CTE_REAL
	;
%%