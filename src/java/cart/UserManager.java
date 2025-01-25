package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public static String validateUser(String email, String password) {
        String sql = "SELECT role FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password); // In production, verify against hashed password
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("role"); // Return the user's role if credentials are valid
            }
            return null; // Return null if no user matches the provided credentials
            
        } catch (SQLException e) {
            e.printStackTrace();
            return null; // Return null if there is a database error
        }
    }
}
