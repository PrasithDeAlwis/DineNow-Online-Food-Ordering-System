<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartManager"%>

<%
if (request.getMethod().equals("POST")) {
    String itemName = request.getParameter("itemName");
    String itemPrice = request.getParameter("itemPrice");
    String itemImage = request.getParameter("itemImage");
    if (itemName != null && itemPrice != null && itemImage != null) {
        CartManager.addItem(session, itemName, itemPrice, itemImage);
        // Redirect to prevent form resubmission
        response.sendRedirect("BrowseMenu.jsp?category=" + request.getParameter("category"));
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
                <div class="flex items-center">
                    <a href="index.jsp" class="flex-shrink-0">
                        <span class="text-yellow-400 text-2xl font-bold">Dine NOW</span>
                    </a>
                </div>
                <div class="flex items-center space-x-8">
                    <a href="index.jsp" class="text-gray-600 hover:text-yellow-400">Home</a>
                    <a href="BrowseMenu.jsp" class="text-gray-900 hover:text-yellow-400">Browse Menu</a>
                    <a href="Restaurants.jsp" class="text-gray-600 hover:text-yellow-400">Restaurants</a>
                    <a href="Cart.jsp" class="text-gray-600 hover:text-yellow-400">Cart</a>
                    <a href="SignIn.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                        Login/Signup
                    </a>
                </div>
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
                        <% 
                            String[] categories = {"Burgers", "Fries", "Snacks", "Salads", "Cold drinks", 
                                                    "Happy Meal", "Desserts", "Hot drinks", "Sauces"}; 
                            String activeCategory = request.getParameter("category") == null ? "burgers" : request.getParameter("category");
                        %>
                        <% for(String category : categories) { 
                            String categoryKey = category.toLowerCase().replace(" ", "");
                        %>
                        <a href="BrowseMenu.jsp?category=<%= categoryKey %>" 
                            class="text-sm sm:text-base inline-block px-3 py-1.5 sm:px-4 sm:py-2 rounded-full font-semibold
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
            <!-- Menu Items Grid -->
            <div class="w-full lg:w-3/4">
                <div class="grid custom-grid grid-cols-2 md:grid-cols-2 sm:grid-cols-2 gap-4 sm:gap-6">
                    <%
                        Map<String, String[][]> menuItemsMap = new HashMap<>();
                        menuItemsMap.put("burgers", new String[][]{
                            {"Royal Cheese Burger with extra Fries", "1350", "images/burger-image.jpg", "A delicious burger with extra crispy fries."},
                            {"Big Mac Combo", "1500", "images/burger-image.jpg", "A classic Big Mac with fries and a drink."},
                            {"Big Mac Combo", "1500", "images/burger-image.jpg", "Big Mac with extra cheese and fries."},
                            {"Cheese Burger", "1200", "images/burger-image.jpg", "A classic cheese burger with your choice of toppings."},
                            {"Chicken Royale", "1450", "images/burger-image.jpg", "A spicy chicken royale with extra mayo and fries."},
                            {"Veggie Burger", "1000", "images/burger-image.jpg", "A fresh veggie patty with lettuce, tomato, and sauce."}
                        });
                        menuItemsMap.put("fries", new String[][]{
                            {"Double Fries", "800", "fries-image.jpg", "Double the fries, double the fun!"},
                            {"Fries Combo", "600", "fries-image.jpg", "Crispy fries served with your choice of dipping sauce."},
                            {"Cheese Fries", "900", "fries-image.jpg", "Fries topped with melted cheese and savory seasonings."},
                            {"Spicy Fries", "700", "fries-image.jpg", "Hot and spicy fries with a zesty flavor."},
                            {"Garlic Fries", "750", "fries-image.jpg", "Crispy fries with a garlic butter seasoning."}
                        });
                        menuItemsMap.put("salads", new String[][]{
                            {"Caesar Salad", "900", "salad-image.jpg", "A classic Caesar salad with creamy dressing."},
                            {"Greek Salad", "850", "salad-image.jpg", "A fresh Greek salad with olives, feta, and tomatoes."},
                            {"Chicken Caesar Salad", "1050", "salad-image.jpg", "Caesar salad with grilled chicken and crunchy croutons."},
                            {"Mixed Salad", "800", "salad-image.jpg", "A healthy mix of fresh vegetables with a light vinaigrette."},
                            {"Fruit Salad", "650", "salad-image.jpg", "A refreshing mix of seasonal fruits."},
                            {"Avocado Salad", "950", "salad-image.jpg", "A creamy avocado salad with a tangy dressing."}
                        });

                        String[][] selectedCategoryItems = menuItemsMap.get(activeCategory);

                        if (selectedCategoryItems != null) {
                            for (String[] item : selectedCategoryItems) {
                    %>
                    <div class="bg-white p-4 sm:p-6 shadow-[0px_8px_20px_rgba(0,0,0,0.15)] rounded-lg">
                        <div class="flex flex-col sm:flex-row justify-between">
                            <div class="flex-1 mb-4 sm:mb-0">
                                <h3 class="text-lg sm:text-xl font-semibold mb-2"><%= item[0] %></h3>
                                <p class="text-xs sm:text-sm text-gray-600 mb-2 sm:mb-4"><%= item[3] %></p>
                                <p class="text-base sm:text-lg font-semibold">Rs : <%= item[1] %></p>
                            </div>
                            <div class="relative ml-0 sm:ml-4 flex-shrink-0">
                                <img src="<%= item[2] %>" alt="Menu Item" class="w-full h-32 sm:h-32 md:h-36 object-cover sm:w-28 md:w-32"/>
                                <div class="absolute -bottom-4 sm:-bottom-6 -right-4 sm:-right-6 bg-white bg-opacity-90 rounded-tl-[2rem] rounded-tr-none rounded-bl-none rounded-br-lg p-4 sm:p-6">
                                    <form action="BrowseMenu.jsp" method="POST" class="inline">
                                        <input type="hidden" name="itemName" value="<%= item[0] %>">
                                        <input type="hidden" name="itemPrice" value="<%= item[1] %>">
                                        <input type="hidden" name="itemImage" value="<%= item[2] %>">
                                        <input type="hidden" name="category" value="<%= activeCategory %>"> <!-- New hidden input -->
                                        <button type="submit" class="bg-[#0F172A] hover:bg-[#1E293B] rounded-full p-1.5 sm:p-2 shadow-lg">
                                            <svg class="w-4 h-4 sm:w-5 sm:h-5 md:w-6 md:h-6" fill="none" stroke="white" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16M4 12h16" />
                                            </svg>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% 
                            }
                        } else {
                            out.print("<p>No items available for this category.</p>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>