<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode(["status" => "error", "message" => "Data kosong"]);
    exit;
}

// Siapkan Query "ON DUPLICATE KEY UPDATE"
$sql = "INSERT INTO dinos 
    (id, name, diet, period, family, formation_name, description, image_url, height, length, weight, is_primary) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
    name=VALUES(name), diet=VALUES(diet), period=VALUES(period), family=VALUES(family), 
    formation_name=VALUES(formation_name), description=VALUES(description), image_url=VALUES(image_url),
    height=VALUES(height), length=VALUES(length), weight=VALUES(weight), is_primary=VALUES(is_primary)";

$stmt = $conn->prepare($sql);

$primary = $data['isPrimary'] ? 1 : 0;
$h = floatval($data['height']);
$l = floatval($data['length']);
$w = floatval($data['weight']);

$stmt->bind_param("ssssssssdddi", 
    $data['id'], $data['name'], $data['diet'], $data['period'], $data['family'], 
    $data['formationName'], $data['description'], $data['imageUrl'], 
    $h, $l, $w, $primary
);

if ($stmt->execute()) {
    echo json_encode(["status" => "success"]);
} else {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $stmt->error]);
}
?>