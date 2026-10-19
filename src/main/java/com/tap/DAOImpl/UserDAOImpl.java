package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOImpl implements UserDAO {

    // SQL Queries
    private static final String INSERT_USER =
            "INSERT INTO User (name, password, email, phone, address, role, createdDate, lastLoginDate) "
          + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_USER_BY_ID =
            "SELECT * FROM User WHERE Userid = ?";

    private static final String GET_ALL_USERS =
            "SELECT * FROM User";

    private static final String UPDATE_USER =
            "UPDATE User SET name = ?, password = ?, email = ?, phone = ?, "
          + "address = ?, role = ?, createdDate = ?, lastLoginDate = ? "
          + "WHERE Userid = ?";

    private static final String DELETE_USER =
            "DELETE FROM User WHERE Userid = ?";

    private static final String GET_USER_BY_EMAIL =
            "SELECT * FROM User WHERE email = ?";


    // 1. Add User
    @Override
    public void addUser(User user) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_USER)) {

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setTimestamp(7, user.getCreatedDate());
            pstmt.setTimestamp(8, user.getLastLoginDate());

            pstmt.executeUpdate();

            System.out.println("User added successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 2. Get User by ID
    @Override
    public User getUser(int userId) {

        User user = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_ID)) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("Userid"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedDate(rs.getTimestamp("createdDate"));
                user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    // 3. Get All Users
    @Override
    public List<User> getAllUsers() {

        List<User> userList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_USERS)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("Userid"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedDate(rs.getTimestamp("createdDate"));
                user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));

                userList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }


    // 4. Update User
    @Override
    public void updateUser(User user) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_USER)) {

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setTimestamp(7, user.getCreatedDate());
            pstmt.setTimestamp(8, user.getLastLoginDate());

            pstmt.setInt(9, user.getId());

            pstmt.executeUpdate();

            System.out.println("User updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 5. Delete User
    @Override
    public void deleteUser(int userId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_USER)) {

            pstmt.setInt(1, userId);

            pstmt.executeUpdate();

            System.out.println("User deleted successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 6. Get User by Email
    @Override
    public User getUserByEmail(String email) {

        User user = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_EMAIL)) {

            pstmt.setString(1, email);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("Userid"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedDate(rs.getTimestamp("createdDate"));
                user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}
