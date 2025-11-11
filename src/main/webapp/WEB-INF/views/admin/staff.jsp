
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Management - Digital Clinic</title>
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
        function editStaff(id, name, email, active) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-email').value = email;
            document.getElementById("edit-active").checked = (active === "true" || active === true);
            openModal('edit-modal');
        }
        function deleteStaff(id, name) {
            document.getElementById('delete-id').value = id;
            document.getElementById('delete-name').textContent = name;
            openModal('delete-modal');
        }
        function viewStaff(id) {
            window.location.href = '${pageContext.request.contextPath}/admin/staff/' + id;
        }
        function searchStaff() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const cards = document.querySelectorAll('.staff-card');
            cards.forEach(card => {
                const name = card.querySelector('.staff-name').textContent.toLowerCase();
                const role = card.querySelector('.staff-role').textContent.toLowerCase();
                if (name.includes(searchTerm) || role.includes(searchTerm)) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            });
        }
        function filterByRole() {
            const role = document.getElementById('role-filter').value;
            const cards = document.querySelectorAll('.staff-card');
            cards.forEach(card => {
                if (role === 'all') {
                    card.classList.remove('hidden');
                } else {
                    const cardRole = card.querySelector('.staff-role').textContent.toLowerCase();
                    if (cardRole.includes(role.toLowerCase())) {
                        card.classList.remove('hidden');
                    } else {
                        card.classList.add('hidden');
                    }
                }
            });
        }
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Sidebar -->
<c:set var="currentPage" value="staff" scope="request" />
<%@ include file="./../component/sidebar.jsp" %>

<!-- Main Content -->
<div class="ml-64">
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
        <div class="flex items-center justify-between px-8 py-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Staff Management</h1>
                <p class="text-sm text-gray-600 dark:text-gray-400">Manage all staff members in the clinic</p>
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
                <span class="text-sm text-gray-600 dark:text-gray-400">Oct 13, 2025 - 3:15 PM</span>
            </div>
        </div>
    </header>

    <main class="p-8">
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
        <c:if test="${not empty error}">
            <div class="bg-red-100 dark:bg-red-900/20 border border-red-400 dark:border-red-700 text-red-700 dark:text-red-300 px-4 py-3 rounded-xl mb-6 flex items-center justify-between">
                <div class="flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"/>
                    </svg>
                    <span>${error}</span>
                </div>
                <button onclick="this.parentElement.remove()" class="text-red-500 hover:text-red-700">✕</button>
            </div>
        </c:if>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Total</span>
                </div>
                <p class="text-4xl font-bold mb-2">${fn:length(staff)}</p>
                <p class="text-blue-100 text-sm">Total Staff</p>
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
                <p class="text-4xl font-bold mb-2">
                    <c:set var="activeCount" value="0" />
                    <c:forEach var="member" items="${staff}">
                        <c:if test="${member.active}">
                            <c:set var="activeCount" value="${activeCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${activeCount}
                </p>
                <p class="text-green-100 text-sm">Active Staff</p>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Nurses</span>
                </div>
                <p class="text-4xl font-bold mb-2">
                    <c:set var="nurseCount" value="0" />
                    <c:forEach var="member" items="${staff}">
                        <c:if test="${fn:containsIgnoreCase(member.role, 'nurse')}">
                            <c:set var="nurseCount" value="${nurseCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${nurseCount}
                </p>
                <p class="text-purple-100 text-sm">Nurses</p>
            </div>

            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                        </svg>
                    </div>
                    <span class="px-3 py-1 bg-white bg-opacity-20 rounded-full text-xs font-semibold">Depts</span>
                </div>
                <p class="text-4xl font-bold mb-2">${fn:length(departments)}</p>
                <p class="text-orange-100 text-sm">Departments</p>
            </div>
        </div>

        <!-- Search & Filter -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-6">
            <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                <div class="flex flex-col md:flex-row gap-4 flex-1">
                    <div class="relative flex-1">
                        <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        <input type="text" id="search-input" placeholder="Search staff by name or role..."
                               class="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                               oninput="searchStaff()">
                    </div>
é                </div>
                <button onclick="openModal('add-modal')" class="px-6 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    Add Staff
                </button>
            </div>
        </div>

        <!-- Staff Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <c:forEach var="member" items="${staffs}">
                <div class="staff-card bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 hover:shadow-lg transition">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-blue-600 rounded-2xl flex items-center justify-center text-white font-bold text-lg">
                            <c:choose>
                                <c:when test="${not empty member.name}">
                                    ${fn:substring(member.name,0,1)}
                                </c:when>
                                <c:otherwise>S</c:otherwise>
                            </c:choose>
                        </div>
                        <c:choose>
                            <c:when test="${member.active}">
                                <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h3 class="staff-name text-lg font-bold text-gray-900 dark:text-white mb-2">${member.name}</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">📧 ${member.email}</p>
<%--                    <div class="text-xs text-gray-500 dark:text-gray-400 mb-4">--%>
<%--                        Hired: <fmt:formatDate value="${member.hiredAt}" pattern="MMM dd, yyyy"/>--%>
<%--                    </div>--%>

                    <div class="flex space-x-2">
                        <button onclick="viewStaff(${member.id})"
                                class="flex-1 px-3 py-2 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 rounded-xl text-sm hover:bg-green-100 transition">
                            View
                        </button>
                        <button onclick="editStaff(${member.id}, '${fn:escapeXml(member.name)}', '${fn:escapeXml(member.email)}','${fn:escapeXml(member.active)}')"
                                class="px-3 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm hover:bg-blue-100 transition">
                            Edit
                        </button>
                        <button onclick="deleteStaff(${member.id}, '${fn:escapeXml(member.name)}')"
                                class="px-3 py-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm hover:bg-red-100 transition">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <!-- Add New Card -->
            <div onclick="openModal('add-modal')" class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border-2 border-dashed border-gray-300 dark:border-gray-600 p-6 hover:border-blue-400 cursor-pointer transition">
                <div class="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400 min-h-[350px]">
                    <div class="w-16 h-16 bg-gray-100 dark:bg-gray-700 rounded-2xl flex items-center justify-center mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                    </div>
                    <p class="font-medium">Add Staff Member</p>
                    <p class="text-sm text-center mt-2">Add a new staff member to the clinic</p>
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
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Add Staff Member</h2>
                <button onclick="closeModal('add-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/staffs" method="post" class="space-y-4">
                <input type="hidden" name="action" value="add">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name *</label>
                    <input type="text" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           placeholder="John Smith">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email *</label>
                    <input type="email" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                           placeholder="staff@clinic.com">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Password *</label>
                    <input type="password" name="password" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                         >
                </div>


                <div class="flex items-center">
                    <input type="checkbox" name="active" id="add-active" checked class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                    <label for="add-active" class="ml-2 text-sm text-gray-700 dark:text-gray-300">Active</label>
                </div>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('add-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Add Staff</button>
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
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 max-h-[90vh] overflow-y-auto">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Staff Member</h2>
                <button onclick="closeModal('edit-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
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
            <form action="${pageContext.request.contextPath}/admin/staffs" method="post" class="space-y-4">
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
                    <input id="edit-active"  type="checkbox"/>
                    <label for="edit-active">Active</label>
                </div>

                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('edit-modal')" class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Update Staff</button>
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
                <h2 class="text-xl font-bold text-red-600">Delete Staff Member</h2>
                <button onclick="closeModal('delete-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
                Are you sure you want to delete <span id="delete-name" class="font-semibold"></span>? This action cannot be undone.
            </p>
            <form action="${pageContext.request.contextPath}/admin/staffs" method="post" class="flex space-x-4">
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