<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    String category = request.getParameter("category");
    Connection conn = DbConnector.getConnection();
    String sql = "SELECT id, first_name, last_name, email FROM users WHERE role = ? LIMIT 5 OFFSET ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, category);
    pstmt.setInt(2, Integer.parseInt(request.getParameter("offset")));
    ResultSet rs = pstmt.executeQuery();
    
    while (rs.next()) {
        int userId = rs.getInt("id");
        String fullName = rs.getString("first_name") + " " + rs.getString("last_name");
        String email = rs.getString("email");
%>
<tr class="border-b">
    <td class="py-3"><%= fullName %></td>
    <td><%= email %></td>
    <td>
        <div class="flex gap-2">
            <button onclick="deleteUser(<%= userId %>)" class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                Delete
            </button>
            <button onclick="editUser(<%= userId %>)" class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                Edit
            </button>
        </div>
    </td>
</tr>
<% } %>