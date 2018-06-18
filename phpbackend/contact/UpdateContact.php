<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// include database and object files
include_once '../config/DatabaseConnection.php';
include_once '../objects/Contact.php';

// get database connection
$database = new Database();
$db = $database->getConnection();

// prepare Contact object
$contact = new Contact($db);

// get id of Contact to be edited
$data = json_decode(file_get_contents("php://input"));

// set ID property of Contact to be edited
$contact->_id = $data->_id;

// set Contact property values
$contact->name = $data->name;
$contact->phone = $data->phone;
$contact->email = $data->email;
$contact->address = $data->address;
$contact->latitude = $data->latitude;
$contact->longitude= $data->longitude;
$contact->contact_image = $data->contact_image;

// update the contact
if($contact->update($db)){
  header("HTTP/1.1 200 Contact was Updated Successfully");
}

// if unable to update the contact, tell the user
else{
  header("HTTP/1.1 500 No Contact with id ".$data->_id." exist in Database");
}
?>
