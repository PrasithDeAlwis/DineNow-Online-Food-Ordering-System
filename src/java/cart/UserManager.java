package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import classes.DbConnector;
import classes.MD5;

public class UserManager {

    // Method to register a user
    public static boolean registerUser(String firstName, String lastName, String email, String password, String role) {
        String sql = "INSERT INTO users (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String hashedPassword = MD5.getMd5(password);
            
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, hashedPassword);
            pstmt.setString(5, role);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to validate user credentials
    public static Map<String, String> validateUser(String email, String password) {
        String sql = "SELECT id, role, first_name, last_name FROM users WHERE email = ? AND password = ?";
        Map<String, String> userDetails = new HashMap<>();

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String hashedPassword = MD5.getMd5(password);
            pstmt.setString(1, email);
            pstmt.setString(2, hashedPassword);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userDetails.put("role", rs.getString("role"));
                userDetails.put("userId", rs.getString("id"));
                userDetails.put("firstName", rs.getString("first_name"));
                userDetails.put("lastName", rs.getString("last_name"));
                return userDetails;
            }
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
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
    
    public static String getUserName(int userId) {
        String sql = "SELECT first_name, last_name FROM users WHERE id = ?";
        
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                return firstName + " " + lastName;
            }
            return "Unknown";
            
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error";
        }
    }
}