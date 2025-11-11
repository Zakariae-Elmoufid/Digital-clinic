<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen py-8 px-4">

<div class="max-w-4xl mx-auto">
    <h2 class="text-3xl font-bold text-center text-indigo-600 mb-8">Patient Registration</h2>

    <c:if test="${not empty errors}">
        <div class="bg-red-100 text-red-700 p-3 rounded-lg mb-4">
            <ul class="list-disc list-inside">
                <c:forEach var="error" items="${errors}">
                    <li>${error.value}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="bg-green-100 text-green-700 p-3 rounded-lg mb-4">${success}</div>
    </c:if>

    <div class="bg-white rounded-lg shadow-lg p-8">
        <form action="${pageContext.request.contextPath}/login" method="post">


                <div class="space-y-4">
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Email</label>
                        <input type="email" name="email" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Password</label>
                        <input type="password" name="password" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

            <div class="mt-8 text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3 px-8 rounded-lg transition duration-200">Register</button>
            </div>
        </form>
    </div>
</div>


</body>
</html>