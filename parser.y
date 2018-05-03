
%{
	
	#include "ast.h"
	#include "run.h"
	ast_node_sexp *root; 
	extern int yylineno;
	
	
	
%}
%locations
%code requires
{
	#include "run.h"
	#include "ast.h"
	
}

/* Generate a multi-type semantic value */
%union {
	
   int num;
   char* str;
   ast_node_sexp* nodeSexp;
   ast_node_atom* nodeAtom;
   ast_node_list* nodeList;
}

%token <str>   		IDENTIFIER 	101
%token T_INTEGER     			201
%token T_REAL        			202
%token T_BOOLEAN     			203
%token T_CHARACTER   			204
%token T_STRING      			205
%token <num> C_INTEGER     		301
%token C_REAL        			302
%token C_CHARACTER   			303
%token <str> C_STRING      		304
%token C_TRUE        305
%token C_FALSE       306
%token NULL_PTR      401
%token RESERVE       402
%token RELEASE       403
%token FOR           404
%token WHILE         405
%token IF            406
%token THEN          407
%token ELSE          408
%token SWITCH        409
%token CASE          410
%token OTHERWISE     411
%token TYPE          412
%token FUNCTION      413
%token CLOSURE       414
%token L_PARENTHESIS 501
%token R_PARENTHESIS 502
%token L_BRACKET     503
%token R_BRACKET     504
%token L_BRACE       505
%token R_BRACE       506
%token S_QUOTE       507
%token D_QUOTE       508
%token SEMI_COLON    551
%token COLON         552
%token COMMA         553
%token ARROW         554
%token BACKSLASH     555
%token ADD           601
%token SUB_OR_NEG    602
%token MUL           603
%token DIV           604
%token REM           605
%token DOT           606
%token LESS_THAN     607
%token EQUAL_TO      608
%token ASSIGN        609
%token I2R	         610
%token R2I	         611
%token IS_NULL       612
%token NOT           613
%token AND           614
%token OR            615
%token COMMENT       700

%token TOK_EOF 0 "end of file"


%type <nodeSexp> sexp
%type <nodeAtom> atom
%type <nodeList> list

%%
%start sexps;

sexps :
	sexp        					{ printf("1A"); root = $1; print_node_sexp (root);}

sexp:
  atom          					{ 	printf("2A"); $$ = new_sexp_node(ST_ATOM, $1); }
| L_PARENTHESIS list R_PARENTHESIS  {	printf("2B"); $$ = new_sexp_node(ST_LIST, $2); };

list:
  empty			  					{ printf("3A"); $$ = new_list_node(); }
| list sexp     					{ printf("3B"); $$ = $1; add_node_to_list($$, $2); };

atom:
  C_INTEGER     					{ printf("4A"); $$ = new_atom_node(AT_NUMBER, (void *)(&$1)); }
| IDENTIFIER						{ printf("4B"); $$ = new_atom_node(AT_IDENTIFIER, (void *)$1); }
| C_STRING							{ printf("4C"); $$ = new_atom_node(AT_STRING, (void *)$1); };

empty:  ;
%%

void yyerror(const char* p) 
{ 
	fprintf(stderr, "%s on line %d\n",p, yylineno); 
}

void setup(int i, int y, int j, char infile[]) {
	printf("setup");
}



