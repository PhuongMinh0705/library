<?php 
require_once("includes/config.php");

if (!empty($_POST["emailid"])) {
    $email = $_POST["emailid"];
    if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        echo "Lỗi: Email không hợp lệ !!";
    } else {
        $sql = "SELECT CheckEmailExists(:email) as email_count";
        $query = $dbh->prepare($sql);
        $query->bindParam(':email', $email, PDO::PARAM_STR);
        $query->execute();
        $result = $query->fetch(PDO::FETCH_ASSOC);
        $email_count = $result['email_count'];
        if ($email_count > 0) {
            echo "<span style='color:red'>Email đã tồn tại .</span>";
            echo "<script>$('#submit').prop('disabled',true);</script>";
        } else {
            echo "<span style='color:green'> 	Email hợp lệ .</span>";
            echo "<script>$('#submit').prop('disabled',false);</script>";
        }
    }
}


?>