<?php
// Database connection details
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "streamer_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// HTML Form for creating account
echo '<form method="POST" action="">
        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username"><br>
        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Create Account">
    </form>';

// Insert user into the database if form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = $_POST['username'];
    $pass = password_hash($_POST['password'], PASSWORD_DEFAULT); // Hash the password for security

    // SQL to insert the user
    $sql = "INSERT INTO logins (username, password) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    
    if ($stmt) {
        $stmt->bind_param("ss", $user, $pass);
        
        if ($stmt->execute()) {
            echo "New account created successfully";
        } else {
            echo "Error: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Error preparing statement: " . $conn->error;
    }
}

$conn->close();
?>
