package com.tap.DAO;

import java.util.List;
import com.tap.model.OrderItem;

public interface OrderItemDAO {

    // Add an item to an order
    void addOrderItem(OrderItem orderItem);

    // Get order item by ID
    OrderItem getOrderItem(int orderItemId);

    // Get all order items
    List<OrderItem> getAllOrderItems();

    // Get all items belonging to a particular order
    List<OrderItem> getOrderItemsByOrder(int orderId);

    // Update an order item
    void updateOrderItem(OrderItem orderItem);

    // Delete an order item
    void deleteOrderItem(int orderItemId);

    // Delete all items belonging to an order
    void deleteOrderItemsByOrder(int orderId);
}