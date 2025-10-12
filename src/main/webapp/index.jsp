<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Clinic - Modern Healthcare Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        // Dark mode configuration for Tailwind CSS
        tailwind.config = {
            darkMode: 'class',
        }

        // Dark mode toggle functionality
        function initDarkMode() {
            // Check for saved theme preference or default to 'light' mode
            const theme = localStorage.getItem('theme') || 'light';
            if (theme === 'dark') {
                document.documentElement.classList.add('dark');
            }
        }

        function toggleDarkMode() {
            const html = document.documentElement;
            const isDark = html.classList.contains('dark');

            if (isDark) {
                html.classList.remove('dark');
                localStorage.setItem('theme', 'light');
            } else {
                html.classList.add('dark');
                localStorage.setItem('theme', 'dark');
            }
        }

        // Initialize dark mode before page loads
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-white dark:bg-gray-900 transition-colors duration-300">
<!-- Navigation -->
<nav class="fixed w-full bg-white/90 dark:bg-gray-900/90 backdrop-blur-md z-50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20">
            <div class="flex items-center">
                <div class="flex-shrink-0 flex items-center">
                    <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-purple-600 rounded-2xl flex items-center justify-center shadow-lg">
                        <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <span class="ml-3 text-2xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
                            Digital Clinic
                        </span>
                </div>
            </div>
            <div class="hidden md:flex items-center space-x-8">
                <a href="#home" class="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 font-medium transition duration-200">Home</a>
                <a href="#features" class="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 font-medium transition duration-200">Features</a>
                <a href="#services" class="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 font-medium transition duration-200">Services</a>
                <a href="#about" class="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 font-medium transition duration-200">About</a>

                <!-- Dark Mode Toggle Button -->
                <button onclick="toggleDarkMode()" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition duration-200" aria-label="Toggle dark mode">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
                    </svg>
                    <svg class="w-5 h-5 text-gray-400 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                </button>

                <a href="${pageContext.request.contextPath}/login"
                   class="px-5 py-2 text-blue-600 dark:text-blue-400 font-semibold border-2 border-blue-600 dark:border-blue-400 rounded-xl hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 dark:hover:text-gray-900 transition duration-200">
                    Sign In
                </a>
                <a href="${pageContext.request.contextPath}/register"
                   class="px-5 py-2 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-semibold rounded-xl hover:shadow-lg transform hover:scale-105 transition duration-200">
                    Get Started
                </a>
            </div>
            <div class="md:hidden flex items-center space-x-2">
                <!-- Mobile Dark Mode Toggle -->
                <button onclick="toggleDarkMode()" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition duration-200" aria-label="Toggle dark mode">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
                    </svg>
                    <svg class="w-5 h-5 text-gray-400 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                </button>
                <button class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-400">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="pt-32 pb-20 px-4 bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-900 dark:to-gray-800 transition-colors duration-300">
    <div class="max-w-7xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div class="space-y-8">
                <div class="inline-block">
                        <span class="px-4 py-2 bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300 rounded-full text-sm font-semibold">
                            ✨ Modern Healthcare Solution
                        </span>
                </div>
                <h1 class="text-5xl lg:text-6xl font-bold text-gray-900 dark:text-white leading-tight">
                    Your Health,
                    <span class="bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
                            Simplified
                        </span>
                </h1>
                <p class="text-xl text-gray-600 dark:text-gray-300 leading-relaxed">
                    Experience seamless healthcare management with our digital clinic platform. Book appointments, connect with specialists, and manage your medical records—all in one place.
                </p>
                <div class="flex flex-col sm:flex-row gap-4">
                    <a href="${pageContext.request.contextPath}/register"
                       class="px-8 py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-semibold rounded-2xl hover:shadow-2xl transform hover:scale-105 transition duration-200 text-center">
                        Book Appointment
                    </a>
                    <a href="#features"
                       class="px-8 py-4 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 font-semibold rounded-2xl border-2 border-gray-200 dark:border-gray-700 hover:border-blue-600 dark:hover:border-blue-400 hover:text-blue-600 dark:hover:text-blue-400 transition duration-200 text-center">
                        Learn More
                    </a>
                </div>
                <div class="flex items-center space-x-8 pt-4">
                    <div>
                        <p class="text-3xl font-bold text-gray-900 dark:text-white">500+</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Patients</p>
                    </div>
                    <div>
                        <p class="text-3xl font-bold text-gray-900 dark:text-white">50+</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Doctors</p>
                    </div>
                    <div>
                        <p class="text-3xl font-bold text-gray-900 dark:text-white">15+</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Specialties</p>
                    </div>
                </div>
            </div>
            <div class="relative">
                <div class="relative z-10">
                    <img src="https://www.iepmrc.edu.pe/wp-content/uploads/2016/09/doctor-one-450x450-1.jpg"
                         alt="Healthcare"
                         class="rounded-3xl shadow-2xl">
                </div>
                <div class="absolute -top-6 -right-6 w-72 h-72 bg-gradient-to-br from-blue-400 to-purple-400 rounded-3xl opacity-20 blur-3xl"></div>
                <div class="absolute -bottom-6 -left-6 w-72 h-72 bg-gradient-to-br from-purple-400 to-pink-400 rounded-3xl opacity-20 blur-3xl"></div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="py-20 px-4 bg-white dark:bg-gray-900 transition-colors duration-300">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-900 dark:text-white mb-4">Why Choose Digital Clinic?</h2>
            <p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
                Advanced features designed to make healthcare management effortless and efficient.
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-blue-500/10 transition duration-300">
                <div class="w-14 h-14 bg-blue-600 dark:bg-blue-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Easy Scheduling</h3>
                <p class="text-gray-600 dark:text-gray-300">Book appointments instantly with real-time availability checking and automatic reminders.</p>
            </div>

            <!-- Feature 2 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-900/20 dark:to-purple-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-purple-500/10 transition duration-300">
                <div class="w-14 h-14 bg-purple-600 dark:bg-purple-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Medical Records</h3>
                <p class="text-gray-600 dark:text-gray-300">Access your complete medical history securely from anywhere, anytime.</p>
            </div>

            <!-- Feature 3 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-green-50 to-green-100 dark:from-green-900/20 dark:to-green-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-green-500/10 transition duration-300">
                <div class="w-14 h-14 bg-green-600 dark:bg-green-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Find Specialists</h3>
                <p class="text-gray-600 dark:text-gray-300">Search and connect with qualified doctors across multiple specialties.</p>
            </div>

            <!-- Feature 4 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-orange-50 to-orange-100 dark:from-orange-900/20 dark:to-orange-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-orange-500/10 transition duration-300">
                <div class="w-14 h-14 bg-orange-600 dark:bg-orange-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">24/7 Availability</h3>
                <p class="text-gray-600 dark:text-gray-300">Manage your health on your schedule with round-the-clock system access.</p>
            </div>

            <!-- Feature 5 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-pink-50 to-pink-100 dark:from-pink-900/20 dark:to-pink-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-pink-500/10 transition duration-300">
                <div class="w-14 h-14 bg-pink-600 dark:bg-pink-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Secure & Private</h3>
                <p class="text-gray-600 dark:text-gray-300">Your data is protected with enterprise-grade security and encryption.</p>
            </div>

            <!-- Feature 6 -->
            <div class="group p-8 rounded-3xl bg-gradient-to-br from-indigo-50 to-indigo-100 dark:from-indigo-900/20 dark:to-indigo-800/20 hover:shadow-xl dark:hover:shadow-2xl dark:hover:shadow-indigo-500/10 transition duration-300">
                <div class="w-14 h-14 bg-indigo-600 dark:bg-indigo-500 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition duration-300">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Smart Reminders</h3>
                <p class="text-gray-600 dark:text-gray-300">Never miss an appointment with automated email and SMS notifications.</p>
            </div>
        </div>
    </div>
</section>

<!-- Services Section -->
<section id="services" class="py-20 px-4 bg-gradient-to-br from-gray-50 to-blue-50 dark:from-gray-800 dark:to-blue-900/20 transition-colors duration-300">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-900 dark:text-white mb-4">Our Specialties</h2>
            <p class="text-xl text-gray-600 dark:text-gray-300">Comprehensive healthcare services across multiple departments</p>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
            <div class="p-6 bg-white dark:bg-gray-800 rounded-2xl shadow-sm hover:shadow-lg dark:hover:shadow-2xl dark:hover:shadow-blue-500/10 transition duration-300 text-center">
                <div class="w-16 h-16 bg-blue-100 dark:bg-blue-900/50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                    </svg>
                </div>
                <h4 class="font-semibold text-gray-900 dark:text-white">Cardiology</h4>
            </div>

            <div class="p-6 bg-white dark:bg-gray-800 rounded-2xl shadow-sm hover:shadow-lg dark:hover:shadow-2xl dark:hover:shadow-purple-500/10 transition duration-300 text-center">
                <div class="w-16 h-16 bg-purple-100 dark:bg-purple-900/50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                    </svg>
                </div>
                <h4 class="font-semibold text-gray-900 dark:text-white">Neurology</h4>
            </div>

            <div class="p-6 bg-white dark:bg-gray-800 rounded-2xl shadow-sm hover:shadow-lg dark:hover:shadow-2xl dark:hover:shadow-green-500/10 transition duration-300 text-center">
                <div class="w-16 h-16 bg-green-100 dark:bg-green-900/50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5"/>
                    </svg>
                </div>
                <h4 class="font-semibold text-gray-900 dark:text-white">Orthopedics</h4>
            </div>

            <div class="p-6 bg-white dark:bg-gray-800 rounded-2xl shadow-sm hover:shadow-lg dark:hover:shadow-2xl dark:hover:shadow-orange-500/10 transition duration-300 text-center">
                <div class="w-16 h-16 bg-orange-100 dark:bg-orange-900/50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                    </svg>
                </div>
                <h4 class="font-semibold text-gray-900 dark:text-white">Ophthalmology</h4>
            </div>

            <div class="p-6 bg-white dark:bg-gray-800 rounded-2xl shadow-sm hover:shadow-lg dark:hover:shadow-2xl dark:hover:shadow-pink-500/10 transition duration-300 text-center">
                <div class="w-16 h-16 bg-pink-100 dark:bg-pink-900/50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-pink-600 dark:text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                </div>
                <h4 class="font-semibold text-gray-900 dark:text-white">Pediatrics</h4>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-20 px-4 bg-gradient-to-r from-blue-600 to-purple-600 dark:from-blue-700 dark:to-purple-700">
    <div class="max-w-4xl mx-auto text-center">
        <h2 class="text-4xl font-bold text-white mb-6">Ready to Transform Your Healthcare Experience?</h2>
        <p class="text-xl text-blue-100 dark:text-blue-200 mb-8">Join thousands of patients who trust Digital Clinic for their healthcare needs.</p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="${pageContext.request.contextPath}/register"
               class="px-8 py-4 bg-white text-blue-600 font-semibold rounded-2xl hover:shadow-2xl transform hover:scale-105 transition duration-200">
                Get Started Free
            </a>
            <a href="${pageContext.request.contextPath}/login"
               class="px-8 py-4 bg-transparent text-white font-semibold rounded-2xl border-2 border-white hover:bg-white hover:text-blue-600 transition duration-200">
                Sign In
            </a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 dark:bg-gray-950 text-gray-300 dark:text-gray-400 py-12 px-4 transition-colors duration-300">
    <div class="max-w-7xl mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
            <div>
                <div class="flex items-center mb-4">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <span class="ml-3 text-xl font-bold text-white">Digital Clinic</span>
                </div>
                <p class="text-sm">Modern healthcare management for everyone.</p>
            </div>
            <div>
                <h4 class="font-semibold text-white mb-4">Quick Links</h4>
                <ul class="space-y-2 text-sm">
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">About Us</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">Services</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">Doctors</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">Contact</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-semibold text-white mb-4">For Patients</h4>
                <ul class="space-y-2 text-sm">
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">Book Appointment</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">Find Doctor</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">My Records</a></li>
                    <li><a href="#" class="hover:text-white dark:hover:text-gray-200 transition duration-200">FAQ</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-semibold text-white mb-4">Contact</h4>
                <ul class="space-y-2 text-sm">
                    <li>Email: info@digitalclinic.com</li>
                    <li>Phone: +212 123 456 789</li>
                    <li>Address: Marrakesh, Morocco</li>
                </ul>
            </div>
        </div>
        <div class="border-t border-gray-800 dark:border-gray-700 pt-8 text-center text-sm">
            <p>&copy; 2025 Digital Clinic. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    initDarkMode();
</script>
</body>
</html>