<?php

class DeletedContacts{

     // database connection and table name
    private $conn;
    private $table_name = "deletedcontacts";

    // object properties
    public $_id;
    public $name;
    public $phone;
    public $email;
    public $address;
    public $latitude;
    public $longitude;
    public $contact_image;

    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }

// read DeletedContacts
function read($db){

    // select all query
    $query = "SELECT * FROM " . $this->table_name . "";

    // prepare query statement
    $stmt = $this->conn->prepare($query);

    // execute query
    $stmt->execute();

    $this->makeEntryInLogs($db,"Reading all the Deleted Contacts from Database.");

    return $stmt;
}

// create Deleted Contact
function create($db){

    // query to insert record
    $query = "INSERT INTO
                " . $this->table_name . "
            SET
            _id=:_id,
            name=:name,
            phone=:phone,
            email=:email,
            address=:address,
            latitude=:latitude,
            longitude=:longitude,
            contact_image=:contact_image";

    // prepare query
    $stmt = $this->conn->prepare($query);

    // sanitize
    $this->_id=htmlspecialchars(strip_tags($this->_id));
    $this->name=htmlspecialchars(strip_tags($this->name));
    $this->phone=htmlspecialchars(strip_tags($this->phone));
    $this->email=htmlspecialchars(strip_tags($this->email));
    $this->address=htmlspecialchars(strip_tags($this->address));
    $this->latitude=htmlspecialchars(strip_tags($this->latitude));
    $this->longitude=htmlspecialchars(strip_tags($this->longitude));
    $this->contact_image=htmlspecialchars(strip_tags($this->contact_image));


    // bind values
    $stmt->bindParam(":_id", $this->_id);
    $stmt->bindParam(":name", $this->name);
    $stmt->bindParam(":phone", $this->phone);
    $stmt->bindParam(":email", $this->email);
    $stmt->bindParam(":address", $this->address);
    $stmt->bindParam(":latitude", $this->latitude);
    $stmt->bindParam(":longitude", $this->longitude);
    $stmt->bindParam(":contact_image", $this->contact_image);

    $this->makeEntryInLogs($db,"Creating a Contact in Deleted Contacts Table.");

    // execute query
    if($stmt->execute()){
        return true;
    }

    return false;

}

function makeEntryInLogs($db,$query){
  include_once 'Log.php';
  $logEntry = new Log($db);
  $logEntry->column_timestamp = time();
  $logEntry->column_transaction = $query;
  $logEntry->column_date = date("m/d/Y h:i:s a");
  $logEntry->create($db);
}

}
?>
