package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    final static String URL = "jdbc:mysql://localhost:3306/foodapp";
    final static String USERNAME = "root";
    final static String PASSWORD = "Ruchitha@123";

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                    URL,
                    USERNAME,
                    PASSWORD
            );

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException("Database connection failed!", e);
        }
    }
}
