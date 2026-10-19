package com.tap.DAO;

import java.util.List;
import com.tap.model.User;

public interface UserDAO {

    void addUser(User user);

    User getUser(int userId);

    List<User> getAllUsers();

    void updateUser(User user);

    void deleteUser(int userId);

    User getUserByEmail(String email);
}