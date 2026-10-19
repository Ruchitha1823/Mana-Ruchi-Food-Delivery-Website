package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    // 1. Add Restaurant
    private static final String INSERT_RESTAURANT =
            "INSERT INTO Restaurant "
          + "(name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath) "
          + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    // 2. Get Restaurant by ID
    private static final String GET_RESTAURANT_BY_ID =
            "SELECT * FROM Restaurant WHERE restaurantId = ?";

    // 3. Get All Restaurants
    private static final String GET_ALL_RESTAURANTS =
            "SELECT * FROM Restaurant";

    // 4. Update Restaurant
    private static final String UPDATE_RESTAURANT =
            "UPDATE Restaurant SET name = ?, cuisineType = ?, deliveryTime = ?, "
          + "address = ?, adminUserId = ?, rating = ?, isActive = ?, imagePath = ? "
          + "WHERE restaurantId = ?";

    // 5. Delete Restaurant
    private static final String DELETE_RESTAURANT =
            "DELETE FROM Restaurant WHERE restaurantId = ?";

    // 6. Get Active Restaurants
    private static final String GET_ACTIVE_RESTAURANTS =
            "SELECT * FROM Restaurant WHERE isActive = ?";

    // 7. Search Restaurants by Name
    private static final String SEARCH_RESTAURANTS =
            "SELECT * FROM Restaurant WHERE name LIKE ?";

    // 8. Get Restaurants by Cuisine
    private static final String GET_BY_CUISINE =
            "SELECT * FROM Restaurant WHERE cuisineType = ?";

    // 9. Get Restaurants by Admin
    private static final String GET_BY_ADMIN =
            "SELECT * FROM Restaurant WHERE adminUserId = ?";

    private static final String GET_ACTIVE_RESTAURANTS_BY_LOCATION =
            "SELECT * FROM Restaurant " +
            "WHERE isActive = ? AND address LIKE ?";

    // ---------------------------------------------------------
    // 1. ADD RESTAURANT
    // ---------------------------------------------------------

    @Override
    public void addRestaurant(Restaurant restaurant) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_RESTAURANT)) {

            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setInt(3, restaurant.getDeliveryTime());
            pstmt.setString(4, restaurant.getAddress());
            pstmt.setInt(5, restaurant.getAdminUserId());
            pstmt.setDouble(6, restaurant.getRating());
            pstmt.setBoolean(7, restaurant.isActive());
            pstmt.setString(8, restaurant.getImagePath());

            pstmt.executeUpdate();

            System.out.println("Restaurant added successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 2. GET RESTAURANT BY ID
    // ---------------------------------------------------------

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_RESTAURANT_BY_ID)) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                restaurant = extractRestaurantFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }


    // ---------------------------------------------------------
    // 3. GET ALL RESTAURANTS
    // ---------------------------------------------------------

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_RESTAURANTS)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = extractRestaurantFromResultSet(rs);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    // ---------------------------------------------------------
    // 4. UPDATE RESTAURANT
    // ---------------------------------------------------------

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_RESTAURANT)) {

            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setInt(3, restaurant.getDeliveryTime());
            pstmt.setString(4, restaurant.getAddress());
            pstmt.setInt(5, restaurant.getAdminUserId());
            pstmt.setDouble(6, restaurant.getRating());
            pstmt.setBoolean(7, restaurant.isActive());
            pstmt.setString(8, restaurant.getImagePath());

            pstmt.setInt(9, restaurant.getRestaurantId());

            pstmt.executeUpdate();

            System.out.println("Restaurant updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 5. DELETE RESTAURANT
    // ---------------------------------------------------------

    @Override
    public void deleteRestaurant(int restaurantId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_RESTAURANT)) {

            pstmt.setInt(1, restaurantId);

            pstmt.executeUpdate();

            System.out.println("Restaurant deleted successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 6. GET ACTIVE RESTAURANTS
    // ---------------------------------------------------------

    @Override
    public List<Restaurant> getActiveRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ACTIVE_RESTAURANTS)) {

            pstmt.setBoolean(1, true);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = extractRestaurantFromResultSet(rs);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    // ---------------------------------------------------------
    // 7. SEARCH RESTAURANTS BY NAME
    // ---------------------------------------------------------

    @Override
    public List<Restaurant> searchRestaurants(String name) {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(SEARCH_RESTAURANTS)) {

            pstmt.setString(1, "%" + name + "%");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = extractRestaurantFromResultSet(rs);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    // ---------------------------------------------------------
    // 8. GET RESTAURANTS BY CUISINE
    // ---------------------------------------------------------

    @Override
    public List<Restaurant> getRestaurantsByCuisine(String cuisineType) {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_CUISINE)) {

            pstmt.setString(1, cuisineType);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = extractRestaurantFromResultSet(rs);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    // ---------------------------------------------------------
    // 9. GET RESTAURANTS BY ADMIN
    // ---------------------------------------------------------

    @Override
    public List<Restaurant> getRestaurantsByAdmin(int adminUserId) {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BY_ADMIN)) {

            pstmt.setInt(1, adminUserId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = extractRestaurantFromResultSet(rs);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    // ---------------------------------------------------------
    // COMMON METHOD TO CONVERT RESULTSET → RESTAURANT OBJECT
    // ---------------------------------------------------------

    private Restaurant extractRestaurantFromResultSet(ResultSet rs)
            throws SQLException {

        Restaurant restaurant = new Restaurant();

        restaurant.setRestaurantId(rs.getInt("restaurantId"));
        restaurant.setName(rs.getString("name"));
        restaurant.setCuisineType(rs.getString("cuisineType"));
        restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setAdminUserId(rs.getInt("adminUserId"));
        restaurant.setRating(rs.getDouble("rating"));
        restaurant.setActive(rs.getBoolean("isActive"));
        restaurant.setImagePath(rs.getString("imagePath"));

        return restaurant;
    }
    
    public List<Restaurant> getActiveRestaurantsByLocation(String location) {

        List<Restaurant> restaurantList = new ArrayList<>();

        String searchLocation = (location == null) ? "" : location.trim();

        if (searchLocation.isEmpty()) {
            return getActiveRestaurants();
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(GET_ACTIVE_RESTAURANTS_BY_LOCATION)) {

            pstmt.setBoolean(1, true);
            pstmt.setString(2, "%" + searchLocation + "%");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    restaurantList.add(extractRestaurantFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }
}