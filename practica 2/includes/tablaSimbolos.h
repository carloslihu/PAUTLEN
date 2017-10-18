#include "tablaHash.h"


STATUS declararGlobal(const char* lexema,  CATEGORIA categ, TIPO tipo, CLASE clase, int adic1, int adic2);
STATUS declararLocal(const char* lexema,  CATEGORIA categ, TIPO tipo, CLASE clase, int adic1, int adic2);
INFO_SIMBOLO *usoGlobal(const char* lexema);
INFO_SIMBOLO *usoLocal(const char* lexema);
STATUS declararFuncion(const char* lexema,  CATEGORIA categ, TIPO tipo, CLASE clase, int adic1, int adic2);