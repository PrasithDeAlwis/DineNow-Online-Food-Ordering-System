<%@page import="food.Food"%>
<%@page import="cart.UserManager"%>
<%@page import="order.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="order.Order"%>
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
    
    // Handle order details request
    String orderIdParam = request.getParameter("orderId");
    if (orderIdParam != null) {
        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = Order.getOrderById(orderId);
            List<OrderItem> items = OrderItem.getOrderItems(orderId);
            request.setAttribute("selectedOrder", order);
            request.setAttribute("orderItems", items);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to retrieve order details.");
        }
    }
    
    // Retrieve all orders from the database
    List<Order> orders = null;
    try {
        orders = Order.getAllOrders();
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Failed to retrieve orders. Please try again.");
    }
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
            
            <!-- Order Details Modal -->
            <div id="orderModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm hidden overflow-y-auto h-full w-full z-50">
                <div class="relative top-20 mx-auto p-0 border-0 w-11/12 md:w-4/5 lg:w-3/4 max-w-4xl shadow-lg rounded-xl bg-white">
                    <!-- Modal Header -->
                    <div class="flex justify-between items-center p-6 border-b border-gray-200">
                        <h3 class="text-2xl font-semibold text-gray-800">Order Details</h3>
                        <button onclick="closeModal()" class="text-gray-400 hover:text-gray-500 transition-colors rounded-lg p-1 hover:bg-gray-100">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>

                    <!-- Modal Content -->
                    <div class="p-6">
                        <% if (request.getAttribute("selectedOrder") != null) { 
                            Order selectedOrder = (Order) request.getAttribute("selectedOrder");
                            List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
                        %>
                        <!-- Order Information -->
                        <div class="bg-gray-100 rounded-lg p-4 mb-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Order ID</span>
                                    <span class="font-medium">#<%= selectedOrder.getOrderId() %></span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Order Date</span>
                                    <span class="font-medium"><%= selectedOrder.getOrderDate() %></span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Customer</span>
                                    <span class="font-medium"><%= UserManager.getUserName(selectedOrder.getUserId()) %></span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Status</span>
                                    <span class="inline-flex items-center mt-1">
                                        <% if ("Delivered".equals(selectedOrder.getStatus())) { %>
                                            <span class="px-4 py-1 bg-green-400 text-white rounded-full text-sm font-medium">
                                                Delivered
                                            </span>
                                        <% } else if ("Not Delivered".equals(selectedOrder.getStatus())) { %>
                                            <span class="px-4 py-1 bg-red-400 text-white rounded-full text-sm font-medium">
                                                Not Delivered
                                            </span>
                                        <% } else { %>
                                            <span class="px-4 py-1 bg-blue-400 text-white rounded-full text-sm font-medium">
                                                <%= selectedOrder.getStatus() %>
                                            </span>
                                        <% } %>
                                    </span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Address</span>
                                    <span class="font-medium"><%= selectedOrder.getAddress() %></span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-sm text-gray-600">Mobile</span>
                                    <span class="font-medium"><%= selectedOrder.getMobileNumber() %></span>
                                </div>
                            </div>
                        </div>

                        <!-- Order Items Table -->
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-100">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-900">Item</th>
                                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-900">Quantity</th>
                                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-900">Price</th>
                                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-900">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-gray-50 divide-y divide-gray-200">
                                    <% 
                                    double total = 0;
                                    for (OrderItem item : orderItems) {
                                        Food food = Food.getFoodById(item.getFoodId());
                                        String foodName = food != null ? food.getName() : "Unknown Food";
                                        double subtotal = item.getPrice() * item.getQuantity();
                                        total += subtotal;
                                    %>
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= foodName %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= item.getQuantity() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">RS. <%= String.format("%.2f", item.getPrice()) %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">RS. <%= String.format("%.2f", subtotal) %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                                <tfoot class="bg-gray-100">
                                    <tr>
                                        <td colspan="3" class="px-6 py-4 text-right font-medium text-gray-900">Total:</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">RS. <%= String.format("%.2f", total) %></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <% } %>
                    </div>

                    <!-- Modal Footer -->
                    <div class="flex justify-end space-x-3 p-6 border-t border-gray-200">
                        <button onclick="closeModal()" 
                                class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-800 text-sm font-medium rounded-lg transition-colors">
                            Close
                        </button>
                    </div>
                </div>
            </div>
            
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
                            <a href="addUser.jsp" class="bg-green-400 hover:bg-green-500 text-white px-6 py-2 rounded-lg transition-colors">
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
                                    <th>Phone Number</th>
                                    <th>Order ID</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <% for(Order order : orders) { %>
                            <tr class="border-b">
                                <td class="py-3"><%= UserManager.getUserName(order.getAgentId()) %></td>
                                <td><%= order.getMobileNumber() %></td>
                                <td><%= order.getOrderId() %></td>
                                <td>
                                    <div class="flex gap-2">
                                        <% if ("Delivered".equals(order.getStatus())) { %>
                                            <span class="bg-green-400 text-white px-4 py-1 rounded-full text-sm">
                                                Delivered
                                            </span>
                                        <% } else if ("Not Delivered".equals(order.getStatus())) { %>
                                            <span class="bg-red-400 text-white px-4 py-1 rounded-full text-sm">
                                                <%= order.getStatus() %>
                                            </span>
                                        <% } else { %>
                                            <span class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                                <%= order.getStatus() %>
                                            </span>
                                        <% } %>
                                    </div>
                                </td>
                                <td>
                                    <form action="Admin.jsp" method="get" style="display: inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                        <button type="submit" 
                                                onclick="showModal()"
                                                class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                            View
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function deleteUser(userId) {
            if (confirm("Are you sure you want to delete this user?")) {
                window.location.href = "deleteUser.jsp?userId=" + userId;
            }
        }

        function editUser(userId) {
            window.location.href = "editUser.jsp?userId=" + userId;
        }
        
        function showModal() {
            document.getElementById('orderModal').classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('orderModal').classList.add('hidden');
            document.body.style.overflow = 'auto';
        }

        <% if (request.getAttribute("selectedOrder") != null) { %>
            showModal();
        <% } %>

        document.getElementById('orderModal').addEventListener('click', function(event) {
            if (event.target === this) {
                closeModal();
            }
        });
    </script>
</body>
</html>