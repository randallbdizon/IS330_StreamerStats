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

    $sql = "SELECT * FROM streamers";

    if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
        $streamer = $conn->real_escape_string($_GET['streamer']);
        $sql = "SELECT * FROM streamers WHERE name LIKE '%$streamer%'";
        echo "Searching for Streamer: " . htmlspecialchars($streamer) . "<br><br>";
    }

    $result = $conn->query($sql);

    if (!$result) {
        die("Error executing query: " . $conn->error);
    }

    if ($result->num_rows > 0) {
        //Output data of each row
        while ($row = $result->fetch_assoc()) {
            echo "<li>Streamer: " . htmlspecialchars($row["name"]);
            if (!empty($row["website"])) {
                echo "<br> Website: <a href='" . htmlspecialchars($row["website"]) . "' target='_blank'>" . htmlspecialchars($row["website"]) . "</a>";
            } else {
                echo "<br> No website.";
            }
            echo "</li>";
        }
    } else {
        echo "0 results";
    }
    $conn->close();
    ?>
</ul>

<!-- Streamer ID search -->
<form method="GET" action="">
    <label for="streamer">Streamer Name:</label>
    <input type="text" name="streamer" value="">
    <input type="submit" value="Search">
</form>
