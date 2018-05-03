/* run.c -- main program for CSE443 Compiler */
#include "run.h"

/* Gobal Variables required to support printing of input file */
static FILE *fileIn;    	    /* Input file pointer */
static int ascToFile = 0;  		/* If set to 1, prints annotated source file to file */
static int printToFile = 0; 	/* If set to 1, prints symbol table to file */
static int irToFile = 0; 	/* If set to 1, prints symbol table to file */

extern void yyset_in(FILE*);
extern int yydebug;
extern void setup(int i, int y, int j, char infile[]);
/*********************************************/
int main(int argc, char *argv[]){
	
	int i; 
	char *infile = NULL; 
	debug = 0;

	infile = argv[argc - 1]; /* Last command should be the input file */

	/* Process command line */
	for (i = 1; i < argc; i++) {
		if ( strcmp(argv[i],"-debug") == 0 ) {
			 printf ("debugging activated\n");
			 debug = 1; 
		}
		if ( strcmp(argv[i],"-st") == 0 ) {
			 printf ("printing symbol table to file activated \n");
			 printToFile = 1; 
		}
		if ( strcmp(argv[i],"-asc") == 0 ) {
			 printf ("printing annotated source file to file activated \n");
			 ascToFile = 1; 
		}
		if ( strcmp(argv[i],"-ir") == 0 ) {
			 printf ("printing ir source file to file activated \n");
			 irToFile = 1; 
		}
	}

	/* Open input file for reading */
	if ( infile == NULL ) { 
		printf("No program to compile\n"); 
		return 1; 
	}
	if ( (fileIn = fopen(infile, "r")) == NULL) {
	  printf("Cannot open file -- abort\n");
	  return 10; 
	}
	setup(printToFile, ascToFile, irToFile, infile);


	yyset_in(fileIn);
	yyparse();

	
	fclose(fileIn);
	return 0; 
}