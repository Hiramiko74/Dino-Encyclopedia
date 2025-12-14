<?php
$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'dino_db';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(["status" => "error", "message" => "Koneksi Gagal"]));
}

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
?>