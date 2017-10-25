#include "../includes/tablaSimbolos.h"

int main(int argc, char ** argv) {
	FILE * fInput, *fOutput;
	char command[128], *inputName, *outputName;
	int number = 0;
	int retVal;
	STATUS stat = OK;
	INFO_SIMBOLO * infos;
	AMBITO ambito = GLOBAL;

	if (argc != 3)
		return 1;
	inputName = argv[1];
	outputName = argv[2];

	fInput = fopen(inputName, "r");
	if (fInput == NULL)
		return 1;
	fOutput = fopen(outputName, "w");
	if (fOutput == NULL)
		return 1;

	while ((retVal = fscanf(fInput, "%s\t%d\n", command, &number)) != EOF) {
		if (retVal == 1) { //comandos que no tienen un numero: peticiones de lectura de la tabla de simbolos
			if (ambito == GLOBAL) {
				infos = usoGlobal(command);
			} else {
				infos = usoLocal(command);
			}
			if (infos != NULL)
				fprintf(fOutput, "%s\t%d\n", infos->lexema, infos->adicional1);
			else
				fprintf(fOutput, "%s\t-1\n", command);
		} else {//comandos que tienen un numero: peticiones de escritura en la tabla de simbolos
			if (strcmp(command, "cierre") == 0 && number == -999) {
				cerrarFuncion();
				fprintf(fOutput, "%s\n", command);
				ambito = GLOBAL;
			} else if (number < 0) { //declaracion de funcion y creacion de nuevo ambito
				stat = declararFuncion(command, FUNCION, ENTERO, ESCALAR, number, 0);
				ambito = LOCAL;
				if (stat == OK)
					fprintf(fOutput, "%s\n", command);
				else
					fprintf(fOutput, "-1\t%s\n", command);
			} else {//insercion de id
				if (ambito == GLOBAL) {
					stat = declararGlobal(command, VARIABLE, ENTERO, ESCALAR, number, 0);
				} else {
					stat = declararLocal(command, VARIABLE, ENTERO, ESCALAR, number, 0);
				}
				if (stat == OK)
					fprintf(fOutput, "%s\n", command);
				else
					fprintf(fOutput, "-1\t%s\n", command);
			}
		}
	}

	limpiarTablas();
	fclose(fOutput);
	fclose(fInput);
	return 0;
}