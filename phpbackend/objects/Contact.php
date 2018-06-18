<?php

class Contact{

     // database connection and table name
    private $conn;
    private $table_name = "contact";

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

// read contacts
function read($db){

    // select all query
    $query = "SELECT * FROM " . $this->table_name . "";

    // prepare query statement
    $stmt = $this->conn->prepare($query);

    // execute query
    $stmt->execute();

    $this->makeEntryInLogs($db,"Reading All the Contacts Available In Database.");

    return $stmt;
}

// create contact
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

    $this->makeEntryInLogs($db,"A New Contact is Being Inserted in Contact Table.");

    // execute query
    if($stmt->execute()){
        return true;
    }

    return false;

}

// used for reading one contact
function readOne($db){

    // query to read single record
    $query = "SELECT * FROM " . $this->table_name . " WHERE _id = ?";

    // prepare query statement
    $stmt = $this->conn->prepare( $query );

    // bind id of contact to be updated
    $stmt->bindParam(1, $this->_id);

    // execute query
    $stmt->execute();

    // get retrieved row
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    // set values to object properties
    $this->_id = $row['_id'];
    $this->name = $row['name'];
    $this->phone = $row['phone'];
    $this->email = $row['email'];
    $this->address = $row['address'];
    $this->latitude = $row['latitude'];
    $this->longitude = $row['longitude'];
    $this->contact_image = $row['contact_image'];

    $this->makeEntryInLogs($db,"Reading Single Contact from the Database.");

    return $stmt;
}

// update the Contact
function update($db){

    // update query
    $query = "UPDATE
                " . $this->table_name . "
            SET

            name=:name,
            phone=:phone,
            email=:email,
            address=:address,
            latitude=:latitude,
            longitude=:longitude,
            contact_image=:contact_image

            WHERE
                _id = :_id";

    // prepare query statement
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

    $this->makeEntryInLogs($db,"Updating a Contact in Database.");

    // execute the query
    if($stmt->execute() && (($stmt->rowCount())>0)){
        return true;
    }

    return false;
}

// delete the Contact
function delete($db){

  $stmtFindContact = $this->readOne($db);
  $num = $stmtFindContact->rowCount();

  if($num>0){
    include_once 'DeletedContacts.php';

    $deletedContact = new DeletedContacts($db);
    $deletedContact->_id = $this->_id;
    $deletedContact->name = $this->name;
    $deletedContact->phone = $this->phone;
    $deletedContact->email = $this->email;
    $deletedContact->address = $this->address;
    $deletedContact->latitude = $this->latitude;
    $deletedContact->longitude= $this->longitude;
    $deletedContact->contact_image = $this->contact_image;
    $deletedContact->create($db);
    }

    // delete query
    $query = "DELETE FROM " . $this->table_name . " WHERE _id = ?";

    // prepare query
    $stmt = $this->conn->prepare($query);

    // sanitize
    $this->_id=htmlspecialchars(strip_tags($this->_id));

    // bind id of record to delete
    $stmt->bindParam(1, $this->_id);

    $this->makeEntryInLogs($db,"Deleting a Contact from Database.");

    // execute query
    if($stmt->execute() && (($stmt->rowCount())>0)){
        return true;
    }

    return false;

}

// search contacts
function search($keywords,$db){

    // select all query
    $query = "SELECT * FROM " . $this->table_name . " WHERE
                name LIKE ? OR phone LIKE ? OR email LIKE ? OR address LIKE ?
            ";

    // prepare query statement
    $stmt = $this->conn->prepare($query);

    // sanitize
    $keywords=htmlspecialchars(strip_tags($keywords));
    $keywords = "%{$keywords}%";

    // bind
    $stmt->bindParam(1, $keywords);
    $stmt->bindParam(2, $keywords);
    $stmt->bindParam(3, $keywords);
    $stmt->bindParam(4, $keywords);


    // execute query
    $stmt->execute();

    $this->makeEntryInLogs($db,"Searching a contact in database.");

    return $stmt;
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
