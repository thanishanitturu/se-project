<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <form method="post" action="login">
            <input type="text" name="txtName" placeholder="Username" required>
            <input type="password" name="txtPwd" placeholder="Password" required>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>