<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Streamers</title>
    <link rel="icon" href="Media/Images/CoughingCatIcon.png">
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
</head>

<body>
    <h1>List of Streamers</h1>
    <ul>
        <?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "streamerStat";

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Check if a specific streamer is being searched for
        if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
            $streamer = $conn->real_escape_string($_GET['streamer']);
            $sql = "SELECT * FROM streamers WHERE name LIKE '%$streamer%'";
            echo "Searching for Streamer: " . htmlspecialchars($streamer) . "<br><br>";
        } else {
            // Display all streamers without their website initially
            $sql = "SELECT * FROM streamers";
        }

        $result = $conn->query($sql);

        if (!$result) {
            die("Error executing query: " . $conn->error);
        }

        if ($result->num_rows > 0) {
            // Output data of each row
            while ($row = $result->fetch_assoc()) {
                echo "<li>Streamer: " . htmlspecialchars($row["name"]);

                if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
                    // Display website link only if a specific streamer is searched
                    if (!empty($row["website"])) {
                        $website = htmlspecialchars($row["website"]);

                        // Determine the platform type
                        $platform = "Website";
                        if (strpos($website, 'twitch.tv') !== false) {
                            $platform = "Twitch";
                        } elseif (strpos($website, 'youtube.com') !== false || strpos($website, 'youtu.be') !== false) {
                            $platform = "YouTube";
                        } elseif (strpos($website, 'twitter.com') !== false) {
                            $platform = "Twitter";
                        } elseif (strpos($website, 'facebook.com') !== false) {
                            $platform = "Facebook";
                        } elseif (strpos($website, 'trovo.com') !== false) {
                            $platform = "Trovo";
                        }

                        // Display the platform and link
                        echo "<br> $platform: <a href='" . $website . "' target='_blank'>" . $website . "</a>";
                    } else {
                        echo "<br> No website.";
                    }
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
</body>

</html>