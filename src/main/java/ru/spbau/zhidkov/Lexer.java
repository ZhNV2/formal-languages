package ru.spbau.zhidkov;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

public class Lexer {

    public List<Scanner.Token> parse(Reader reader) throws IOException {
        Scanner scanner = new Scanner(reader);
        List<Scanner.Token> tokens = new ArrayList<>();
        while (true) {
            Scanner.Token token = scanner.yylex();
            tokens.add(token);
            if (Scanner.EofToken.class.isInstance(token)) {
                break;
            }
        }
        return tokens;
    }

}
