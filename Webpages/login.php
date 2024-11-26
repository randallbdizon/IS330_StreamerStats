<?php
include 'db_connection.php';
// Enable autocommit to ensure changes are saved permanently
$connection->autocommit(TRUE);

// Add a div with a class to wrap login/logout forms for styling
echo '<div class="auth-container">';

// Check if user is logged in
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    // If logged in, show logout button
    echo '<form method="POST" action="">
            <input type="submit" name="logout" value="Logout">
          </form>';
} else {
    // If not logged in, show login and registration forms
    echo '<div id="forms-container">
            <form id="login-form" method="POST" action="">
                <p>Login</p>
                <label for="login-username" style="font-size: 16px;">Username:</label><br>
                <input type="text" id="login-username" name="login-username" required><br>
                <label for="login-password" style="font-size: 16px;">Password:</label><br>
                <input type="password" id="login-password" name="login-password" required><br><br>
                <input type="submit" name="login" value="Login">
            </form>

            <form id="register-form" method="POST" action="" style="display:none;">
                <p>Create Account</p>
                <label for="username" style="font-size: 16px;">Username:</label><br>
                <input type="text" id="username" name="username" required><br>
                
                <label for="password" style="font-size: 16px;">Password:</label><br>
                <input type="password" id="password" name="password" required><br>
                
                <label for="confirm-password" style="font-size: 16px;">Confirm Password:</label><br>
                <input type="password" id="confirm-password" name="confirm-password" required><br><br>
                
                <input type="submit" name="register" value="Create Account">
            </form>

            <button onclick="toggleForms()">Switch to Login/Create Account</button>
        </div>';

    echo '<script>
        function toggleForms() {
            const loginForm = document.getElementById("login-form");
            const registerForm = document.getElementById("register-form");
            if (loginForm.style.display === "none") {
                loginForm.style.display = "block";
                registerForm.style.display = "none";
            } else {
                loginForm.style.display = "none";
                registerForm.style.display = "block";
            }
        }
    </script>';
}

echo '</div>'; // Close the auth-container div

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['register'])) {
        // Registration process
        $user = $_POST['username'];
        $pass = $_POST['password'];
        $confirm_pass = $_POST['confirm-password'];

        // Check if passwords match
        if ($pass === $confirm_pass) {
            // Hash the password for security
            $hashed_pass = password_hash($pass, PASSWORD_DEFAULT);

            // SQL to insert the user
            $sql = "INSERT INTO logins (username, password) VALUES ('$user', '$hashed_pass')";

            if ($connection->query($sql) === TRUE) {
                echo "Account created successfully!";
            } else {
                echo "Error creating account: " . $connection->error;
            }
        } else {
            echo "Passwords do not match. Please try again.";
        }
    } elseif (isset($_POST['login'])) {
        // Login process
        $user = $_POST['login-username'];
        $pass = $_POST['login-password'];

        // SQL to check user credentials
        $sql = "SELECT password FROM logins WHERE username='$user'";
        $result = $connection->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if (password_verify($pass, $row['password'])) {
                $_SESSION['loggedin'] = true;
                $_SESSION['username'] = $user;

                // Redirect to another page after successful login
                header("Location: Webpages/home.php");
                exit();
            } else {
                echo "Invalid password.";
            }
        } else {
            echo "No account found with that username.";
        }
    } elseif (isset($_POST['logout'])) {
        // Logout process
        session_unset(); // Unset all session variables
        session_destroy(); // Destroy the session

        // Redirect to index.php after successful logout
        header("Location: ../index.php");
        exit();
    }
}

// Close the database connection
$connection->close();
?>
