<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cart.UserManager" %>
<%
    // Check if the user is logged in and has the role "agent"
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (user == null || !"admin".equals(role)) {
        // Redirect to the login page if the user is not logged in or not an agent
        response.sendRedirect("SignIn.jsp?error=2"); // Optional: Add an error code for unauthorized access
        return; // Stop further execution of the page
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
            
        <!-- Header -->
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
                                <input type="text" value="Prasith De Alwis" readonly class="w-full p-2 font-semibold rounded-lg bg-gray-50 border focus:outline-none focus:border-yellow-400"/>
                            </div>
                            <div class="pl-8 flex items-center pt-4">                              
                                <label class="">Email</label>
                            </div>                            
                            <div class="pl-8 pr-6">
                                <input type="text" value="prasith@admin.com" readonly class="w-full p-2 font-semibold rounded-lg bg-gray-50 border focus:outline-none focus:border-yellow-400"/>
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
                            <select class="w-80 p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                                <option>Customer</option>
                                <option>Agent</option>
                                <option>Admin</option>
                            </select>
                            <button class="bg-green-400 text-white px-6 py-2 rounded-lg">
                                Add User
                            </button>
                        </div>
                    </div>

                    <!-- User details section -->
                    <div class="bg-white rounded-lg border shadow-sm p-6 mb-8">
                        <h2 class="text-xl font-bold mb-4">User Details</h2>
                        <table class="w-full">
                            <thead class="border-b">
                                <tr class="text-left">
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <td class="py-3">Uditha Dissanayake</td>
                                    <td>uditha@gmail.com</td>
                                    <td>077-9467340</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                                                Delete
                                            </button>
                                            <button class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                                Edit
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="border-b">
                                    <td class="py-3">Geethaka Kalhara</td>
                                    <td>geethaka@gmail.com</td>
                                    <td>077-3312789</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                                                Delete
                                            </button>
                                            <button class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                                Edit
                                            </button>
                                        </div>
                                    </td>
                                </tr>                                
                            </tbody>
                        </table>
                    </div>

                    <!-- Agent details section -->
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
                            <tbody>
                                <tr class="border-b">
                                    <td class="py-3">Uditha Dissanayake</td>
                                    <td>077-9467340</td>
                                    <td>ORD_25</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-green-400 text-white px-4 py-1 rounded-full text-sm">
                                                Delivered
                                            </button>
                                            <button class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                                                Not Delivered
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <button class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                            View
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>