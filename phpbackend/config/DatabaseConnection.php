<?php
 class Database{

     // specify your own database credentials
     private $host = "your_host";
     private $db_name = "your_database_name";
     private $username = "your_user_name";
     private $password = "your_password";
     public $conn;

     // get the database connection
     public function getConnection(){

         $this->conn = null;

         try{
             $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
             $this->conn->exec("set names utf8");
         }catch(PDOException $exception){
             echo "Connection error: " . $exception->getMessage();
         }

         return $this->conn;
     }
 }
 ?>
