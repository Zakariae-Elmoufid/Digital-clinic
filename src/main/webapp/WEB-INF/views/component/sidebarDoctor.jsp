<div id="sidebar" class="fixed inset-y-0 left-0 w-64 bg-gradient-to-b from-gray-900 to-gray-800 text-white transform -translate-x-full lg:translate-x-0 transition-transform z-50">
  <div class="flex flex-col h-full">
    <!-- Logo -->
    <div class="flex items-center justify-between p-6 border-b border-gray-700">
      <div class="flex items-center">
        <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl flex items-center justify-center">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
        </div>
        <span class="ml-3 text-lg font-bold">Doctor Panel</span>
      </div>
      <button onclick="toggleSidebar()" class="lg:hidden p-2 rounded-lg hover:bg-gray-700">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 px-4 py-6 space-y-2">
      <a href="${pageContext.request.contextPath}/doctor" class="flex ${currentPage == 'doctor' ? 'bg-gray-700' : 'text-gray-300 hover:bg-gray-700'} items-center px-4 py-3  rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3"/>
        </svg>
        Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/doctor/availability" class="flex items-center px-4 py-3  ${currentPage == 'availability' ? 'bg-gray-700' : 'text-gray-300 hover:bg-gray-700'} rounded-xl">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
        </svg>
        Availability
      </a>
      <a href="${pageContext.request.contextPath}/doctor/appointments" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857"/>
        </svg>
        Appointments
      </a>
      <a href="${pageContext.request.contextPath}/doctor/patients" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197"/>
        </svg>
        Patients
      </a>
      <a href="${pageContext.request.contextPath}/doctor/profile" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 rounded-xl transition">
        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
        </svg>
        Profile
      </a>
    </nav>

    <!-- User Profile -->
    <div class="p-4 border-t border-gray-700">
      <div class="flex items-center">
        <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold">
          Z
        </div>
        <div class="ml-3 flex-1">
          <p class="text-sm font-semibold">Dr. ${sessionScope.user.fullName}</p>
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
