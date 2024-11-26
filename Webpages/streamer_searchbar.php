<form id="search-form" method="GET" action="">
    <label for="streamer">Streamer search:</label>
    <input type="text" name="streamer" value="">
    <input type="submit" value="Search">
</form>

<ul>
    <?php
    include 'db_connection.php';
    // Check if a specific streamer is being searched for
    if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
        $streamer = $connection->real_escape_string($_GET['streamer']);
        $sql = "SELECT * FROM streamers WHERE name LIKE '%$streamer%'";
        echo "Searching for Streamer: " . htmlspecialchars($streamer) . "<br><br>";
    } else {
        // Display all streamers without their website initially
        $sql = "SELECT * FROM streamers";
    }

    $result = $connection->query($sql);

    if (!$result) {
        die("Error executing query: " . $connection->error);
    }

    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            echo "<h2>" . htmlspecialchars($row["name"]);

            if (isset($_GET['streamer']) && !empty($_GET['streamer'])) {
                // Display website link only if a specific streamer is searched
                if (!empty($row["website"])) {
                    $website = htmlspecialchars($row["website"]);

                    // Determine the platform type and replace link text with an image
                    $platformImage = "../Media/Images/Website.png"; // Default image if platform isn't matched
    
                    if (strpos($website, 'twitch.tv') !== false) {
                        $platformImage = "../Media/Images/Twitch.png";
                    } elseif (strpos($website, 'youtube.com') !== false || strpos($website, 'youtu.be') !== false) {
                        $platformImage = "../Media/Images/Youtube.png";
                    } elseif (strpos($website, 'twitter.com') !== false) {
                        $platformImage = "../Media/Images/Twitter.png";
                    } elseif (strpos($website, 'facebook.com') !== false) {
                        $platformImage = "../Media/Images/Facebook.png";
                    } elseif (strpos($website, 'trovo.com') !== false) {
                        $platformImage = "../Media/Images/Trovo.png";
                    }

                    // Display the platform image as a clickable link
                    echo "<br> <a href='" . $website . "'><img src='" . $platformImage . "' alt='Platform' class='platform-icon'></a>";
                } else {
                    echo "<br> No website.";
                }
            }

            echo "</h2>";
        }
    } else {
        echo "0 results";
    }

    $connection->close();
    ?>
</ul>