<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="sidebar" class="fixed inset-y-0 left-0 w-64 bg-gradient-to-b from-gray-900 to-gray-800 text-white transform -translate-x-full lg:translate-x-0 transition-transform z-50">
  <div class="flex flex-col h-full">
    <!-- Logo -->
    <div class="flex items-center justify-between p-6 border-b border-gray-700">
      <div class="flex items-center">
        <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl flex items-center justify-center">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
          </svg>
        </div>
        <span class="ml-3 text-lg font-bold">Patient Portal</span>
      </div>
      <button onclick="toggleSidebar()" class="lg:hidden p-2 rounded-lg hover:bg-gray-700">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 px-4 py-6 space-y-2">
      <a href="${pageContext.request.contextPath}/patient" class="${currentPage == 'patient' ? 'bg-gray-700' : 'text-gray-300 hover:bg-gray-700'}  flex items-center px-4 py-3 bg-gray-700 rounded-xl">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3"/>
        </svg>
        Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/patient/appointments" class="${currentPage == 'appointments' ? 'bg-gray-700' : 'text-gray-300 hover:bg-gray-700'} flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
        </svg>
        My Appointments
      </a>
      <a href="${pageContext.request.contextPath}/patient/medical-records" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
        </svg>
        Medical Records
      </a>
      <a href="${pageContext.request.contextPath}/patient/prescriptions" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
        </svg>
        Prescriptions
      </a>
      <a href="${pageContext.request.contextPath}/patient/profile" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
        </svg>
        My Profile
      </a>
    </nav>

    <!-- User Profile -->
    <div class="p-4 border-t border-gray-700">
      <div class="flex items-center">
        <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold">
          Z
        </div>
        <div class="ml-3 flex-1">
          <p class="text-sm font-semibold">${sessionScope.user.fullName}</p>
          <p class="text-xs text-gray-400">Patient ID: #${sessionScope.user.id}</p>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="text-gray-400 hover:text-white p-2" title="Logout">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7"/>
          </svg>
        </a>
      </div>
    </div>
  </div>
</div>
