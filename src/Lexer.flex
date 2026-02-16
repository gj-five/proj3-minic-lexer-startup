/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2000 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: Dhruv Patel                                                    *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

import java.util.*;

%%

%class Lexer
%unicode
%line
%column
%byaccj

%{
   // Declaration of variables
  public Parser   parser;
  public int      lineno;
  public int      column;
  public int      counter = 0;

  public Lexer(java.io.Reader r, Parser parser) {
   this(r);
   this.parser = parser;
   this.lineno = (yyline+1);
   this.column = (yycolumn+1);
  }

  HashMap<String, String> defines = new HashMap<>(); // Hashmap to store defined symbols and their replacement
  HashMap<String, Integer> symbolTable = new HashMap<>(); // HashMap to store symbols and their values

  private int handleDefineReplacement(String text) {
    if(defines.containsKey(text)) {
      String replacement = defines.get(text);
      switch(replacement) {
        case "int":
          this.lineno=(yyline+1);
          this.column=(yycolumn+1);
          return Parser.INT;
        case "bool":
        this.lineno=(yyline+1);
          this.column=(yycolumn+1);
          return Parser.BOOL;
        case "float":
        this.lineno=(yyline+1);
          this.column=(yycolumn+1);
          return Parser.FLOAT;
         default:
          try {
            Float.parseFloat(replacement);
            parser.yylval = new ParserVal((Object)replacement);
            this.lineno=(yyline+1);
          this.column=(yycolumn+1);
            return Parser.FLOAT_VALUE;
          } catch(NumberFormatException e) {
            parser.yylval = new ParserVal((Object)replacement);
            this.lineno=(yyline+1);
          this.column=(yycolumn+1);
            return Parser.IDENT;
          }
      }
    } else {
      this.lineno=(yyline+1);
          this.column=(yycolumn+1);
      return -1; // No replacement found, return -1
    }
  }
%}

int         = [0-9]+
float       = [0-9]+("."[0-9]+)?
identifier  = [a-zA-Z][a-zA-Z0-9_]*
newline     = \n
whitespace  = [ \t\r]+
linecomment = "%%".*
blockcomment= "%*"[^]*"*%"
define      = "#define" [ \t]+([a-zA-Z][a-zA-Z0-9_]*)[ \t]+([a-zA-Z0-9_.]+)

%%

"print"     { 
               parser.yylval = new ParserVal((Object)yytext());  // Set parser value to the token
               this.lineno=(yyline+1);  // Update line number
               this.column=(yycolumn+1);  // Update column number
               return Parser.PRINT;  // Return PRINT token
            }
"func"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.FUNC;
            }
"var"       { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.VAR;
            }
"void"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.VOID;
            }
"bool"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.BOOL;
            }
"int"       { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.INT;
            }
"float"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.FLOAT;
            }
"struct"    { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.STRUCT;
            }
"size"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.SIZE;
            }
"new"       { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.NEW;
            }
"if"        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.IF;
            }
"else"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.ELSE;
            }
"while"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.WHILE;
            }
"return"    { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.RETURN;
            }
"break"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.BREAK;
            }
"continue"  { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.CONTINUE;
            }
"true"      { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.TRUE;
            }
"false"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.FALSE;
            }
"begin"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.BEGIN; 
            }
"end"       { 
               parser.yylval = new ParserVal((Object)yytext()); 
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.END;
            }
"addr"      { 
               parser.yylval = new ParserVal((Object)yytext()); 
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.ADDR; 
            }
"value"     { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.VALUE;
            }
"then"      { 
               parser.yylval  = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.THEN; 
            }

"("         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.LPAREN;
            }
")"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.RPAREN;
            }
"["         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.LBRACKET; 
            }
"]"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.RBRACKET;
            }
";"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.SEMI;
            }
","         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.COMMA;
            }
"."         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.DOT;
            }
":="        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.ASSIGN;
            }
"::"        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.TYPEOF;
            }

"+"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"-"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"*"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"%"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP; // Map % to PERCENT
            }
"/"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"and"       { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"or"        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }
"not"       { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.OP;
            }

"="         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.RELOP;
            }
"<>"        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1);
               return Parser.RELOP;
            }
"<"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.RELOP;
            }
">"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1);  
               return Parser.RELOP;  
            }
"<="        { 
               parser.yylval = new ParserVal((Object)yytext()); 
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1);  
               return Parser.RELOP; 
            }
">="        { 
               parser.yylval = new ParserVal((Object)yytext());  
               this.lineno=(yyline+1); 
               this.column=(yycolumn+1); 
               return Parser.RELOP; 
            }

"<-"        { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.ASSIGN; // Changed from ARROW to ASSIGN
            }
"@"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.VALUEAT;
            }

"{"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.BEGIN; // Map { to BEGIN
            }
"}"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.END; // Map } to END
            }
"&"         { 
               parser.yylval = new ParserVal((Object)yytext());
               this.lineno=(yyline+1);
               this.column=(yycolumn+1);
               return Parser.ADDROF; // Map & to ADDROF
            }

{define} {
   String[] parts = yytext().split("[ \t]+", 3);
   defines.put(parts[1], parts[2]);
}

/* Preprocessor directive */
{int} {
   parser.yylval = new ParserVal((Object)yytext());
   this.lineno=(yyline+1);
   this.column=(yycolumn+1);
   return Parser.INT_VALUE;
}

{float} {
   parser.yylval = new ParserVal((Object)yytext());
   this.lineno=(yyline+1);
   this.column=(yycolumn+1);
   return Parser.FLOAT_VALUE;
}

{identifier} {
    int replacementToken = handleDefineReplacement(yytext());
    if(replacementToken != -1) {
      this.lineno=(yyline+1);
      this.column=(yycolumn+1);
      return replacementToken;
    } else {
      String identifierName = yytext();
      parser.yylval = new ParserVal((Object)identifierName);
      if(!symbolTable.containsKey(identifierName)){
         symbolTable.put(identifierName, counter);
         System.out.print(String.format("<<new symbol table entity [%d, \"%s\"]>>", counter, identifierName));
         counter++;
         this.lineno=(yyline+1);
         this.column=(yycolumn+1);
         return Parser.IDENT;
        }
      this.lineno=(yyline+1);
      this.column=(yycolumn+1);
      return Parser.IDENT;
    }
}

{linecomment} {
   String lexeme=yytext();
   System.out.print(yytext()); /* linwecomm skip */
}

{blockcomment} {
   String lexeme=yytext();
   lineno+=lexeme.length()-lexeme.replace("\n","").length();
   column= lexeme.length()-lexeme.lastIndexOf("\n");
   System.out.print(yytext());/* blk skip */
}

{newline} {
   String lexeme=yytext();
   System.out.print(yytext());
   lineno++;
   column=1;/* line skip */
}

{whitespace} {
    if (yytext().equals("    ")){
      column+=4;
    } else if (yytext().equals("\t")){
      column+=4;
    } else {
      for(int i=0; i<yytext().length();i++){
         if (yytext().charAt(i)==' '){
            column++;
         }
      }
    }
   System.out.print(yytext());
   /* white skip */
}

\b {
   System.err.println("Sorry, backspace doesn't work");
}

/* error fallback */
[^] {
   this.lineno=(yyline+1);
   this.column=(yycolumn+1);
   System.out.println("\nLexical error: unexpected character '"+yytext()+"' at " + lineno + ":" + column + ".");
   this.lineno=(yyline+1);
   this.column=(yycolumn+1);
   return -1;
}
