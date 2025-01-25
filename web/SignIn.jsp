<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - DineNow</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <nav class="bg-white shadow-sm fixed w-full z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center space-x-8">
                    <a href="index.jsp" class="flex-shrink-0">
                        <img src="resources/images/logo.png" alt="Dine NOW Logo" class="h-20 w-auto mr-0 mt-6">
                    </a>
                    <div class="hidden lg:flex space-x-8">
                        <a href="index.jsp" class="text-gray-600 hover:text-yellow-400">Home</a>
                        <a href="BrowseMenu.jsp" class="text-gray-600 hover:text-yellow-400">Browse Menu</a>
                        <a href="Cart.jsp" class="text-gray-600 hover:text-yellow-400">Cart</a>
                    </div>
                </div>
                <div class="hidden lg:flex items-center space-x-4">
                    <a href="SignUp.jsp" class="bg-yellow-400 text-white px-6 py-2 rounded-full hover:bg-yellow-500">
                        Signup
                    </a>
                </div>
                <div class="flex items-center lg:hidden">
                    <button class="text-gray-900 focus:outline-none focus:ring-2 focus:ring-yellow-400" id="menu-toggle">
                        <i class="fas fa-bars text-2xl"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="lg:hidden" id="mobile-menu" style="display: none;">
            <div class="px-2 pt-2 pb-3 space-y-1">
                <a href="index.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Home</a>
                <a href="BrowseMenu.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Browse Menu</a>
                <a href="Cart.jsp" class="block text-gray-600 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-400">Cart</a>
                <a href="SignUp.jsp" class="block text-white bg-yellow-400 px-3 py-2 rounded-md text-base font-medium hover:bg-yellow-500">Signup</a>
            </div>
        </div>
    </nav>

    <div class="min-h-screen flex flex-col pt-16">
        <main class="flex-grow flex items-center justify-center px-4 sm:px-6 lg:px-8">
            <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm relative overflow-hidden">
                <div class="absolute left-0 bottom-0 w-32 h-32 bg-yellow-400 rounded-full -ml-16 -mb-16"></div>
                <div class="absolute right-0 top-0 w-32 h-32 bg-yellow-400 rounded-full -mr-16 -mt-16"></div>
                
                <div class="relative">
                    <h2 class="mt-6 text-center text-3xl font-bold text-gray-900">
                        Sign In
                    </h2>

                    <form class="mt-8 space-y-6" action="processSignIn.jsp" method="POST">
                        <div class="space-y-4">
                            <div>
                                <label for="email" class="sr-only">Email</label>
                                <input id="email" name="email" type="email" 
                                       class="appearance-none rounded-lg relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 focus:z-10 sm:text-sm"
                                       placeholder="Enter email">
                            </div>
                            
                            <div>
                                <label for="password" class="sr-only">Password</label>
                                <input id="password" name="password" type="password" required
                                       class="appearance-none rounded-lg relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 focus:z-10 sm:text-sm"
                                       placeholder="Enter password">
                            </div>
                        </div>

                        <div>
                            <button type="submit" 
                                    class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-black hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500">
                                Continue
                            </button>
                        </div>

                        <div class="text-center">
                            <p class="text-sm text-gray-600">
                                Don't have an account? 
                                <a href="SignUp.jsp" class="font-medium text-yellow-400 hover:text-yellow-500">
                                    Sign up
                                </a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <footer class="bg-gray-50 border-t mt-auto">
            <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
                <p class="text-center text-sm text-gray-500">
                    &copy; 2024 DineNow. All rights reserved.
                </p>
            </div>
        </footer>
    </div>

    <script>
        const mobileMenuButton = document.querySelector('[aria-controls="mobile-menu"]');
        const mobileMenu = document.getElementById('mobile-menu');

        mobileMenuButton.addEventListener('click', () => {
            const expanded = mobileMenuButton.getAttribute('aria-expanded') === 'true';
            mobileMenuButton.setAttribute('aria-expanded', !expanded);
            mobileMenu.classList.toggle('hidden');
        });
    </script>
</body>
</html>
