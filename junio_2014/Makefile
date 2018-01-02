IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall
prg=prueba

_FILES=tablaHash tablaSimbolos generacion y.tab


DEPS = $(patsubst %,$(IDIR)/%.h,$(_FILES)) 

OBJ = $(patsubst %,$(ODIR)/%.o,$(_FILES)) $(ODIR)/lex.yy.o

all:
	bison -dyv $(SDIR)/alfa.y
	lex $(SDIR)/alfa.l
	mv *.c $(SDIR)
	mv *.h $(IDIR)
	$(MAKE) alfa

alfa: $(OBJ) $(ODIR)/main.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

asm:
	#valgrind --leak-check=full --show-leak-kinds=all ./alfa $(prg).alf $(prg).asm
	./alfa $(prg).alf $(prg).asm
	nasm -felf32 $(prg).asm
	mv $(prg).o $(ODIR)/$(prg).o
	gcc -m32 -o $(prg) $(ODIR)/$(prg).o $(ODIR)/alfalib.o

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

zip:
	zip -r GomezJavier_LiCarlos_compilador.zip includes obj src Makefile README

.PHONY: clean

clean:
	-rm $(OBJ) $(IDIR)/y.tab.h 
	-rm $(SDIR)/lex.yy.c $(SDIR)/y.tab.c $(ODIR)/$(prg).o $(ODIR)/main.o
	-rm $(ODIR)/prg/*.o
	-rm prg/*.asm
	-rm y.output alfa $(prg) *.asm
