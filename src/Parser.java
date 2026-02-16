// Dhruv Patel

import java.util.HashMap;

public class Parser {
    public static final int INT         = 10; // "int"
    public static final int LPAREN      = 11; // "("
    public static final int RPAREN      = 12; // ")"
    public static final int SEMI        = 13; // ";"
    public static final int OP          = 14; // "+", "-", "*", "/", "%", "and", "or", "not"
    public static final int RELOP       = 15; // "=", "<>", "<", ">", "<=", ">="
    public static final int INT_VALUE   = 16; // {int}
    public static final int IDENT       = 17; // {identifier}
    public static final int PRINT       = 18; // "print"
    public static final int FUNC        = 19; // "func"
    public static final int VAR         = 20; // "var"
    public static final int VOID        = 21; // "void"
    public static final int BOOL        = 22; // "bool"
    public static final int FLOAT       = 23; // "float"
    public static final int STRUCT      = 24; // "struct"
    public static final int SIZE        = 25; // "size"
    public static final int NEW         = 26; // "new"
    public static final int IF          = 27; // "if"
    public static final int ELSE        = 28; // "else"
    public static final int WHILE       = 29; // "while"
    public static final int RETURN      = 30; // "return"
    public static final int BREAK       = 31; // "break"
    public static final int CONTINUE    = 32; // "continue"
    public static final int TRUE        = 33; // "true"
    public static final int FALSE       = 34; // "false"
    public static final int BEGIN       = 35; // "begin" or "{"
    public static final int END         = 36; // "end" or "}"
    public static final int ADDR        = 37; // "&"
    public static final int VALUE       = 38; // "value"
    public static final int LBRACKET    = 39; // "["
    public static final int RBRACKET    = 40; // "]"
    public static final int COMMA       = 41; // ","
    public static final int DOT         = 42; // "."
    // public static final int ASSIGN   = 43; // "="
    public static final int TYPEOF      = 44; // "typeof"
    public static final int THEN        = 45; // "then"
    public static final int FLOAT_VALUE = 46; // {float}
    public static final int ASSIGN      = 47; // "<-"
    public static final int VALUEAT     = 48; // "@"
    public static final int ADDROF      = 49; // "&"
    // public static final int VALUEAT  = 50; // "*"
    public static final int PERCENT     = 51; // "%"
    public static final int AND         = 52; // "and"
    public static final int OR          = 53; // "or"
    public static final int NOT         = 54; // "not"


    public Parser(java.io.Reader r, Compiler compiler) throws Exception {
        this.compiler = compiler;
        this.lexer    = new Lexer(r, this);
    }

    Lexer            lexer;
    Compiler         compiler;
    public ParserVal yylval;

    public int yyparse() throws java.io.IOException {
        int counter= 0;
        String tokenname = "";
        while (true) {
            int token = lexer.yylex();
            Object attr = yylval.obj;
            if(token == 0) {
             // EOF is reached
             System.out.print("Success!");
             return 0;
            }
            if(token == -1) {
                // error
                return -1;
            }
            if(token == 10) {
               tokenname = "INT";
               System.out.print("<INT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 11) {
                tokenname = "LPREN";
                System.out.print("<LPAREN" +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 12) {
                tokenname = "RPREN";
                System.out.print("<RPAREN" +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 13) {
                tokenname = "SEMI";
                System.out.print("<SEMI" +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 14) {
                tokenname = "OP";
                System.out.print("<OP" + ", attr:\"" +(yylval.obj.toString())+ "\" " + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 15) {
                tokenname = "RELOP";
                System.out.print("<RELOP" + ", attr:\"" + attr + "\" " + ", "+ lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 16) {
                tokenname = "INT_VALUE";
                System.out.print("<INT_VALUE" + ", attr:\""  +(yylval.obj.toString())+"\""+ ", "+lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 17) {
                tokenname = "ID";
                System.out.print("<ID" + ", attr:sym-id:" +lexer.symbolTable.get(yylval.obj.toString())+  ", "+lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 18) {
                tokenname = "PRINT";
                System.out.print("<" + lexer.yytext().toUpperCase() +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 19) {
                tokenname = "FUNC";
                System.out.print("<" + lexer.yytext().toUpperCase()  + ", "+lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 20) {
                tokenname = "VAR";
                System.out.print("<" + lexer.yytext().toUpperCase() +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 21) {
                tokenname = "VOID";
                System.out.print("<" + lexer.yytext().toUpperCase()  + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 22) {
                tokenname = "BOOL";
                System.out.print("<BOOL" +  ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 23) {
                tokenname = "FLOAT";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", "+ lexer.lineno + ":"+lexer.column + ">");
            }
            if(token == 24) {
                tokenname = "STRUCT";
                System.out.print("<" + lexer.yytext().toUpperCase()+", "  + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 25) {
                tokenname = "SIZE";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 26) {
                tokenname = "NEW";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", "  +  lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 27) {
                tokenname = "IF";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", " +  lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 28) {
                tokenname = "ELSE";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", " +  lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 29) {
                tokenname = "WHILE";
                System.out.print("<" + lexer.yytext().toUpperCase() + ", " +   lexer.lineno+":" + lexer.column + ">");
            }
            if(token == 30) {
                tokenname = "RETURN";
                System.out.print("<" + lexer.yytext().toUpperCase()  +", "  +  lexer.lineno+ ":"+  lexer.column + ">");
            }
            if(token == 31) {
                tokenname = "BREAK";
                System.out.print("<" + lexer.yytext().toUpperCase() +", " +  lexer.lineno +":"+  lexer.column + ">");
            }
            if(token == 32) {
                tokenname = "CONTINUE";
                System.out.print("<" + lexer.yytext().toUpperCase()+", "  +  lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 33) {
                tokenname = "TRUE";
                System.out.print("<BOOL_VALUE" + ", attr:\"" + lexer.yytext() + "\", " +  lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 34) {
                tokenname = "FALSE";
                System.out.print("<BOOL_VALUE" + ", attr:\"" + lexer.yytext() + "\", " +  lexer.lineno + ":" + lexer.column + ">"); 
            }
            if(token == 35) {
                tokenname = "BEGIN";
                System.out.print("<BEGIN" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 36) {
                tokenname = "END";
                System.out.print("<END" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 37) {
                tokenname = "ADDR";
                System.out.print("<ADDR" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 38) {
                tokenname = "VALUE";
                System.out.print("<VALUE" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 39) {
                tokenname = "LBRACKET";
                System.out.print("<LBRACKET" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 40) {
                tokenname = "RBRACKET";
                System.out.print("<RBRACKET" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 41) {
                tokenname = "COMMA";
                System.out.print("<COMMA" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 42) {
                tokenname = "DOT";
                System.out.print("<DOT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            // if(token == 43) {
            //     tokenname = "ASSIGN";
            //     System.out.print("<ASSIGN" + ", " + lexer.lineno + ":" + lexer.column + ">");
            // }
            if(token == 44) {
                tokenname = "TYPEOF";
                System.out.print("<TYPEOF" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 45) {
                tokenname = "THEN";
                System.out.print("<THEN" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 46) {
                tokenname = "FLOAT_VALUE";
                System.out.print("<FLOAT_VALUE" + ", attr:\"" +(yylval.obj.toString())+"\"" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 47) {
                tokenname = "ASSIGN";
                System.out.print("<ASSIGN" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 48) {
                tokenname = "VALUEAT";
                System.out.print("<VALUEAT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 49) {
                tokenname = "ADDROF";
                System.out.print("<ADDROF" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            // if(token == 50) {
            //     tokenname = "VALUEAT";
            //     System.out.print("<VALUEAT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            // }
            if(token == 51) {
                tokenname = "PERCENT";
                System.out.print("<PERCENT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 52) {
                tokenname = "AND";
                System.out.print("<AND" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 53) {
                tokenname = "OR";
                System.out.print("<OR" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }
            if(token == 54) {
                tokenname = "NOT";
                System.out.print("<NOT" + ", " + lexer.lineno + ":" + lexer.column + ">");
            }

        }
    }
}