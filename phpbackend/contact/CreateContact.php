<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// get database connection
include_once '../config/DatabaseConnection.php';

// instantiate Contact object
include_once '../objects/Contact.php';

$database = new Database();
$db = $database->getConnection();

$contact = new Contact($db);

// get posted data
$data = json_decode(file_get_contents("php://input"));


// set contact property values
$contact->_id = $data->_id;
$contact->name = $data->name;
$contact->phone = $data->phone;
$contact->email = $data->email;
$contact->address = $data->address;
$contact->latitude = $data->latitude;
$contact->longitude= $data->longitude;
$contact->contact_image = $data->contact_image;

// create the contact
if($contact->create($db)){
  header("HTTP/1.1 201 Contact was Created");
}

// if unable to create the contact, tell the user
else{
  header("HTTP/1.1 500 Unable to Create Contact");
}
?>
