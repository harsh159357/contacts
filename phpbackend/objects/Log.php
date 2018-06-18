<?php

class Log{

    private $conn;
    private $table_name = "log";

    // object properties
    public $column_transaction;
    public $column_timestamp;
    public $column_date;
    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }

// read Logs
function read($db){

    // select all query
    $query = "SELECT * FROM " . $this->table_name . "";

    // prepare query statement
    $stmt = $this->conn->prepare($query);

    $stmt->execute();

    return $stmt;
}

// create Log
function create($db){
    $this->conn = $db;

    // query to insert record
    $query = "INSERT INTO
                " . $this->table_name . "
            SET
            column_timestamp=:column_timestamp,
            column_transaction=:column_transaction,
            column_date=:column_date";

    // prepare query
    $stmt = $this->conn->prepare($query);

    // sanitize
    $this->column_timestamp=htmlspecialchars(strip_tags($this->column_timestamp));
    $this->column_transaction=htmlspecialchars(strip_tags($this->column_transaction));
    $this->column_date=htmlspecialchars(strip_tags($this->column_date));

    // bind values
    $stmt->bindParam(":column_timestamp", $this->column_timestamp);
    $stmt->bindParam(":column_transaction", $this->column_transaction);
    $stmt->bindParam(":column_date", $this->column_date);

    // execute query
    $stmt->execute();
}
}
?>
