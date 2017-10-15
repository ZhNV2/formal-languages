package ru.spbau.zhidkov;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Specify input file");
            return;
        }
        String inputFile = args[0];
        try (Reader reader = new FileReader(inputFile)) {
            List<Scanner.Token> tokens = new Lexer().parse(reader);
            for (Scanner.Token token : tokens) {
                System.out.println(token);
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
        } catch (IOException e) {
            System.out.println("IOException " + e.getMessage());
        }
    }
}
