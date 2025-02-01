package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import classes.DbConnector;

public class OrderItem {
    private int id;
    private int orderId;
    private int foodId;
    private int quantity;
    private double price;

    // Constructor
    public OrderItem(int id, int orderId, int foodId, int quantity, double price) {
        this.id = id;
        this.orderId = orderId;
        this.foodId = foodId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Method to add an item to an order
    public static void addOrderItem(int orderId, int foodId, int quantity, double price) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, food_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection connection = DbConnector.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            statement.setInt(2, foodId);
            statement.setInt(3, quantity);
            statement.setDouble(4, price);
            statement.executeUpdate();
        }
    }
}