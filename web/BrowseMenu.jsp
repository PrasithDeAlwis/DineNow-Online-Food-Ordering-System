<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartManager"%>
<%@page import="java.util.List"%>
<%@page import="food.Food"%>
<%@page import="food.Category"%>

<%
if (request.getMethod().equals("POST")) {
    String itemName = request.getParameter("itemName");
    String itemPrice = request.getParameter("itemPrice");
    String itemImage = request.getParameter("itemImage");
    String foodId = request.getParameter("foodId");
    
    if (itemName != null && itemPrice != null && itemImage != null && foodId != null) {
        CartManager.addItem(session, itemName, itemPrice, itemImage, foodId);
        response.sendRedirect("BrowseMenu.jsp?category=" + request.getParameter("category"));
        return;
    }
}

// Get all categories from the database
List<Category> categories = Category.getAllCategories();
// Get active category from URL parameter or default to first category
String activeCategory = request.getParameter("category");
if (activeCategory == null && !categories.isEmpty()) {
    activeCategory = categories.get(0).getName().toLowerCase().replace(" ", "");
}

// Get all foods from the database
List<Food> allFoods = Food.getAllFoods();
// Filter foods by active category
List<Food> categoryFoods = new ArrayList<>();
for (Food food : allFoods) {
    Category foodCategory = Category.getCategoryById(food.getCategoryId());
    if (foodCategory != null && 
        foodCategory.getName().toLowerCase().replace(" ", "").equals(activeCategory)) {
        categoryFoods.add(food);
    }
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dine NOW</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media (max-width: 460px) {
            .custom-grid {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
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
                        <a href="BrowseMenu.jsp" class="text-gray-900 hover:text-yellow-400">Browse Menu</a>
                        <a href="Cart.jsp" class="text-gray-600 hover:text-yellow-400">Cart</a>
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
                <a href="BrowseMenu.jsp" class="block text-gray-900 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Browse Menu</a>
                <a href="Cart.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Cart</a>
                <% if (session.getAttribute("user") != null) { %>
                    <a href="Logout.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Logout</a>
                <% } else { %>
                    <a href="SignIn.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Login</a>
                    <a href="SignUp.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Signup</a>
                <% } %>
            </div>
        </div>
    </nav>
    <!-- Cart Icon with Counter -->
    <div class="fixed top-4 right-4 z-50 pt-20">
        <a href="Cart.jsp" class="bg-yellow-400 p-3 rounded-full flex items-center gap-2">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
            <% 
                ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
                int totalQuantity = 0;
                if (cart != null) {
                    for (HashMap<String, String> item : cart) {
                        totalQuantity += Integer.parseInt(item.get("quantity"));
                    }
                }
            %>
            <span class="bg-white px-2 py-1 rounded-full text-sm"><%= totalQuantity %></span>
        </a>
    </div>

    <!-- Menu Section -->
    <div class="max-w-7xl mx-auto px-2 sm:px-4 py-24">
        <div class="flex flex-col lg:flex-row gap-4 sm:gap-8">
            <!-- Categories Sidebar -->
            <div class="w-full lg:w-1/4">
                <div class="bg-gray-100 border border-black rounded-tl-3xl rounded-tr-lg rounded-br-lg rounded-bl-lg p-4 sm:p-6">
                    <h1 class="text-2xl sm:text-3xl font-bold mb-4 sm:mb-6">Our Menu</h1>
                    <div class="flex flex-wrap lg:flex-col gap-2 sm:gap-4">
                        <% for(Category category : categories) { 
                            String categoryKey = category.getName().toLowerCase().replace(" ", "");
                        %>
                        <a href="BrowseMenu.jsp?category=<%= categoryKey %>" 
                            class="text-sm sm:text-base inline-block px-3 py-1.5 sm:px-4 sm:py-2 rounded-full font-semibold
                            <% if(activeCategory.equals(categoryKey)) { %> 
                                bg-yellow-400 text-black 
                            <% } else { %> 
                                hover:bg-white text-gray-800 
                            <% } %>">
                            <%= category.getName() %>
                        </a>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Menu Items Grid -->
            <div class="w-full lg:w-3/4">
                <div class="grid custom-grid grid-cols-2 md:grid-cols-2 sm:grid-cols-2 gap-4 sm:gap-6">
                    <% if (!categoryFoods.isEmpty()) {
                        for (Food food : categoryFoods) { %>
                    <div class="bg-white p-4 sm:p-6 shadow-[0px_8px_20px_rgba(0,0,0,0.15)] rounded-lg">
                        <div class="flex flex-col sm:flex-row justify-between">
                            <div class="flex-1 mb-4 sm:mb-0">
                                <h3 class="text-lg sm:text-xl font-semibold mb-2"><%= food.getName() %></h3>
                                <p class="text-xs sm:text-sm text-gray-600 mb-2 sm:mb-4"><%= food.getDescription() %></p>
                                <p class="text-base sm:text-lg font-semibold">Rs : <%= String.format("%.2f", food.getPrice()) %></p>
                            </div>
                            <div class="relative ml-0 sm:ml-4 flex-shrink-0">
                                <img src="<%= food.getImageUrl() %>" alt="Menu Item" class="w-full h-32 sm:h-32 md:h-32 object-cover sm:w-28 md:w-32"/>
                                <% if (food.isAvailability()) { %>
                                <div class="absolute -bottom-4 sm:-bottom-6 -right-4 sm:-right-6 bg-white bg-opacity-90 rounded-tl-[2rem] rounded-tr-none rounded-bl-none rounded-br-lg p-4 sm:p-6">
                                    <form action="BrowseMenu.jsp" method="POST" class="inline">
                                        <input type="hidden" name="itemName" value="<%= food.getName() %>">
                                        <input type="hidden" name="itemPrice" value="<%= String.format("%.2f", food.getPrice()) %>">
                                        <input type="hidden" name="itemImage" value="<%= food.getImageUrl() %>">
                                        <input type="hidden" name="foodId" value="<%= food.getId() %>">
                                        <input type="hidden" name="category" value="<%= activeCategory %>">
                                        <button type="submit" class="bg-[#0F172A] hover:bg-[#1E293B] rounded-full p-1.5 sm:p-2 shadow-lg">
                                            <svg class="w-4 h-4 sm:w-5 sm:h-5 md:w-6 md:h-6" fill="none" stroke="white" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16M4 12h16" />
                                            </svg>
                                        </button>
                                    </form>
                                </div>
                                <% } else { %>
                                <div class="absolute -bottom-4 sm:-bottom-6 -right-4 sm:-right-6 bg-red-100 bg-opacity-90 rounded-tl-[2rem] rounded-tr-none rounded-bl-none rounded-br-lg p-4 sm:p-6">
                                    <span class="text-red-600 font-semibold">Not Available</span>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } 
                    } else { %>
                        <p class="col-span-2 text-center text-gray-600">No items available for this category.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>