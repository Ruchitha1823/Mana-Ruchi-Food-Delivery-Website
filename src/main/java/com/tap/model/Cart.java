package com.tap.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private int restaurantId;

    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    public Cart() {
        this.restaurantId = 0;
    }

    public boolean addItem(Menu menu) {

        // Cart is empty
        if (items.isEmpty()) {
            restaurantId = menu.getRestaurantId();

            CartItem cartItem = new CartItem(menu, 1);
            items.put(menu.getMenuId(), cartItem);

            return true;
        }

        // Different restaurant
        if (restaurantId != menu.getRestaurantId()) {
            return false;
        }

        // Item already exists
        CartItem existingItem = items.get(menu.getMenuId());

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + 1);
        } 
        else {
            CartItem cartItem = new CartItem(menu, 1);
            items.put(menu.getMenuId(), cartItem);
        }

        return true;
    }

    public void updateQuantity(int menuId, int quantity) {

        CartItem cartItem = items.get(menuId);

        if (cartItem != null) {

            if (quantity <= 0) {
                items.remove(menuId);
            } 
            else {
                cartItem.setQuantity(quantity);
            }
        }

        if (items.isEmpty()) {
            restaurantId = 0;
        }
    }

    public void removeItem(int menuId) {

        items.remove(menuId);

        if (items.isEmpty()) {
            restaurantId = 0;
        }
    }

    public void clear() {

        items.clear();
        restaurantId = 0;
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public double getTotal() {

        double total = 0;

        for (CartItem cartItem : items.values()) {
            total += cartItem.getSubtotal();
        }

        return total;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public Map<Integer, CartItem> getItemMap() {
        return items;
    }
}