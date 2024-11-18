<?php
// Starting session
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "streamer_db";
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

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

// Get user information from database
$username = $_SESSION['username'];
$sql = "SELECT * FROM logins WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    
    // Check if user is an admin
    if ($user['admin'] != 1) {
        echo "<p>You do not have permission to access this page.</p>";
        exit;
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
            // Insert file details into database
            $sql = "INSERT INTO projects (project_name, description, created_at, project_image_path) VALUES (?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
    
            if (!$stmt) {
                die("Prepare failed: " . $conn->error);
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Upload Page</title>
</head>
<body>
<h2>Upload File</h2>
<form action="" method="post" enctype="multipart/form-data">
    <label for="title">Title:</label>
    <input type="text" name="title" id="title" required><br><br>
    
    <label for="description">Description:</label><br>
    <textarea name="description" id="description" rows="4" cols="50" required></textarea><br><br>

    <label for="file">Select file to upload:</label>
    <input type="file" name="file" id="file" required><br><br>

    <input type="submit" value="Upload File" name="submit">
</form>
</body>
</html>
