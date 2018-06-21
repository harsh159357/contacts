<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// include database and object files
include_once '../config/DatabaseConnection.php';
include_once '../objects/Contact.php';

// instantiate database and contact object
$database = new Database();
$db = $database->getConnection();

// initialize object
$contact = new Contact($db);

// get keywords
$keywords=isset($_GET["s"]) ? $_GET["s"] : "";

if($keywords!="") {
// query contacts
$stmt = $contact->search($keywords,$db);
$num = $stmt->rowCount();

// check if more than 0 record found
if($num>0){

  // contacts array
  $contacts_arr=array();
  // $contacts_arr["contacts"]=array();

  // retrieve our table contents
  // fetch() is faster than fetchAll()
  // http://stackoverflow.com/questions/2770630/pdofetchall-vs-pdofetch-in-a-loop
  while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
      // extract row
      // this will make $row['name'] to
      // just $name only
      extract($row);

      $contact_item=array(
          "_id" => $_id,
          "name" => $name,
          "phone" => $phone,
          "email" => $email,
          "address" => $address,
          "latitude" => $latitude,
          "longitude" => $longitude,
          "contact_image" => $contact_image,
      );

      array_push($contacts_arr, $contact_item);
      // array_push($contacts_arr["contacts"], $contact_item);
  }

  header("HTTP/1.1 200 Contacts found for search query ".$keywords."");

  echo json_encode($contacts_arr);
}

else{
  header("HTTP/1.1 404 No Contacts Found for your search query ".$keywords."");
}
} else {
  header("HTTP/1.1 400 Please provide search query parameter s");
}
?>
