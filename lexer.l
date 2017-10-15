package ru.spbau.zhidkov;

%%

%public
%class Scanner

%type Token

%{
    private void shiftColumn(int delta) {
        yycolumn += delta;
    }
    public class Token {
        protected int line;
        protected int begPos;
        protected int endPos;

        public Token(int line, int begPos, int endPos) {
            this.line = line;
            this.begPos = begPos;
            this.endPos = endPos;
            shiftColumn(endPos - begPos);
        }

        public void setLine(int line) {
            this.line = line;
        }

        public void setBegPos(int begPos) {
            this.begPos = begPos;
        }

        public void setEndPos(int endPos) {
            this.endPos = endPos;
        }

        public int getLine() {
            return line;
        }

        public int getBegPos() {
            return begPos;
        }

        public int getEndPos() {
            return endPos;
        }

        @Override
        public String toString() {
            return  getClass().getSimpleName() + "{" +
                    "line = " + line +
                    ", begPos = " + begPos +
                    ", endPos = " + endPos +
                    '}';
        }
    }

    public class TokenWithValue<T> extends Token {
        public T getValue() {
            return value;
        }

        public void setValue(T value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return getClass().getSimpleName() + "{" +
                    "line = " + line +
                    ", begPos = " + begPos +
                    ", endPos = " + endPos +
                    ", value = <" + value + '>' + 
                    '}';
        }

        private T value;

        public TokenWithValue(T value, int line, int begPos, int endPos) {
            super(line, begPos, endPos);
            this.value = value;
        }
    }

    public class IntegerToken extends TokenWithValue<Integer> {

        public IntegerToken(Integer value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }

    public class DoubleToken extends TokenWithValue<Double> {
        public DoubleToken(Double value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }

    public class BooleanToken extends TokenWithValue<Boolean> {
        public BooleanToken(Boolean value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }

    public class LeftBracketToken extends Token {
        public LeftBracketToken(int line, int begPos, int endPos) {
            super(line, begPos, endPos);
        }
    }

    public class RightBracketToken extends Token {
        public RightBracketToken(int line, int begPos, int endPos) {
            super(line, begPos, endPos);
        }
    }

    public class ColonToken extends Token {
        public ColonToken(int line, int begPos, int endPos) {
            super(line, begPos, endPos);
        }
    }

    public class OperatorToken extends TokenWithValue<String> {

        public OperatorToken(String value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }

    public class KeyWordToken extends TokenWithValue<String> {

        public KeyWordToken(String value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }

    public class IdentifierToken extends TokenWithValue<String> {

        public IdentifierToken(String value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }
    
    public class NewLineToken extends Token {

        public NewLineToken(int line, int begPos, int endPos) {
            super(line, begPos, endPos);
        }
    }

    public class EofToken extends Token {

        public EofToken(int line, int begPos, int endPos) {
            super(line, begPos, endPos);
        }
    }

    public class CommentToken extends TokenWithValue<String> {

        public CommentToken(String value, int line, int begPos, int endPos) {
            super(value, line, begPos, endPos);
        }
    }


  
%}

INT_NUMBER = "-"?(0|[1-9][0-9]*)
DOUBLE_NUMBER = {INT_NUMBER}|{INT_NUMBER}"."{INT_NUMBER}
KEYWORD = "if"|"then"|"else"|"while"|"do"|"read"|"write"|"begin"|"end"
IDENTIFIER = [a-z]+
NEW_LINE = "\n"|"\r"|"\r\n"
SPACE = [ \t]
BOOLEAN = "true"|"false"
OPERATOR = "+"|"−"|"∗"|"%"|"=="|"!="|">"|">="|"<"|"<="|"&&"|"||"|"/"
LEFT_BRACKET = "("
RIGHT_BRACKET = ")"
COLON = ";"
COMMENT = "//".*


%%

{INT_NUMBER} {
    return new IntegerToken(Integer.valueOf(yytext()), yyline, yycolumn, yycolumn + yylength());
}

{DOUBLE_NUMBER} {
    return new DoubleToken(Double.valueOf(yytext()), yyline, yycolumn, yycolumn +  yylength());
}

{BOOLEAN} {
    return new BooleanToken(Boolean.valueOf(yytext()), yyline, yycolumn, yycolumn +  yylength());
}

{LEFT_BRACKET} {
    return new LeftBracketToken(yyline, yycolumn, yycolumn +  yylength());
}

{RIGHT_BRACKET} {
    return new RightBracketToken(yyline, yycolumn, yycolumn +  yylength());
}

{COLON} {
    return new ColonToken(yyline, yycolumn, yycolumn +  yylength());
}

{COMMENT} {
    return new CommentToken(yytext(), yyline, yycolumn, yycolumn +  yylength());
}


{OPERATOR} {
    return new OperatorToken(yytext(), yyline, yycolumn, yycolumn +  yylength());
}

{KEYWORD} {
    return new KeyWordToken(yytext(), yyline, yycolumn, yycolumn +  yylength());
}

{IDENTIFIER} {
    return new IdentifierToken(yytext(), yyline, yycolumn, yycolumn +  yylength());
}

{NEW_LINE}  {
    NewLineToken token = new NewLineToken(yyline, yycolumn, yycolumn +  yylength());
    yyline++;
    yycolumn = 0;
    return token;
}

{SPACE} {
    yycolumn += yylength();
}

. {
    throw new RuntimeException("Unrecognized character: " + yytext());
}

<<EOF>> { 
    return new EofToken(yyline, yycolumn,  yycolumn + yylength()); 
}

