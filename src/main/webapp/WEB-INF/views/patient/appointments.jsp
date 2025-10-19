<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Digital Clinic</title>
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

        function filterAppointments(filter) {
            const cards = document.querySelectorAll('.appointment-card');
            const noResults = document.getElementById('no-results');
            let visibleCount = 0;

            cards.forEach(card => {
                const status = card.getAttribute('data-status');
                const date = card.getAttribute('data-date');
                const today = new Date().toISOString().split('T')[0];

                let show = false;
                if (filter === 'all') {
                    show = true;
                } else if (filter === 'upcoming') {
                    show = status === 'Scheduled' && date >= today;
                } else if (filter === 'completed') {
                    show = status === 'Completed';
                } else if (filter === 'cancelled') {
                    show = status === 'Cancelled';
                }

                card.classList.toggle('hidden', !show);
                if (show) visibleCount++;
            });

            noResults.classList.toggle('hidden', visibleCount > 0);
        }

        function cancelAppointment(appointmentId, doctorName) {
            document.getElementById('cancel-appointment-id').value = appointmentId;
            document.getElementById('cancel-doctor-name').textContent = doctorName;
            openModal('cancel-modal');
        }

        function confirmCancel() {
            const appointmentId = document.getElementById('cancel-appointment-id').value;
            const reason = document.getElementById('cancel-reason').value;

            if (!reason.trim()) {
                alert('Please provide a reason for cancellation');
                return;
            }

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/patient/appointments/cancel';
            form.innerHTML = `
                <input type="hidden" name="appointmentId" value="${appointmentId}">
                <input type="hidden" name="cancelReason" value="${reason}">
            `;
            document.body.appendChild(form);
            form.submit();
        }

        function rescheduleAppointment(appointmentId, doctorName, currentDate, currentTime) {
            document.getElementById('reschedule-appointment-id').value = appointmentId;
            document.getElementById('reschedule-doctor-name').textContent = doctorName;
            document.getElementById('reschedule-current-datetime').textContent = `${currentDate} at ${currentTime}`;
            openModal('reschedule-modal');
        }

        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Mobile Overlay -->
<div id="overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden hidden" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<c:set var="currentPage" value="appointment" scope="request" />
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
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">My Appointments</h1>
                    <p class="text-sm text-gray-600 dark:text-gray-400">View and manage all your scheduled appointments</p>
                </div>
            </div>
            <div class="flex items-center space-x-4">
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
                <span class="text-sm text-gray-600 dark:text-gray-400 hidden sm:block">2025-10-19 20:08:36</span>
            </div>
        </div>
    </header>

    <main class="p-4 lg:p-8">
        <!-- Quick Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-3">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Total</span>
                </div>
                <p class="text-4xl font-bold mb-1">${fn:length(appointments)}</p>
                <p class="text-blue-100 text-sm">Total Appointments</p>
            </div>

            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-3">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Upcoming</span>
                </div>
                <p class="text-4xl font-bold mb-1">
                    <c:set var="upcomingCount" value="0" />
                    <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status == 'Scheduled'}">
                            <c:set var="upcomingCount" value="${upcomingCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${upcomingCount}
                </p>
                <p class="text-green-100 text-sm">Upcoming Appointments</p>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-3">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m7 0a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Completed</span>
                </div>
                <p class="text-4xl font-bold mb-1">
                    <c:set var="completedCount" value="0" />
                    <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status == 'Completed'}">
                            <c:set var="completedCount" value="${completedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${completedCount}
                </p>
                <p class="text-purple-100 text-sm">Completed Appointments</p>
            </div>

            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-3">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l-2-2m0 0l-2-2m2 2l2-2m-2 2l-2 2"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Cancelled</span>
                </div>
                <p class="text-4xl font-bold mb-1">
                    <c:set var="cancelledCount" value="0" />
                    <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status == 'Cancelled'}">
                            <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${cancelledCount}
                </p>
                <p class="text-orange-100 text-sm">Cancelled Appointments</p>
            </div>
        </div>

        <!-- Filter Tabs -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-8">
            <div class="flex items-center justify-between flex-wrap gap-4">
                <div class="flex space-x-2 flex-wrap">
                    <button onclick="filterAppointments('all'); this.classList.add('bg-blue-600', 'text-white'); document.querySelectorAll('.filter-btn').forEach(b => {if(b !== this) b.classList.remove('bg-blue-600', 'text-white'); b.classList.add('bg-gray-100', 'text-gray-700', 'dark:bg-gray-700', 'dark:text-gray-300')})"
                            class="filter-btn px-6 py-2 bg-blue-600 text-white rounded-xl font-semibold transition">
                        All Appointments
                    </button>
                    <button onclick="filterAppointments('upcoming'); this.classList.add('bg-blue-600', 'text-white'); document.querySelectorAll('.filter-btn').forEach(b => {if(b !== this) b.classList.remove('bg-blue-600', 'text-white'); b.classList.add('bg-gray-100', 'text-gray-700', 'dark:bg-gray-700', 'dark:text-gray-300')})"
                            class="filter-btn px-6 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold transition hover:bg-gray-200 dark:hover:bg-gray-600">
                        Upcoming
                    </button>
                    <button onclick="filterAppointments('completed'); this.classList.add('bg-blue-600', 'text-white'); document.querySelectorAll('.filter-btn').forEach(b => {if(b !== this) b.classList.remove('bg-blue-600', 'text-white'); b.classList.add('bg-gray-100', 'text-gray-700', 'dark:bg-gray-700', 'dark:text-gray-300')})"
                            class="filter-btn px-6 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold transition hover:bg-gray-200 dark:hover:bg-gray-600">
                        Completed
                    </button>
                    <button onclick="filterAppointments('cancelled'); this.classList.add('bg-blue-600', 'text-white'); document.querySelectorAll('.filter-btn').forEach(b => {if(b !== this) b.classList.remove('bg-blue-600', 'text-white'); b.classList.add('bg-gray-100', 'text-gray-700', 'dark:bg-gray-700', 'dark:text-gray-300')})"
                            class="filter-btn px-6 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold transition hover:bg-gray-200 dark:hover:bg-gray-600">
                        Cancelled
                    </button>
                </div>
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="px-6 py-2 bg-green-600 text-white rounded-xl font-semibold hover:bg-green-700 transition">
                    Book New Appointment
                </a>
            </div>
        </div>

        <!-- Appointments List -->
        <div class="space-y-6">
            <c:choose>
                <c:when test="${not empty appointmentsPatient}">
                    <c:forEach var="appointment" items="${appointmentsPatient}">
                        <div class="appointment-card bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 hover:shadow-lg transition"
                             data-status="${appointment.status}"
                             data-date="${appointment.appointmentDate}">
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                                <!-- Doctor Info -->
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-2xl flex items-center justify-center text-white font-bold text-lg flex-shrink-0">
                                            ${fn:substring(appointment.doctor.user.fullName, 0, 1)}
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-bold text-gray-900 dark:text-white">Dr. ${appointment.doctor.user.fullName}</h3>
                                        <p class="text-sm text-blue-600 dark:text-blue-400">${appointment.doctor.specialite.name}</p>
                                        <p class="text-xs text-gray-600 dark:text-gray-400">${appointment.doctor.specialite.department.name}</p>
                                    </div>
                                </div>

                                <!-- Appointment Details -->
                                <div>
                                    <p class="text-xs text-gray-600 dark:text-gray-400 font-semibold mb-1">DATE & TIME</p>
                                    <p class="text-lg font-bold text-gray-900 dark:text-white">
                                        ${appointment.appointmentDate}
                                    </p>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">
                                            ${appointment.startTime}
                                    </p>
                                </div>

                                <!-- Status -->
                                <div>
                                    <p class="text-xs text-gray-600 dark:text-gray-400 font-semibold mb-2">STATUS</p>
                                    <c:choose>
                                        <c:when test="${appointment.status == 'PLANNED'}">
                                                <span class="inline-block px-3 py-1 bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300 rounded-full text-xs font-bold">
                                                    ✓ Scheduled
                                                </span>
                                        </c:when>
                                        <c:when test="${appointment.status == 'DONE'}">
                                                <span class="inline-block px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs font-bold">
                                                    ✓ Completed
                                                </span>
                                        </c:when>
                                        <c:when test="${appointment.status == 'CANCELED'}">
                                                <span class="inline-block px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs font-bold">
                                                    ✗ Cancelled
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="inline-block px-3 py-1 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-full text-xs font-bold">
                                                    ? Unknown
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Actions -->
<%--                                <div class="flex flex-col space-y-2">--%>
<%--                                    <a href="${pageContext.request.contextPath}/patient/appointments/${appointment.id}" class="px-4 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm hover:bg-blue-100 dark:hover:bg-blue-900/40 transition text-center">--%>
<%--                                        View Details--%>
<%--                                    </a>--%>
<%--                                    <c:if test="${appointment.status == 'PLANNED'}">--%>
<%--                                        <button onclick="rescheduleAppointment(${appointment.id}, 'Dr. ${fn:escapeXml(appointment.doctor.user.fullName)}', '${fn:escapeXml(appointment.appointmentDate)}', '${fn:escapeXml(appointment.startTime)}')"--%>
<%--                                                class="px-4 py-2 bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400 rounded-xl text-sm hover:bg-orange-100 dark:hover:bg-orange-900/40 transition">--%>
<%--                                            Reschedule--%>
<%--                                        </button>--%>
<%--                                        <button onclick="cancelAppointment(${appointment.id}, 'Dr. ${fn:escapeXml(appointment.doctor.user.fullName)}')"--%>
<%--                                                class="px-4 py-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm hover:bg-red-100 dark:hover:bg-red-900/40 transition">--%>
<%--                                            Cancel--%>
<%--                                        </button>--%>
<%--                                    </c:if>--%>
<%--                                </div>--%>
                            </div>

                            <!-- Reason for Visit -->
                            <div class="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
                                <p class="text-xs text-gray-600 dark:text-gray-400 font-semibold mb-1">REASON FOR VISIT</p>
<%--                                <p class="text-sm text-gray-700 dark:text-gray-300">${appointment.reasonForVisit}</p>--%>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div id="no-results" class="text-center py-12 bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700">
                        <svg class="w-16 h-16 text-gray-400 dark:text-gray-600 mx-auto mb-4 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        <p class="text-gray-600 dark:text-gray-400 font-medium mb-2">No appointments found</p>
                        <p class="text-sm text-gray-500 dark:text-gray-500 mb-6">You don't have any appointments yet</p>
                        <a href="${pageContext.request.contextPath}/patient/dashboard" class="px-6 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 inline-block">
                            Book Your First Appointment
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<!-- Cancel Appointment Modal -->
<div id="cancel-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Cancel Appointment</h2>
                <button onclick="closeModal('cancel-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>

            <div class="mb-6 p-4 bg-red-50 dark:bg-red-900/20 rounded-xl">
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">You are cancelling appointment with:</p>
                <p id="cancel-doctor-name" class="font-bold text-gray-900 dark:text-white"></p>
            </div>

            <form onsubmit="event.preventDefault(); confirmCancel();" class="space-y-4">
                <input type="hidden" id="cancel-appointment-id">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">Reason for Cancellation *</label>
                    <textarea id="cancel-reason" rows="3" required
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-red-500 dark:bg-gray-700 dark:text-white resize-none"
                              placeholder="Please tell us why you're cancelling..."></textarea>
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('cancel-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Keep It</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-red-600 text-white rounded-xl hover:bg-red-700">Cancel Appointment</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reschedule Appointment Modal -->
<div id="reschedule-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Reschedule Appointment</h2>
                <button onclick="closeModal('reschedule-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>

            <div class="mb-6 space-y-3">
                <div class="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl">
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Current Appointment:</p>
                    <p id="reschedule-doctor-name" class="font-bold text-gray-900 dark:text-white mb-1"></p>
                    <p id="reschedule-current-datetime" class="text-sm text-gray-700 dark:text-gray-300"></p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/patient/appointments/reschedule" method="post" class="space-y-4">
                <input type="hidden" id="reschedule-appointment-id" name="appointmentId">

                <div>
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">New Date *</label>
                    <input type="date" name="newDate" required min="2025-10-19"
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>

                <div>
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">New Time *</label>
                    <select name="newTime" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                        <option value="">Select time</option>
                        <option value="09:00">09:00 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="11:00">11:00 AM</option>
                        <option value="14:00">02:00 PM</option>
                        <option value="15:00">03:00 PM</option>
                        <option value="16:00">04:00 PM</option>
                    </select>
                </div>

                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('reschedule-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Reschedule</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>