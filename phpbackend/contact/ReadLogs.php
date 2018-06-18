<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// include database and object files
include_once '../config/DatabaseConnection.php';
include_once '../objects/Log.php';

// instantiate database and Log object
$database = new Database();
$db = $database->getConnection();

// initialize object
$logs = new Log($db);

// query logs
$stmt = $logs->read($db);
$num = $stmt->rowCount();

// check if more than 0 record found
if($num>0){

    // logs array
    $logs_arr=array();

    // retrieve our table contents
    // fetch() is faster than fetchAll()
    // http://stackoverflow.com/questions/2770630/pdofetchall-vs-pdofetch-in-a-loop
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        // extract row
        // this will make $row['name'] to
        // just $name only
        extract($row);

        $log_item=array(
            "column_timestamp" => $column_timestamp,
            "column_transaction" => $column_transaction,
            "column_date" => $column_date,
        );

        array_push($logs_arr, $log_item);

        // array_push($contacts_arr["contacts"], $contact_item);
    }
    header('HTTP/1.1 200 Logs Found');
    echo json_encode($logs_arr);
}

else{
  header('HTTP/1.1 404 No Logs Found in Remote Database');
}
?>
