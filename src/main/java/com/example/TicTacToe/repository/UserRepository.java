package com.example.TicTacToe.repository;

import com.example.TicTacToe.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findUserByUserName(String userName);

    User findFirstByEmail(String email);

    @Query(value = "SELECT * FROM user WHERE logged = true", nativeQuery = true)
    List<User> findByLogged();
}
