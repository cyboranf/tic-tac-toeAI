package com.example.TicTacToe.algorithm.classes;


import com.example.TicTacToe.algorithm.interfaces.InterfaceAI;
import org.springframework.stereotype.Service;

@Service
public class BotSkill implements InterfaceAI {

    @Override
    public int minimax(boolean maximizing, int[][] board) {
        return 0;
    }

    @Override
    public boolean gameEnd(int[][] board) {
        return false;
    }

    @Override
    public boolean gamePart2(int[][] board) {
        return false;
    }

    @Override
    public int winner(int[][] board) {
        return 0;
    }
}
