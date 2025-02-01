<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Check if user is logged in as agent
    String user = (String) session.getAttribute("user");
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (user == null || !"agent".equals(role)) {
        response.sendRedirect("SignIn.jsp?error=2");
        return;
    }

    // Handle status update
    String statusParam = request.getParameter("status");
    String orderIdParam = request.getParameter("orderId");
    boolean showSuccessMessage = false;
    if (statusParam != null && orderIdParam != null) {
        try {
            int orderId = Integer.parseInt(orderIdParam);
            boolean success = Order.updateOrderStatus(orderId, statusParam);
            if (success) {
                showSuccessMessage = true;
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch "Not Delivered" orders for the agent
    int agentId = userId;
    List<Order> orders = null;
    try {
        orders = Order.getOrdersByAgentAndStatus(agentId, "In Progress");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dine NOW - Agent Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        'poppins': ['Poppins', 'sans-serif']
                    },
                    colors: {
                        'brand-yellow': '#FFD700',
                        'delivery-green': '#22c55e',
                        'cancel-red': '#ef4444'
                    },
                }
            }
        }

        // Function to hide the success message after 3 seconds
        function hideSuccessMessage() {
            setTimeout(() => {
                const successMessage = document.getElementById('success-message');
                if (successMessage) {
                    successMessage.style.display = 'none';
                }
            }, 3000); // 3 seconds
        }

        // Call the function when the page loads
        window.onload = hideSuccessMessage;
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="font-poppins bg-white overflow-x-hidden">
    <!-- Background Elements -->
    <div class="fixed top-[-20%] right-[-10%] w-[600px] h-[600px] bg-brand-yellow rounded-full z-0"></div>
    <div class="fixed bottom-[-10%] left-[-10%] w-[500px] h-[500px] bg-brand-yellow rounded-full z-0"></div>
    
    <!-- Main Container -->
    <div class="relative min-h-screen w-full max-w-[1440px] mx-auto px-8 pb-6">
        <!-- Success Message -->
        <% if (showSuccessMessage) { %>
            <div id="success-message" class="fixed top-4 right-4 bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-2 z-50">
                <span>✔</span>
                <span>Order status updated successfully!</span>
            </div>
        <% } %>

        <!-- Logo Section -->
        <div class="">
            <a href="index.jsp" class="flex-shrink-0">
                <img src="resources/images/logo.png" alt="Dine NOW Logo" class="h-20 w-auto">
            </a>
        </div>

        <!-- Main Content Grid -->
        <div class="grid grid-cols-2 gap-12">
            <!-- Left Column -->
            <div class="pt-12">
                <div class="space-y-2">
                    <h2 class="text-[42px] font-bold text-gray-900 leading-tight">Delivering Smiles,</h2>
                    <p class="text-[42px] font-bold text-brand-yellow leading-tight">One meal at a time!</p>
                </div>
                <div class="relative">
                    <img src="resources/images/deliveryman.png" alt="Delivery Person" 
                         class="max-w-[480px] relative z-10">
                </div>
            </div>

            <!-- Right Column - Order Details -->
            <div class="pt-12">
                <div class="bg-white rounded-[24px] shadow-lg p-8 max-w-[450px]">
                    <h3 class="text-xl font-semibold mb-6">Order Details</h3>
                    
                    <% if (orders != null && !orders.isEmpty()) { %>
                        <% for (Order order : orders) { %>
                            <div class="bg-white rounded-[16px] border border-gray-200 p-6 mb-6">
                                <div class="space-y-4">
                                    <div class="flex justify-between text-gray-600">
                                        <span>Price Rs :</span>
                                        <span class="text-gray-800"><%= order.getTotalAmount() %></span>
                                    </div>
                                    <div class="flex justify-between text-gray-600">
                                        <span>Address :</span>
                                        <span class="text-gray-800"><%= order.getAddress() %></span>
                                    </div>
                                    <div class="flex justify-between text-gray-600">
                                        <span>Payment Method:</span>
                                        <span class="text-gray-800">Cash on Delivery</span>
                                    </div>
                                    <div class="flex justify-between text-gray-600">
                                        <span>Phone No:</span>
                                        <span class="text-gray-800"><%= order.getMobileNumber() %></span>
                                    </div>
                                </div>
                                <!-- Action Buttons -->
                                <form method="post" class="flex gap-4 mt-4">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <button type="submit" name="status" value="Delivered" 
                                        class="flex-1 bg-delivery-green hover:bg-green-500 text-white py-2.5 px-4 rounded-lg transition-all font-medium">
                                        Delivered
                                    </button>
                                    <button type="submit" name="status" value="Not Delivered"
                                        class="flex-1 bg-cancel-red hover:bg-red-500 text-white py-2.5 px-4 rounded-lg transition-all font-medium">
                                        Not Delivered
                                    </button>
                                </form>
                            </div>
                        <% } %>
                    <% } else { %>
                        <p class="text-gray-600 text-center py-4">No orders assigned</p>
                    <% } %>
                </div>

                <!-- Logout Button -->
                <div class="flex justify-center mt-8">
                    <a href="Logout.jsp" class="bg-cancel-red hover:bg-red-500 text-white px-10 py-2.5 rounded-lg transition-all font-medium">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>