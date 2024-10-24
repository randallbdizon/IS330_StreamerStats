<style>
    body {
        font-family: 'Comic Sans MS';
        color: white;
        background-image: url('coughing_cat.png');
        background-size: contain;
    }
</style>
<h1>List of Streamers</h1>
<ul>
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

    $sql = "SELECT name, streamer_ID FROM streamers";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        //Output data of each row
        while ($row = $result->fetch_assoc()) {
            echo "<li>Streamer: " . htmlspecialchars($row["name"]) . "</li>";
        }
    } else {
        echo "0 results";
    }
    $conn->close();
    ?>
</ul>

<!-- Streamer ID search -->
<form method="GET" action="">
    <label for="streamer">Streamer ID:</label>
    <input type="text" name="streamer" value="">
    <input type="submit" value="Search">
</form>
<?php
// Check if a streamer code was entered
if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
    $streamer_id = htmlspecialchars($_GET['streamer']);
    echo "Searching for Streamer ID: " . $streamer_id;

    // Perform a query based on the entered streamer ID if needed
    // Add SQL here to retrieve and display relevant streamer data
}
?>
