<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// include database and object files
include_once '../config/DatabaseConnection.php';
include_once '../objects/DeletedContacts.php';

// instantiate database and Deleted Contact object
$database = new Database();
$db = $database->getConnection();

// initialize object
$deletedContacts = new DeletedContacts($db);

// query contacts
$stmt = $deletedContacts->read($db);
$num = $stmt->rowCount();

// check if more than 0 record found
if($num>0){

    // contacts array
    $deletedContacts_arr=array();
    // $deletedContacts_arr["contacts"]=array();

    // retrieve our table contents
    // fetch() is faster than fetchAll()
    // http://stackoverflow.com/questions/2770630/pdofetchall-vs-pdofetch-in-a-loop
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        // extract row
        // this will make $row['name'] to
        // just $name only
        extract($row);

        $deletedContacts_item=array(
            "_id" => $_id,
            "name" => $name,
            "phone" => $phone,
            "email" => $email,
            "address" => $address,
            "latitude" => $latitude,
            "longitude" => $longitude,
            "contact_image" => $contact_image,
        );

        array_push($deletedContacts_arr, $deletedContacts_item);

        // array_push($deletedContacts_arr["contacts"], $deletedContacts_item);
    }
    header('HTTP/1.1 200 Deleted Contacts Found');
    echo json_encode($deletedContacts_arr);
}

else{
  header('HTTP/1.1 404 No  Deleted Contacts Found in Remote Database');
}
?>
