<?php
// required headers
session_start();
ini_set('display_errors', true);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

// include database and object files
include_once 'config/database.php';
include_once 'objects/post.php';


if (empty($_SESSION['user'])) {
    echo json_encode([
        "ok" => false,
        "message" => "You should login first"
    ]);
    exit();
}

$database = new Database();
$posts = new Post($database->getConnection());
$inputData = file_get_contents('php://input');
$data = json_decode($inputData, TRUE);
$author = $_SESSION['user']["id"];
$title = $data['title'];
$content = $data['content'];

$result = $posts->insertPost($author, $title, $content);

if ($result) {
    echo json_encode([
        "ok" => true,
        "message" => "Post saved successfully"
    ]);
} else {
    echo json_encode([
        "ok" => false,
        "message" => "Post failed"
    ]);
}
