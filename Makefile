lexer: 
	flex lexer.l
	
runner: 
	rm -f compile
	rm -f lex.yy.c
	rm -f parser.tab.c
	rm -f parser.tab.h
	rm -f parser.output
	flex -l lexer.l
	bison -v -d  --verbose --report=all parser.y
	gcc run.c ast.c lex.yy.c parser.tab.c -o compiler
	./compiler test.txt