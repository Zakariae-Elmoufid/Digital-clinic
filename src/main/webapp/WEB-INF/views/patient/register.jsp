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
        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <!-- Column 1 -->
                <div class="space-y-4">
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Full Name</label>
                        <input type="text" name="fullName" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Email</label>
                        <input type="email" name="email" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Phone</label>
                        <input type="text" name="phone" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none">
                    </div>

                    <div>
                        <label class="block text-gray-700 mb-2 font-medium">CIN</label>
                        <input type="text" name="cin"
                               class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 focus:outline-none transition"
                               placeholder="Enter your CIN" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 mb-2 font-medium">Insurance Number</label>
                        <input type="text" name="insuranceNumber"
                               class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 focus:outline-none transition"
                               placeholder="Enter your insurance number" required>
                    </div>
                </div>

                <!-- Column 2 -->
                <div class="space-y-4">
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Password</label>
                        <input type="password" name="password" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none" required>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Date of Birth</label>
                        <input type="date" name="dob" class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-400 focus:outline-none">
                    </div>

                    <!-- Gender -->
                    <div>
                        <label class="block text-gray-700 mb-2 font-medium">Gender</label>
                        <select name="gender"
                                class="w-full border border-gray-300 rounded-lg px-4 py-2.5 bg-white focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 focus:outline-none transition">
                            <option value="" disabled selected>Select gender</option>
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                        </select>
                    </div>

                    <!-- Blood Type -->
                    <div>
                        <label class="block text-gray-700 mb-2 font-medium">Blood Type</label>
                        <select name="blood"
                                class="w-full border border-gray-300 rounded-lg px-4 py-2.5 bg-white focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 focus:outline-none transition">
                            <option value="" disabled selected>Select blood type</option>
                            <option value="A_POSITIVE">A+</option>
                            <option value="A_NEGATIVE">A-</option>
                            <option value="B_POSITIVE">B+</option>
                            <option value="B_NEGATIVE">B-</option>
                            <option value="AB_POSITIVE">AB+</option>
                            <option value="AB_NEGATIVE">AB-</option>
                            <option value="O_POSITIVE">O+</option>
                            <option value="O_NEGATIVE">O-</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="mt-8 text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3 px-8 rounded-lg transition duration-200">Register</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.querySelector("form").addEventListener("submit", function(e){
        let password = this.password.value;
        let confirm = this.confirmPassword.value;
        if(password !== confirm){
            e.preventDefault();
            alert("Passwords do not match!");
        }
    });
</script>
</body>
</html>