<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


// include database and object file
include_once '../config/DatabaseConnection.php';
include_once '../objects/Contact.php';

// get database connection
$database = new Database();
$db = $database->getConnection();

// prepare Contact object
$contact = new Contact($db);

// get Contact id
$data = json_decode(file_get_contents("php://input"));

if($data->_id) {
  // set contact id to be deleted
$contact->_id = $data->_id;

// delete the contact
if($contact->delete($db)){
  header("HTTP/1.1 200 Contact Deleted Successfully");
}

// if unable to delete the Contact
else{
  header("HTTP/1.1 500 No Contact with  id ".$data->_id." exist in Database");
}
}  else {
  header("HTTP/1.1 400 Please provide _id of the contact to be deleted");
}
?>
