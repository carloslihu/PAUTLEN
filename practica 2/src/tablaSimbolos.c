#include "../includes/tablaHash.h"

/*
DeclararGlobal(id, desc_id)
if ( TablaSimbolosGlobal -> get(id) == null)
{
	TablaSimbolosGlobal->set(id, desc_id);
	return ok;   // 9
}
else  return error; // 1, 2, 3

DeclararLocal(id, desc_id)
if ( TablaSimbolosLocal -> get(id) == null)
{
	TablaSimbolosLocal->set(id, desc_id);
	return ok;   // 10 11
}
else  return error; // 4, 5, 6, 7, 8

UsoGlobal(id)
dato = TablaSimbolosGlobal -> get(id);
if ( dato == null)
{
	return err;   // 12, 17 (funciones)
}
else  return dato; // 9, 16 (funciones)

UsoLocal(id)
dato = TablaSimbolosLoca	l -> get(id);
if ( dato == null)
{
	dato = TablaSimbolosGlobal -> get(id);
	if (dato == null) return err;   // 13
	else return dato                   // 14
}
else  return dato; // 10, 11, 15

DeclararFuncion(id, desc_id)
if ( TablaSimbolosGlobal-> get(id) != null )
	return error;  // 3
else {
	TablaSimbolosGlobal -> set(id, desc_id);
	TablaSimbolosLocal->init();
	TablaSimbolosLocal->set(id, desc_id);
	return ok;     // 11  }

 */
