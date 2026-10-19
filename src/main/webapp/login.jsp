<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | Mana Ruchi</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        background: linear-gradient(135deg, #fff3e8, #ffe0cc);
    }

    .login-container {
        width: 100%;
        max-width: 420px;
        padding: 38px 32px;
        background: #ffffff;
        border-radius: 18px;
        box-shadow: 0 12px 35px rgba(80, 40, 15, 0.14);
    }

    .brand {
        text-align: center;
        margin-bottom: 28px;
    }

    .brand h1 {
        color: #e85d04;
        font-size: 32px;
        margin-bottom: 8px;
    }

    .brand p {
        color: #777;
        font-size: 14px;
    }

    .login-container h2 {
        text-align: center;
        color: #292929;
        margin-bottom: 25px;
        font-size: 23px;
    }

    .form-group {
        margin-bottom: 19px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-size: 14px;
        font-weight: bold;
    }

    input {
        width: 100%;
        padding: 13px 14px;
        border: 1px solid #ddd;
        border-radius: 9px;
        font-size: 15px;
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    input:focus {
        border-color: #e85d04;
        box-shadow: 0 0 0 3px rgba(232, 93, 4, 0.12);
    }

    .login-btn {
        width: 100%;
        padding: 14px;
        margin-top: 8px;
        border: none;
        border-radius: 9px;
        background: #e85d04;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s, transform 0.2s;
    }

    .login-btn:hover {
        background: #c94d00;
        transform: translateY(-1px);
    }

    .error-message {
        margin-bottom: 18px;
        padding: 11px;
        background: #fff0f0;
        color: #c62828;
        border-radius: 8px;
        text-align: center;
        font-size: 14px;
    }

    .success-message {
        margin-bottom: 18px;
        padding: 11px;
        background: #eaf8ee;
        color: #24743b;
        border-radius: 8px;
        text-align: center;
        font-size: 14px;
    }

    .back-home {
        display: block;
        text-align: center;
        margin-top: 22px;
        color: #e85d04;
        text-decoration: none;
        font-size: 14px;
    }

    .back-home:hover {
        text-decoration: underline;
    }

    @media (max-width: 480px) {
        .login-container {
            padding: 30px 22px;
        }

        .brand h1 {
            font-size: 28px;
        }
    }
</style>
</head>

<body>

<div class="login-container">

    <div class="brand">
        <h1>Mana Ruchi</h1>
        <p>Delicious food, delivered to you.</p>
    </div>

    <h2>Welcome Back!</h2>

    <% if ("invalid".equals(request.getParameter("error"))) { %>
        <div class="error-message">
            Invalid email or password. Please try again.
        </div>
    <% } %>

    <% if ("failed".equals(request.getParameter("error"))) { %>
        <div class="error-message">
            Something went wrong. Please try again.
        </div>
    <% } %>

    <% if ("registered".equals(request.getParameter("success"))) { %>
        <div class="success-message">
            Registration successful! Please log in.
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login"
          method="post">

        <div class="form-group">
            <label for="email">Email Address</label>
            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                autocomplete="email"
                required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                autocomplete="current-password"
                required>
        </div>

        <button type="submit" class="login-btn">
            Login
        </button>

    </form>

    <a class="back-home"
       href="<%= request.getContextPath() %>/home.jsp">
        &#8592; Back to Home
    </a>

</div>

</body>
</html>