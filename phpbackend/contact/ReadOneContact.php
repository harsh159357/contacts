<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

// include database and object files
include_once '../config/DatabaseConnection.php';
include_once '../objects/Contact.php';

// get database connection
$database = new Database();
$db = $database->getConnection();

// prepare Contact object
$contact = new Contact($db);

// set ID property of contact to be edited
$idParam = isset($_GET['_id']) ? $_GET['_id'] : "";

if($idParam == "") {
  header('HTTP/1.1 400 Bad Request Please Supply Query Param _id');

  // echo json_encode(
  //     array("message" => "Please pass a query parameter _id in the url.")
  // );
} else {

$contact->_id = $idParam;

$stmt = $contact->readOne($db);
$num = $stmt->rowCount();

if($num>0){

// create array
$contact_arr = array(
  "_id" => $contact->_id,
  "name" => $contact->name,
  "phone" => $contact->phone,
  "email" => $contact->email,
  "address" => $contact->address,
  "latitude" => $contact->latitude,
  "longitude" => $contact->longitude,
  "contact_image" => $contact->contact_image,
);

header('HTTP/1.1 200 Contact Found');

// make it json format
echo json_encode($contact_arr);
} else {

  header("HTTP/1.1 404 No Contact Found with id ".$idParam."");

}
}
?>
