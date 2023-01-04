%{
    enum TokenType {
        EOL = 258,
        FUNC = 259,
        STRUCT = 260,
        PUB = 261,
        PVT = 262,
        MUT = 263,
        COLON = 264,
        SCOPE_START = 265,
        SCOPE_END = 266,
        DOT = 267,
        IMPORT = 268,
        ASTERISK = 269,
        RETVAL = 270,
        RETURN = 271,
        ADD = 272,
        SUB = 273,
        DIVIDE = 274,
        PARAM_START = 275,
        PARAM_END = 276,
        COMMA = 277,
        WHITESPACE = 278,
        QUOTE = 279,
        VAL = 280,
        INT = 281,
        SCOPE = 282,
        NEWLINE = 283,
        UNKNOWN = 284
    };
%}

%%

"fn"            { return FUNC; }
"struct"        { return STRUCT; }
"pub"           { return PUB; }
"pvt"           { return PVT; }
"mut"           { return MUT; }
"return"        { return RETURN; }
"import"        { return IMPORT; }
"::"            { return SCOPE; }
":"             { return COLON; }
"."             { return DOT; }
","             { return COMMA; }
";"             { return EOL; }

"*"             { return ASTERISK; }
"->"            { return RETVAL; }

"+"             { return ADD; }
"-"             { return SUB; }
"/"             { return DIVIDE; }

"{"             { return SCOPE_START; }
"}"             { return SCOPE_END; }
"("             { return PARAM_START; }
")"             { return PARAM_END; }

['"]            { return QUOTE; }
[a-zA-Z0-9_]+   { return VAL; }
[0-9\.]+        { return INT; }
\n              { return NEWLINE; }
[ \t]           { return WHITESPACE; }

.               { return UNKNOWN; }
%%

int main(int argc, char **argv) {
    yyin = fopen(argv[1], "r");
    enum TokenType tok;

    while((tok = yylex())) {
        printf("%d\n", tok);
    }

    fclose(yyin);
    return 0;
}
