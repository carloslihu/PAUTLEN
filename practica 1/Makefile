IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall
#-pthread -rdynamic `pkg-config --cflags gtk+-3.0`

_DEPS =generacion_codigo.h

_OBJ =generacion_codigo.o


DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


all: $(OBJ)#ejecutable

$(OBJ): $(SDIR)/generacion_codigo.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/main_0_generacion.o: $(SDIR)/main_0_generacion.c
	$(CC) -c -o $@ $< $(CFLAGS)

#EJECUTABLES
main: $(OBJ) $(ODIR)/main_0_generacion.o
	$(CC) -o $@ $^ $(CFLAGS)
	./main output.asm

#para compilar asm y crear ejecutable
assemblerMain: output.asm
	nasm -g -o $(ODIR)/output.o -f elf32 output.asm
	gcc -m32 -o assemblerMain $(ODIR)/output.o $(ODIR)/alfalib.o

allmight: main
	./main output.asm
	$(MAKE) assemblerMain


.PHONY: clean
clean:
	-rm -f $(ODIR)/generacion_codigo.o *~ core $(INCDIR)/*~ 
	-rm -f $(ODIR)/output.o $(ODIR)/main_0_generacion.o
	-rm -f main assemblerMain output.asm