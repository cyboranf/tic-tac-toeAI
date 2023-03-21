package com.example.TicTacToe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class TicTacToeApplication {
	public static void main(String[] args) {
		SpringApplication.run(TicTacToeApplication.class, args);
	}

}
