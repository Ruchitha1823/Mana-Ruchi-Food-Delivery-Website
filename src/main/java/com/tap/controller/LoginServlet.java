
package com.tap.controller;

import java.io.IOException;

import com.tap.DAO.UserDAO;
import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Open the login page when /login is accessed directly
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate the submitted fields
        if (email == null || password == null
                || email.trim().isEmpty()
                || password.isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                    + "/login.jsp?error=invalid"
            );
            return;
        }

        // Find the user using the existing DAO
        User user = userDAO.getUserByEmail(email.trim());

        // Verify the credentials
        if (user != null
                && password.equals(user.getPassword())) {

            // Store the logged-in user in the session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            // Return to the homepage after successful login
            response.sendRedirect(
                request.getContextPath() + "/home.jsp"
            );

        } else {

            // Redirect back to login if credentials are invalid
            response.sendRedirect(
                request.getContextPath()
                    + "/login.jsp?error=invalid"
            );
        }
    }
}
