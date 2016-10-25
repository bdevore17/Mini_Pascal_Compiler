#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "project.h"

void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}

static unsigned symhash(char *sym) {
  return (unsigned) (atoi(sym) / NHASH);
}

struct symbol *lookup(char *sym) {
  return &symtab[symhash(sym)];
}

int
main(int argc, char **argv)
{
	extern FILE *yyin;
	++argv; --argc;
	yyin = fopen(argv[0], "r");
	return yyparse();
}