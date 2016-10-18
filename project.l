%option noyywrap
%{
#include "project.h"
#include "project.tab.c"
%}

%%


"."   |
","   |
"["   |
"]"   |
"{"   |
"}"   |
"("   |
")"   |
"*"   |
"-"   |
"="   |
"/"   |
"<"   |
">"   |
":"   |
";"   |
"+"   { printf("%c\n", yytext[0]); return yytext[0]; /* what you have read, return it */ }


"program" { printf("program\n"); return PROGRAM; }
"var" { printf("var\n"); return VAR; }
"array" { printf("array\n"); return ARRAY; }
"of" { printf("of\n"); return OF; }
"integer" { printf("integer\n"); return INTEGER; }
"real" { printf("real\n"); return REAL; }
"begin" { printf("begin\n"); return BGN; }
"end" { printf("end\n"); return END; }
"if" { printf("if\n"); return IF; }
"then" { printf("then\n"); return THEN; }
"else" { printf("else\n"); return ELSE; }
"while" { printf("while\n"); return WHILE; }
"do" { printf("do\n"); return DO; }
".." { printf("..\n"); return DOTS; }
"print" { printf("print\n"); return PRINT; }



[a-zA-Z][a-zA-Z0-9]*  { printf("%s\n", yytext); return ID; }

[0-9]+"."[0-9]+ |
[0-9]+  { printf("%s\n", yytext); return NUMBER; }

"//".*
[ \t\n]
.   { yyerror("Mystery Character \n"); }

%%
