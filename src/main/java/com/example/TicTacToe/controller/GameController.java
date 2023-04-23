package com.example.TicTacToe.controller;

import com.example.TicTacToe.domain.User;
import com.example.TicTacToe.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

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

        model.addAttribute("userId", loggedUser.getId());
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

        quantityOfAllGames = userService.quantityOfAllGames();
        usersScore = userService.scoresOfAllUsers();
        aiScore = (quantityOfAllGames * 3) - usersScore;

        model.addAttribute("quantityOfAllGames", quantityOfAllGames);
        model.addAttribute("aiScore", aiScore);

        return "table";
    }

    @PostMapping("/app/updateScore")
    public ResponseEntity<?> updateScore(@RequestParam("userId") Long userId, @RequestParam("result") String result) {
        userService.incrementQuantityOfGames(userId);

        if (result.equals("userWon")) {
            User user = userService.findById(userId);
            int newScore = user.getScore() + 3;
            userService.updateUserScore(userId, newScore);
        }

        User updatedUser = userService.findById(userId);
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("updatedScore", updatedUser.getScore());
        responseData.put("updatedQuantityOfGames", updatedUser.getQuantityOfGames());

        return ResponseEntity.ok(responseData);
    }
}
