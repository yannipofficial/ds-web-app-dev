<?php 
ini_set('display_errors', true);
error_reporting(E_ALL);
require('config/database.php');
require('objects/post.php');

$database = new Database();
$posts = new Post($database->getConnection());

$postsList = $posts->getPostAuthors();
echo json_encode($postsList);
