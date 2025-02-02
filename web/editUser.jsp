<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    Connection conn = DbConnector.getConnection();
    String sql = "SELECT * FROM users WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, userId);
    ResultSet rs = pstmt.executeQuery();
    rs.next();
    String firstName = rs.getString("first_name");
    String lastName = rs.getString("last_name");
    String email = rs.getString("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
</head>
<body>
    <form action="updateUser.jsp" method="post">
        <input type="hidden" name="userId" value="<%= userId %>" />
        <label>First Name:</label><input type="text" name="firstName" value="<%= firstName %>" /><br/>
        <label>Last Name:</label><input type="text" name="lastName" value="<%= lastName %>" /><br/>
        <label>Email:</label><input type="email" name="email" value="<%= email %>" /><br/>
        <input type="submit" value="Save Changes" />
    </form>
</body>
</html>
