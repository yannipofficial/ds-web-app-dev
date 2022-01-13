<?php
class User
{
    private $conn;

    public function __construct($db)
    {
        $this->conn = $db;
    }

    public function find($username, $password)
    {
        $query = "SELECT * FROM users WHERE username = '". $username ."' AND password = '". $password . "'";
        $result = $this->conn->query($query, PDO::FETCH_ASSOC);
        $users = [];
        foreach ($result as $post) {
            array_push($users, [
                "id" => $post["id"],
                "username" => $post["username"],
                "name" => $post["name"],
                "password" => $post["password"]
            ]);
        }
        return $users;
    }
}
