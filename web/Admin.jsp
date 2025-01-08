<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <!-- Main content -->
        <div class="p-8 relative">
            <!-- Header -->
            <div class="flex items-center justify-between mb-8">
                <h1 class="text-2xl font-bold text-yellow-400">Dine NOW</h1>
            </div>

            <div class="flex relative w-full h-screen bg-white">
                <!-- Left section -->
                <div class="w-1/3 pr-8 relative overflow-hidden z-10">
                    <div class="mb-6">
                        <div class="w-32 h-32 bg-yellow-400 rounded-full flex items-center justify-center mx-auto">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                            </svg>
                        </div>
                        <div class="space-y-4 pt-4">
                            <input type="text" placeholder="name" 
                                class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                            <input type="email" placeholder="email" 
                                class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        </div>
                    </div>
                    
                    <!-- Half circle attached to divider -->
                    <div class="absolute right-0 top-1/2 w-64 h-64 bg-yellow-400 rounded-full translate-x-1/2 -translate-y-1/2 -z-10"></div>
                </div>

                <!-- Vertical Divider -->
                <div class="w-px bg-gray-200 absolute right-2/3 top-0 bottom-0"></div>

                <!-- Bottom half circle -->
                <div class="absolute bottom-40 -left-12 w-64 h-64 bg-yellow-400 opacity-70 rounded-full -translate-x-1/2 translate-y-1/2"></div>

                <!-- Right section -->
                <div class="w-2/3 pl-8">
                    <!-- Category section -->
                    <div class="mb-8">
                        <h2 class="text-xl font-bold mb-4">Catogory</h2>
                        <div class="flex items-center justify-between">
                            <select class="w-80 p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                                <option>Customer</option>
                                <option>Agent</option>
                                <option>Admin</option>
                            </select>
                            <button class="bg-green-400 text-white px-6 py-2 rounded-lg">
                                add user
                            </button>
                        </div>
                    </div>

                    <!-- User details section -->
                    <div class="bg-white rounded-lg border shadow-sm p-6 mb-8">
                        <h2 class="text-xl font-bold mb-4">User detils</h2>
                        <table class="w-full border">
                            <thead>
                                <tr class="text-left">
                                    <th>name</th>
                                    <th>email</th>
                                    <th>phone nu</th>
                                    <th>actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(int i = 0; i < 3; i++) { %>
                                <tr class="border-b">
                                    <td class="py-3">uditha dissanayake</td>
                                    <td>uditha@gmail.com</td>
                                    <td>077-9467340</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                                                delete
                                            </button>
                                            <button class="bg-blue-400 text-white px-4 py-1 rounded-full text-sm">
                                                edit
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Agent details section -->
                    <div class="bg-white rounded-lg border shadow-sm p-6">
                        <h2 class="text-xl font-bold mb-4">Agunt detils</h2>
                        <table class="w-full">
                            <thead>
                                <tr class="text-left">
                                    <th>name</th>
                                    <th>phone nu</th>
                                    <th>status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(int i = 0; i < 3; i++) { %>
                                <tr class="border-b">
                                    <td class="py-3">uditha dissanayake</td>
                                    <td>077-9467340</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button class="bg-green-400 text-white px-4 py-1 rounded-full text-sm">
                                                delivery
                                            </button>
                                            <button class="bg-red-500 text-white px-4 py-1 rounded-full text-sm">
                                                not delivery
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>