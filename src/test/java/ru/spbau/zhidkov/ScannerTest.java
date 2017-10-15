package ru.spbau.zhidkov;

import org.junit.Test;

import java.io.IOException;
import java.io.StringReader;
import java.util.List;

public class ScannerTest {

    @Test
    public void test() throws IOException {
        Lexer lexer = new Lexer();
        List<Scanner.Token> tokens = lexer.parse(new StringReader(
                "read x; //dsafds adsf asd  fds" + "\n" +
                        "read x; if y + 1 == x then write y else write x"));
        for (Scanner.Token token : tokens) {
            System.out.println(token);
        }
    }
}
