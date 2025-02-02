<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    // Check if admin is logged in
    String userRole = (String) session.getAttribute("role");
    if (!"admin".equals(userRole)) {
        response.sendRedirect("SignIn.jsp");
        return;
    }

    String message = "";
    try {
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
    <title>Edit User - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-md w-96">
            <h2 class="text-2xl font-bold mb-6 text-center">Edit User</h2>
            
            <% if (!message.isEmpty()) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= message %>
                </div>
            <% } %>

            <form action="updateUser.jsp" method="post" class="space-y-4">
                <input type="hidden" name="userId" value="<%= userId %>">
                <input type="hidden" name="category" value="<%= request.getParameter("category") %>">
                
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">First Name</label>
                    <input type="text" 
                           name="firstName" 
                           value="<%= firstName %>"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Last Name</label>
                    <input type="text" 
                           name="lastName" 
                           value="<%= lastName %>"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                    <input type="email" 
                           name="email" 
                           value="<%= email %>"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>

                <div class="flex gap-4">
                    <button type="submit" 
                            class="w-full bg-yellow-400 text-white py-2 rounded-lg hover:bg-yellow-500 transition-colors">
                        Save Changes
                    </button>
                    <a href="Admin.jsp" 
                       class="w-full bg-gray-400 text-white py-2 rounded-lg hover:bg-gray-500 transition-colors text-center">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
<%
    } catch (Exception e) {
        response.sendRedirect("Admin.jsp?error=invalidUser");
    }
%>