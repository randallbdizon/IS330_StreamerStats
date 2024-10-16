<style>
    body {
        background-image: url('coughing_cat.png');
        background-size: contain;
    }
</style>

<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "streamerStat";

//Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

//Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT name FROM streamers";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    //Output data of each row
    while ($row = $result->fetch_assoc()) {
        echo "Streamer: " . $row["name"] . "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();

for ($i = 0; $i < 100; $i++) {
    echo "<p>This is a paragraph</p>";
}
?>