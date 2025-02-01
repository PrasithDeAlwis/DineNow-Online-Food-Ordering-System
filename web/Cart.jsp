<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="cart.CartManager"%>

<%
if (request.getMethod().equals("POST")) {
    String foodId = request.getParameter("foodId");
    String action = request.getParameter("action");
    if (foodId != null && action != null) {
        CartManager.updateQuantity(session, foodId, action);
        response.sendRedirect("Cart.jsp");
        return;
    }
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Dine NOW</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <!-- Navigation -->
    <nav class="bg-white shadow-sm fixed w-full z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <!-- Left side: Logo and Links -->
                <div class="flex items-center space-x-8">
                    <a href="index.jsp" class="flex-shrink-0">
                        <img src="resources/images/logo.png" alt="Dine NOW Logo" class="h-20 w-auto mr-0 mt-6">
                    </a>
                    <div class="hidden lg:flex space-x-8">
                        <a href="index.jsp" class="text-gray-600 hover:text-yellow-400">Home</a>
                        <a href="BrowseMenu.jsp" class="text-gray-600 hover:text-yellow-400">Browse Menu</a>
                        <a href="Cart.jsp" class="text-gray-900 hover:text-yellow-400">Cart</a>
                    </div>
                </div>

                <!-- Right side: Login and Signup Buttons -->
                <div class="hidden lg:flex items-center space-x-4">
                    <% if (session.getAttribute("user") != null) { %>
                        <a href="Logout.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                            Logout
                        </a>
                    <% } else { %>
                        <a href="SignIn.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                            Login
                        </a>
                        <a href="SignUp.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                            Signup
                        </a>
                    <% } %>
                </div>
                <!-- Mobile responsive menu toggle -->
                <div class="flex items-center lg:hidden">
                    <button class="text-gray-900 focus:outline-none focus:ring-2 focus:ring-yellow-400" id="menu-toggle">
                        <i class="fas fa-bars text-2xl"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Mobile menu -->
        <div class="lg:hidden" id="mobile-menu" style="display: none;">
            <div class="px-2 pt-2 pb-3 space-y-1">
                <a href="index.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Home</a>
                <a href="BrowseMenu.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Browse Menu</a>
                <a href="Cart.jsp" class="block text-gray-900 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Cart</a>
                <% if (session.getAttribute("user") != null) { %>
                    <a href="Logout.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Logout</a>
                <% } else { %>
                    <a href="SignIn.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Login</a>
                    <a href="SignUp.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Signup</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Main Section -->
    <div class="max-w-7xl mx-auto px-2 sm:px-4 py-24">
        <div class="flex flex-col lg:flex-row gap-4 sm:gap-8">
            <!-- Categories Sidebar -->
            <div class="w-full lg:w-1/4">
                <div class="bg-gray-100 border border-gray-300 border-2 rounded-tl-3xl rounded-tr-lg rounded-br-lg rounded-bl-lg p-4 sm:p-6">
                    <h1 class="text-xl sm:text-2xl lg:text-3xl font-bold mb-4 sm:mb-6">Our Menu</h1>
                    <div class="flex flex-wrap lg:flex-col gap-2 sm:gap-4">
                        <% 
                            String[] categories = {"Burgers", "Fries", "Snacks", "Salads", "Cold drinks", 
                                                    "Happy Meal", "Desserts", "Hot drinks", "Sauces"}; 
                            String activeCategory = request.getParameter("category") == null ? "burgers" : request.getParameter("category");
                        %>
                        <% for(String category : categories) { 
                            String categoryKey = category.toLowerCase().replace(" ", "");
                        %>
                        <a href="BrowseMenu.jsp?category=<%= categoryKey %>" 
                            class="text-xs sm:text-sm lg:text-base inline-block px-2 py-1 sm:px-3 sm:py-1.5 lg:px-4 lg:py-2 rounded-full font-semibold
                            <% if(activeCategory.equals(categoryKey)) { %> 
                                bg-yellow-400 text-black 
                            <% } else { %> 
                                hover:bg-white text-gray-800 
                            <% } %>">
                            <%= category %>
                        </a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Main Content Area -->
            <div class="flex-1">
                <div class="flex flex-col lg:flex-row gap-6 bg-gray-100 rounded-tl-3xl rounded-tr-lg rounded-br-lg rounded-bl-lg shadow-lg border border-gray-300 border-2">
                    <!-- Cart Items Section -->
                    <div class="flex-1">
                        <div class="bg-gray-100 rounded-3xl p-4 sm:p-6 lg:p-8">
                            <h2 class="text-xl sm:text-2xl lg:text-3xl font-bold mb-4 sm:mb-6 lg:mb-8">Order's Summary</h2>
                            
                            <!-- Cart Items -->
                            <div class="space-y-4 sm:space-y-6">
                                <%
                                    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
                                    double total = 0;
                                    if(cart != null && !cart.isEmpty()) {
                                        for(HashMap<String, String> item : cart) {
                                            double price = Double.parseDouble(item.get("price"));
                                            int quantity = Integer.parseInt(item.get("quantity"));
                                            total += price * quantity;
                                %>
                                <div class="bg-white rounded-xl p-3 sm:p-4 shadow-sm border border-gray-100">
                                    <div class="flex justify-between items-center gap-3 sm:gap-4">
                                        <div>
                                            <h3 class="text-base sm:text-lg font-semibold mb-1"><%= item.get("name") %></h3>
                                            <div class="flex items-center gap-4 sm:gap-6">
                                                <p class="text-sm sm:text-base text-gray-900 font-medium">Rs : <%= String.format("%.2f", price) %></p>
                                                <!-- Quantity Controls -->
                                                <div class="flex items-center bg-gray-100 rounded-full px-0.5 sm:px-1 py-0.5 sm:py-1">
                                                    <form action="Cart.jsp" method="POST" class="flex items-center">
                                                        <input type="hidden" name="foodId" value="<%= item.get("foodId") %>">
                                                        <input type="hidden" name="action" value="decrease">
                                                        <button type="submit" 
                                                            class="w-6 h-6 sm:w-8 sm:h-8 rounded-full bg-white shadow-sm flex items-center justify-center text-gray-600 hover:bg-gray-50 transition-colors">
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 sm:w-6 sm:h-6 stroke-gray-200 hover:stroke-gray-300 transition-colors" fill="none" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M4 12h16" />
                                                            </svg>
                                                        </button>
                                                    </form>
                                                    
                                                    <span class="w-8 sm:w-10 text-center text-sm sm:text-base font-medium"><%= item.get("quantity") %></span>

                                                    <form action="Cart.jsp" method="POST" class="flex items-center">
                                                        <input type="hidden" name="foodId" value="<%= item.get("foodId") %>">
                                                        <input type="hidden" name="action" value="increase">
                                                        <button type="submit" 
                                                            class="w-6 h-6 sm:w-8 sm:h-8 rounded-full bg-white shadow-sm flex items-center justify-center text-gray-600 hover:bg-gray-50 transition-colors">
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 sm:w-6 sm:h-6 stroke-gray-200 hover:stroke-gray-300 transition-colors" fill="none" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16M4 12h16" />
                                                            </svg>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <img src="<%= item.get("image") %>" alt="<%= item.get("name") %>" class="w-16 h-16 sm:w-20 sm:h-20 object-cover rounded-xl"/>
                                    </div>
                                </div>
                                <%
                                        }
                                    } else {
                                        out.println("<p class='text-center text-gray-500 text-sm sm:text-base'>Your cart is empty</p>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                            
                    <!-- Divider Line -->
                    <div class="hidden lg:block w-px bg-gray-300 my-8"></div>
                    <div class="block lg:hidden h-px bg-gray-300 mx-6"></div>

                    <!-- Total Section -->
                    <div class="lg:w-80">
                        <div class="bg-gray-100 rounded-3xl p-4 sm:p-6 lg:p-8">
                            <h3 class="text-xl sm:text-2xl lg:text-3xl font-semibold mb-4">Total Price</h3>
                            <div class="flex flex-col gap-3 bg-white rounded-lg p-4 sm:p-6">
                                <% if(cart != null && !cart.isEmpty()) { 
                                    for(HashMap<String, String> item : cart) {
                                        double price = Double.parseDouble(item.get("price"));
                                        int quantity = Integer.parseInt(item.get("quantity"));
                                %>
                                <div class="flex justify-between items-center text-gray-600 text-xs sm:text-sm font-semibold">
                                    <span class="flex items-center gap-1">
                                        <span>Rs <%= String.format("%.2f", price) %></span>
                                        <span class="text-gray-400">×</span>
                                        <span><%= quantity %></span>
                                    </span>
                                    <span><%= String.format("%.2f", price * quantity) %></span>
                                </div>
                                <% } %>
                                <div class="border-t border-gray-200 mt-2 pt-3">
                                    <div class="flex justify-between items-center font-semibold text-base sm:text-lg">
                                        <span>Total</span>
                                        <span>Rs <%= String.format("%.2f", total) %></span>
                                    </div>
                                </div>
                                <% } else { %>
                                    <p class="text-center text-gray-500 text-sm sm:text-base">Rs 0.00</p>
                                <% } %>
                                <div class="mt-3 sm:mt-4 flex justify-center">
                                    <a href="Checkout.jsp" class="w-auto max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg bg-yellow-400 hover:bg-yellow-500 text-black text-sm sm:text-base font-semibold py-2 sm:py-3 px-8 sm:px-12 rounded-full transition-colors">
                                        Checkout
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>