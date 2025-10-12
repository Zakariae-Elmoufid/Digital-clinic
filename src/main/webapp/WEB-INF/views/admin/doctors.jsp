<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctors Management - Digital Clinic</title>
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
        function openModal(id) {
            document.getElementById(id).classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }
        function closeModal(id) {
            document.getElementById(id).classList.add('hidden');
            document.body.style.overflow = 'auto';
        }
        function editDoctor(id, name, email, phone, specialty, department) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-email').value = email;
            document.getElementById('edit-phone').value = phone || '';
            document.getElementById('edit-specialty').value = specialty || '';
            document.getElementById('edit-department').value = department || '';
            openModal('edit-modal');
        }
        function deleteDoctor(id, name) {
            document.getElementById('delete-id').value = id;
            document.getElementById('delete-name').textContent = name;
            openModal('delete-modal');
        }
        function viewDoctor(id) {
            window.location.href = '${pageContext.request.contextPath}/admin/doctors/' + id;
        }
        function searchDoctors() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const cards = document.querySelectorAll('.doctor-card');
            cards.forEach(card => {
                const name = card.querySelector('.doctor-name').textContent.toLowerCase();
                const specialty = card.querySelector('.doctor-specialty').textContent.toLowerCase();
                if (name.includes(searchTerm) || specialty.includes(searchTerm)) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            });
        }
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Sidebar -->
<c:set var="currentPage" value="doctors" scope="request" />
<%@ include file="./../component/sidebar.jsp" %>

<!-- Main Content -->
<div class="ml-64">
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
        <div class="flex items-center justify-between px-8 py-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Doctors Management</h1>
                <p class="text-sm text-gray-600 dark:text-gray-400">Manage all doctors in the clinic</p>
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
                <span class="text-sm text-gray-600 dark:text-gray-400">Oct 12, 2025 - 8:29 PM</span>
            </div>
        </div>
    </header>

    <main class="p-8">
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 dark:bg-green-900/20 border border-green-400 dark:border-green-700 text-green-700 dark:text-green-300 px-4 py-3 rounded-xl mb-6 flex items-center justify-between">
                <span>${success}</span>
                <button onclick="this.parentElement.remove()" class="text-green-500 hover:text-green-700">✕</button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 dark:bg-red-900/20 border border-red-400 dark:border-red-700 text-red-700 dark:text-red-300 px-4 py-3 rounded-xl mb-6 flex items-center justify-between">
                <span>${error}</span>
                <button onclick="this.parentElement.remove()" class="text-red-500 hover:text-red-700">✕</button>
            </div>
        </c:if>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white">
                <p class="text-4xl font-bold mb-2">${fn:length(doctors)}</p>
                <p class="text-blue-100 text-sm">Total Doctors</p>
            </div>
            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white">
                <p class="text-4xl font-bold mb-2">
                    <c:set var="activeCount" value="0" />
                    <c:forEach var="doctor" items="${doctors}">
                        <c:if test="${doctor.active}">
                            <c:set var="activeCount" value="${activeCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${activeCount}
                </p>
                <p class="text-green-100 text-sm">Active Doctors</p>
            </div>
            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white">
                <p class="text-4xl font-bold mb-2">${fn:length(departments)}</p>
                <p class="text-purple-100 text-sm">Departments</p>
            </div>
            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white">
                <p class="text-4xl font-bold mb-2">${fn:length(specialties)}</p>
                <p class="text-orange-100 text-sm">Specialties</p>
            </div>
        </div>

        <!-- Search & Add -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-6">
            <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                <div class="flex-1 w-full md:w-auto">
                    <input type="text" id="search-input" placeholder="Search doctors by name or specialty..."
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           oninput="searchDoctors()">
                </div>
                <button onclick="openModal('add-modal')" class="px-6 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    Add Doctor
                </button>
            </div>
        </div>

        <!-- Doctors Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
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
                        <c:choose>
                            <c:when test="${doctor.active}">
                                <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h3 class="doctor-name text-lg font-bold text-gray-900 dark:text-white mb-2">${doctor.name}</h3>
                    <p class="doctor-specialty text-sm text-blue-600 dark:text-blue-400 font-medium mb-2">
                        <c:choose>
                            <c:when test="${not empty doctor.specialty}">
                                ${doctor.specialty}
                            </c:when>
                            <c:otherwise>General Practitioner</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">
                        <c:choose>
                            <c:when test="${not empty doctor.department}">
                                ${doctor.department}
                            </c:when>
                            <c:otherwise>No Department</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">📧 ${doctor.email}</p>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
                        📞 <c:choose>
                        <c:when test="${not empty doctor.phone}">
                            ${doctor.phone}
                        </c:when>
                        <c:otherwise>No phone</c:otherwise>
                    </c:choose>
                    </p>

                    <div class="text-xs text-gray-500 dark:text-gray-400 mb-4">
                        Joined: <fmt:formatDate value="${doctor.joinedAt}" pattern="MMM dd, yyyy"/>
                    </div>

                    <div class="flex space-x-2">
                        <button onclick="viewDoctor(${doctor.id})"
                                class="flex-1 px-3 py-2 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 rounded-xl text-sm hover:bg-green-100 transition">
                            View
                        </button>
                        <button onclick="editDoctor(${doctor.id}, '${fn:escapeXml(doctor.name)}', '${fn:escapeXml(doctor.email)}', '${fn:escapeXml(doctor.phone)}', '${fn:escapeXml(doctor.specialty)}', '${fn:escapeXml(doctor.department)}')"
                                class="px-3 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm hover:bg-blue-100 transition">
                            Edit
                        </button>
                        <button onclick="deleteDoctor(${doctor.id}, '${fn:escapeXml(doctor.name)}')"
                                class="px-3 py-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm hover:bg-red-100 transition">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <!-- Add New Card -->
            <div onclick="openModal('add-modal')" class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border-2 border-dashed border-gray-300 dark:border-gray-600 p-6 hover:border-blue-400 cursor-pointer transition">
                <div class="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400 min-h-[300px]">
                    <div class="w-16 h-16 bg-gray-100 dark:bg-gray-700 rounded-2xl flex items-center justify-center mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                    </div>
                    <p class="font-medium">Add Doctor</p>
                    <p class="text-sm text-center mt-2">Add a new doctor to the clinic</p>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Add Modal -->
<div id="add-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 max-h-[90vh] overflow-y-auto">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Add Doctor</h2>
                <button onclick="closeModal('add-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <c:if test="${not empty errors}">
                <div class="bg-red-50 dark:bg-red-900/20 border-l-4 border-red-500 text-red-700 dark:text-red-400 p-4 mb-4 rounded-r-lg">
                    <p class="font-semibold mb-2">Please fix the following errors:</p>
                    <ul class="list-disc list-inside space-y-1">
                        <c:forEach var="error" items="${errors}">
                            <li class="text-sm">${error.message}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <form action="${pageContext.request.contextPath}/admin/doctors" method="post" class="space-y-4">
                <input type="hidden" name="action" value="add">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name *</label>
                    <input type="text" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           placeholder="Dr. John Smith">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email *</label>
                    <input type="email" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           placeholder="doctor@clinic.com">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Password</label>
                    <input type="password" name="password"
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           placeholder="+1 (555) 123-4567">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Matriculate</label>
                    <input type="text" name="matricule" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"

                           placeholder="Ex : DOC1234" >
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Specialty</label>
                    <select name="specialtyId" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                        <option value="">Select Specialty</option>
                        <c:forEach var="specialty" items="${specialties}">
                            <option value="${specialty.id}">${specialty.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="flex items-center">
                    <input type="checkbox" name="active" id="add-active" checked class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                    <label for="add-active" class="ml-2 text-sm text-gray-700 dark:text-gray-300">Active</label>
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('add-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Add Doctor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 max-h-[90vh] overflow-y-auto">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Doctor</h2>
                <button onclick="closeModal('edit-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/doctors" method="post" class="space-y-4">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="edit-id" name="id">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name *</label>
                    <input type="text" id="edit-name" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email *</label>
                    <input type="email" id="edit-email" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Phone</label>
                    <input type="tel" id="edit-phone" name="phone"
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Specialty</label>
                    <input type="text" id="edit-specialty" name="specialty"
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Department</label>
                    <input type="text" id="edit-department" name="department"
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('edit-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Update Doctor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div id="delete-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-red-600">Delete Doctor</h2>
                <button onclick="closeModal('delete-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
                Are you sure you want to delete Dr. <span id="delete-name" class="font-semibold"></span>? This action cannot be undone.
            </p>
            <form action="${pageContext.request.contextPath}/admin/doctors" method="post" class="flex space-x-4">
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