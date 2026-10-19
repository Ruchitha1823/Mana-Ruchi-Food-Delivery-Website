package com.tap.DAO;

import java.util.List;
import com.tap.model.OrderTable;

public interface OrderTableDAO {

    // Create a new order
    void addOrder(OrderTable order);

    // Get order by order ID
    OrderTable getOrder(int orderId);

    // Get all orders
    List<OrderTable> getAllOrders();

    // Get all orders placed by a particular user
    List<OrderTable> getOrdersByUser(int userId);

    // Get all orders for a particular restaurant
    List<OrderTable> getOrdersByRestaurant(int restaurantId);

    // Update order details
    void updateOrder(OrderTable order);

    // Update only the order status
    void updateOrderStatus(int orderId, String status);

    // Delete an order
    void deleteOrder(int orderId);
}