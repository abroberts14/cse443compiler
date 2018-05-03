%{
	#include "run.h"
%}

%option noyywrap
%option yylineno

/* flex definitions */
%x CMNT
delim		[ \t]
ws			{delim}+
letter		[A-Za-z]
digit		[0-9]
int     	[+|-]?{digit}+
string 		\"(\\.|[^"^\n\\])*\" 
id    		[a-zA-Z][a-zA-Z_0-9]*

%%



 /* **********************rules************************* */




{int}       			{ 
							yylval.num = atol(yytext); 
							return C_INTEGER;
						}
\"(\\.|[^"^\n\\])*\" 	{ 	
							char* sr = strdup(yytext);
							yylval.str = sr; 
							return C_STRING;
						}

integer 				{ 
							yylval.str = "T_INTEGER"; 
							return T_INTEGER; 
						}
						
string	 				{ 
							yylval.str = "T_STRING"; 
							return T_STRING; 
						}
						
						
{ws}		{ /* do nothing */ 		}

null_ptr	{ return NULL_PTR; 		}
reserve		{ return RESERVE; 		}
release 	{ return RELEASE; 		}
for 		{ return FOR; 			}
while 		{ return WHILE; 		}
if 			{ return IF; 			}
then 		{ return THEN; 			}
else 		{ return ELSE; 			}
switch 		{ return SWITCH; 		}
case 		{ return CASE; 			}
otherwise 	{ return OTHERWISE; 	}
type 		{ return TYPE; 			}
function 	{ return FUNCTION; 		}
closure 	{ return CLOSURE; 		}
\( 			{ return L_PARENTHESIS; }
\) 			{ return R_PARENTHESIS; }
\[			{ return L_BRACKET; 	}
\] 			{ return R_BRACKET; 	}
\{ 			{ return L_BRACE; 		}
\} 			{ return R_BRACE; 		}
\' 			{ return S_QUOTE; 		}
\" 			{ return D_QUOTE; 		}
; 			{ return SEMI_COLON; 	}
: 			{ return COLON; 		}
, 			{ return COMMA;			}
-> 			{ return ARROW; 		}
\\ 			{ return BACKSLASH; 	}
"+" 		{ return ADD; 			}
"-" 		{ return SUB_OR_NEG; 	}
"*" 		{ return MUL;	 		}
"/" 		{ return DIV; 			}
"%" 		{ return REM; 			}
"." 		{ return DOT; 			}
"<" 		{ return LESS_THAN; 	}
"=" 		{ return EQUAL_TO; 		}
":=" 		{ return ASSIGN; 		}
I2R			{ return I2R; 			}
R2I			{ return R2I; 			}
is_null 	{ return IS_NULL; 		}
"!" 		{ return NOT; 			}
"&" 		{ return AND; 			}
"|" 		{ return OR; 			}

\n			{  						}

{id}		{ 
				char* str = strdup(yytext); 
				yylval.str = str; 
				return IDENTIFIER;
			}


%%

 /* **********************subroutines********************** */

