package com.tap.DAO;

import java.util.List;
import com.tap.model.Menu;

public interface MenuDAO {

    // Add a new menu item
    void addMenu(Menu menu);

    // Get menu item by ID
    Menu getMenu(int menuId);

    // Get all menu items
    List<Menu> getAllMenus();

    // Get all menu items of a particular restaurant
    List<Menu> getMenusByRestaurant(int restaurantId);

    // Update menu item details
    void updateMenu(Menu menu);

    // Delete menu item
    void deleteMenu(int menuId);

    // Get only available menu items
    List<Menu> getAvailableMenus();

    // Search menu items by name
    List<Menu> searchMenus(String itemName);

    // Get available menu items of a particular restaurant
    List<Menu> getAvailableMenusByRestaurant(int restaurantId);
    
    // Get menu items by food type (Veg or Non-Veg)
    List<Menu> getMenusByFoodType(String foodType);
}
