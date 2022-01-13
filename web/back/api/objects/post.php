<?php
class Post
{

    // database connection and table name
    private $conn;
    private $table_name = "posts";

    // object properties
    public $id;
    public $username;
    public $article;

    // constructor with $db as database connection
    public function __construct($db)
    {
        $this->conn = $db;
    }

    public function getPosts($userId = null)
    {
        $query = "SELECT posts.id, posts.title, posts.content, users.name as author, added_at as addedat FROM " . $this->table_name . " INNER JOIN users ON users.id = posts.user_id";
        if ($userId) {
            $query .= " WHERE posts.user_id = " . $userId;
        }
        $query .= " ORDER BY posts.id DESC";
        $result = $this->conn->query($query, PDO::FETCH_ASSOC);
        $posts = [];
        foreach ($result as $post) {
            array_push($posts, [
                "id" => $post["id"],
                "author" => $post["author"],
                "title" => $post["title"],
                "content" => $post["content"],
                "addedat" => $post["addedat"]
            ]);
        }
        return $posts;
    }
    public function getPostAuthors()
    {
        $query = "SELECT DISTINCT(users.name) as author, users.id FROM " . $this->table_name . " INNER JOIN users ON users.id = posts.user_id";

        $result = $this->conn->query($query, PDO::FETCH_ASSOC);
        $posts = [];
        foreach ($result as $post) {
            array_push($posts, [
                "author" => $post["author"],
                "usersid" => $post["id"]
            ]);
        }
        return $posts;
    }

    public function insertPost($userId, $title, $content)
    {
        $query = "INSERT INTO posts (user_id, title, content)
        VALUES ('$userId', '$title', '$content')";
        $result = $this->conn->exec($query);
        return $result;
    }
}
