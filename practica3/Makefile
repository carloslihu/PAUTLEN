all:
	flex alfa.l
	gcc -Wall -o pruebaMorfo pruebaMorfo.c lex.yy.c

diff:
	diff -bB misalida1.txt salida1.txt
	diff -bB misalida2.txt salida2.txt
	diff -bB misalida3.txt salida3.txt
prueba:
	./pruebaMorfo entrada1.txt misalida1.txt
	./pruebaMorfo entrada2.txt misalida2.txt
	./pruebaMorfo entrada3.txt misalida3.txt	
zip:
	zip GomezJavier_LiCarlos_morfo.zip	ej_flex_1.* tokens.h

.PHONY: clean

clean:
	-rm -f pruebaMorfo lex.yy.c misalida*