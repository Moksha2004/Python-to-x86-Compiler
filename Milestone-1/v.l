%option noyywrap
%option case-insensitive
%option yylineno
%{
// Include any necessary headers or declarations here
//#include <stdio.h>
#include "parser.tab.h"
%}

Arithmetic_op "+"|"-"|"*"|"/"|"//"|"%"|"**"
Relational_op "=="|"!="|">"|"<"|">="|"<="
Logical_op "and"|"or"|"not"
Bitwise_op "&"|"|"|"ˆ"|"˜"|"«"|"»"
Assignment_op "="|"+="|"-="|"*="|"/="|"%="|"**="|"&="|"|="|"ˆ="|"«="|"»="

%%
"False"|"await"|"import"|"pass"|"None"|"break"|"except"|"in"|"raise"|"True"|"class"|"finally"|"is"|"return"|"and"|"continue"|"for"|"lambda"|"try"|"as"|"def"|"from"|"nonlocal"|"while"|"assert"|"del"|"global"|"not"|"with"|"async"|"or"|"yield" {
    //cout<<"keyword"<<endl;
    //return KEYWORD;
    }
"a"("x"|"y") {//cout<<"there"<<endl;
}    
"print"[(][^\n]*[)] { //cout<<"print"<<endl;
    //return PRINT;
    }
"," {
    printf("coma in  lex\n");
    return COMA;
}
";" {return SEMI;}
"#"[^\n]*"\n" {
    //cout<<"comment"<<endl;
    //return COMMENT;
    }
{Arithmetic_op}|{Relational_op}|{Bitwise_op}|{Assignment_op} { //cout<<"op"<<endl;
    //return OP;
    }
"if" {
    printf("ifin lex \n");
    return IF;
    }
[a-zA-Z][a-zA-Z0-9_]* {//cout<<"var"<<endl;
printf("var in lex\n");
return var;
}
"\n" {}
" " {}
.                      { //cout<<"error"<<endl; 
} 
%%



