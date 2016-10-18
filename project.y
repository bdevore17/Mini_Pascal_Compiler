%{
#include <stdio.h>
#include <stdlib.h>
#include "project.h"
%}

%union {
  struct ast *a;
  double d;
  struct symbol *s;
  struct symlist *sl;
  struct numlist *nl;
  int fn;
  char type_c;
}

%token <d> NUMBER
%token <s> ID
%token PROGRAM VAR ARRAY OF INTEGER REAL BGN END IF THEN ELSE WHILE DO DOTS PRINT
%token <type_c> STD_TYPE

%nonassoc <fn> CMP
%right '='
%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS

%type <a> decl_list decl stmt_list stmt exp
%type <sl> id_list
%type <nl> num_list

%start program
%%

program: PROGRAM ID '(' id_list ')' ';' declarations compound_statement '.'

id_list: ID
  | ID ',' id_list
  ;

declarations: declarations VAR id_list ':' type ';'
  | %empty
  ;

type: standard_type
  | ARRAY '[' NUMBER DOTS NUMBER ']' OF standard_type
  ;

standard_type: INTEGER
  | REAL
  ;

compound_statement: BGN optional_statement END
  ;

optional_statement: statement_list
  | %empty
  ;

statement_list: statement_list ';' statement_list
  | statement
  ;

statement: IF expression THEN '{' statement_list '}' ELSE '{' statement '}'
  | WHILE expression DO '{' statement_list '}'
  | ID '=' expression
  | expression
  ;

expression: simple_expression
  | simple_expression '<' simple_expression
  | simple_expression '>' simple_expression
  | simple_expression "<=" simple_expression
  | simple_expression ">=" simple_expression
  | simple_expression "<>" simple_expression
  | simple_expression "==" simple_expression
  ;

simple_expression: term
  | sign term
  | simple_expression '+' term
  | simple_expression '-' term
  ;

term: factor
  | term '*' factor
  | term '/' factor
  ;

factor: ID
  | NUMBER
  | '(' expression ')'
  ;

sign: '+'
  | '-'
  ;


%%
