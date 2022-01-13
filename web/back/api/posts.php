<?php
// required headers
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
$database = new Database();
$posts = new Post($database->getConnection());
$author = !empty($_GET['id']) ? $_GET['id'] : null;
$postsList = $posts->getPosts($author);
echo json_encode($postsList);
