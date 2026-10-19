package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    // 1. Add Order Item
    @Override
    public void addOrderItem(OrderItem orderItem) {

        String sql = "INSERT INTO OrderItem "
                   + "(OrderID, MenuID, Quantity, TotalAmount) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getTotalAmount());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 2. Get Order Item by ID
    @Override
    public OrderItem getOrderItem(int orderItemId) {

        String sql = "SELECT * FROM OrderItem WHERE OrderItemID = ?";

        OrderItem orderItem = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItemId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                orderItem = extractOrderItemFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }


    // 3. Get All Order Items
    @Override
    public List<OrderItem> getAllOrderItems() {

        String sql = "SELECT * FROM OrderItem";

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }


    // 4. Get Order Items by Order
    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {

        String sql = "SELECT * FROM OrderItem WHERE OrderID = ?";

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }


    // 5. Update Order Item
    @Override
    public void updateOrderItem(OrderItem orderItem) {

        String sql = "UPDATE OrderItem SET "
                   + "OrderID = ?, MenuID = ?, Quantity = ?, TotalAmount = ? "
                   + "WHERE OrderItemID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getTotalAmount());
            pstmt.setInt(5, orderItem.getOrderItemId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 6. Delete Order Item
    @Override
    public void deleteOrderItem(int orderItemId) {

        String sql = "DELETE FROM OrderItem WHERE OrderItemID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItemId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 7. Delete All Order Items for an Order
    @Override
    public void deleteOrderItemsByOrder(int orderId) {

        String sql = "DELETE FROM OrderItem WHERE OrderID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Helper Method
    private OrderItem extractOrderItemFromResultSet(ResultSet rs)
            throws SQLException {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(rs.getInt("OrderItemID"));
        orderItem.setOrderId(rs.getInt("OrderID"));
        orderItem.setMenuId(rs.getInt("MenuID"));
        orderItem.setQuantity(rs.getInt("Quantity"));
        orderItem.setTotalAmount(rs.getDouble("TotalAmount"));

        return orderItem;
    }
}