<%@ page import="java.sql.*, classes.DbConnector, cart.UserManager" %>
<%
    // Check if admin is logged in
    String userRole = (String) session.getAttribute("role");
    if (!"admin".equals(userRole)) {
        response.sendRedirect("SignIn.jsp");
        return;
    }

    String message = "";
    boolean isSuccess = false;

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role").toLowerCase();

        // Validate inputs
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            message = "All fields are required";
        } else {
            // Attempt to register user
            boolean registered = UserManager.registerUser(firstName, lastName, email, password, role);
            if (registered) {
                response.sendRedirect("Admin.jsp?success=userAdded");
                return;
            } else {
                message = "Failed to add user. Please try again.";
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add User - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-md w-96">
            <h2 class="text-2xl font-bold mb-6 text-center">Add New User</h2>
            
            <% if (!message.isEmpty()) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= message %>
                </div>
            <% } %>

            <form action="addUser.jsp" method="post" class="space-y-4">
                <div>
                    <input type="text" name="firstName" placeholder="First Name"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                <div>
                    <input type="text" name="lastName" placeholder="Last Name"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                <div>
                    <input type="email" name="email" placeholder="Email"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                <div>
                    <input type="password" name="password" placeholder="Password"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                </div>
                <div>
                    <select name="role" 
                            class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-yellow-400">
                        <option value="user">Customer</option>
                        <option value="agent">Agent</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <button type="submit" 
                        class="w-full bg-yellow-400 text-white py-2 rounded-lg hover:bg-yellow-500 transition-colors">
                    Add User
                </button>
            </form>
        </div>
    </div>
</body>
</html>