all:
	bison -dyv alfa.y
	lex alfa.l
	gcc -c *.c
	gcc -o pruebaSintactico *.o

tests:
	./pruebaSintactico entrada_sin_1.txt misalida_sin_1.txt
	./pruebaSintactico entrada_sin_2.txt misalida_sin_2.txt
	./pruebaSintactico entrada_sin_3.txt misalida_sin_3.txt
	diff -bB salida_sin_1.txt misalida_sin_1.txt
	diff -bB salida_sin_2.txt misalida_sin_2.txt
	diff -bB salida_sin_3.txt misalida_sin_3.txt

zip:
	zip GomezJavier_LiCarlos_sintactico.zip alfa.y alfa.l pruebaSintactico.c Makefile

clean:
	rm *.o misalida_sin_* lex.yy.c y.tab.c y.tab.h pruebaSintactico y.output *.zip