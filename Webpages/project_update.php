
<?php
// Include the database connection
include 'db_connection.php';  // Make sure this is correctly pointing to your database connection file

// Regenerate session ID to prevent fixation attacks
if (!isset($_SESSION['regenerated'])) {
    session_regenerate_id();
    $_SESSION['regenerated'] = true;
}

// Check if user is logged in
if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    echo "<p>You must be logged in to access this page.</p>";
    exit;
}

// Get user information from the database
$username = $_SESSION['username'];
$sql = "SELECT * FROM logins WHERE username = ?";
$stmt = $connection->prepare($sql); // Changed to $connection for consistency
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    // Check if user is an admin
    if ($user['admin'] === 1) {
        echo '<h2>Upload File</h2>
                <form action="" method="post" enctype="multipart/form-data">
                    <label for="title">Title:</label>
                    <input type="text" name="title" id="title" required><br><br>
    
                    <label for="description">Description:</label><br>
                    <textarea name="description" id="description" rows="4" cols="50" required></textarea><br><br>

                    <label for="file">Select file to upload:</label>
                    <input type="file" name="file" id="file" required><br><br>

                    <input type="submit" value="Upload File" name="submit">
                </form>';
    }
} else {
    echo "<p>Invalid user.</p>";
    exit;
}

// File upload logic
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = $_POST['title'];
    $description = $_POST['description'];
    $upload_date = date('Y-m-d');

    // File details
    $target_dir = "../Media/Uploads/";
    $target_file = $target_dir . basename($_FILES["file"]["name"]);
    $uploadOk = 1;
    $fileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

    // Check if file already exists
    if (file_exists($target_file)) {
        echo "<p>Sorry, file already exists.</p>";
        $uploadOk = 0;
    }

    // Allow certain file formats
    if ($fileType != "jpg" && $fileType != "png" && $fileType != "jpeg" && $fileType != "pdf" && $fileType != "docx") {
        echo "<p>Sorry, only JPG, JPEG, PNG, PDF & DOCX files are allowed.</p>";
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        echo "<p>Sorry, your file was not uploaded.</p>";
    } else {
        if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
            // Insert file details into the database
            $sql = "INSERT INTO projects (project_name, description, created_at, project_image_path) VALUES (?, ?, ?, ?)";
            $stmt = $connection->prepare($sql); // Changed to $connection

            if (!$stmt) {
                die("Prepare failed: " . $connection->error); // Changed to $connection
            }

            // Assuming the variables are renamed accordingly
            $project_name = $title;  // Rename your variable to match the column
            $created_at = $upload_date; // Optional: omit if using the default timestamp
            $project_image_path = $target_file;

            $stmt->bind_param("ssss", $project_name, $description, $created_at, $project_image_path);

            if ($stmt->execute()) {
                echo "<p>The file " . htmlspecialchars(basename($_FILES["file"]["name"])) . " has been uploaded successfully.</p>";
            } else {
                echo "<p>Sorry, there was an error uploading your file to the database: " . $stmt->error . "</p>";
            }
        } else {
            echo "<p>Sorry, there was an error uploading your file.</p>";
        }
    }
}
?>

<body>



<h1>Project Updates</h1>

<?php
// Write the query to select all projects
$query = "SELECT * FROM projects";
$result = mysqli_query($connection, $query); // Changed to $connection

// Check if the query was successful
if (!$result) {
    die("Query failed: " . mysqli_error($connection)); // Changed to $connection
}

// Loop through the results and display the projects
while ($row = mysqli_fetch_assoc($result)) {
    echo "<section>";
    echo "<div class='project'>";
    echo "<h2>" . htmlspecialchars($row['project_name']) . "</h2>";
    echo "<p>" . htmlspecialchars($row['description']) . "</p>";
    echo "</section>";
    echo "<aside>";
    if (!empty($row['project_image_path'])) {
        echo "<img src='" . htmlspecialchars($row['project_image_path']) . "' alt='Project Image'>";
    }
    echo "</div>";
    echo "</aside>";
}
?>

</body>
