
package com.tap.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import com.tap.DAO.MenuDAO;
import com.tap.DAO.RestaurantDAO;
import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        String restaurantIdParameter =
                request.getParameter("restaurantId");

        if (restaurantIdParameter == null ||
            restaurantIdParameter.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Restaurant ID is required"
            );
            return;
        }

        try {
            int restaurantId =
                    Integer.parseInt(restaurantIdParameter.trim());

            // STEP 1: Retrieve the selected restaurant
            Restaurant restaurant =
                    restaurantDAO.getRestaurant(restaurantId);

            if (restaurant == null) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Restaurant not found"
                );
                return;
            }

            // STEP 2: Retrieve menu items for this restaurant
            List<Menu> menuList =
                    menuDAO.getMenusByRestaurant(restaurantId);

            // STEP 3: Normalize the selected food filter
            String foodType = request.getParameter("foodType");

            if (foodType == null ||
                foodType.trim().isEmpty() ||
                "All".equalsIgnoreCase(foodType.trim())) {

                foodType = "All";

            } else if ("Veg".equalsIgnoreCase(foodType.trim())) {

                foodType = "Veg";

            } else if ("Non-Veg".equalsIgnoreCase(foodType.trim())) {

                foodType = "Non-Veg";

            } else {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid food type"
                );
                return;
            }

            // STEP 4: Filter only this restaurant's menu items
            if ("Veg".equals(foodType)) {

                menuList = menuList.stream()
                    .filter(menu ->
                        "Veg".equalsIgnoreCase(menu.getFoodType()))
                    .collect(Collectors.toList());

            } else if ("Non-Veg".equals(foodType)) {

                menuList = menuList.stream()
                    .filter(menu ->
                        "Non-Veg".equalsIgnoreCase(menu.getFoodType()))
                    .collect(Collectors.toList());
            }

            // STEP 5: Pass data to menu.jsp
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuList", menuList);
            request.setAttribute("restaurantId", restaurantId);
            request.setAttribute("selectedFoodType", foodType);

            // STEP 6: Forward to the existing JSP
            request.getRequestDispatcher("/menu.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid restaurant ID"
            );
        }
    }
}
