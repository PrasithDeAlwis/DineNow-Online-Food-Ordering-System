<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    // Retrieve user details from session
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    // Check if the user is logged in and has the role "admin"
    if (userName == null || userEmail == null || !"admin".equals(role)) {
        response.sendRedirect("SignIn.jsp?error=2"); // Redirect unauthorized users
        return;
    }

    // Get selected category (User, Agent, Admin) from the dropdown
    String category = request.getParameter("category");
    if (category == null) category = "User";  // Default to "User" if no category is selected
    
    // Prepare SQL query to retrieve users based on selected category
    String sql = "SELECT id, first_name, last_name, email FROM users WHERE role = ?";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <div class="min-h-screen bg-white relative overflow-hidden">
        <nav class="bg-white shadow-sm fixed w-full z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <!-- Logo Section -->
                    <div class="flex items-center pt-4">
                        <a href="index.jsp" class="flex-shrink-0">
                            <img src="resources/images/logo.png" alt="Dine NOW Logo" class="h-20 w-auto">
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main content -->
        <div class="px-8 relative pt-16">
            <div class="flex relative w-full h-screen bg-white pt-8">
                <!-- Left section -->
                <div class="w-1/3 pr-8 relative overflow-hidden z-10">
                    <div class="mb-6">
                        <div class="w-32 h-32 bg-yellow-400 rounded-full flex items-center justify-center mx-auto">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                            </svg>
                        </div>
                        <div class="space-y-2 pt-4">
                            <div class="pl-8 flex items-center">                              
                                <label class="">Name</label>
                            </div>
                            <div class="pl-8 pr-6">
                                <input type="text" value="<%= userName %>" readonly class="w-full p-2 font-semibold rounded-lg bg-gray-50 border focus:outline-none focus:border-yellow-400"/>
                            </div>
                            <div class="pl-8 flex items-center pt-4">                              
                                <label class="">Email</label>
                            </div>                            
                            <div class="pl-8 pr-6">
                                <input type="text" value="<%= userEmail %>" readonly class="w-full p-2 font-semibold rounded-lg bg-gray-50 border focus:outline-none focus:border-yellow-400"/>
                            </div>
                        </div>
                            <div class="pt-8 flex justify-center items-center">
                                <a href="Logout.jsp" class="px-6 p-3 bg-red-500 hover:bg-red-600 text-white rounded-lg flex items-center justify-center space-x-2 transition-colors">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                    </svg>
                                    <span>Logout</span>
                                </a>
                            </div>
                    </div>
                    
                    <!-- Half circle attached to divider -->
                    <div class="absolute right-0 top-2/4 w-64 h-64 bg-yellow-400 rounded-full translate-x-1/2 -translate-y-1/2 -z-10"></div>
                </div>

                <!-- Vertical Divider -->
                <div class="w-px bg-gray-500 absolute right-2/3 top-0 bottom-0"></div>

                <!-- Bottom half circle -->
                <div class="absolute bottom-40 -left-12 w-64 h-64 bg-yellow-400 opacity-70 rounded-full -translate-x-1/2 translate-y-1/2"></div>

                <!-- Right section -->
                <div class="w-2/3 pl-8">
                    <!-- Category section -->
                    <div class="mb-8">
                        <h2 class="text-xl font-bold mb-4">Category</h2>
                        <div class="flex items-center justify-between">
                            <form method="get" action="Admin.jsp" class="flex gap-4">
                                <select name="category" class="w-80 p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                                    <option <%= "User".equals(category) ? "selected" : "" %>>User</option>
                                    <option <%= "Agent".equals(category) ? "selected" : "" %>>Agent</option>
                                    <option <%= "Admin".equals(category) ? "selected" : "" %>>Admin</option>
                                </select>
                                <button type="submit" class="bg-yellow-400 text-white px-6 py-2 rounded-lg">
                                    Select
                                </button>
                            </form>
                            <a href="AddUser.jsp" class="bg-green-400 hover:bg-green-500 text-white px-6 py-2 rounded-lg transition-colors">
                                Add User
                            </a>
                        </div>
                    </div>

                    <!-- User details section -->
                    <div class="bg-white rounded-lg border shadow-sm p-6 mb-8">
                        <h2 class="text-xl font-bold mb-4"><%= category %> Details</h2>
                        <table class="w-full">
                            <thead class="border-b">
                                <tr class="text-left">
                                    <th class="py-2">Name</th>
                                    <th>Email</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        conn = DbConnector.getConnection();
                                        pstmt = conn.prepareStatement(sql);
                                        pstmt.setString(1, category.toLowerCase());
                                        rs = pstmt.executeQuery();
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
                                            <button onclick="deleteUser(<%= userId %>)" class="bg-red-500 hover:bg-red-600 text-white px-4 py-1 rounded-full text-sm transition-colors">
                                                Delete
                                            </button>
                                            <button onclick="editUser(<%= userId %>)" class="bg-blue-400 hover:bg-blue-500 text-white px-4 py-1 rounded-full text-sm transition-colors">
                                                Edit
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%  
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                        // Consider adding proper error handling/logging here
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) { }
                                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                                        if (conn != null) try { conn.close(); } catch (SQLException e) { }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Order Details Section -->
                    <div class="bg-white rounded-lg border shadow-sm p-6">
                        <h2 class="text-xl font-bold mb-4">Order Details</h2>
                        <table class="w-full">
                            <thead class="border-b">
                                <tr class="text-left">
                                    <th>Agent Name</th>
                                    <th>Order ID</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <td class="py-3">Uditha Dissanayake</td>
                                    <td>ORD_25</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-green-400 hover:bg-green-500 text-white px-4 py-1 rounded-full text-sm transition-colors">
                                                Delivered
                                            </button>
                                            <button class="bg-red-500 hover:bg-red-600 text-white px-4 py-1 rounded-full text-sm transition-colors">
                                                Not Delivered
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <button class="bg-blue-400 hover:bg-blue-500 text-white px-4 py-1 rounded-full text-sm transition-colors">
                                            View
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for Delete and Edit -->
    <script>
        function deleteUser(userId) {
            if (confirm("Are you sure you want to delete this user?")) {
                window.location.href = "deleteUser.jsp?userId=" + userId;
            }
        }

        function editUser(userId) {
            window.location.href = "editUser.jsp?userId=" + userId;
        }
    </script>
</body>
</html>