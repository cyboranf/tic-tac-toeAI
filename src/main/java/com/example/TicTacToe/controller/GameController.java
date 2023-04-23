package com.example.TicTacToe.controller;

import com.example.TicTacToe.domain.User;
import com.example.TicTacToe.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GameController {
    private final UserService userService;

    public GameController(UserService userService) {
        this.userService = userService;
    }

    public int quantityOfAllGames = 0;
    public int loggedUserScore;
    public int usersScore;
    public int aiScore;

    @GetMapping("/app/game")
    public String showGame(Model model) {
        User user = userService.findByLogged();
        model.addAttribute("username", user.getUserName());

        return "gameE";
    }

    @GetMapping("/app/medium")
    public String showGameMediumLevel(Model model) {
        User user = userService.findByLogged();
        model.addAttribute("username", user.getUserName());

        return "gameM";
    }

    @GetMapping("/app/hard")
    public String showGameHardLevel(Model model) {
        User loggedUser = userService.findByLogged();

        loggedUserScore = loggedUser.getScore();
        quantityOfAllGames = userService.quantityOfAllGames();
        usersScore = userService.scoresOfAllUsers();
        aiScore = (quantityOfAllGames * 3) - usersScore;

        model.addAttribute("username", loggedUser.getUserName());
        model.addAttribute("loggedUserScore", loggedUserScore);
        model.addAttribute("quantityOfAllGames", quantityOfAllGames);
        model.addAttribute("aiScore", aiScore);


        return "gameH";
    }

    @GetMapping("/app/hardB")
    public String showGameHardLevel2(Model model) {
        User loggedUser = userService.findByLogged();

        model.addAttribute("username", loggedUser.getUserName());
        model.addAttribute("loggedUserScore", loggedUserScore);
        model.addAttribute("quantityOfAllGames", quantityOfAllGames);
        model.addAttribute("aiScore", aiScore);

        return "gameHB";
    }

    @GetMapping("/app/table")
    public String showTable(Model model) {
        model.addAttribute("list", userService.findAll());
        model.addAttribute("aiScore", aiScore);

        return "table";
    }
}
