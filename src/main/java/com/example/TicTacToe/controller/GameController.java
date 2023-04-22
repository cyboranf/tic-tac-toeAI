package com.example.TicTacToe.controller;

import com.example.TicTacToe.algorithm.classes.BotSkill;
import com.example.TicTacToe.domain.LoggedUser;
import com.example.TicTacToe.domain.User;
import com.example.TicTacToe.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GameController {
    private final UserService userService;
    private final BotSkill botSkill;

    public GameController(UserService userService, BotSkill botSkill) {
        this.userService = userService;
        this.botSkill = botSkill;
    }

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
        User user = userService.findByLogged();
        model.addAttribute("username", user.getUserName());

        return "gameH";
    }

    @GetMapping("/app/hardB")
    public String showGameHardLevel2(Model model) {
        User user = userService.findByLogged();
        model.addAttribute("username", user.getUserName());

        return "gameHB";
    }

    @GetMapping("/app/table")
    public String showTable(Model model) {
        model.addAttribute("list", userService.findAll());
        return "table";
    }
}
