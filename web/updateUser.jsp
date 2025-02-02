<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");

    Connection conn = DbConnector.getConnection();
    String sql = "UPDATE users SET first_name=?, last_name=?, email=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, firstName);
    pstmt.setString(2, lastName);
    pstmt.setString(3, email);
    pstmt.setInt(4, userId);
    pstmt.executeUpdate();

    response.sendRedirect("Admin.jsp?category=" + request.getParameter("category"));
%>
