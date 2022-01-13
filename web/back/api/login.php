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
include_once 'objects/user.php';

$database = new Database();
$user = new User($database->getConnection());
$inputData = file_get_contents('php://input');
$data = json_decode($inputData, TRUE);
$username = $data['username'];
$password = $data['password'];

$result = $user->find($username, $password);

if ($result) {
    
    $_SESSION['user']['id'] = $result[0]["id"];
    $_SESSION['user']['username'] = $result[0]["username"];
    echo json_encode([
        "ok" => true,
        "message" => "user login successfully",
        "username" => $result[0]["username"]
    ]);
} else {
    echo json_encode([
        "ok" => false,
        "message" => "login failed"
    ]);
}
