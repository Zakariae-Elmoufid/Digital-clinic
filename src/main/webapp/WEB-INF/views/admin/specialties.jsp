<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specialties - Digital Clinic</title>
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
        function editSpecialty(id, name, description , nameDep ,idDep) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-department').innerHTML = nameDep ;
            document.getElementById('edit-department').value = idDep;
            document.getElementById('edit-description').value = description || '';
            openModal('edit-modal');
        }
        function deleteSpecialty(id, name) {
            document.getElementById('delete-id').value = id;
            document.getElementById('delete-name').textContent = name;
            openModal('delete-modal');
        }
        document.addEventListener('DOMContentLoaded', initDarkMode);
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">
<!-- Sidebar -->
<c:set var="currentPage" value="specialtie" scope="request" />
<%@ include file="./../component/sidebar.jsp" %>

<!-- Main Content -->
<div class="ml-64">
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-40">
        <div class="flex items-center justify-between px-8 py-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Specialties</h1>
                <p class="text-sm text-gray-600 dark:text-gray-400">Manage medical specialties for departments</p>
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
                <span class="text-sm text-gray-600 dark:text-gray-400"><fmt:formatDate value="${now}" pattern="MMM dd, yyyy - HH:mm"/></span>
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

        <!-- Add & Search -->
        <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6 mb-6 flex justify-between items-center">
            <input type="text" placeholder="Search specialties..." class="flex-1 px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl mr-4 focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
            <button onclick="openModal('add-modal')" class="px-6 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 flex items-center">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                </svg>
                Add Specialty
            </button>
        </div>

        <!-- Specialties Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
             <c:forEach var="spec" items="${specialties}">
                <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-700 p-6">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-2">${spec.name}</h3>
                        <c:choose>
                            <c:when test="${spec.active}">
                                <span class="px-3 py-1 bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded-full text-xs">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-3 py-1 bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-300 rounded-full text-xs">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
                        <c:choose>
                            <c:when test="${not empty spec.description}">
                                ${spec.description}
                            </c:when>
                            <c:otherwise>
                                No description provided
                            </c:otherwise>
                        </c:choose>
                    </p>
<%--                    <div class="text-xs text-gray-500 dark:text-gray-400 mb-4">--%>
<%--                        Created: <fmt:formatDate value="${spec.createdAt}" pattern="MMM dd, yyyy"/>--%>
<%--                    </div>--%>
                    <div class="flex space-x-2">
                        <button onclick="editSpecialty(${spec.id}, '${fn:escapeXml(spec.name)}', '${fn:escapeXml(spec.description)}' ,'${fn:escapeXml(spec.departmentName)}','${fn:escapeXml(spec.depaId)}')"
                                class="flex-1 px-3 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl text-sm hover:bg-blue-100">
                            Edit
                        </button>
                        <button onclick="deleteSpecialty(${spec.id}, '${fn:escapeXml(spec.name)}')"
                                class="px-3 py-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm hover:bg-red-100">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <div onclick="openModal('add-modal')" class="bg-white dark:bg-gray-800 rounded-3xl shadow-sm border-2 border-dashed border-gray-300 dark:border-gray-600 p-6 hover:border-blue-400 cursor-pointer">
                <div class="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400">
                    <div class="w-16 h-16 bg-gray-100 dark:bg-gray-700 rounded-2xl flex items-center justify-center mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                    </div>
                    <p class="font-medium">Add Specialty</p>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Add Modal -->
<div id="add-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Add Specialty</h2>
                <button onclick="closeModal('add-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/specialties" method="post" class="space-y-4">
                <input type="hidden" name="action" value="add">
                <input type="text" name="name" required
                       class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                       placeholder="Specialty Name">
                <textarea name="description" rows="3"
                          class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
                          placeholder="Description..."></textarea>
                <label for="departmentId">Department:</label>
                <select name="departmentId" id="departmentId" required>
                    <option value="">-- Select Department --</option>
                    <c:forEach var="dep" items="${departments}">
                        <option value="${dep.id}"
                            ${dep.id == oldDepartmentId ? 'selected' : ''}>
                                ${dep.name}
                        </option>
                    </c:forEach>
                </select>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('add-modal')"
                            class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit"
                            class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Add</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white dark:bg-gray-800 rounded-3xl max-w-md w-full p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 dark:text-white">Edit Specialty</h2>
                <button onclick="closeModal('edit-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/specialties" method="post" class="space-y-4">
                <input type="hidden" name="action" value="update">
                <input type="" id="edit-id" name="id">
                <input type="text" id="edit-name" name="name" required
                       class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white">
                <textarea id="edit-description" name="description" rows="3"
                          class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-xl focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"></textarea>
                <label for="departmentId">Department:</label>
                <select name="departmentId" id="departmentId" required>
                    <option selected  id="edit-department"> </option>
                    <option value="">-- Select Department --</option>
                    <c:forEach var="dep" items="${departments}">
                    <option value="${dep.id}"
                        ${dep.id == oldDepartmentId ? 'selected' : ''}>
                            ${dep.name}
                    </option>
                    </c:forEach>
                </select>
                <div class="flex space-x-4">
                    <button type="button" onclick="closeModal('edit-modal')"
                            class="flex-1 px-4 py-2 bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-xl">Cancel</button>
                    <button type="submit"
                            class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700">Update</button>
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
                <h2 class="text-xl font-bold text-red-600">Delete Specialty</h2>
                <button onclick="closeModal('delete-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">✕</button>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
                Are you sure you want to delete <span id="delete-name" class="font-semibold"></span>?
            </p>
            <form action="${pageContext.request.contextPath}/admin/specialties" method="post" class="flex space-x-4">
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