package com.example.TicTacToe.controller;

import com.example.TicTacToe.domain.User;
import com.example.TicTacToe.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public RegisterController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/login/register")
    public String showRegisterJSP(@ModelAttribute("user") User user,
                                  Model model) {
        model.addAttribute("user", user);
        return "register";
    }

    @PostMapping("/login/register")
    public String createAnUser(@ModelAttribute("user") User user,
                               BindingResult result, Model model) {

        if (result.hasErrors()) {
            model.addAttribute("user", user);
            return "register";
        }
        if (userService.findByEmail(user.getEmail()) != null) {
            result.rejectValue("email", "error.user", "You already have an account");
            model.addAttribute("user", user);
            return "register";
        }
        if (!user.getPassword().equals(user.getMatchingPassword())) {
            result.rejectValue("password", "error.user", "Wrong password or matching password");
            model.addAttribute("user", user);
            return "register";
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setActive(true);

        userService.save(user);
        model.addAttribute("registered", "true");

        return "register";
    }
}
