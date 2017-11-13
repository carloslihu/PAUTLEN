
all: ejercicio1.o y.tab.o lex.yy.o
	gcc -o ejercicio1 ejercicio1.o y.tab.o lex.yy.o

lex.yy.c: ejercicio1.l
	flex ejercicio1.l

ejercicio1.o: ejercicio1.c
	gcc -c ejercicio1.c

y.tab.o: y.tab.c y.tab.h
	gcc -c y.tab.c

lex.yy.o: lex.yy.c y.tab.h
	gcc -c lex.yy.c

y.tab.c: ejercicio1.y
	bison -dyv ejercicio1.y
	
y.tab.h: ejercicio1.y
	bison -dyv ejercicio1.y