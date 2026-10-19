
package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    // 1. Add Menu Item
    private static final String INSERT_MENU =
            "INSERT INTO Menu "
          + "(restaurantId, itemName, description, price, isAvailable, imagePath, foodType) "
          + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    // 2. Get Menu Item by ID
    private static final String GET_MENU_BY_ID =
            "SELECT * FROM Menu WHERE menuId = ?";

    // 3. Get All Menu Items
    private static final String GET_ALL_MENUS =
            "SELECT * FROM Menu";

    // 4. Get Menu Items by Restaurant
    private static final String GET_MENUS_BY_RESTAURANT =
            "SELECT * FROM Menu WHERE restaurantId = ?";

    // 5. Update Menu Item
    private static final String UPDATE_MENU =
            "UPDATE Menu SET restaurantId = ?, itemName = ?, description = ?, "
          + "price = ?, isAvailable = ?, imagePath = ?, foodType = ? "
          + "WHERE menuId = ?";

    // 6. Delete Menu Item
    private static final String DELETE_MENU =
            "DELETE FROM Menu WHERE menuId = ?";

    // 7. Get Available Menu Items
    private static final String GET_AVAILABLE_MENUS =
            "SELECT * FROM Menu WHERE isAvailable = ?";

    // 8. Search Menu Items by Name
    private static final String SEARCH_MENUS =
            "SELECT * FROM Menu WHERE itemName LIKE ?";

    // 9. Get Available Menu Items by Restaurant
    private static final String GET_AVAILABLE_MENUS_BY_RESTAURANT =
            "SELECT * FROM Menu WHERE restaurantId = ? AND isAvailable = ?";

    // 10. Get Menu Items by Food Type
    private static final String GET_MENUS_BY_FOOD_TYPE =
            "SELECT * FROM Menu WHERE foodType = ?";


    // ---------------------------------------------------------
    // 1. ADD MENU ITEM
    // ---------------------------------------------------------

    @Override
    public void addMenu(Menu menu) {

        String foodType = menu.getFoodType();

        if (!isValidFoodType(foodType)) {
            throw new IllegalArgumentException(
                    "Food type must be Veg or Non-Veg.");
        }

        String normalizedFoodType = normalizeFoodType(foodType);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_MENU)) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());
            pstmt.setString(7, normalizedFoodType);

            pstmt.executeUpdate();

            System.out.println("Menu item added successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 2. GET MENU ITEM BY ID
    // ---------------------------------------------------------

    @Override
    public Menu getMenu(int menuId) {

        Menu menu = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_MENU_BY_ID)) {

            pstmt.setInt(1, menuId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    menu = extractMenuFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }


    // ---------------------------------------------------------
    // 3. GET ALL MENU ITEMS
    // ---------------------------------------------------------

    @Override
    public List<Menu> getAllMenus() {

        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_MENUS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                menuList.add(extractMenuFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // 4. GET MENU ITEMS BY RESTAURANT
    // ---------------------------------------------------------

    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(GET_MENUS_BY_RESTAURANT)) {

            pstmt.setInt(1, restaurantId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuList.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // 5. UPDATE MENU ITEM
    // ---------------------------------------------------------

    @Override
    public void updateMenu(Menu menu) {

        String foodType = menu.getFoodType();

        if (!isValidFoodType(foodType)) {
            throw new IllegalArgumentException(
                    "Food type must be Veg or Non-Veg.");
        }

        String normalizedFoodType = normalizeFoodType(foodType);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_MENU)) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());
            pstmt.setString(7, normalizedFoodType);
            pstmt.setInt(8, menu.getMenuId());

            pstmt.executeUpdate();

            System.out.println("Menu item updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 6. DELETE MENU ITEM
    // ---------------------------------------------------------

    @Override
    public void deleteMenu(int menuId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_MENU)) {

            pstmt.setInt(1, menuId);
            pstmt.executeUpdate();

            System.out.println("Menu item deleted successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // ---------------------------------------------------------
    // 7. GET AVAILABLE MENU ITEMS
    // ---------------------------------------------------------

    @Override
    public List<Menu> getAvailableMenus() {

        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(GET_AVAILABLE_MENUS)) {

            pstmt.setBoolean(1, true);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuList.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // 8. SEARCH MENU ITEMS BY NAME
    // ---------------------------------------------------------

    @Override
    public List<Menu> searchMenus(String itemName) {

        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(SEARCH_MENUS)) {

            pstmt.setString(1, "%" + itemName + "%");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuList.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // 9. GET AVAILABLE MENU ITEMS BY RESTAURANT
    // ---------------------------------------------------------

    @Override
    public List<Menu> getAvailableMenusByRestaurant(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(GET_AVAILABLE_MENUS_BY_RESTAURANT)) {

            pstmt.setInt(1, restaurantId);
            pstmt.setBoolean(2, true);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuList.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // 10. GET MENU ITEMS BY FOOD TYPE
    // ---------------------------------------------------------

    @Override
    public List<Menu> getMenusByFoodType(String foodType) {

        List<Menu> menuList = new ArrayList<>();

        if (!isValidFoodType(foodType)) {
            return menuList;
        }

        String normalizedFoodType = normalizeFoodType(foodType);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt =
                     con.prepareStatement(GET_MENUS_BY_FOOD_TYPE)) {

            pstmt.setString(1, normalizedFoodType);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuList.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // ---------------------------------------------------------
    // COMMON METHOD: RESULTSET TO MENU OBJECT
    // ---------------------------------------------------------

    private Menu extractMenuFromResultSet(ResultSet rs)
            throws SQLException {

        Menu menu = new Menu();

        menu.setMenuId(rs.getInt("menuId"));
        menu.setRestaurantId(rs.getInt("restaurantId"));
        menu.setItemName(rs.getString("itemName"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setAvailable(rs.getBoolean("isAvailable"));
        menu.setImagePath(rs.getString("imagePath"));
        menu.setFoodType(rs.getString("foodType"));

        return menu;
    }


    // ---------------------------------------------------------
    // HELPER METHODS: VALIDATE AND NORMALIZE FOOD TYPE
    // ---------------------------------------------------------

    private boolean isValidFoodType(String foodType) {

        return foodType != null
                && (foodType.trim().equalsIgnoreCase("Veg")
                || foodType.trim().equalsIgnoreCase("Non-Veg"));
    }

    private String normalizeFoodType(String foodType) {
        return foodType.trim().equalsIgnoreCase("Veg")
                ? "Veg"
                : "Non-Veg";
    }
}
