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
}
