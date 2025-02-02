package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import classes.DbConnector;

public class UserManager {

    // Method to register a user
    public static boolean registerUser(String firstName, String lastName, String email, String password, String role) {
        String sql = "INSERT INTO users (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, password); // In production, hash the password
            pstmt.setString(5, role);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Return true if user is successfully registered
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to validate user credentials
    public static Map<String, String> validateUser(String email, String password) {
        String sql = "SELECT id, first_name, last_name, role FROM users WHERE email = ? AND password = ?";
        Map<String, String> userDetails = new HashMap<>();

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password); // In production, verify against hashed password
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userDetails.put("userId", rs.getString("id"));  // Store user ID
                userDetails.put("firstName", rs.getString("first_name"));  // Store first name
                userDetails.put("lastName", rs.getString("last_name"));  // Store last name
                userDetails.put("role", rs.getString("role"));  // Store user role
                return userDetails; // Return user details if credentials are valid
            }
            return null; // Return null if no user matches the provided credentials
            
        } catch (SQLException e) {
            e.printStackTrace();
            return null; // Return null if there is a database error
        }
    }
    // Get Agent ID
    public static int getAgentId() throws SQLException {
        String sql = "SELECT id FROM users WHERE role = 'agent' LIMIT 1";

        try (Connection conn = DbConnector.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            throw new SQLException("No agent found in system");
        }
    }
}