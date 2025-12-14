<?php
include 'db.php';

// 1. AMBIL DATA DINOSAURUS
$sqlDinos = "SELECT * FROM dinos";
$resultDinos = $conn->query($sqlDinos);
$dinos = [];

while ($row = $resultDinos->fetch_assoc()) {
    $row['isPrimary'] = ($row['is_primary'] == 1);
    $row['formationName'] = $row['formation_name'];
    $row['imageUrl'] = $row['image_url'];
    unset($row['is_primary'], $row['formation_name'], $row['image_url']);
    
    $dinos[] = $row;
}

// 2. AMBIL DATA TAGS
$resultTags = $conn->query("SELECT * FROM tags ORDER BY name ASC");
$tags = ['families' => [], 'periods' => [], 'formations' => []];

while ($row = $resultTags->fetch_assoc()) {
    $item = [
        'id' => $row['id'],
        'name' => $row['name']
    ];

    if ($row['category'] == 'family') {
        $tags['families'][] = $item;
    } 
    elseif ($row['category'] == 'period') {
        $tags['periods'][] = $item;
    } 
    elseif ($row['category'] == 'formation') {
        $item['left'] = (float)$row['coord_x'];
        $item['top'] = (float)$row['coord_y'];
        $tags['formations'][] = $item;
    }
}

// 3. KIRIM SEBAGAI JSON
echo json_encode([
    'dinos' => $dinos,
    'tags' => $tags
]);
?>