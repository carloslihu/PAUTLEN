all: ejercicio1.l ejercicio1.y ejercicio1.c
	flex ejercicio1.l
	bison -dyv ejercicio1.y
	gcc -c y.tab.c
	gcc -c lex.yy.c
	gcc -c ejercicio1.c
	gcc -o ejercicio1 ejercicio1.o y.tab.o lex.yy.o