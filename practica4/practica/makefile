all:
	bison -dyv alfa.y
	lex alfa.l
	gcc -c *.c
	gcc -o pruebaSintactico *.o