package food;

import classes.DbConnector;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Food {
    private int id;
    private String name;
    private String description;
    private double price;
    private boolean availability;
    private String imageUrl;
    private int categoryId;

    // Constructors
    public Food() {}

    public Food(int id, String name, String description, double price, boolean availability, String imageUrl, int categoryId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.availability = availability;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
    }

    // Getters and Setters
    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id;
    }

    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name;
    }

    public String getDescription() { 
        return description;
    }
    
    public void setDescription(String description) { 
        this.description = description;
    }

    public double getPrice() { 
        return price;
    }
    
    public void setPrice(double price) { 
        this.price = price;
    }

    public boolean isAvailability() { 
        return availability;
    }
    
    public void setAvailability(boolean availability) { 
        this.availability = availability;
    }

    public String getImageUrl() {
        return imageUrl; 
    }
    
    public void setImageUrl(String imageUrl) { 
        this.imageUrl = imageUrl;
    }

    public int getCategoryId() { 
        return categoryId; 
    }
    
    public void setCategoryId(int categoryId) { 
        this.categoryId = categoryId;
    }

    // Add Food Item
    public boolean addFood() {
        String query = "INSERT INTO food (name, description, price, availability, image_url, category_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConnector.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, this.name);
            stmt.setString(2, this.description);
            stmt.setDouble(3, this.price);
            stmt.setBoolean(4, this.availability);
            stmt.setString(5, this.imageUrl);
            stmt.setInt(6, this.categoryId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    this.id = generatedKeys.getInt(1);
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Retrieve Food by ID
    public static Food getFoodById(int id) {
        String query = "SELECT * FROM food WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Food(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getBoolean("availability"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update Food
    public boolean updateFood() {
        String query = "UPDATE food SET name = ?, description = ?, price = ?, availability = ?, image_url = ?, category_id = ? WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, this.name);
            stmt.setString(2, this.description);
            stmt.setDouble(3, this.price);
            stmt.setBoolean(4, this.availability);
            stmt.setString(5, this.imageUrl);
            stmt.setInt(6, this.categoryId);
            stmt.setInt(7, this.id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Food
    public boolean deleteFood() {
        String query = "DELETE FROM food WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, this.id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Retrieve All Foods
    public static List<Food> getAllFoods() {
        List<Food> foods = new ArrayList<>();
        String query = "SELECT * FROM food";

        try (Connection conn = DbConnector.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                foods.add(new Food(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getBoolean("availability"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return foods;
    }

}