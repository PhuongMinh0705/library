<?php
session_start();
error_reporting(0);
include('includes/config.php');

if(strlen($_SESSION['login']) == 0) {   
    header('location:index.php');
    exit();
} else { 
    if(isset($_GET['del'])) {
        $id = $_GET['del'];
        $sql = "DELETE FROM quanlymuontra WHERE id=:id";
        $query = $dbh->prepare($sql);
        $query->bindParam(':id', $id, PDO::PARAM_STR);
        $query->execute();
        $_SESSION['delmsg'] = "Xóa thể loại thành công";
        header('location:manage-books.php');
        exit();
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
    <title>Hệ thống quản lý thư viện | Sách đã mượn</title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>
<body>
<?php include('includes/header.php');?>
    <div class="content-wrapper">
        <div class="container">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line">Sách đã mượn</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Sách đã mượn
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên Sách</th>
                                            <th>Mã ISBN</th>
                                            <th>Ngày mượn</th>
                                            <th>Ngày trả</th>
                                            <th>Phí mượn sách</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php 
                                        $sid = $_SESSION['stdid'];
                                        $stmt = $dbh->prepare("CALL LaySachDocGiaDaMuon(:sid)");
                                        $stmt->bindParam(':sid', $sid, PDO::PARAM_STR);
                                        $stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_OBJ);
                                        $cnt = 1;
                                        foreach($results as $result) { ?>                                      
                                            <tr class="odd gradeX">
                                                <td class="center"><?php echo htmlentities($cnt);?></td>
                                                <td class="center"><?php echo htmlentities($result->ten_sach);?></td>
                                                <td class="center"><?php echo htmlentities($result->ma_isbn);?></td>
                                                <td class="center"><?php echo htmlentities($result->ngay_muon);?></td>
                                                <td class="center">
                                                    <?php 
                                                    if($result->ngay_tra=="") {
                                                        echo "<span style='color:red'>Chưa Trả</span>";
                                                    } else {
                                                        echo htmlentities($result->ngay_tra);
                                                    }
                                                    ?>
                                                </td>
                                                <td class="center"><?php echo htmlentities($result->phi_muon);?></td>
                                            </tr>
                                            <?php $cnt = $cnt + 1;
                                        } ?>                                      
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php include('includes/footer.php');?>
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script src="assets/js/custom.js"></script>
</body>
</html>