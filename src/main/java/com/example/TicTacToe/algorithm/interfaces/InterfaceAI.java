package com.example.TicTacToe.algorithm.interfaces;

public interface InterfaceAI {
    //TODO: give AI the best move
    int minimax(boolean maximizing, int[][] board);

    //TODO: checks if the game is over
    boolean gameEnd(int[][] board);

    //TODO: check if the game is gonna change to part 2
    boolean gamePart2(int[][] board);

    //TODO: check who won
    int winner(int board[][]);

}
