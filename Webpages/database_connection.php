<?php
// database_connection.php

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

// Enable autocommit to ensure changes are saved permanently
$conn->autocommit(TRUE);
?>
