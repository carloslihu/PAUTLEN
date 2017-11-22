IDIR=includes
ODIR=obj
SDIR=src
CC=gcc
CFLAGS= -g -Wall

_FILES=tablaHash tablaSimbolos generacion y.tab


DEPS = $(patsubst %,$(IDIR)/%.h,$(_FILES)) 

OBJ = $(patsubst %,$(ODIR)/%.o,$(_FILES)) lex.yy.o

all:
	bison -dyv $(SDIR)/alfa.y
	lex $(SDIR)/alfa.l
	mv *.c $(SDIR)
	mv *.h $(IDIR)

alfa: $(OBJ) $(ODIR)/main.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

zip:


.PHONY: clean

clean:
	-rm $(ODIR)/*.o $(IDIR)/y.tab.h 
	-rm $(SDIR)/alfa.c $(SDIR)/lex.yy.c $(SDIR)/y.tab.c
	-rm y.output