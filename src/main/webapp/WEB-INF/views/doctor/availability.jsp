<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Availability - Digital Clinic</title>
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
        function editSlot(id, day, duration, startTime, endTime, startDate , endDate ,  isAvailable) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-day').value = day;
            document.getElementById('edit-day').innerHTML = day;
            document.getElementById('edit-duration').value = duration
            document.getElementById('edit-start-time').value = startTime;
            document.getElementById('edit-end-time').value = endTime;

            document.getElementById('edit-start-date').value = startDate;

            document.getElementById('edit-end-date').value =  endDate|| '';

            document.getElementById('edit-available').checked =  (isAvailable === "true" || isAvailable === true);
            openModal('edit-modal');
        }
        function deleteSlot(id) {
            document.getElementById('delete-id').value = id;
            openModal('delete-modal');
        }


        function addTimeSlot(day) {
            document.getElementById('add-day').value = day;
            openModal('add-modal');
        }
        function toggleDayAvailability(day, currentStatus) {
            fetch('${pageContext.request.contextPath}/doctor/availability/toggle', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ day: day, available: !currentStatus })
            }).then(() => location.reload());
        }
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Mobile Overlay -->
<div id="overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden hidden" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<c:set var="currentPage" value="availability" scope="request" />
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
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Availability Management</h1>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Define your working hours and availability</p>
                </div>
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
                <span class="text-sm text-gray-600 dark:text-gray-400">Oct 14, 2025 - 09:00 AM</span>
            </div>
        </div>
    </header>

    <main class="p-4 lg:p-8">
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 dark:bg-green-900/20 border border-green-400 dark:border-green-700 text-green-700 dark:text-green-300 px-4 py-3 rounded-xl mb-6 flex items-center justify-between">
                <div class="flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span>${success}</span>
                </div>
                <button onclick="this.parentElement.remove()" class="text-green-500 hover:text-green-700">✕</button>
            </div>
        </c:if>

        <!-- Quick Stats -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Weekly</span>
                </div>
                <p class="text-4xl font-bold mb-2">40</p>
                <p class="text-blue-100 text-sm">Hours per Week</p>
            </div>

            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Active</span>
                </div>
                <p class="text-4xl font-bold mb-2">5</p>
                <p class="text-green-100 text-sm">Working Days</p>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Today</span>
                </div>
                <p class="text-4xl font-bold mb-2">8</p>
                <p class="text-purple-100 text-sm">Available Hours</p>
            </div>
        </div>


        <!-- Time Slots -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Custom Time Slots</h2>
                <button onclick="openModal('add-slot-modal')" class="px-4 py-2 bg-green-600 text-white rounded-xl hover:bg-green-700 text-sm">
                    Add Time Slot
                </button>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">


                <c:forEach var="availability" items="${availabilities}">
                    <div class="p-4 bg-green-50 dark:bg-green-900/20 rounded-2xl">
                        <div class="flex items-center justify-between mb-2">
                            <h4 class="font-semibold text-gray-900 dark:text-white">${availability.dayOfWeek}</h4>
                            <c:choose>
                                <c:when test="${availability.available}">
                                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">
                                ${availability.startDateFormatted} -<c:if test="${availability.endDateFormatted  != null}">
                                    ${availability.endDateFormatted }
                                </c:if>
                                    <c:if test="${availability.endDateFormatted == null}">
                                    No end date
                                </c:if>
                        </p>
                        <p class="text-sm font-medium text-green-600 dark:text-green-400">
                                ${availability.startTimeFormatted} - ${availability.endTimeFormatted}
                        </p>
                        <div class="flex space-x-2 mt-3">
                            <button   onclick="editSlot(
                                ${availability.id},
                                    '${availability.dayOfWeek}',
                                    '${availability.slotDuration}',
                                    '${fn:escapeXml(availability.startTime)}',
                                    '${fn:escapeXml(availability.endTime)}',
                                    '${fn:escapeXml(availability.startDate)}',
                                    '${fn:escapeXml(availability.endDate)}',
                                    '${fn:escapeXml(availability.available)}'
                                    )"
                                      class="px-3 py-1 bg-white dark:bg-gray-700 text-green-600 dark:text-green-400 rounded-lg text-xs hover:bg-gray-50 dark:hover:bg-gray-600 transition">Edit</button>
                            <button  onclick="deleteSlot(${availability.id})"
                                    class="px-3 py-1 bg-white dark:bg-gray-700 text-red-600 dark:text-red-400 rounded-lg text-xs hover:bg-gray-50 dark:hover:bg-gray-600 transition">Delete</button>
                        </div>
                    </div>
                </c:forEach>

                <!-- Add new time slot card -->
                <div onclick="openModal('add-slot-modal')" class="p-4 border-2 border-dashed border-gray-300 dark:border-gray-600 rounded-2xl cursor-pointer hover:border-green-400 dark:hover:border-green-500 transition">
                    <div class="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400">
                        <div class="w-12 h-12 bg-gray-100 dark:bg-gray-700 rounded-2xl flex items-center justify-center mb-2">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                            </svg>
                        </div>
                        <p class="font-medium">Add Time Slot</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>



<!-- Edit Modal -->
<div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Availability</h2>
                <button onclick="closeModal('edit-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/doctor/availability" method="post" class="space-y-4">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="edit-id" name="id">

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Slot Name</label>
                    <input type="number" id="edit-duration" name="duration"  required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white" placeholder="ex,30">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Days</label>
                    <select  name="day-of-week"  class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                        <option selected  id="edit-day"></option>
                        <option value="MONDAY">Monday</option>
                        <option value="TUESDAY">Tuesday</option>
                        <option value="WEDNESDAY">Wednesday</option>
                        <option value="THURSDAY">Thursday</option>
                        <option value="FRIDAY">Friday</option>
                        <option value="SATURDAY">Saturday</option>
                        <option value="SUNDAY">Sunday</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Start Time</label>
                    <input type="time" id="edit-start-time" name="start-time" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">End Time</label>
                    <input type="time" id="edit-end-time" name="end-time" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>



                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Start Date</label>
                    <input type="date" id="edit-start-date" name="start-date"  class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">End Date</label>
                    <input type="date" id="edit-end-date" name="end-dat"  class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>

                <div class="flex items-center">
                    <label for="edit-available" class="ml-2 text-sm text-gray-700 dark:text-gray-300">Available</label>
                    <input type="checkbox" name="is-available" id="edit-available"  class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('edit-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Time Slot Modal -->
<div id="add-slot-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Add Time Slot</h2>
                <button onclick="closeModal('add-slot-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/doctor/availability" method="post" class="space-y-4">
                <input type="hidden" name="action" value="add" />
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Slot Name</label>
                    <input type="number" name="slot-duration" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white" placeholder="ex,30">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Days</label>
                    <select name="day-of-week"  class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                        <option value="MONDAY">Monday</option>
                        <option value="TUESDAY">Tuesday</option>
                        <option value="WEDNESDAY">Wednesday</option>
                        <option value="THURSDAY">Thursday</option>
                        <option value="FRIDAY">Friday</option>
                        <option value="SATURDAY">Saturday</option>
                        <option value="SUNDAY">Sunday</option>
                    </select>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Start Date</label>
                        <input type="date" id="edit-end-time" name="start-date" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">End Date</label>
                        <input type="date" id="edit-end-time" name="end-date"  class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Start Time</label>
                        <input type="time" name="start-time" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">End Time</label>
                        <input type="time" name="end-time" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                    </div>
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('add-slot-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-green-600 text-white rounded-xl hover:bg-green-700">Create Slot</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="delete-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-red-600">Delete Availabbility</h2>
                <button onclick="closeModal('delete-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
                Are you sure you want to delete Dr. <span id="delete-name" class="font-semibold"></span>? This action cannot be undone.
            </p>
            <form action="${pageContext.request.contextPath}/doctor/availability" method="post" class="flex space-x-4">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="delete-id" name="id">
                <button type="button" onclick="closeModal('delete-modal')"
                        class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                <button type="submit"
                        class="flex-1 px-4 py-2 bg-red-600 text-white rounded-xl hover:bg-red-700">Delete</button>
            </form>
        </div>
    </div>
</div>


</body>
</html>