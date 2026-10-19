
package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DAO.RestaurantDAO;
import com.tap.DAO.MenuDAO;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;
    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String query = request.getParameter("q");

        if (query == null || query.trim().isEmpty()) {
            response.sendRedirect(
                request.getContextPath() + "/restaurants"
            );
            return;
        }

        query = query.trim();

        List<Restaurant> restaurantResults =
                new ArrayList<>();

        List<Map<String, Object>> dishResults =
                new ArrayList<>();

        try {
            // Search restaurant names and cuisines
            List<Restaurant> restaurants =
                    restaurantDAO.getActiveRestaurants();

            for (Restaurant restaurant : restaurants) {

                boolean restaurantMatch =
                        contains(restaurant.getName(), query)
                        || contains(
                                restaurant.getCuisineType(), query);

                if (restaurantMatch) {
                    restaurantResults.add(restaurant);
                }

                // Search dishes belonging to each restaurant
                List<Menu> menus =
                        menuDAO.getMenusByRestaurant(
                                restaurant.getRestaurantId());

                for (Menu menu : menus) {

                    if (contains(menu.getItemName(), query)
                            || contains(
                                menu.getDescription(), query)) {

                        Map<String, Object> result =
                                new HashMap<>();

                        result.put("menu", menu);
                        result.put("restaurant", restaurant);

                        dishResults.add(result);
                    }
                }
            }

            request.setAttribute("query", query);
            request.setAttribute(
                    "restaurantResults", restaurantResults);
            request.setAttribute("dishResults", dishResults);

            request.getRequestDispatcher(
                    "/search-results.jsp"
            ).forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to search restaurants and dishes.", e);
        }
    }

    private boolean contains(String value, String query) {
        return value != null
                && value.toLowerCase()
                        .contains(query.toLowerCase());
    }
}
