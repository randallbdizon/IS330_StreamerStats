<?php
// Starting session
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// db_connection.php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "streamer_db";

$connection = new mysqli($servername, $username, $password, $dbname);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}
?>
