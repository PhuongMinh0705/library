-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 06, 2024 lúc 03:31 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `library`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBook` (IN `bookname` VARCHAR(255), IN `category` INT, IN `author` INT, IN `isbn` VARCHAR(255), IN `price` DECIMAL(10,2))   BEGIN
    INSERT INTO dulieu_sach(BookName, CatId, AuthorId, ISBNNumber, BookPrice)
    VALUES(bookname, category, author, isbn, price);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LaySachChuaTra` (IN `student_id` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS DemSoSach
    FROM quanlymuontra
    WHERE StudentID = student_id AND RetrunStatus = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LaySachDaMuon` (IN `student_id` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS DemSoSach
    FROM quanlymuontra
    WHERE StudentID = student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LaySachDocGiaDaMuon` (IN `student_id` VARCHAR(100))   BEGIN
    SELECT q.id, ds.BookName AS ten_sach, ds.ISBNNumber AS ma_isbn, q.IssuesDate AS ngay_muon, q.ReturnDate AS ngay_tra, q.fine AS phi_muon
    FROM quanlymuontra q
    INNER JOIN dulieu_sach ds ON q.BookId = ds.id
    WHERE q.StudentID = student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LaySoSachChuaTraTheoDocGia` (IN `student_id` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS SoSachChuaTra
    FROM quanlymuontra
    WHERE StudentID = student_id AND RetrunStatus IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LaySoSachDaMuonTheoDocGia` (IN `student_id` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS SoSachDaMuon
    FROM quanlymuontra
    WHERE StudentID = student_id;
END$$

--
-- Các hàm
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CheckEmailExists` (`email` VARCHAR(255)) RETURNS INT(11)  BEGIN
    DECLARE email_count INT;
    SELECT COUNT(*) INTO email_count FROM dulieu_docgia WHERE EmailId = email;
    RETURN email_count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `AdminEmail` varchar(120) DEFAULT NULL,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `updationDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`id`, `FullName`, `AdminEmail`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'minh', 'minhb2017057@student.ctu.edu.vn', 'admin', '202cb962ac59075b964b07152d234b70', '2024-04-06 13:29:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dulieu_docgia`
--

CREATE TABLE `dulieu_docgia` (
  `id` int(11) NOT NULL,
  `StudentId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FullName` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `EmailId` varchar(120) DEFAULT NULL,
  `MobileNumber` char(11) DEFAULT NULL,
  `Password` varchar(120) DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Đang đổ dữ liệu cho bảng `dulieu_docgia`
--

INSERT INTO `dulieu_docgia` (`id`, `StudentId`, `FullName`, `EmailId`, `MobileNumber`, `Password`, `Status`, `RegDate`, `UpdationDate`) VALUES
(128, 'SID017', 'Nguyễn Phương Minh', 'minh@gmail.com', '0123456789', 'c92f1d1f2619172bf87a12e5915702a6', 1, '2024-04-02 17:54:32', NULL),
(129, 'SID018', 'Nguyen Phuong A', 'minh123@gmail.com', '0115554', '202cb962ac59075b964b07152d234b70', 1, '2024-04-03 02:40:27', '2024-04-03 02:41:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dulieu_sach`
--

CREATE TABLE `dulieu_sach` (
  `id` int(11) NOT NULL,
  `BookName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CatId` int(11) DEFAULT NULL,
  `AuthorId` int(11) DEFAULT NULL,
  `ISBNNumber` int(11) DEFAULT NULL,
  `BookPrice` int(11) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Đang đổ dữ liệu cho bảng `dulieu_sach`
--

INSERT INTO `dulieu_sach` (`id`, `BookName`, `CatId`, `AuthorId`, `ISBNNumber`, `BookPrice`, `RegDate`, `UpdationDate`) VALUES
(11, 'Tôi thấy hoa vàng trên cỏ xanh', 15, 21, 1, 5000, '2024-04-02 17:34:31', NULL),
(12, 'Chí Phèo', 14, 20, 2, 5000, '2024-04-02 17:34:50', NULL),
(13, 'Cho tôi xin một vé đi tuổi thơ', 14, 21, 3, 5000, '2024-04-02 18:03:17', NULL),
(14, 'Sherlock Holmes', 16, 22, 4, 5000, '2024-04-02 18:05:24', NULL),
(15, 'Ông Già Và Biển Cả', 14, 23, 5, 5000, '2024-04-02 18:36:29', NULL),
(16, 'Hai Vạn Dặm Dưới Đáy Biển', 17, 24, 6, 5000, '2024-04-02 18:37:56', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dulieu_tacgia`
--

CREATE TABLE `dulieu_tacgia` (
  `id` int(11) NOT NULL,
  `AuthorName` varchar(159) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Đang đổ dữ liệu cho bảng `dulieu_tacgia`
--

INSERT INTO `dulieu_tacgia` (`id`, `AuthorName`, `creationDate`, `UpdationDate`) VALUES
(20, 'Nam Cao', '2024-04-02 14:21:48', NULL),
(21, 'Nguyễn Nhật Ánh', '2024-04-02 17:18:50', NULL),
(22, 'Arthur Conan Doyle', '2024-04-02 18:04:44', NULL),
(23, 'Ernest Hemingway', '2024-04-02 18:35:38', NULL),
(24, 'Jules Verne', '2024-04-02 18:37:33', NULL);

--
-- Bẫy `dulieu_tacgia`
--
DELIMITER $$
CREATE TRIGGER `before_insert_tacgia` BEFORE INSERT ON `dulieu_tacgia` FOR EACH ROW BEGIN
    DECLARE author_count INT;

    SELECT COUNT(*) INTO author_count
    FROM dulieu_tacgia
    WHERE AuthorName = NEW.AuthorName;

    IF author_count > 0 THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Tên Tác Giả đã tồn tại';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dulieu_theloai`
--

CREATE TABLE `dulieu_theloai` (
  `id` int(11) NOT NULL,
  `CategoryName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Status` int(1) DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Đang đổ dữ liệu cho bảng `dulieu_theloai`
--

INSERT INTO `dulieu_theloai` (`id`, `CategoryName`, `Status`, `CreationDate`, `UpdationDate`) VALUES
(14, 'Truyện Ngắn', 1, '2024-04-02 17:33:37', '2024-04-02 17:33:37'),
(15, 'Tiểu thuyết thanh thiếu niên', 1, '2024-04-02 17:34:08', '2024-04-02 17:34:08'),
(16, 'Trinh Thám', 1, '2024-04-02 18:03:58', '2024-04-02 18:03:58'),
(17, 'Phiêu Lưu', 1, '2024-04-02 18:37:27', '2024-04-02 18:53:46'),
(18, 'kinh di', 0, '2024-04-03 02:31:41', '2024-04-03 02:31:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quanlymuontra`
--

CREATE TABLE `quanlymuontra` (
  `id` int(11) NOT NULL,
  `BookId` int(11) DEFAULT NULL,
  `StudentID` varchar(150) DEFAULT NULL,
  `IssuesDate` timestamp NULL DEFAULT current_timestamp(),
  `ReturnDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `RetrunStatus` int(1) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `dulieu_docgia`
--
ALTER TABLE `dulieu_docgia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `StudentId` (`StudentId`);

--
-- Chỉ mục cho bảng `dulieu_sach`
--
ALTER TABLE `dulieu_sach`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `dulieu_tacgia`
--
ALTER TABLE `dulieu_tacgia`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `dulieu_theloai`
--
ALTER TABLE `dulieu_theloai`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `quanlymuontra`
--
ALTER TABLE `quanlymuontra`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2113328;

--
-- AUTO_INCREMENT cho bảng `dulieu_docgia`
--
ALTER TABLE `dulieu_docgia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT cho bảng `dulieu_sach`
--
ALTER TABLE `dulieu_sach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `dulieu_tacgia`
--
ALTER TABLE `dulieu_tacgia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `dulieu_theloai`
--
ALTER TABLE `dulieu_theloai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `quanlymuontra`
--
ALTER TABLE `quanlymuontra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
