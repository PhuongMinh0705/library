<?php
session_start();

include('includes/config.php');
if(strlen($_SESSION['alogin'])==0)
{
    header('location:index.php');
}
else
    if(isset($_POST['create']))
{
    $author=$_POST['author'];
    
    // Kiểm tra xem tác giả đã tồn tại chưa
    $sql_check = "SELECT * FROM dulieu_tacgia WHERE AuthorName = :author";
    $query_check = $dbh->prepare($sql_check);
    $query_check->bindParam(':author', $author, PDO::PARAM_STR);
    $query_check->execute();
    $result_check = $query_check->fetch(PDO::FETCH_ASSOC);

    if($result_check) {
        $_SESSION['error']="Tên Tác Giả đã tồn tại";
        header('location:manage-authors.php');
    } else {
        // Tiến hành chèn dữ liệu
        $sql="INSERT INTO dulieu_tacgia (AuthorName) VALUES (:author)";
        $query = $dbh->prepare($sql);
        $query->bindParam(':author',$author,PDO::PARAM_STR);
        $query->execute();
        $lastInsertId = $dbh->lastInsertId();
        if($lastInsertId)
        {
            $_SESSION['msg']="Thêm Tác Giả thành công";
            header('location:manage-authors.php');
        }
        else 
        {
            $_SESSION['error']="Có lỗi xảy ra, vui lòng thử lại !!!";
            header('location:manage-authors.php');
        }
    }
}

?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Quản Lý Thư Viện | Thêm Tác Giả</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

</head>
<body>
      <!------MENU SECTION START-->
<?php include('includes/header.php');?>
<!-- MENU SECTION END-->
    <div class="content-wra
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Thêm Tác Giả</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3"">
<div class="panel panel-info">
<div class="panel-heading">
Thông Tin Tác Giả
</div>
<div class="panel-body">
<form role="form" method="post">
<div class="form-group">
<label>Tên Tác Giả</label>
<input class="form-control" type="text" name="author" autocomplete="off"  required />
</div>

<button type="submit" name="create" class="btn btn-info">Thêm </button>

                                    </form>
                            </div>
                        </div>
</div>

        </div>
   
    </div>
    </div>
     <!-- CONTENT-WRAPPER SECTION END-->
  <?php include('includes/footer.php');?>
      <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<?php ?>