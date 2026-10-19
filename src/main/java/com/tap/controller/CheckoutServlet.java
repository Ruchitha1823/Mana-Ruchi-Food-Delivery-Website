package com.tap.controller;

import java.io.IOException;

import com.tap.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        // Check whether cart exists
        if (cart == null || cart.getItems().isEmpty()) {

            response.sendRedirect(
                request.getContextPath() + "/cart"
            );
            return;
        }

        // Send cart to checkout.jsp
        request.setAttribute("cart", cart);

        request.getRequestDispatcher("/checkout.jsp")
               .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        // For now, POST will also display checkout page
        doGet(request, response);
    }
}