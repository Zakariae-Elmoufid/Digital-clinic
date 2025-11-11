<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Doctor Dashboard - Digital Clinic</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = { darkMode: 'class' }
    function initDarkMode() {
      if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.classList.add('dark');
      }
    }
    function toggleDarkMode() {
      document.documentElement.classList.toggle('dark');
      localStorage.setItem('theme', document.documentElement.classList.contains('dark') ? 'dark' : 'light');
    }
    function toggleSidebar() {
      document.getElementById('sidebar').classList.toggle('-translate-x-full');
      document.getElementById('overlay').classList.toggle('hidden');
    }
    function openModal(id) {
      document.getElementById(id).classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    }
    function closeModal(id) {
      document.getElementById(id).classList.add('hidden');
      document.body.style.overflow = 'auto';
    }
    function updateAppointmentStatus(id, status) {
      fetch('${pageContext.request.contextPath}/doctor/appointments/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: id, status: status })
      }).then(() => location.reload());
    }
    // Real-time clock
    function updateClock() {
      const now = new Date();
      const options = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      };
      document.getElementById('current-time').textContent = now.toLocaleDateString('en-US', options);
    }
    setInterval(updateClock, 1000);
    document.addEventListener('DOMContentLoaded', function() {
      initDarkMode();
      updateClock();
    });
  </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Mobile Overlay -->
<div id="overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden hidden" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<c:set var="currentPage" value="doctor" scope="request" />
<%@ include file="./../component/sidebarDoctor.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64">
  <!-- Header -->
  <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
    <div class="flex items-center justify-between px-4 lg:px-8 py-4">
      <div class="flex items-center">
        <button onclick="toggleSidebar()" class="lg:hidden mr-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
          </svg>
        </button>
        <div>
          <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Good Morning, Dr. Zakariae!</h1>
          <p class="text-sm text-gray-600 dark:text-gray-400">Welcome to your dashboard. Here's what's happening today.</p>
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <!-- Notifications -->
        <button class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 relative">
          <svg class="w-6 h-6 text-gray-600 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
          <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
        </button>
        <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700">
          <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646"/>
          </svg>
          <svg class="w-5 h-5 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3"/>
          </svg>
        </button>
        <span id="current-time" class="text-sm text-gray-600 dark:text-gray-400 hidden sm:block">
                        Monday, October 14, 2025 at 10:43:55 AM
                    </span>
      </div>
    </div>
  </header>

  <main class="p-4 lg:p-8">
    <!-- Quick Stats -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
      <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
        <div class="flex items-center justify-between mb-4">
          <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10"/>
            </svg>
          </div>
          <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Today</span>
        </div>
        <p class="text-4xl font-bold mb-2">${todayAppointments != null ? todayAppointments : 8}</p>
        <p class="text-blue-100 text-sm">Appointments Today</p>
      </div>

      <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
        <div class="flex items-center justify-between mb-4">
          <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197"/>
            </svg>
          </div>
          <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Total</span>
        </div>
        <p class="text-4xl font-bold mb-2">${totalPatients != null ? totalPatients : 245}</p>
        <p class="text-green-100 text-sm">Total Patients</p>
      </div>

      <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
        <div class="flex items-center justify-between mb-4">
          <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
            </svg>
          </div>
          <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Rating</span>
        </div>
        <p class="text-4xl font-bold mb-2">${rating != null ? rating : 4.9}</p>
        <p class="text-purple-100 text-sm">Patient Rating</p>
      </div>

      <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
        <div class="flex items-center justify-between mb-4">
          <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
          </div>
          <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Hours</span>
        </div>
        <p class="text-4xl font-bold mb-2">${weeklyHours != null ? weeklyHours : 45}</p>
        <p class="text-orange-100 text-sm">Hours This Week</p>
      </div>
    </div>

    <!-- Today's Schedule -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
      <!-- Appointments -->
      <div class="lg:col-span-2 bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-xl font-bold text-gray-900 dark:text-white">Today's Appointments</h2>
          <a href="${pageContext.request.contextPath}/doctor/appointments" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 text-sm font-medium">
            View All →
          </a>
        </div>
        <div class="space-y-4">
          <!-- Sample appointments - replace with real data -->
          <div class="flex items-center p-4 bg-blue-50 dark:bg-blue-900/20 rounded-2xl border border-blue-100 dark:border-blue-800">
            <div class="w-12 h-12 bg-blue-600 rounded-xl flex items-center justify-center text-white font-bold">
              AM
            </div>
            <div class="ml-4 flex-1">
              <h4 class="font-semibold text-gray-900 dark:text-white">Ahmed Hassan</h4>
              <p class="text-sm text-gray-600 dark:text-gray-400">Regular Checkup</p>
            </div>
            <div class="text-right">
              <p class="text-sm font-semibold text-blue-600 dark:text-blue-400">9:00 AM</p>
              <span class="px-2 py-1 bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300 rounded text-xs">Confirmed</span>
            </div>
          </div>

          <div class="flex items-center p-4 bg-green-50 dark:bg-green-900/20 rounded-2xl border border-green-100 dark:border-green-800">
            <div class="w-12 h-12 bg-green-600 rounded-xl flex items-center justify-center text-white font-bold">
              SM
            </div>
            <div class="ml-4 flex-1">
              <h4 class="font-semibold text-gray-900 dark:text-white">Sara Mohamed</h4>
              <p class="text-sm text-gray-600 dark:text-gray-400">Heart Consultation</p>
            </div>
            <div class="text-right">
              <p class="text-sm font-semibold text-green-600 dark:text-green-400">11:00 AM</p>
              <span class="px-2 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded text-xs">In Progress</span>
            </div>
          </div>

          <div class="flex items-center p-4 bg-orange-50 dark:bg-orange-900/20 rounded-2xl border border-orange-100 dark:border-orange-800">
            <div class="w-12 h-12 bg-orange-600 rounded-xl flex items-center justify-center text-white font-bold">
              KA
            </div>
            <div class="ml-4 flex-1">
              <h4 class="font-semibold text-gray-900 dark:text-white">Khalid Ali</h4>
              <p class="text-sm text-gray-600 dark:text-gray-400">Follow-up Visit</p>
            </div>
            <div class="text-right">
              <p class="text-sm font-semibold text-orange-600 dark:text-orange-400">2:30 PM</p>
              <span class="px-2 py-1 bg-orange-100 dark:bg-orange-900/50 text-orange-700 dark:text-orange-300 rounded text-xs">Upcoming</span>
            </div>
          </div>

          <div class="flex items-center p-4 bg-purple-50 dark:bg-purple-900/20 rounded-2xl border border-purple-100 dark:border-purple-800">
            <div class="w-12 h-12 bg-purple-600 rounded-xl flex items-center justify-center text-white font-bold">
              NF
            </div>
            <div class="ml-4 flex-1">
              <h4 class="font-semibold text-gray-900 dark:text-white">Nour Fatima</h4>
              <p class="text-sm text-gray-600 dark:text-gray-400">Emergency Consultation</p>
            </div>
            <div class="text-right">
              <p class="text-sm font-semibold text-purple-600 dark:text-purple-400">4:00 PM</p>
              <span class="px-2 py-1 bg-purple-100 dark:bg-purple-900/50 text-purple-700 dark:text-purple-300 rounded text-xs">Urgent</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions & Status -->
      <div class="space-y-6">
        <!-- Quick Actions -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
          <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4">Quick Actions</h3>
          <div class="space-y-3">
            <button onclick="window.location.href='${pageContext.request.contextPath}/doctor/availability'" class="w-full flex items-center p-3 bg-blue-50 dark:bg-blue-900/20 hover:bg-blue-100 dark:hover:bg-blue-900/40 rounded-xl transition">
              <div class="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10"/>
                </svg>
              </div>
              <div class="text-left">
                <p class="font-medium text-gray-900 dark:text-white">Update Schedule</p>
                <p class="text-xs text-gray-500 dark:text-gray-400">Manage availability</p>
              </div>
            </button>

            <button onclick="window.location.href='${pageContext.request.contextPath}/doctor/patients'" class="w-full flex items-center p-3 bg-green-50 dark:bg-green-900/20 hover:bg-green-100 dark:hover:bg-green-900/40 rounded-xl transition">
              <div class="w-10 h-10 bg-green-600 rounded-xl flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197"/>
                </svg>
              </div>
              <div class="text-left">
                <p class="font-medium text-gray-900 dark:text-white">View Patients</p>
                <p class="text-xs text-gray-500 dark:text-gray-400">Patient records</p>
              </div>
            </button>

            <button onclick="window.location.href='${pageContext.request.contextPath}/doctor/reports'" class="w-full flex items-center p-3 bg-purple-50 dark:bg-purple-900/20 hover:bg-purple-100 dark:hover:bg-purple-900/40 rounded-xl transition">
              <div class="w-10 h-10 bg-purple-600 rounded-xl flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10"/>
                </svg>
              </div>
              <div class="text-left">
                <p class="font-medium text-gray-900 dark:text-white">Generate Report</p>
                <p class="text-xs text-gray-500 dark:text-gray-400">Analytics & insights</p>
              </div>
            </button>
          </div>
        </div>

        <!-- Current Status -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
          <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4">Current Status</h3>
          <div class="space-y-4">
            <div>
              <div class="flex justify-between items-center mb-2">
                <span class="text-sm text-gray-600 dark:text-gray-400">Today's Progress</span>
                <span class="text-sm font-semibold text-gray-900 dark:text-white">65%</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                <div class="bg-blue-500 h-2 rounded-full" style="width: 65%"></div>
              </div>
            </div>
            <div>
              <div class="flex justify-between items-center mb-2">
                <span class="text-sm text-gray-600 dark:text-gray-400">Weekly Target</span>
                <span class="text-sm font-semibold text-gray-900 dark:text-white">78%</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                <div class="bg-green-500 h-2 rounded-full" style="width: 78%"></div>
              </div>
            </div>
            <div class="p-3 bg-green-50 dark:bg-green-900/20 rounded-xl">
              <div class="flex items-center">
                <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                <span class="text-sm font-medium text-green-800 dark:text-green-200">Available Now</span>
              </div>
              <p class="text-xs text-green-600 dark:text-green-400 mt-1">Next: 11:00 AM - Sara Mohamed</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Recent Activity & Notifications -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Recent Activity -->
      <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-xl font-bold text-gray-900 dark:text-white">Recent Activity</h2>
          <button class="text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"/>
            </svg>
          </button>
        </div>
        <div class="space-y-4">
          <div class="flex items-start space-x-3">
            <div class="w-2 h-2 bg-blue-500 rounded-full mt-2"></div>
            <div>
              <p class="text-sm font-medium text-gray-900 dark:text-white">Completed appointment with Ahmed Hassan</p>
              <p class="text-xs text-gray-500 dark:text-gray-400">2 hours ago</p>
            </div>
          </div>
          <div class="flex items-start space-x-3">
            <div class="w-2 h-2 bg-green-500 rounded-full mt-2"></div>
            <div>
              <p class="text-sm font-medium text-gray-900 dark:text-white">Updated availability for next week</p>
              <p class="text-xs text-gray-500 dark:text-gray-400">4 hours ago</p>
            </div>
          </div>
          <div class="flex items-start space-x-3">
            <div class="w-2 h-2 bg-purple-500 rounded-full mt-2"></div>
            <div>
              <p class="text-sm font-medium text-gray-900 dark:text-white">New patient record created for Nour Fatima</p>
              <p class="text-xs text-gray-500 dark:text-gray-400">6 hours ago</p>
            </div>
          </div>
          <div class="flex items-start space-x-3">
            <div class="w-2 h-2 bg-orange-500 rounded-full mt-2"></div>
            <div>
              <p class="text-sm font-medium text-gray-900 dark:text-white">Generated monthly report</p>
              <p class="text-xs text-gray-500 dark:text-gray-400">1 day ago</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Notifications -->
      <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-xl font-bold text-gray-900 dark:text-white">Notifications</h2>
          <span class="px-2 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs font-semibold">3 New</span>
        </div>
        <div class="space-y-4">
          <div class="flex items-start space-x-3 p-3 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-xl">
            <div class="flex-shrink-0">
              <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium text-gray-900 dark:text-white">New appointment request</p>
              <p class="text-sm text-gray-600 dark:text-gray-400">Patient: Mariam Ali requesting appointment for tomorrow</p>
              <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">5 minutes ago</p>
            </div>
          </div>

          <div class="flex items-start space-x-3 p-3 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-xl">
            <div class="flex-shrink-0">
              <svg class="w-5 h-5 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"/>
              </svg>
            </div>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium text-gray-900 dark:text-white">Schedule reminder</p>
              <p class="text-sm text-gray-600 dark:text-gray-400">You have 3 appointments scheduled for this afternoon</p>
              <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">30 minutes ago</p>
            </div>
          </div>

          <div class="flex items-start space-x-3 p-3 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-xl">
            <div class="flex-shrink-0">
              <svg class="w-5 h-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium text-gray-900 dark:text-white">Patient feedback received</p>
              <p class="text-sm text-gray-600 dark:text-gray-400">Ahmed Hassan left a 5-star review for your service</p>
              <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">2 hours ago</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>
</body>
</html>