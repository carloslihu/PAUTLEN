IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall

_FILES=tablaHash tablaSimbolos generacion
#_DEPS =tablaHash.h tablaSimbolos.h
#_OBJ =tablaHash.o tablaSimbolos.o


DEPS = $(patsubst %,$(IDIR)/%.h,$(_FILES))

OBJ = $(patsubst %,$(ODIR)/%.o,$(_FILES))

all:
	bison -dyv alfa.y
	lex alfa.l
	gcc -c *.c
	gcc -o pruebaSintactico *.o

zip:

clean: