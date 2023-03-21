package com.example.TicTacToe.domain;

import lombok.Data;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(length = 60, unique = true)
    private String email;
    @Column(nullable = false, unique = true, length = 30)
    private String userName;
    @Column(length = 60)
    private String lastName;
    @Column(length = 100, nullable = false)
    private String password;
    @Transient
    private String matchingPassword;
    private boolean logged;
    private boolean active;
    private int score;
    private int quantityOfGames;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;
}
