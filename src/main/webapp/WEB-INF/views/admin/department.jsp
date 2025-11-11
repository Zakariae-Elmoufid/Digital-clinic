<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - Digital Clinic</title>
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
        }

        function closeModal(id) {
            document.getElementById(id).classList.add('hidden');
            const form = document.getElementById(id).querySelector('form');
            if (form) {
                form.reset();
                clearFormErrors(id);
            }
        }

        function clearFormErrors(modalId) {
            const modal = document.getElementById(modalId);
            const errorElements = modal.querySelectorAll('.field-error');
            errorElements.forEach(el => el.remove());

            const inputElements = modal.querySelectorAll('input, textarea');
            inputElements.forEach(el => {
                el.classList.remove('border-red-500', 'focus:ring-red-500');
                el.classList.add('border-gray-300', 'focus:ring-blue-500');
            });
        }

        function editDept(id, name, description) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-description').value = description;
            clearFormErrors('edit-modal');
            openModal('edit-modal');
        }

        function deleteDept(id) {
            document.getElementById('delete-id').value = id;
            openModal('delete-modal');
        }

        function showSuccessMessage(message) {
            const toast = document.getElementById('success-toast');
            document.getElementById('success-message').textContent = message;
            toast.classList.remove('hidden');
            toast.classList.add('animate-slide-in');

            setTimeout(() => {
                toast.classList.add('animate-slide-out');
                setTimeout(() => {
                    toast.classList.add('hidden');
                    toast.classList.remove('animate-slide-in', 'animate-slide-out');
                }, 300);
            }, 4000);
        }

        function showErrorMessage(message) {
            const toast = document.getElementById('error-toast');
            document.getElementById('error-message').textContent = message;
            toast.classList.remove('hidden');
            toast.classList.add('animate-slide-in');

            setTimeout(() => {
                toast.classList.add('animate-slide-out');
                setTimeout(() => {
                    toast.classList.add('hidden');
                    toast.classList.remove('animate-slide-in', 'animate-slide-out');
                }, 300);
            }, 4000);
        }

        function validateForm(formId) {
            const form = document.getElementById(formId);
            let isValid = true;

            clearFormErrors(formId.replace('-form', '-modal'));

            const nameInput = form.querySelector('[name="name"]');
            const descriptionInput = form.querySelector('[name="description"]');

            if (!nameInput.value.trim()) {
                showFieldError(nameInput, 'Department name is required');
                isValid = false;
            } else if (nameInput.value.trim().length < 3) {
                showFieldError(nameInput, 'Department name must be at least 3 characters');
                isValid = false;
            } else if (nameInput.value.trim().length > 100) {
                showFieldError(nameInput, 'Department name must not exceed 100 characters');
                isValid = false;
            }

            if (descriptionInput.value.trim() && descriptionInput.value.trim().length > 500) {
                showFieldError(descriptionInput, 'Description must not exceed 500 characters');
                isValid = false;
            }

            return isValid;
        }

        function showFieldError(inputElement, message) {
            inputElement.classList.remove('border-gray-300', 'focus:ring-blue-500');
            inputElement.classList.add('border-red-500', 'focus:ring-red-500');

            const errorDiv = document.createElement('div');
            errorDiv.className = 'field-error text-red-600 text-sm mt-1';
            errorDiv.textContent = message;

            inputElement.parentNode.appendChild(errorDiv);
        }

        document.addEventListener('DOMContentLoaded', () => {
            initDarkMode();

            // Check for success message
            <c:if test="${not empty success}">
            showSuccessMessage('${success}');
            // Close modals on success
            closeModal('add-modal');
            closeModal('edit-modal');
            closeModal('delete-modal')
            </c:if>

            // Check for error message
            <c:if test="${not empty error}">
            showErrorMessage('${error}');
            </c:if>

            // Open modal if there are validation errors
            <c:if test="${not empty errors}">
            openModal('add-modal');
            </c:if>
        });
    </script>
    <style>
        @keyframes slide-in {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes slide-out {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        .animate-slide-in { animation: slide-in 0.3s ease-out; }
        .animate-slide-out { animation: slide-out 0.3s ease-in; }
    </style>
</head>
<body class="bg-gray-50 dark:bg-gray-900">

<!-- Success Toast -->
<div id="success-toast" class="hidden fixed top-4 right-4 z-50 max-w-md">
    <div class="bg-green-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center space-x-3">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        <span id="success-message" class="font-medium"></span>
    </div>
</div>

<!-- Error Toast -->
<div id="error-toast" class="hidden fixed top-4 right-4 z-50 max-w-md">
    <div class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center space-x-3">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        <span id="error-message" class="font-medium"></span>
    </div>
</div>

<!-- Sidebar -->
<c:set var="currentPage" value="department" scope="request" />
<%@ include file="./../component/sidebar.jsp" %>

<!-- Main Content -->
<div class="ml-64">
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
        <div class="flex items-center justify-between px-8 py-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Departments</h1>
                <p class="text-sm text-gray-600 dark:text-gray-400">Manage hospital departments</p>
            </div>
            <div class="flex items-center space-x-4">
                <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-400 dark:hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
                    </svg>
                    <svg class="w-5 h-5 text-yellow-400 hidden dark:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                </button>
                <span class="text-sm text-gray-600 dark:text-gray-400">
                    <jsp:useBean id="now" class="java.util.Date"/>
                    <fmt:formatDate value="${now}" pattern="MMM dd, yyyy - hh:mm a"/>
                </span>
            </div>
        </div>
    </header>

    <main class="p-8">
        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-3xl p-6 text-white shadow-lg">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-4xl font-bold">${fn:length(departments)}</p>
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                        </svg>
                    </div>
                </div>
                <p class="text-blue-100 text-sm">Total Departments</p>
            </div>
            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-3xl p-6 text-white shadow-lg">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-4xl font-bold">
                        <c:set var="activeCount" value="0"/>
                        <c:forEach var="dep" items="${departments}">
                            <c:if test="${dep.active}">
                                <c:set var="activeCount" value="${activeCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${activeCount}
                    </p>
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
                <p class="text-green-100 text-sm">Active</p>
            </div>
            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-3xl p-6 text-white shadow-lg">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-4xl font-bold">156</p>
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                </div>
                <p class="text-purple-100 text-sm">Total Staff</p>
            </div>
            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-3xl p-6 text-white shadow-lg">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-4xl font-bold">24</p>
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                    </div>
                </div>
                <p class="text-orange-100 text-sm">Avg Beds</p>
            </div>
        </div>

        <!-- Search & Add -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-6">
            <div class="flex flex-col sm:flex-row gap-4">
                <div class="flex-1 relative">
                    <input type="text" id="searchInput" placeholder="Search departments..."
                           class="w-full px-4 py-3 pl-10 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white">
                    <svg class="w-5 h-5 absolute left-3 top-3.5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <button onclick="openModal('add-modal')" class="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-xl hover:from-blue-700 hover:to-blue-800 font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-200">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    Add Department
                </button>
            </div>
        </div>

        <!-- Departments Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="dep" items="${departments}">
                <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 hover:shadow-lg transition duration-200">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-bold text-gray-900 dark:text-white">${dep.name}</h3>
                        <c:choose>
                            <c:when test="${dep.active}">
                                <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs font-semibold">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs font-semibold">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4 line-clamp-2">${dep.description}</p>
                    <div class="flex space-x-2 mt-4">
                        <button onclick="editDept(${dep.id}, '${fn:escapeXml(dep.name)}', '${fn:escapeXml(dep.description)}')"
                                class="flex-1 px-4 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm font-medium hover:bg-blue-100 dark:hover:bg-blue-900/40 transition duration-200">
                            Edit
                        </button>


                            <c:choose>
                                <c:when test="${dep.active}">
                                    <form action="${pageContext.request.contextPath}/admin/departments" method="post">
                                        <input type="hidden" name="action" value="toggleActive"/>
                                        <input type="hidden" name="id" value="${dep.id}" />
                                        <input type="hidden" name="isActive" value="false" />
                                        <button type="submit" class="text-500-red bg-50-red">Deactivate</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/departments" method="post">
                                        <input type="hidden" name="action" value="toggleActive"/>
                                        <input type="hidden" name="id" value="${dep.id}" />
                                        <input type="hidden" name="isActive" value="true" />
                                        <button type="submit" class="text-500-green bg-50-green">Activate</button>
                                    </form>
                                </c:otherwise>

                            </c:choose>

                        <button onclick="deleteDept(${dep.id})"
                                class="px-4 py-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm font-medium hover:bg-red-100 dark:hover:bg-red-900/40 transition duration-200">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <!-- Add New Card -->
            <div onclick="openModal('add-modal')"
                 class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border-2 border-dashed border-gray-300 dark:border-gray-600 p-6 hover:border-blue-400 dark:hover:border-blue-500 cursor-pointer transition duration-200">
                <div class="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400">
                    <div class="w-16 h-16 bg-gray-100 dark:bg-gray-700 rounded-2xl flex items-center justify-center mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                    </div>
                    <p class="font-medium">Add New Department</p>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Add Modal -->
<div id="add-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 shadow-2xl">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white">Add Department</h2>
            <button onclick="closeModal('add-modal')" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 transition duration-200">
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <!-- Server-side validation errors -->
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

        <form id="add-form" action="${pageContext.request.contextPath}/admin/departments" method="post" class="space-y-4" onsubmit="return validateForm('add-form')">
            <input type="hidden" name="action" value="add">

            <div>
                <label for="add-name" class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">Department Name *</label>
                <input type="text" id="add-name" name="name" value="${oldName}" required
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition duration-200"
                       placeholder="Enter department name">
            </div>

            <div>
                <label for="add-description" class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">Description</label>
                <textarea id="add-description" name="description" rows="4"
                          class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition duration-200 resize-none"
                          placeholder="Enter department description">${oldDescription}</textarea>
            </div>

            <div class="flex space-x-4 pt-4">
                <button type="button" onclick="closeModal('add-modal')"
                        class="flex-1 px-4 py-3 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold hover:bg-gray-200 dark:hover:bg-gray-600 transition duration-200">
                    Cancel
                </button>
                <button type="submit"
                        class="flex-1 px-4 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-xl font-semibold hover:from-blue-700 hover:to-blue-800 shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-200">
                    Add Department
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 shadow-2xl">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white">Edit Department</h2>
            <button onclick="closeModal('edit-modal')" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 transition duration-200">
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <form id="edit-form" action="${pageContext.request.contextPath}/admin/departments" method="post" class="space-y-4" onsubmit="return validateForm('edit-form')">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="edit-id" name="id">

            <div>
                <label for="edit-name" class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">Department Name *</label>
                <input type="text" id="edit-name" name="name" required
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition duration-200">
            </div>

            <div>
                <label for="edit-description" class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">Description</label>
                <textarea id="edit-description" name="description" rows="4"
                          class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition duration-200 resize-none"></textarea>
            </div>

            <div class="flex space-x-4 pt-4">
                <button type="button" onclick="closeModal('edit-modal')"
                        class="flex-1 px-4 py-3 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold hover:bg-gray-200 dark:hover:bg-gray-600 transition duration-200">
                    Cancel
                </button>
                <button type="submit"
                        class="flex-1 px-4 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-xl font-semibold hover:from-blue-700 hover:to-blue-800 shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-200">
                    Update Department
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Modal -->
<div id="delete-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6 shadow-2xl">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-bold text-red-600 dark:text-red-500">Delete Department</h2>
            <button onclick="closeModal('delete-modal')" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 transition duration-200">
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <div class="mb-6">
            <div class="w-16 h-16 bg-red-100 dark:bg-red-900/20 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                </svg>
            </div>
            <p class="text-gray-600 dark:text-gray-400 text-center mb-2">
                Are you sure you want to delete
                <span id="delete-name" class="font-semibold text-gray-900 dark:text-white"></span>?
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-500 text-center">
                This action cannot be undone.
            </p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/departments" method="post" class="flex space-x-4">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" id="delete-id" name="id">
            <button type="button" onclick="closeModal('delete-modal')"
                    class="flex-1 px-4 py-3 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl font-semibold hover:bg-gray-200 dark:hover:bg-gray-600 transition duration-200">
                Cancel
            </button>
            <button type="submit"
                    class="flex-1 px-4 py-3 bg-red-600 text-white rounded-xl font-semibold hover:bg-red-700 shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-200">
                Delete Department
            </button>
        </form>
    </div>
</div>

</body>
</html>