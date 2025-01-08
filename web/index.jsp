<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DineNow - Quick Food Delivery</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-white shadow-sm fixed w-full z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <!-- Left side: Logo and Links -->
                <div class="flex items-center space-x-8">
                    <a href="index.jsp" class="flex-shrink-0">
                        <img src="Images/logo.png" alt="Dine NOW Logo" class="h-20 w-auto mr-0 mt-6">
                    </a>
                    <div class="hidden lg:flex space-x-8">
                        <a href="index.jsp" class="text-gray-900 hover:text-yellow-400">Home</a>
                        <a href="BrowseMenu.jsp" class="text-gray-600 hover:text-yellow-400">Browse Menu</a>
                        <a href="Cart.jsp" class="text-gray-600 hover:text-yellow-400">Cart</a>
                    </div>
                </div>

                <!-- Right side: Login and Signup Buttons -->
                <div class="hidden lg:flex items-center space-x-4">

                    <a href="SignIn.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                        Login
                    </a>
                    <a href="SignUp.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                        Signup
                    </a>
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
                <a href="index.jsp" class="block text-gray-900 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Home</a>
                <a href="BrowseMenu.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Browse Menu</a>
                <a href="Cart.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Cart</a>
                <a href="SignIn.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Login</a>
                <a href="SignUp.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Signup</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="pt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="flex flex-col lg:flex-row items-center">
                <div class="lg:w-1/2">
                    <h1 class="text-4xl font-bold text-gray-900">Quick Bites,</h1>
                    <h2 class="text-4xl font-bold text-yellow-400 mt-2">Right to Your Door! 🚀🍔</h2>
                    <div class="mt-8">
                        <div class="flex space-x-4">
                            <div class="flex-grow">
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-map-marker-alt text-gray-400"></i>
                                    </div>
                                    <input type="text" placeholder="Enter your location" 
                                           class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg">
                                </div>
                            </div>
                            <button class="bg-yellow-400 text-white px-8 py-2 rounded-lg hover:bg-yellow-500">
                                Find Food
                            </button>
                        </div>
                    </div>
                </div>
                <div class="lg:w-1/2 mt-8 lg:mt-0">
                    <img src="Images/home.png" alt="Food delivery" class="w-full rounded-lg">
                </div>
            </div>
        </div>
    </div>

    <!-- Popular Categories -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">Popular Categories</h2>
        <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-6">
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Burgers & Fast food.png" alt="Burgers" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Burgers & Fast food</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Salads.png" alt="Salads" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Salads</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Pasta & Casuals.png" alt="Pasta" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Pasta</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Pizza.png" alt="Pizza" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Pizza</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Breakfast.png" alt="Breakfast" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Breakfast</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="Images/Soups.png" alt="Soups" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Soups</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Restaurants -->
    <section class="bg-gray-100 py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-8">Popular Restaurants</h2>
            <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-6">
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/McDonald.png" alt="McDonald's" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">McDonald's</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/PizzaHut.png" alt="Pizza Hut" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Pizza Hut</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/KFC.png" alt="KFC" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">KFC</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/Crepe runner.png" alt="Crepe runner" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Crepe Runner</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/Burger King.png" alt="Burger King" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Burger King</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="Images/Domino's.png" alt="Domino's Pizza" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Domino's Pizza</p>
                </div>
            </div>
    </section>

    <!-- How It Works -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">How DineNow Works</h2>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
            <div class="text-center p-6 bg-white rounded-xl shadow-sm">
                <i class="fas fa-search text-yellow-400 text-4xl mb-4"></i>
                <h3 class="text-lg font-bold">Browse Menus</h3>
                <p class="text-gray-600 mt-2">Explore your favorite meals from top restaurants.</p>
        </div>
            <div class="text-center p-6 bg-white rounded-xl shadow-sm">
                <i class="fas fa-utensils text-yellow-400 text-4xl mb-4"></i>
                <h3 class="text-lg font-bold">Choose Dishes</h3>
                <p class="text-gray-600 mt-2">Pick your favorite meals and order them online.</p>
            </div>
            <div class="text-center p-6 bg-white rounded-xl shadow-sm">
                <i class="fas fa-truck text-yellow-400 text-4xl mb-4"></i>
                <h3 class="text-lg font-bold">Fast Delivery</h3>
                <p class="text-gray-600 mt-2">Get your food delivered fresh and hot to your door.</p>
            </div>
        </div>
    </section>
    <!-- Footer -->
    <footer class="bg-gray-50 border-t">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-4 gap-8">
                <div>
                    <span class="text-yellow-400 text-xl font-bold">Dine NOW</span>
                    <p class="mt-4 text-sm text-gray-600">
                        <b>Uva Wellassa University of Sri Lanka</b><br>
                        <a href="#" class="hover:text-yellow-400">Contact Us</a> | 
                        <a href="#" class="hover:text-yellow-400">Privacy Policy</a>
                    </p>

                    <div class="mt-4 flex space-x-4 items-center">
                        <img src="Images/AppStore.png" alt="App Store" class="h-8 w-auto">
                        <img src="Images/Playstore.png" alt="Play Store" class="h-8 w-auto">
                    </div>

                </div>
                <div>
                    <h3 class="font-semibold mb-4">Legal</h3>
                    <ul class="space-y-2 text-sm text-gray-600">
                        <li><a href="#" class="hover:text-yellow-400">Terms and Conditions</a></li>
                        <li><a href="#" class="hover:text-yellow-400">Privacy Policy</a></li>
                        <li><a href="#" class="hover:text-yellow-400">Cookie Policy</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="font-semibold mb-4">Partner With Us</h3>
                    <ul class="space-y-2 text-sm text-gray-600">
                        <li><a href="#" class="hover:text-yellow-400">Add your restaurant</a></li>
                        <li><a href="#" class="hover:text-yellow-400">Sign up to deliver</a></li>
                        <li><a href="#" class="hover:text-yellow-400">Create business account</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="font-semibold mb-4">Follow Us</h3>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-yellow-400">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-yellow-400">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-yellow-400">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-yellow-400">
                            <i class="fab fa-snapchat"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="mt-8 pt-8 border-t text-center text-sm text-gray-600">
                <p>&copy; 2024 DineNow. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Toggle mobile menu
        document.getElementById('menu-toggle').addEventListener('click', function () {
            const menu = document.getElementById('mobile-menu');
            if (menu.style.display === 'none') {
                menu.style.display = 'block';
            } else {
                menu.style.display = 'none';
            }
        });
    </script>
</body>
</html>
