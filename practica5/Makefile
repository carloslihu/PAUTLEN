IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall

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
	./alfa prg1.alf prg1.asm
	nasm -felf32 prg1.asm
	mv prg1.o $(ODIR)/prg1.o
	gcc -m32 -o prg1 $(ODIR)/prg1.o $(ODIR)/alfalib.o

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

zip:


.PHONY: clean

clean:
	-rm $(OBJ) $(IDIR)/y.tab.h 
	-rm $(SDIR)/alfa.c $(SDIR)/lex.yy.c $(SDIR)/y.tab.c $(ODIR)/prg1.o $(ODIR)/main.o
	-rm y.output alfa prg1 prg1.asm
