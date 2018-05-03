/* run.h -- Header files for compiler modules */
#ifndef RUN_H_
#define RUN_H_

/* C header files */
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <memory.h>
#include <stdlib.h>
#include <stdarg.h>
#include "ast.h"
#include "parser.tab.h"

/* global variable to support debug */
	int debug;

/* global variables to support scope */
   static int  NS1;		/* Max Scope Number*/
   static int  NS2;		/* Current Scope Number */
   static int  SOC[1024];	/* Scope Open(1)/Closed(0)Array*/

/* global variables to support the symbol table */
   enum { ST_var, ST_record, ST_array, ST_ftype, ST_func, ST_parm };
   static int  ST_index;	
   static int  ST_scope[2048];
   static char ST_name [2048][32];
   static int  ST_class[2048];
   static char ST_type [2048][256];
   static char Wstring [256];
   static char* token1;
   static char S1[] = "|", S2[] = ":";
   
	extern int yylex(void);
	extern int yyparse(void);
	extern void yyerror(const char*);

#endif /*RUN_H_*/
