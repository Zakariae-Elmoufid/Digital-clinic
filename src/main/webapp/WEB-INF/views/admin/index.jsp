<%@ page import="org.example.demo.entity.User" %>
<%@ page import="org.example.demo.dto.LoginDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Digital Clinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
        }

        function initDarkMode() {
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

        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebar-overlay');
            sidebar.classList.toggle('-translate-x-full');
            overlay.classList.toggle('hidden');
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            initDarkMode();
        });
    </script>
</head>

<body class="bg-gray-50 dark:bg-gray-900">
<c:set var="currentPage" value="dashboard" scope="request" />
<%@ include file="./../component/sidebar.jsp" %>


<!-- Main Content -->
<div class="lg:ml-64">
    <!-- Top Bar -->
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40 transition-colors duration-300">
        <div class="flex items-center justify-between px-4 lg:px-8 py-4">
            <div class="flex items-center">
                <!-- Mobile Menu Button -->
                <button onclick="toggleSidebar()" class="lg:hidden mr-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-6 h-6 text-gray-600 dark:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
                <div>
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Dashboard Overview</h1>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Welcome back, Admin! Here's what's happening today.</p>
                </div>
            </div>
            <div class="flex items-center space-x-4">
                <!-- Dark Mode Toggle -->
                <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 transition duration-200" aria-label="Toggle dark mode">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
                    </svg>
                    <svg class="w-5 h-5 text-gray-400 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                </button>

                <!-- Notifications -->
                <button class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 relative transition duration-200">
                    <svg class="w-6 h-6 text-gray-600 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
                    </svg>
                    <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                </button>

                <!-- Date Display -->
                <span class="text-sm text-gray-600 dark:text-gray-400 hidden sm:block">
                        <c:choose>
                            <c:when test="${not empty currentDate}">
                                <fmt:formatDate value="${currentDate}" pattern="EEEE, MMM dd, yyyy"/>
                            </c:when>
                            <c:otherwise>
                                <%= new java.util.Date() %>
                            </c:otherwise>
                        </c:choose>
                    </span>
            </div>
        </div>
    </header>

    <!-- Dashboard Content -->
    <main class="p-4 lg:p-8">
        <!-- Stats Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <!-- Total Users -->
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">+12%</span>
                </div>
                <p class="text-4xl font-bold mb-2">
                    <c:choose>
                        <c:when test="${not empty totalUsers}">${totalUsers}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </p>
                <p class="text-blue-100 text-sm">Total Users</p>
            </div>

            <!-- Total Doctors -->
            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">+5</span>
                </div>
                <p class="text-4xl font-bold mb-2">
                    <c:choose>
                        <c:when test="${not empty totalDoctors}">${totalDoctors}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </p>
                <p class="text-purple-100 text-sm">Active Doctors</p>
            </div>

            <!-- Total Appointments -->
            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Today</span>
                </div>
                <p class="text-4xl font-bold mb-2">
                    <c:choose>
                        <c:when test="${not empty todayAppointments}">${todayAppointments}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </p>
                <p class="text-green-100 text-sm">Appointments Today</p>
            </div>

            <!-- Revenue -->
            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">+18%</span>
                </div>
                <p class="text-4xl font-bold mb-2">
                    <c:choose>
                        <c:when test="${not empty monthlyRevenue}">${monthlyRevenue}</c:when>
                        <c:otherwise>$0</c:otherwise>
                    </c:choose>
                </p>
                <p class="text-orange-100 text-sm">Monthly Revenue</p>
            </div>
        </div>

        <!-- Charts & Tables Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
            <!-- Recent Appointments -->
            <div class="lg:col-span-2 bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 transition-colors duration-300">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold text-gray-900 dark:text-white">Recent Appointments</h2>
                    <a href="${pageContext.request.contextPath}/admin/appointments" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm font-medium transition duration-200">
                        View All →
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                        <tr class="border-b border-gray-200 dark:border-gray-600">
                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Patient</th>
                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Doctor</th>
                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Date</th>
                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Status</th>
                            <th class="text-center py-3 px-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty recentAppointments}">
                                <c:forEach var="appointment" items="${recentAppointments}">
                                    <tr class="border-b border-gray-100 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700 transition duration-200">
                                        <td class="py-4 px-4">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-sm">
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.patient.name}">
                                                            ${appointment.patient.name.substring(0,1).toUpperCase()}
                                                        </c:when>
                                                        <c:otherwise>P</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="ml-3">
                                                    <p class="font-medium text-gray-900 dark:text-white">
                                                        <c:choose>
                                                            <c:when test="${not empty appointment.patient.name}">${appointment.patient.name}</c:when>
                                                            <c:otherwise>Unknown Patient</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p class="text-sm text-gray-500 dark:text-gray-400">
                                                        <c:choose>
                                                            <c:when test="${not empty appointment.patient.email}">${appointment.patient.email}</c:when>
                                                            <c:otherwise>No email</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-4 px-4">
                                            <p class="font-medium text-gray-900 dark:text-white">
                                                <c:choose>
                                                    <c:when test="${not empty appointment.doctor.name}">
                                                        ${appointment.doctor.title} ${appointment.doctor.name}
                                                    </c:when>
                                                    <c:otherwise>Unknown Doctor</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="text-sm text-gray-500 dark:text-gray-400">
                                                <c:choose>
                                                    <c:when test="${not empty appointment.specialty}">${appointment.specialty}</c:when>
                                                    <c:otherwise>General</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </td>
                                        <td class="py-4 px-4">
                                            <p class="text-sm text-gray-900 dark:text-white">
                                                <c:choose>
                                                    <c:when test="${not empty appointment.date}">
                                                        <fmt:formatDate value="${appointment.date}" pattern="MMM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>No date</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="text-sm text-gray-500 dark:text-gray-400">
                                                <c:choose>
                                                    <c:when test="${not empty appointment.time}">
                                                        <fmt:formatDate value="${appointment.time}" pattern="hh:mm a"/>
                                                    </c:when>
                                                    <c:otherwise>No time</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </td>
                                        <td class="py-4 px-4">
                                            <c:choose>
                                                <c:when test="${appointment.status == 'PLANNED'}">
                                                    <span class="px-3 py-1 bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300 rounded-full text-xs font-semibold">Planned</span>
                                                </c:when>
                                                <c:when test="${appointment.status == 'DONE'}">
                                                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs font-semibold">Done</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs font-semibold">Canceled</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-4 text-center">
                                            <button class="text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition duration-200">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"/>
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="py-8 text-center text-gray-500 dark:text-gray-400">
                                        <div class="flex flex-col items-center">
                                            <svg class="w-12 h-12 mb-4 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                            <p>No recent appointments found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="space-y-6">
                <!-- Appointment Status -->
                <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 transition-colors duration-300">
                    <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4">Appointment Status</h3>
                    <div class="space-y-4">
                        <div>
                            <div class="flex justify-between items-center mb-2">
                                <span class="text-sm text-gray-600 dark:text-gray-400">Completed</span>
                                <span class="text-sm font-semibold text-gray-900 dark:text-white">
                                        <c:choose>
                                            <c:when test="${not empty completedPercentage}">${completedPercentage}%</c:when>
                                            <c:otherwise>0%</c:otherwise>
                                        </c:choose>
                                    </span>
                            </div>
                            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                <div class="bg-green-500 h-2 rounded-full" style="width: ${not empty completedPercentage ? completedPercentage : 0}%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between items-center mb-2">
                                <span class="text-sm text-gray-600 dark:text-gray-400">Planned</span>
                                <span class="text-sm font-semibold text-gray-900 dark:text-white">
                                        <c:choose>
                                            <c:when test="${not empty plannedPercentage}">${plannedPercentage}%</c:when>
                                            <c:otherwise>0%</c:otherwise>
                                        </c:choose>
                                    </span>
                            </div>
                            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                <div class="bg-blue-500 h-2 rounded-full" style="width: ${not empty plannedPercentage ? plannedPercentage : 0}%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between items-center mb-2">
                                <span class="text-sm text-gray-600 dark:text-gray-400">Canceled</span>
                                <span class="text-sm font-semibold text-gray-900 dark:text-white">
                                        <c:choose>
                                            <c:when test="${not empty canceledPercentage}">${canceledPercentage}%</c:when>
                                            <c:otherwise>0%</c:otherwise>
                                        </c:choose>
                                    </span>
                            </div>
                            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                <div class="bg-red-500 h-2 rounded-full" style="width: ${not empty canceledPercentage ? canceledPercentage : 0}%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top Specialties -->
                <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 transition-colors duration-300">
                    <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4">Top Specialties</h3>
                    <div class="space-y-3">
                        <c:choose>
                            <c:when test="${not empty topSpecialties}">
                                <c:forEach var="specialty" items="${topSpecialties}">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                                            <span class="text-sm text-gray-700 dark:text-gray-300">${specialty.name}</span>
                                        </div>
                                        <span class="text-sm font-semibold text-gray-900 dark:text-white">${specialty.count}</span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-gray-500 dark:text-gray-400 py-4">
                                    <p class="text-sm">No specialty data available</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- System Activity -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Recent Users -->
            <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 transition-colors duration-300">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold text-gray-900 dark:text-white">Recent Users</h2>
                    <a href="${pageContext.request.contextPath}/admin/users" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm font-medium transition duration-200">
                        View All →
                    </a>
                </div>
                <div class="space-y-4">
                    <c:choose>
                        <c:when test="${not empty recentUsers}">
                            <c:forEach var="user" items="${recentUsers}">
                                <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700 rounded-2xl hover:bg-gray-100 dark:hover:bg-gray-600 transition duration-200">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold">
                                            <c:choose>
                                                <c:when test="${not empty user.name}">
                                                    ${user.name.substring(0,1).toUpperCase()}
                                                </c:when>
                                                <c:otherwise>U</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="ml-4">
                                            <p class="font-semibold text-gray-900 dark:text-white">
                                                <c:choose>
                                                    <c:when test="${not empty user.name}">${user.name}</c:when>
                                                    <c:otherwise>Unknown User</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="text-sm text-gray-500 dark:text-gray-400">
                                                <c:choose>
                                                    <c:when test="${not empty user.email}">${user.email}</c:when>
                                                    <c:otherwise>No email</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                    <span class="px-3 py-1 bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300 rounded-full text-xs font-semibold">
                                            <c:choose>
                                                <c:when test="${not empty user.role}">${user.role}</c:when>
                                                <c:otherwise>USER</c:otherwise>
                                            </c:choose>
                                        </span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-gray-500 dark:text-gray-400 py-8">
                                <div class="flex flex-col items-center">
                                    <svg class="w-12 h-12 mb-4 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                                    </svg>
                                    <p>No recent users found</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- System Alerts -->
            <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 transition-colors duration-300">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold text-gray-900 dark:text-white">System Alerts</h2>
                    <button class="text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                        </svg>
                    </button>
                </div>
                <div class="space-y-4">
                    <c:choose>
                        <c:when test="${not empty systemAlerts}">
                            <c:forEach var="alert" items="${systemAlerts}">
                                <div class="flex items-start space-x-3 p-4 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-2xl">
                                    <div class="flex-shrink-0">
                                        <svg class="w-5 h-5 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"/>
                                        </svg>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900 dark:text-white">${alert.title}</p>
                                        <p class="text-sm text-gray-600 dark:text-gray-400">${alert.message}</p>
                                        <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">
                                            <fmt:formatDate value="${alert.timestamp}" pattern="MMM dd, hh:mm a"/>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-gray-500 dark:text-gray-400 py-8">
                                <div class="flex flex-col items-center">
                                    <svg class="w-12 h-12 mb-4 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    <p>All systems running smoothly</p>
                                    <p class="text-xs mt-1">No alerts to display</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>