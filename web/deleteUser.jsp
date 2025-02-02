<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    // Get the userId from the request parameters
    int userId = Integer.parseInt(request.getParameter("userId"));

    // Initialize the database connection
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Connect to the database
        conn = DbConnector.getConnection();

        // SQL query to delete the user based on the userId
        String sql = "DELETE FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId); // Set the userId parameter for the DELETE query

        // Execute the DELETE query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Deletion was successful, redirect to Admin page with the correct category
            response.sendRedirect("Admin.jsp?category=" + request.getParameter("category"));
        } else {
            // If no rows were deleted, show an error message
            response.sendRedirect("Admin.jsp?category=" + request.getParameter("category") + "&error=User not found");
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle SQL exceptions
        response.sendRedirect("Admin.jsp?category=" + request.getParameter("category") + "&error=An error occurred while deleting the user");
    } finally {
        // Close database resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle closing exceptions
        }
    }
%>