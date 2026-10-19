package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderTableDAO;
import com.tap.model.OrderTable;
import com.tap.utility.DBConnection;

public class OrderTableDAOImpl implements OrderTableDAO {

    // 1. Add Order
    @Override
    public void addOrder(OrderTable order) {

        String sql = "INSERT INTO OrderTable "
                   + "(UserID, RestaurantID, OrderDate, TotalAmount, Status, PaymentMethod) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setTimestamp(3, order.getOrderDate());
            pstmt.setDouble(4, order.getTotalAmount());
            pstmt.setString(5, order.getStatus());
            pstmt.setString(6, order.getPaymentMethod());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 2. Get Order by ID
    @Override
    public OrderTable getOrder(int orderId) {

        String sql = "SELECT * FROM OrderTable WHERE OrderID = ?";

        OrderTable order = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }


    // 3. Get All Orders
    @Override
    public List<OrderTable> getAllOrders() {

        String sql = "SELECT * FROM OrderTable";

        List<OrderTable> orders = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }


    // 4. Get Orders by User
    @Override
    public List<OrderTable> getOrdersByUser(int userId) {

        String sql = "SELECT * FROM OrderTable WHERE UserID = ?";

        List<OrderTable> orders = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }


    // 5. Get Orders by Restaurant
    @Override
    public List<OrderTable> getOrdersByRestaurant(int restaurantId) {

        String sql = "SELECT * FROM OrderTable WHERE RestaurantID = ?";

        List<OrderTable> orders = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }


    // 6. Update Order
    @Override
    public void updateOrder(OrderTable order) {

        String sql = "UPDATE OrderTable SET "
                   + "UserID = ?, RestaurantID = ?, OrderDate = ?, "
                   + "TotalAmount = ?, Status = ?, PaymentMethod = ? "
                   + "WHERE OrderID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setTimestamp(3, order.getOrderDate());
            pstmt.setDouble(4, order.getTotalAmount());
            pstmt.setString(5, order.getStatus());
            pstmt.setString(6, order.getPaymentMethod());
            pstmt.setInt(7, order.getOrderId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 7. Update Order Status
    @Override
    public void updateOrderStatus(int orderId, String status) {

        String sql = "UPDATE OrderTable SET Status = ? WHERE OrderID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // 8. Delete Order
    @Override
    public void deleteOrder(int orderId) {

        String sql = "DELETE FROM OrderTable WHERE OrderID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Helper Method
    private OrderTable extractOrderFromResultSet(ResultSet rs) throws SQLException {

        OrderTable order = new OrderTable();

        order.setOrderId(rs.getInt("OrderID"));
        order.setUserId(rs.getInt("UserID"));
        order.setRestaurantId(rs.getInt("RestaurantID"));
        order.setOrderDate(rs.getTimestamp("OrderDate"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setStatus(rs.getString("Status"));
        order.setPaymentMethod(rs.getString("PaymentMethod"));

        return order;
    }
}