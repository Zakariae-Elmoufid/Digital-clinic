<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Account - Digital Clinic</title>
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
        function openModal(id) { document.getElementById(id).classList.remove('hidden'); }
        function closeModal(id) { document.getElementById(id).classList.add('hidden'); }
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Optional Sidebar -->
<%-- <%@ include file="./../component/sidebar.jsp" %> --%>

<div class="max-w-5xl mx-auto py-10 px-4">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8">
        <div>
            <h1 class="text-3xl font-bold text-gray-900 dark:text-white">Doctor Account Manager</h1>
            <p class="text-gray-600 dark:text-gray-400">Manage your profile, schedule, and appointments</p>
        </div>
        <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700">
            <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646"/>
            </svg>
            <svg class="w-5 h-5 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3"/>
            </svg>
        </button>
    </div>

    <!-- Profile Card -->
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-8 mb-8 flex flex-col sm:flex-row items-center">
        <div class="flex-shrink-0 mr-8">
            <div class="w-24 h-24 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-4xl">
                <c:choose>
                    <c:when test="${not empty doctor.name}">
                        ${fn:substring(doctor.name,0,1)}
                    </c:when>
                    <c:otherwise>D</c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="flex-1 min-w-0">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">${doctor.name}</h2>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-2">${doctor.specialty} &mdash; ${doctor.department}</p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-2"><span class="font-medium">Email:</span> ${doctor.email}</p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-2"><span class="font-medium">Phone:</span> ${doctor.phone}</p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-2"><span class="font-medium">Joined:</span>
                <fmt:formatDate value="${doctor.joinedAt}" pattern="MMM dd, yyyy"/>
            </p>
            <button onclick="openModal('edit-profile-modal')" class="mt-4 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">
                Edit Profile
            </button>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-8">
        <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white text-center">
            <p class="text-3xl font-bold mb-1">${doctor.appointmentsToday}</p>
            <p class="text-blue-100 text-sm">Appointments Today</p>
        </div>
        <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white text-center">
            <p class="text-3xl font-bold mb-1">${doctor.patientsThisMonth}</p>
            <p class="text-green-100 text-sm">Patients This Month</p>
        </div>
        <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white text-center">
            <p class="text-3xl font-bold mb-1">${doctor.rating}</p>
            <p class="text-purple-100 text-sm">Rating</p>
        </div>
    </div>

    <!-- Schedule Table -->
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-8">
        <div class="flex items-center justify-between mb-4">
            <h2 class="text-xl font-bold text-gray-900 dark:text-white">Upcoming Schedule</h2>
            <button onclick="openModal('edit-schedule-modal')" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 font-medium">
                Edit Schedule
            </button>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="border-b border-gray-200 dark:border-gray-600">
                    <th class="py-3 px-3 text-left text-sm font-semibold text-gray-700 dark:text-gray-300">Date</th>
                    <th class="py-3 px-3 text-left text-sm font-semibold text-gray-700 dark:text-gray-300">Time</th>
                    <th class="py-3 px-3 text-left text-sm font-semibold text-gray-700 dark:text-gray-300">Type</th>
                    <th class="py-3 px-3 text-left text-sm font-semibold text-gray-700 dark:text-gray-300">Patient</th>
                    <th class="py-3 px-3 text-center text-sm font-semibold text-gray-700 dark:text-gray-300">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="appt" items="${doctor.upcomingAppointments}">
                    <tr class="border-b border-gray-100 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                        <td class="py-3 px-3">
                            <fmt:formatDate value="${appt.date}" pattern="MMM dd, yyyy"/>
                        </td>
                        <td class="py-3 px-3">
                            <fmt:formatDate value="${appt.time}" pattern="HH:mm"/>
                        </td>
                        <td class="py-3 px-3">${appt.type}</td>
                        <td class="py-3 px-3">${appt.patientName}</td>
                        <td class="py-3 px-3 text-center">
                            <c:choose>
                                <c:when test="${appt.status == 'PLANNED'}">
                                    <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">Planned</span>
                                </c:when>
                                <c:when test="${appt.status == 'DONE'}">
                                    <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs font-semibold">Done</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="px-3 py-1 bg-red-100 text-red-700 rounded-full text-xs font-semibold">Canceled</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit Profile Modal -->
    <div id="edit-profile-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Profile</h2>
                    <button onclick="closeModal('edit-profile-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
                </div>
                <form action="${pageContext.request.contextPath}/doctor/account" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="updateProfile">
                    <input type="text" name="name" value="${doctor.name}" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Full Name">
                    <input type="text" name="specialty" value="${doctor.specialty}" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Specialty">
                    <input type="text" name="department" value="${doctor.department}" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Department">
                    <input type="email" name="email" value="${doctor.email}" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Email">
                    <input type="tel" name="phone" value="${doctor.phone}" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Phone">
                    <div class="flex space-x-4">
                        <button type="button" onclick="closeModal('edit-profile-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                        <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Schedule Modal -->
    <div id="edit-schedule-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Schedule</h2>
                    <button onclick="closeModal('edit-schedule-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
                </div>
                <form action="${pageContext.request.contextPath}/doctor/account" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="updateSchedule">
                    <textarea name="scheduleNotes" rows="3" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl dark:bg-gray-700 dark:text-white" placeholder="Describe your weekly schedule, available times, etc.">${doctor.scheduleNotes}</textarea>
                    <div class="flex space-x-4">
                        <button type="button" onclick="closeModal('edit-schedule-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                        <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>