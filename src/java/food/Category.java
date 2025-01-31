/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package food;

import classes.DbConnector;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Category {
    private int id;
    private String name;
    private String imageUrl;

    // Constructors
    public Category() {}

    public Category(int id, String name, String imageUrl) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
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

    public String getImageUrl() { 
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) { 
        this.imageUrl = imageUrl;
    }
    
    // Add category
    public boolean addCategory() {
        String query = "INSERT INTO category (name, image_url) VALUES (?, ?)";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, this.name);
            stmt.setString(2, this.imageUrl);
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
       
    // Get category by ID
    public static Category getCategoryById(int id) {
        String query = "SELECT * FROM category WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Category(rs.getInt("id"), rs.getString("name"), rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Update Category
    public boolean updateCategory() {
        String query = "UPDATE category SET name = ?, image_url = ? WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, this.name);
            stmt.setString(2, this.imageUrl);
            stmt.setInt(3, this.id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Category
    public boolean deleteCategory() {
        String query = "DELETE FROM category WHERE id = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, this.id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Retrieve All Categories
    public static List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM category";

        try (Connection conn = DbConnector.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                categories.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("image_url")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
       
}

