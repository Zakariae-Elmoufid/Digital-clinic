<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - Digital Clinic</title>
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

        // Search and filter doctors
        function searchDoctors() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const specialty = document.getElementById('specialty-filter').value.toLowerCase();
            const cards = document.querySelectorAll('.doctor-card');

            cards.forEach(card => {
                const name = card.querySelector('.doctor-name').textContent.toLowerCase();
                const doctorSpecialty = card.querySelector('.doctor-specialty').textContent.toLowerCase();

                const matchesSearch = name.includes(searchTerm);
                const matchesSpecialty = specialty === 'all' || doctorSpecialty.includes(specialty);

                if (matchesSearch && matchesSpecialty ) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            });
        }



        function bookAppointment(doctorId, doctorName) {
            document.getElementById('book-doctor-id').value = doctorId;
            document.getElementById('book-doctor-name').textContent = doctorName;
            openModal('book-modal');
        }

        function viewDoctorProfile(doctorId) {
            window.location.href = '${pageContext.request.contextPath}/patient/doctors/' + doctorId;
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
<c:set var="currentPage" value="patient" scope="request" />
<%@ include file="./../component/sidebarPatient.jsp" %>
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
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Welcome, Zakariae!</h1>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Find the best doctors for your health needs</p>
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
                        Thursday, October 16, 2025 at 02:54:23 PM
                    </span>
            </div>
        </div>
    </header>

    <main class="p-4 lg:p-8">
        <!-- Quick Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Next</span>
                </div>
                <p class="text-4xl font-bold mb-2">3</p>
                <p class="text-blue-100 text-sm">Upcoming Appointments</p>
            </div>

            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Total</span>
                </div>
                <p class="text-4xl font-bold mb-2">${fn:length(doctors)}</p>
                <p class="text-green-100 text-sm">Available Doctors</p>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Files</span>
                </div>
                <p class="text-4xl font-bold mb-2">12</p>
                <p class="text-purple-100 text-sm">Medical Records</p>
            </div>

            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white shadow-lg hover:shadow-xl transition">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Active</span>
                </div>
                <p class="text-4xl font-bold mb-2">5</p>
                <p class="text-orange-100 text-sm">Prescriptions</p>
            </div>
        </div>

        <!-- Search Section -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-8">
            <h2 class="text-xl font-bold text-gray-900 dark:text-white mb-6">Find Your Doctor</h2>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <!-- Search Input -->
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Search by Name</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        <input type="text" id="search-input" placeholder="Search doctor by name..."
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                               oninput="searchDoctors()">
                    </div>
                </div>

                <!-- Specialty Filter -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Specialty</label>
                    <select id="specialty-filter" class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white" onchange="searchDoctors()">
                        <option value="all">All Specialties</option>
                        <c:forEach var="specialty" items="${specialties}">
                            <option value="${specialty.name}">${specialty.name}</option>
                        </c:forEach>
                    </select>
                </div>


            </div>

            <!-- Results Count -->
            <div class="mt-4 flex items-center justify-between">
                <p id="result-count" class="text-sm text-gray-600 dark:text-gray-400"></p>
                <button onclick="document.getElementById('search-input').value=''; document.getElementById('specialty-filter').value='all';  searchDoctors();"
                        class="text-sm text-blue-600 dark:text-blue-400 hover:text-blue-700">
                    Clear Filters
                </button>
            </div>
        </div>

        <!-- Doctors Grid -->
        <div class="mb-6">
            <h2 class="text-xl font-bold text-gray-900 dark:text-white mb-4">Available Doctors</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                <!-- Sample Doctor Cards - Replace with real data -->
                <c:forEach var="doctor" items="${doctors}">
                    <div class="doctor-card bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 hover:shadow-lg transition">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-2xl flex items-center justify-center text-white font-bold text-xl">
                                <c:choose>
                                    <c:when test="${not empty doctor.name}">
                                        ${fn:substring(doctor.name,0,1)}
                                    </c:when>
                                    <c:otherwise>Dr</c:otherwise>
                                </c:choose>
                            </div>
<%--                            <div class="flex items-center">--%>
<%--                                <svg class="w-5 h-5 text-yellow-400 mr-1" fill="currentColor" viewBox="0 0 20 20">--%>
<%--                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>--%>
<%--                                </svg>--%>
<%--                                <span class="text-sm font-semibold text-gray-900 dark:text-white">${doctor.rating != null ? doctor.rating : 4.8}</span>--%>
<%--                            </div>--%>
                        </div>

                        <h3 class="doctor-name text-lg font-bold text-gray-900 dark:text-white mb-2">Dr. ${doctor.name}</h3>
                        <p class="doctor-specialty text-sm text-blue-600 dark:text-blue-400 font-medium mb-1">
                            <c:choose>
                                <c:when test="${not empty doctor.specialite}">
                                    ${doctor.specialite}
                                </c:when>
                                <c:otherwise>General Practitioner</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="doctor-department text-sm text-gray-600 dark:text-gray-400 mb-3">
                            <c:choose>
                                <c:when test="${not empty doctor.department}">
                                    ${doctor.department}
                                </c:when>
                                <c:otherwise>General Medicine</c:otherwise>
                            </c:choose>
                        </p>



                        <div class="flex space-x-2">
                            <button onclick="viewDoctorProfile(${doctor.id})">
                            </button>
                            <a href="${pageContext.request.contextPath}/patient/doctor/${doctor.id}"  class="flex-1 px-3 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm hover:bg-blue-100 transition">
                                View Profile
                            </a>
<%--                            <button onclick="bookAppointment(${doctor.id}, 'Dr. ${fn:escapeXml(doctor.name)}')" class="px-3 py-2 bg-green-600 text-white rounded-xl text-sm hover:bg-green-700 transition">--%>
<%--                                Book--%>
<%--                            </button>--%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Upcoming Appointments -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Upcoming Appointments</h2>
                <a href="${pageContext.request.contextPath}/patient/appointments" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 text-sm font-medium">
                    View All →
                </a>
            </div>
            <div class="space-y-4">
                <!-- Sample appointments -->
                <div class="flex items-center p-4 bg-blue-50 dark:bg-blue-900/20 rounded-2xl border border-blue-100 dark:border-blue-800">
                    <div class="w-12 h-12 bg-blue-600 rounded-xl flex items-center justify-center text-white font-bold">
                        SJ
                    </div>
                    <div class="ml-4 flex-1">
                        <h4 class="font-semibold text-gray-900 dark:text-white">Dr. Sarah Johnson</h4>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Cardiology - Regular Checkup</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm font-semibold text-blue-600 dark:text-blue-400">Oct 18, 2025</p>
                        <p class="text-xs text-gray-500 dark:text-gray-400">10:00 AM</p>
                    </div>
                </div>

                <div class="flex items-center p-4 bg-green-50 dark:bg-green-900/20 rounded-2xl border border-green-100 dark:border-green-800">
                    <div class="w-12 h-12 bg-green-600 rounded-xl flex items-center justify-center text-white font-bold">
                        MB
                    </div>
                    <div class="ml-4 flex-1">
                        <h4 class="font-semibold text-gray-900 dark:text-white">Dr. Michael Brown</h4>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Neurology - Consultation</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm font-semibold text-green-600 dark:text-green-400">Oct 22, 2025</p>
                        <p class="text-xs text-gray-500 dark:text-gray-400">2:30 PM</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Book Appointment Modal -->
<div id="book-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Book Appointment</h2>
                <button onclick="closeModal('book-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/patient/appointments" method="post" class="space-y-4">
                <input type="hidden" id="book-doctor-id" name="doctorId">
                <div class="p-3 bg-blue-50 dark:bg-blue-900/20 rounded-xl mb-4">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Booking with:</p>
                    <p id="book-doctor-name" class="font-semibold text-gray-900 dark:text-white"></p>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Appointment Date</label>
                    <input type="date" name="date" required min="2025-10-16" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Preferred Time</label>
                    <select name="time" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                        <option value="">Select time</option>
                        <option value="09:00">09:00 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="11:00">11:00 AM</option>
                        <option value="14:00">02:00 PM</option>
                        <option value="15:00">03:00 PM</option>
                        <option value="16:00">04:00 PM</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Reason for Visit</label>
                    <textarea name="reason" rows="3" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white" placeholder="Describe your symptoms or reason for visit..."></textarea>
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('book-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>