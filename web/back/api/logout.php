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

$_SESSION['user'] = null;

echo json_encode([
    "ok" => true,
    "message" => "user logout successfully"
]);
