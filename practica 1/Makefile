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


.PHONY: clean
clean:
	-rm -f $(ODIR)/generacion_codigo.o *~ core $(INCDIR)/*~ 

#	nasm -g -o output.o -f elf32 output.asm
#	gcc -m32 -o output output.o alfalib.o
