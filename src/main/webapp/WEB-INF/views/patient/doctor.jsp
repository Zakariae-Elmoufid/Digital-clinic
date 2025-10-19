<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dr. ${doctor.user.fullName} - Profile | Digital Clinic</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f7f9fb;
      padding: 2rem;
    }
    .calendar-container {
      max-width: 400px;
      margin: 0 auto;
      background: white;
      padding: 2rem;
      border-radius: 1rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      margin-bottom: 1.5rem;
    }
  </style>
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

    function selectSlot(slotId, day, date, startTime, endTime) {
      const timeRange = `${startTime} - ${endTime}`;
      document.getElementById('selected-slot-display').innerHTML = `
                <div class="text-sm text-gray-600 dark:text-gray-400 mb-1">${day} | ${date}</div>
                <div class="text-lg font-bold text-blue-600 dark:text-blue-400">${timeRange}</div>
            `;
      document.getElementById('selected-slot-id').value = slotId;
      document.getElementById('book-button').disabled = false;

      // Highlight selected slot
      document.querySelectorAll('.time-slot').forEach(slot => {
        slot.classList.remove('ring-2', 'ring-blue-500', 'bg-blue-100', 'dark:bg-blue-900/50', 'shadow-lg');
      });
      event.target.closest('.time-slot').classList.add('ring-2', 'ring-blue-500', 'bg-blue-100', 'dark:bg-blue-900/50', 'shadow-lg');
    }

    function bookAppointment() {
      const reason = document.getElementById('visit-reason').value;
      if (!reason.trim()) {
        alert('Please enter reason for visit');
        return;
      }
      document.getElementById('appointment-form').submit();
    }

    document.addEventListener('DOMContentLoaded', initDarkMode);

  </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Navigation Header -->
<nav class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
  <div class="max-w-7xl mx-auto px-4 lg:px-8 py-4 flex items-center justify-between">
    <div class="flex items-center">
      <a href="${pageContext.request.contextPath}/patient/dashboard" class="flex items-center text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white">
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
        <span class="text-sm">Back to Doctors</span>
      </a>
    </div>
    <div class="flex items-center space-x-4">
      <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700">
        <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646"/>
        </svg>
        <svg class="w-5 h-5 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3"/>
        </svg>
      </button>
      <span class="text-sm text-gray-600 dark:text-gray-400 hidden sm:block">2025-10-18 20:36:07</span>
    </div>
  </div>
</nav>
<%
  String successMessage = (String) session.getAttribute("success");
  if (successMessage != null) {
%>
<div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px;">
  <%= successMessage %>
</div>
<%
    session.removeAttribute("success"); // pour ne pas le réafficher après refresh
  }
%>

<main class="max-w-7xl mx-auto px-4 lg:px-8 py-8">
  <!-- Doctor Profile Header -->
  <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-8 mb-8">
    <div class="flex flex-col md:flex-row items-start md:items-center space-y-6 md:space-y-0 md:space-x-8">
      <!-- Doctor Avatar -->
      <div class="flex-shrink-0">
        <div class="w-40 h-40 bg-gradient-to-br from-blue-500 to-purple-600 rounded-3xl flex items-center justify-center text-white shadow-lg">
                        <span class="text-6xl font-bold">
                          ${fn:substring(doctor.user.fullName, 0, 1)}
                        </span>
        </div>
      </div>

      <!-- Doctor Information -->
      <div class="flex-1">
        <div class="flex items-start justify-between mb-3">
          <div>
            <h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-1">
              Dr. ${doctor.user.fullName}
            </h1>
            <c:if test="${not empty doctor.specialite.name}">
              <p class="text-xl text-blue-600 dark:text-blue-400 font-semibold">
                  ${doctor.specialite.name}
              </p>
            </c:if>
            <c:if test="${not empty doctor.specialite.department.name}">
              <p class="text-lg text-gray-600 dark:text-gray-400">
                  ${doctor.specialite.department.name}
              </p>
            </c:if>
          </div>
          <div class="flex items-center bg-yellow-50 dark:bg-yellow-900/20 px-4 py-2 rounded-2xl">
            <svg class="w-6 h-6 text-yellow-400 fill-current" viewBox="0 0 20 20">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
            </svg>
            <span class="ml-2 text-lg font-bold text-gray-900 dark:text-white">4.8</span>
            <span class="ml-2 text-sm text-gray-600 dark:text-gray-400">(238 reviews)</span>
          </div>
        </div>

        <!-- Key Info -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
          <div class="flex items-center text-gray-700 dark:text-gray-300">
            <div class="w-10 h-10 bg-blue-100 dark:bg-blue-900/50 rounded-full flex items-center justify-center mr-3">
              <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <p class="text-xs text-gray-600 dark:text-gray-400">Experience</p>
              <p class="font-semibold">15+ years</p>
            </div>
          </div>
          <div class="flex items-center text-gray-700 dark:text-gray-300">
            <div class="w-10 h-10 bg-green-100 dark:bg-green-900/50 rounded-full flex items-center justify-center mr-3">
              <svg class="w-5 h-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0"/>
              </svg>
            </div>
            <div>
              <p class="text-xs text-gray-600 dark:text-gray-400">Patients</p>
              <p class="font-semibold">3,200+</p>
            </div>
          </div>
          <div class="flex items-center text-gray-700 dark:text-gray-300">
            <div class="w-10 h-10 bg-purple-100 dark:bg-purple-900/50 rounded-full flex items-center justify-center mr-3">
              <svg class="w-5 h-5 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <p class="text-xs text-gray-600 dark:text-gray-400">Verified</p>
              <p class="font-semibold">100%</p>
            </div>
          </div>
          <div class="flex items-center text-gray-700 dark:text-gray-300">
            <div class="w-10 h-10 bg-orange-100 dark:bg-orange-900/50 rounded-full flex items-center justify-center mr-3">
              <svg class="w-5 h-5 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
              </svg>
            </div>
            <div>
              <p class="text-xs text-gray-600 dark:text-gray-400">Consultation</p>
              <p class="font-semibold">$150</p>
            </div>
          </div>
        </div>

        <!-- Status Badge -->
        <div class="flex items-center space-x-3">
                        <span class="inline-block px-4 py-2 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-sm font-semibold">
                            ✓ Available Today
                        </span>
        </div>
      </div>
    </div>
  </div>

  <!-- Main Content Grid -->
  <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8 px-8 py-10">

    <!-- 🧾 Booking Form -->
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-8 h-fit sticky top-24">
      <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-6">Book Appointment</h3>

      <form id="appointment-form" action="${pageContext.request.contextPath}/patient/appointments" method="post" class="space-y-4">
        <input type="hidden" name="doctorId" value="${doctor.id}">


        <!-- Selected Day -->
        <div class="calendar-container">
          <input id="calendar" type="text" id="selected-date" name="date" placeholder="Select an available day"
                 class="w-full px-4 py-3 rounded-xl border border-gray-300 dark:border-gray-600 focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                 readonly="readonly">

          <c:if test="${empty availableDays}">
            <p class="text-center text-gray-500 mt-4">No available days for this doctor</p>
          </c:if>
        </div>

        <button type="submit" id="book-button"
                class="w-full px-6 py-3 bg-blue-600 text-white rounded-xl hover:bg-blue-700 disabled:bg-gray-300 dark:disabled:bg-gray-600 transition font-semibold shadow-md hover:shadow-lg">
          Confirm Booking
        </button>
      </form>

      <div class="mt-4 p-3 bg-yellow-50 dark:bg-yellow-900/20 rounded-lg border border-yellow-200 dark:border-yellow-800">
        <p class="text-xs text-yellow-800 dark:text-yellow-200 text-center">
          💡 Free cancellation up to 24 hours before appointment
        </p>
      </div>
    </div>
  </div>
  <!-- Doctor About & Details -->
  <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
    <!-- About Doctor -->
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-8">
      <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">About</h3>
      <p class="text-gray-700 dark:text-gray-300 mb-4">
        Dr. ${doctor.user.fullName} is a highly experienced and compassionate healthcare professional
        with a passion for delivering exceptional patient care. With over 15 years of clinical experience,
        they have established themselves as a trusted expert in their field.
      </p>
      <p class="text-gray-700 dark:text-gray-300">
        Known for their thorough approach and excellent bedside manner, they take time to understand
        each patient's unique needs and concerns, ensuring personalized treatment plans and the best possible outcomes.
      </p>
    </div>

    <!-- Qualifications & Languages -->
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-8">
      <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">Qualifications</h3>
      <div class="space-y-4">
        <div>
          <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Medical Degree</p>
          <p class="font-semibold text-gray-900 dark:text-white">M.D. - Harvard Medical School</p>
        </div>
        <div>
          <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Specialization</p>
          <c:if test="${not empty doctor.specialite.name}">
            <p class="font-semibold text-gray-900 dark:text-white">${doctor.specialite.name}</p>
          </c:if>
        </div>
        <div>
          <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Languages</p>
          <p class="font-semibold text-gray-900 dark:text-white">English, Spanish, French, Arabic</p>
        </div>
        <div>
          <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Certifications</p>
          <p class="font-semibold text-gray-900 dark:text-white">Board Certified Specialist</p>
        </div>
      </div>
    </div>
  </div>
</main>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Récupération des dates disponibles depuis ton backend Java
    const availableDays = [
      <c:forEach var="day" items="${availableDays}" varStatus="status">
      "${day}"<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];

    flatpickr("#calendar", {
      dateFormat: "Y-m-d",
      enable: availableDays,
      altInput: true,
      altFormat: "l, d F Y",
      minDate: "today",
      locale: {
        firstDayOfWeek: 1
      },
      onChange: function(selectedDates, dateStr, instance) {
        // Set the value of the hidden input when a date is chosen
        document.getElementById("selected-date").value = dateStr;
        console.log("Selected date:", dateStr);
      }
    });
  });
</script>
</body>
</html>