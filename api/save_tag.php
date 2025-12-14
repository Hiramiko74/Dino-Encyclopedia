<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

// Mapping dari JS (families/periods) ke Database (family/period)
$categoryMap = [
    'families' => 'family',
    'periods' => 'period',
    'formations' => 'formation'
];

$type = $data['type'] ?? ''; // families, periods, etc
$dbCategory = $categoryMap[$type] ?? '';

if (!$dbCategory || empty($data['name'])) {
    echo json_encode(["status" => "error", "message" => "Data tidak lengkap"]);
    exit;
}

$id = $data['id'] ?? null;
$name = $data['name'];
$x = $data['x'] ?? 0;
$y = $data['y'] ?? 0;

if ($id) {
    // UPDATE (Edit)
    $stmt = $conn->prepare("UPDATE tags SET name=?, coord_x=?, coord_y=? WHERE id=?");
    $stmt->bind_param("sddi", $name, $x, $y, $id);
} else {
    // INSERT (Baru)
    $stmt = $conn->prepare("INSERT INTO tags (category, name, coord_x, coord_y) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssdd", $dbCategory, $name, $x, $y);
}

if ($stmt->execute()) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => $stmt->error]);
}
?>