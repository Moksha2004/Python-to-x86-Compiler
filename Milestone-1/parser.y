%{
#include "parser.tab.h"
#include <stdlib.h>
#include <iostream>
#include <map>
#include <algorithm>
#include <vector>
#include <string>
#include <cctype>
#include <stdio.h>
extern int yylineno;
extern char* yytext;
extern int yyparse();
extern YYSTYPE yylval;
extern FILE* yyin;
using namespace std;
void yyerror(const char *s);
int yylex(void);
%}

%start code
%token var
%token main
%token semicolon
%token newline
%token comment
%token equal
%token colon
%token comma
%token plus_eq
%token minus_eq
%token star_eq
%token slash_eq
%token double_slash_eq
%token mod_eq
%token double_star_eq
%token and_eq
%token or_eq
%token xor_eq
%token lshift_eq
%token rshift_eq
%token colon_eq
%token indent
%token dedent
%token break
%token continue
%token return
%token if
%token elif
%token else
%token while
%token for
%token in
%token and
%token or
%token not
%token is
%token double_eq
%token not_eq
%token greater
%token lesser
%token greater_eq
%token lesser_eq
%token plus
%token minus
%token star 
%token slash
%token double_slash
%token double_star
%token mod
%token bit_or
%token bit_and
%token bit_xor
%token bit_not
%token lshift
%tokne rshift
%%
code : part main part ;
part : part stmt |;
stmt : simple_stmt | compound_stmt;
simple_stmt: small_stmt small_stmt_star newline| small_stmt small_stmt_star semicolon newline;
small_stmt_star: small_stmt_star semicolon small_stmt|;  
small_stmt: expr_stmt ;
expr_stmt: testlist_star_expr annasign| testlist_star_expr augasign testlist | testlist_star_expr |
           testlist_star_expr equal testlist_star_expr_plus | testlist_star_expr equal testlist_star_expr_plus comment;
testlist_star_expr_plus: testlist_start_expr_plus testlist_star_expr | testlist_star_expr;
annasign : colon test | colon test equal testlist_star_expr;
testlist_star_expr : test test_comma_star | star_expr test_comma_star | test star_expr_comma_star | star_expr star_expr_comma_star
                     | test test_comma_star comma| star_expr test_comma_star comma| test star_expr_comma_star comma| star_expr star_expr_comma_star comma;
test_comma_star : test_comma_star comma test | ;
star_expr_comma_star: star_expr_comma_star star_expr |;
augasign: plus_eq | minus_eq | star_eq | slash_eq | double_slash_eq | mod_eq | double_star_eq | and_eq | or_eq | xor_eq | lshift_eq | rshift_eq ;

flow_stmt: break_stmt|continue_stmt|return_stmt;
break_stmt: break;
continue_stmt: continue;
return_stmt: return;

compound_stmt: if_stmt|while_stmt|for_stmt|funcdef|classdef;
if_stmt: if namedexpr_test colon suite elif_star | if namedexpr_test colon suite elif_star else colon suite;
elif_star: elif_star elif namedexpr_test colon suite |;
while_stmt: while namedexpr_test colon suite| while namedexpr_test colon suite else colon suite;
for_stmt: for exprlist in testlist colon comment suite | for exprlist in testlist colon suite | for exprlist in testlist colon comment suite else colon suite| for exprlist in testlist colon suite else colon suite;
suite:simple_stmt|newline indent stmt_plus dedent;
stmt_plus:stmt_plus stmt|stmt;
namedexpr_test: test colon_eq test | test;
test: or_test|or_test if or_test else test;
test_nocond: or_test;
or_test:and_test or_and_test_star;
or_and_test_star: or_and_test_star or and_test|;
and_test:not_test and_not_test_star;
and_not_test_star: and_not_test_star and not_test|;
not_test: not not_test | comparison;
comparison: expr comp_op_star;
comp_op_star:comp_op_star comp_op expr|;
comp_op: double_eq | not_eq | greater | lesser | greater_eq | lesser_eq | in | not in| is | is not;
star_expr: star expr;
expr:xor_expr bit_or_xor_expr_star;
bit_or_xor_expr_star:bit_or_xor_expr_star bit_or xor_expr|;
xor_expr: and_expr bit_xor_and_expr_star;
bit_xor_and_expr_star: bit_xor_and_expr_star bit_xor and_expr|;
and_expr:shift_expr bit_and_shift_expr_star;
bit_and_shift_expr_star:bit_and_shift_expr_star bit_and shift_expr|;
shift_expr:arith_expr lshift_arith_expr_star|arith_expr rshift_arith_expr_star;
lshift_arith_expr_star: lshift_arith_expr_star lshift arith_expr|;
rshift_arith_expr_star: rshift_arith_expr_star rshift arith_expr|;
arith_expr:term plus_term_star|term minus_term_star;
plus_term_star: plus_term_star plus term|;
minus_term_star:minus_term_star minus term |;




%%

int main(int argc,char**argv) {
    yyparse();
    return 0;
}


void yyerror(const char *s) {
    printf("error in parsing,%d",yylineno);
}