package com.tap.controller;

import java.io.IOException;

import com.tap.DAO.MenuDAO;
import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.model.Cart;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false); 
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        request.setAttribute("cart", cart);
        
        request.getRequestDispatcher("/cart.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // ADD ITEM
        if ("add".equals(action)) {

            String menuIdParameter = request.getParameter("menuId");

            if (menuIdParameter == null || menuIdParameter.isEmpty()) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Menu ID is required"
                );
                return;
            }

            try {

                int menuId = Integer.parseInt(menuIdParameter);

                Menu menu = menuDAO.getMenu(menuId);

                if (menu == null) {
                    response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Menu item not found"
                    );
                    return;
                }

                if (!menu.isAvailable()) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Menu item is not available"
                    );
                    return;
                }

                boolean added = cart.addItem(menu);

                if (added) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/menu?restaurantId="
                        + menu.getRestaurantId()
                    );
                } else {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/menu?restaurantId="
                        + menu.getRestaurantId()
                        + "&cartError=differentRestaurant"
                    );
                }

            } catch (NumberFormatException e) {

                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid menu ID"
                );
            }
        }

        // UPDATE QUANTITY
        else if ("update".equals(action)) {

            int menuId = Integer.parseInt(
                request.getParameter("menuId")
            );

            int quantity = Integer.parseInt(
                request.getParameter("quantity")
            );

            // Get menu from database
            Menu menu = menuDAO.getMenu(menuId);

            if (menu == null) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Menu item not found"
                );
                return;
            }

            cart.updateQuantity(menuId, quantity);

            String returnTo = request.getParameter("returnTo");

            if ("cart".equals(returnTo)) {
                response.sendRedirect(
                    request.getContextPath() + "/cart"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath()
                    + "/menu?restaurantId="
                    + menu.getRestaurantId()
                );
            }
        }
        // REMOVE ITEM
        else if ("remove".equals(action)) {

            int menuId = Integer.parseInt(
                request.getParameter("menuId")
            );

            cart.removeItem(menuId);

            response.sendRedirect(
                request.getContextPath() + "/cart"
            );
        }

        // CLEAR CART
        else if ("clear".equals(action)) {

            cart.clear();

            response.sendRedirect(
                request.getContextPath() + "/cart"
            );
        }

        else {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid cart action"
            );
        }
    } 
}