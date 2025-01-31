package order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import classes.DbConnector;

public class Order {
    private int orderId;
    private int userId;
    private String status;
    private double totalAmount;
    private Date orderDate;

    // Constructors
    public Order(int userId, String status, double totalAmount, Date orderDate) {
        this.userId = userId;
        this.status = status;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
    }

    public Order(int orderId, int userId, String status, double totalAmount, Date orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.status = status;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
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

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    // Methods to interact with the database
    public static List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int orderId = resultSet.getInt("order_id");
                String status = resultSet.getString("status");
                double totalAmount = resultSet.getDouble("total_amount");
                Date orderDate = resultSet.getDate("order_date");
                orders.add(new Order(orderId, userId, status, totalAmount, orderDate));
            }
        }
        return orders;
    }

    public static boolean createOrder(Order order, List<OrderItem> items) throws SQLException {
        String insertOrderQuery = "INSERT INTO orders (user_id, status, total_amount, order_date) VALUES (?, ?, ?, ?)";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setString(2, order.getStatus());
            preparedStatement.setDouble(3, order.getTotalAmount());
            preparedStatement.setDate(4, order.getOrderDate());
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int orderId = generatedKeys.getInt(1);
                    // Insert items
                    for (OrderItem item : items) {
                        item.setOrderId(orderId);
                        OrderItem.createOrderItem(item);
                    }
                    return true;
                }
            }
        }
        return false;
    }
}
