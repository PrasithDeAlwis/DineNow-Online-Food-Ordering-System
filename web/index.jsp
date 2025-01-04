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
                <div class="flex items-center">
                    <a href="index.jsp" class="flex-shrink-0">
                        <span class="text-yellow-400 text-2xl font-bold">Dine NOW</span>
                    </a>
                </div>
                <div class="flex items-center space-x-8">
                    <a href="index.jsp" class="text-gray-900 hover:text-yellow-400">Home</a>
                    <a href="BrowseMenu.jsp" class="text-gray-600 hover:text-yellow-400">Browse Menu</a>
                    <a href="Restaurants.jsp" class="text-gray-600 hover:text-yellow-400">Restaurants</a>
                    <a href="SignIn.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                        Login/Signup
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="pt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="flex items-center">
                <div class="w-1/2">
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
                <div class="w-1/2">
                    <img src="assets/hero-image.jpg" alt="Food delivery" class="w-full rounded-lg">
                </div>
            </div>
        </div>
    </div>

    <!-- Popular Categories -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">Popular Categories</h2>
        <div class="grid grid-cols-6 gap-6">
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/burger.jpg" alt="Burgers" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Burgers & Fast food</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/salads.jpg" alt="Salads" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Salads</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/pasta.jpg" alt="Pasta" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Pasta</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/pizza.jpg" alt="Pizza" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Pizza</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/breakfast.jpg" alt="Breakfast" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Breakfast</p>
                </div>
            </div>
            <div class="group cursor-pointer">
                <div class="bg-white p-4 rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <img src="assets/categories/soups.jpg" alt="Soups" class="w-full h-32 object-cover rounded-lg">
                    <p class="mt-4 text-center font-medium">Soups</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Restaurants -->
    <section class="bg-gray-100 py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-8">Popular Restaurants</h2>
            <div class="grid grid-cols-6 gap-6">
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/mcdonalds.png" alt="McDonald's" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">McDonald's London</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/pizzahut.png" alt="Pizza Hut" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Pizza Hut</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/kfc.png" alt="KFC" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">KFC West London</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/burgerking.png" alt="Burger King" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Burger King</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/dominos.png" alt="Domino's" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Domino's</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm hover:shadow-md transition-all">
                    <img src="assets/restaurants/subway.png" alt="Subway" class="w-full h-24 object-contain">
                    <p class="mt-4 text-center font-medium">Subway</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">How It Works</h2>
        <div class="grid grid-cols-3 gap-8">
            <div class="text-center">
                <div class="bg-yellow-100 w-20 h-20 rounded-full mx-auto flex items-center justify-center mb-4">
                    <i class="fas fa-map-marker-alt text-yellow-400 text-2xl"></i>
                </div>
                <h3 class="font-semibold mb-2">Set Your Location</h3>
                <p class="text-gray-600">Choose your delivery location</p>
            </div>
            <div class="text-center">
                <div class="bg-yellow-100 w-20 h-20 rounded-full mx-auto flex items-center justify-center mb-4">
                    <i class="fas fa-utensils text-yellow-400 text-2xl"></i>
                </div>
                <h3 class="font-semibold mb-2">Choose Your Meal</h3>
                <p class="text-gray-600">Browse restaurants and select your food</p>
            </div>
            <div class="text-center">
                <div class="bg-yellow-100 w-20 h-20 rounded-full mx-auto flex items-center justify-center mb-4">
                    <i class="fas fa-motorcycle text-yellow-400 text-2xl"></i>
                </div>
                <h3 class="font-semibold mb-2">Fast Delivery</h3>
                <p class="text-gray-600">Food is prepared & delivered to you</p>
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
                        Company # 450139-445<br>
                        Registered with House of companies
                    </p>
                    <div class="mt-4">
                        <img src="assets/app-store.png" alt="App Store" class="h-10 inline-block mr-2">
                        <img src="assets/play-store.png" alt="Play Store" class="h-10 inline-block">
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
</body>
</html>

