<style>
    body {
        font-family: 'Comic Sans MS';
        color: white;
        background-image: url('coughing_cat.png');
        background-size: contain;
    }
</style>
<h1>List of HoloLive EN Streamers</h1>
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

    $sql = "SELECT name FROM streamers";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        //Output data of each row
        while ($row = $result->fetch_assoc()) {
            echo "<li>" . "Streamer: " . $row["name"];
        }
    } else {
        echo "0 results";
    }
    $conn->close();
    ?>
</ul>
<label>Code:</label>
<input type="text" name="code" value="<?php echo htmlspecialchars(
    $product['productCode']
); ?>"><br>