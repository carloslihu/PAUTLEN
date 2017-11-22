#include "../includes/alfa.h"
#include "../includes/y.tab.h" 

extern FILE* yyin; 
FILE* output;
 
int main(int argc, char** argv){  
  //int retVal; 
  if (argc == 2) { 
    yyin = fopen(argv[1], "r"); 
    output = stdout;
  } else if(argc == 3) {
    yyin = fopen(argv[1], "r"); 
    output = fopen(argv[2], "w");
  } else { 
    fprintf(stderr, "formato incorrecto:\n./ejecutable input.txt output.txt\n"); 
    return 1; 
  } 
  yyparse();
  /*
  if(retVal == 0) 
    printf("\nEXPRESION CORRECTA\n"); 
  else 
    printf("\nEXPRESION INCORRECTA\n");
    */
  return 0;  
}