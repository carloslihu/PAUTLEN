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
	bison -dyv $(SDIR)/alfa.y
	lex $(SDIR)/alfa.l
	mv *.c $(SDIR)
	mv *.h $(IDIR)

alfa: $(OBJ) $(ODIR)/alfa.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

zip:

.PHONY: clean
clean: