<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dine NOW</title>
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
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="font-poppins bg-white overflow-x-hidden">
    <!-- Background Elements -->
    <div class="fixed top-[-20%] right-[-10%] w-[600px] h-[600px] bg-brand-yellow rounded-full z-0"></div>
    <div class="fixed bottom-[-10%] left-[-10%] w-[500px] h-[500px] bg-brand-yellow rounded-full z-0"></div>
    
    <!-- Main Container -->
    <div class="relative min-h-screen w-full max-w-[1440px] mx-auto px-8 pb-6">
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
                    
                    <!-- Details Box -->
                    <div class="bg-white rounded-[16px] border border-gray-200 p-6 mb-6">
                        <div class="space-y-4">
                            <div class="flex justify-between text-gray-600">
                                <span>Price Rs :</span>
                                <span class="text-gray-800">2200</span>
                            </div>
                            <div class="flex justify-between text-gray-600">
                                <span>Address :</span>
                                <span class="text-gray-800">No 84,danthure,kandy</span>
                            </div>
                            <div class="flex justify-between text-gray-600">
                                <span>Payment Method:</span>
                                <span class="text-gray-800">Cash on Delivery</span>
                            </div>
                            <div class="flex justify-between text-gray-600">
                                <span>Phone No:</span>
                                <span class="text-gray-800">077-5525347</span>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4">
                        <button class="flex-1 bg-delivery-green hover:bg-green-500 text-white py-2.5 px-4 rounded-lg transition-all font-medium">
                            Delivery
                        </button>
                        <button class="flex-1 bg-cancel-red hover:bg-red-500 text-white py-2.5 px-4 rounded-lg transition-all font-medium">
                            Not Delivery
                        </button>
                    </div>
                </div>

                <!-- Logout Button -->
                <div class="flex justify-center mt-8">
                    <button class="bg-cancel-red hover:bg-red-500 text-white px-10 py-2.5 rounded-lg transition-all font-medium">
                        Logout
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>