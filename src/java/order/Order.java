package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import classes.DbConnector;

public class Order {
    private int orderId;
    private int userId;
    private String status; // "Delivered" or "Not Delivered"
    private double totalAmount;
    private LocalDateTime orderDate;
    private String address;
    private String mobileNumber;
    private int agentId;

    // Constructor
    public Order(int orderId, int userId, String status, double totalAmount, LocalDateTime orderDate,
                 String address, String mobileNumber, int agentId) {
        this.orderId = orderId;
        this.userId = userId;
        this.status = status;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.address = address;
        this.mobileNumber = mobileNumber;
        this.agentId = agentId;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public int getAgentId() {
        return agentId;
    }

    public void setAgentId(int agentId) {
        this.agentId = agentId;
    }

    // Method to create an order in the database
    public static int createOrder(int userId, double totalAmount, String address,String mobileNumber, int agentId) throws SQLException {
        String sql = "INSERT INTO orders (user_id, status, total_amount, order_date, address, mobile_number, agent_id) " + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DbConnector.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, userId);
            statement.setString(2, "In Progress");
            statement.setDouble(3, totalAmount);
            statement.setObject(4, LocalDateTime.now());
            statement.setString(5, address);
            statement.setString(6, mobileNumber);
            statement.setInt(7, agentId);

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
    }

    // Method to get all orders for a specific user
    public static List<Order> getOrdersByUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order(
                            resultSet.getInt("order_id"),
                            resultSet.getInt("user_id"),
                            resultSet.getString("status"),
                            resultSet.getDouble("total_amount"),
                            resultSet.getObject("order_date", LocalDateTime.class),
                            resultSet.getString("address"),
                            resultSet.getString("mobile_number"),
                            resultSet.getInt("agent_id")
                    );
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // Method to get all orders for a specific agent with a specific status
    public static List<Order> getOrdersByAgentAndStatus(int agentId, String status) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE agent_id = ? AND status = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, agentId);
            statement.setString(2, status);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order(
                            resultSet.getInt("order_id"),
                            resultSet.getInt("user_id"),
                            resultSet.getString("status"),
                            resultSet.getDouble("total_amount"),
                            resultSet.getObject("order_date", LocalDateTime.class),
                            resultSet.getString("address"),
                            resultSet.getString("mobile_number"),
                            resultSet.getInt("agent_id")
                    );
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // Method to get all orders (for admin)
    public static List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order(
                            resultSet.getInt("order_id"),
                            resultSet.getInt("user_id"),
                            resultSet.getString("status"),
                            resultSet.getDouble("total_amount"),
                            resultSet.getObject("order_date", LocalDateTime.class),
                            resultSet.getString("address"),
                            resultSet.getString("mobile_number"),
                            resultSet.getInt("agent_id")
                    );
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    
    // Add this method to Order class
    public static Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Order(
                        resultSet.getInt("order_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getString("status"),
                        resultSet.getDouble("total_amount"),
                        resultSet.getObject("order_date", LocalDateTime.class),
                        resultSet.getString("address"),
                        resultSet.getString("mobile_number"),
                        resultSet.getInt("agent_id")
                    );
                }
            }
        }
        return null;
    }

    // Method to update the status of an order (for agent)
    public static boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, orderId);

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0; // Return true if the status was updated
        }
    }
}