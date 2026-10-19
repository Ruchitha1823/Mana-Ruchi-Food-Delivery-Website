package com.tap.DAO;
import java.util.*;

import com.tap.model.Restaurant;

public interface RestaurantDAO {

	    // Add a new restaurant
	    void addRestaurant(Restaurant restaurant);

	    // Get restaurant by ID
	    Restaurant getRestaurant(int restaurantId);

	    // Get all restaurants
	    List<Restaurant> getAllRestaurants();

	    // Update restaurant details
	    void updateRestaurant(Restaurant restaurant);

	    // Delete restaurant
	    void deleteRestaurant(int restaurantId);

	    // Get only active restaurants
	    List<Restaurant> getActiveRestaurants();

	    // Search restaurants by name
	    List<Restaurant> searchRestaurants(String name);

	    // Get restaurants by cuisine type
	    List<Restaurant> getRestaurantsByCuisine(String cuisineType);

	    // Get restaurants belonging to a particular admin
	    List<Restaurant> getRestaurantsByAdmin(int adminUserId);
	    
	 // Get active restaurants by delivery location
	    List<Restaurant> getActiveRestaurantsByLocation(String location);
}
	