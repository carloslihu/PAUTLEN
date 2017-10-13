IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall

_DEPS =tablaHash.h

_OBJ =tablaHash.o tablaSimbolos.o


DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all: prueba_tabla

prueba_tabla: $(OBJ) $(ODIR)/prueba_tabla.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)


zip:
	zip -r Gomez_Li_Nombre_tabla.zip src obj includes Makefile README.txt

.PHONY: clean

clean:
	-rm -f $(ODIR)/* *~ core $(INCDIR)/*~ 
	-rm -f prueba_tabla