<?php
// db_connection.php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "streamer_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
