<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String totalPrice = "0";
    if (request.getMethod().equals("POST")) {
        totalPrice = request.getParameter("totalPrice");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Dine NOW</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="">    
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
                <a href="index.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Home</a>
                <a href="BrowseMenu.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Browse Menu</a>
                <a href="Cart.jsp" class="block text-gray-900 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Cart</a>
                <a href="SignIn.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Login</a>
                <a href="SignUp.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Signup</a>
            </div>
        </div>
    </nav>
    <div class="pt-16">
        <main class="bg-gray-100 py-8 relative overflow-hidden">
            <div class="absolute -left-48 bottom-0 w-[400px] h-[400px] bg-yellow-400 rounded-full opacity-80 z-10 hidden lg:block"></div>
            <div class="absolute -right-48 -top-0 w-[400px] h-[400px] bg-yellow-400 rounded-full opacity-80 z-10 hidden lg:block"></div>
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 lg:grid-cols-2 gap-8 items-center z-20">
                <!-- Left Side - Text and Image -->
                <div class="space-y-4">
                    <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-navy-900">
                        Ready to complete your order?
                        <span class="block text-yellow-500">Just a step away!</span>
                    </h1>
                    <div class="relative hidden lg:block">
                        <img src="resources/images/PizzaSlice.png" alt="Pizza" class="relative z-10 w-[450px] h-auto">
                    </div>
                </div>

                <!-- Checkout Form -->
                <div class="bg-white rounded-3xl shadow-lg p-6 z-20">
                    <h3 class="text-3xl font-semibold mb-6">Checkout</h3>

                    <form action="#" method="POST" class="space-y-6">
                        <!-- Order Confirmation -->
                        <div class="space-y-2">
                            <div class="flex items-center gap-2">
                                <svg class="w-6 h-6 text-yellow-400 fill-yellow-400" viewBox="0 0 24 24">
                                    <path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
                                </svg>                                
                                <label class="">Order Confirmation</label>
                            </div>
                            <div class="pl-8 pr-6">
                                <input type="text" 
                                       value="Rs : <%= totalPrice %>" 
                                       readonly 
                                       class="w-full border-b-2 font-semibold border-gray-200 py-1 focus:outline-none focus:border-yellow-400"
                                />
                            </div>
                        </div>

                        <!-- Delivery Address -->
                        <div class="space-y-2">
                            <div class="flex items-center gap-2">
                                <svg class="w-6 h-6 text-yellow-400 fill-yellow-400" viewBox="0 0 24 24">
                                    <path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
                                </svg>
                                <label class="font-base">Delivery Address</label>
                            </div>
                            <div class="pl-8 pr-6">
                                <input type="text" 
                                       class="w-full border-b-2 border-gray-200 py-1 focus:outline-none focus:border-yellow-400"
                                       placeholder="Enter Delivery Address"
                                />
                            </div>
                        </div>
                        
                        <!-- Phone Number -->
                        <div class="space-y-2">
                            <div class="flex items-center gap-2">
                                <svg class="w-6 h-6 text-yellow-400 fill-yellow-400" viewBox="0 0 24 24">
                                    <path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
                                </svg>
                                <label class="">Phone Number</label>
                            </div>
                            <div class="pl-8 pr-6">
                            <input type="tel" 
                                   class="w-full border-b-2 border-gray-200 py-1 focus:outline-none focus:border-yellow-400"
                                   placeholder="Enter Phone Number"
                            />
                            </div>
                        </div>

                        <!-- Payment Options -->
                        <div class="space-y-2 pb-4">
                            <div class="flex items-center gap-2">
                                <!-- Larger Bookmark Icon -->
                                <svg class="w-6 h-6 text-yellow-400 fill-yellow-400" viewBox="0 0 24 24">
                                    <path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
                                </svg>
                                <label class="text-gray-700">Payment Option</label>
                            </div>
                            <div class="flex gap-6">
                                <label class="flex items-center gap-2 pl-8">
                                    <input type="radio" 
                                           name="payment" 
                                           value="cash" 
                                           checked 
                                           class="w-4 h-4 appearance-none border-2 border-yellow-400 rounded-full checked:bg-yellow-400 checked:border-yellow-400 focus:outline-none"
                                    />
                                    <span>Cash on Delivery</span>
                                </label>
                                <label class="flex items-center gap-2 pt-2">
                                    <input type="radio" 
                                           name="payment" 
                                           value="card" 
                                           class="w-4 h-4 appearance-none border-2 border-yellow-400 rounded-full checked:bg-yellow-400 checked:border-yellow-400 focus:outline-none"
                                    />
                                    <span>Card Payment</span>
                                </label>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="flex justify-center">
                            <button type="submit" 
                                    class="bg-yellow-400 text-gray-900 py-3 px-8 rounded-lg font-semibold hover:bg-yellow-500 transition duration-300">
                                GIVE ME MY FOODS
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>