package com.example.TicTacToe.service;

import com.example.TicTacToe.domain.Role;
import com.example.TicTacToe.domain.User;
import com.example.TicTacToe.repository.RoleRepository;
import com.example.TicTacToe.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
@Transactional
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public User save(User user) {

        user.setActive(true);
        Role userRole = roleRepository.findRoleByName("USER");
        user.setRoles(new HashSet<>(Arrays.asList(userRole)));

        return userRepository.save(user);
    }

    public User findById(Long id) {
        return userRepository.findById(id).get();
    }

    public User findByEmail(String email) {
        return userRepository.findFirstByEmail(email);
    }

    public User findByLogged() {
        return userRepository.findByLogged().get(0);
    }

    public User findUserByName(String name) {
        return userRepository.findUserByUserName(name);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public int scoresOfAllUsers() {
        List<User> users = userRepository.findAll();

        AtomicInteger score = new AtomicInteger();

        users.forEach(u -> {
            score.addAndGet(u.getScore());
        });

        return score.get();
    }

    public int quantityOfAllGames() {
        List<User> users = userRepository.findAll();

        AtomicInteger quantity = new AtomicInteger();

        users.forEach(u -> {
            quantity.addAndGet(u.getQuantityOfGames());
        });

        return quantity.get();
    }

    public void updateUserScore(Long userId, int newScore) {
        User user = userRepository.findById(userId).orElseThrow(/* Handle user not found */);
        user.setScore(newScore);
        userRepository.save(user);
    }

    public void incrementQuantityOfGames(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(/* Handle user not found */);
        user.setQuantityOfGames(user.getQuantityOfGames() + 1);
        userRepository.save(user);
    }
}
