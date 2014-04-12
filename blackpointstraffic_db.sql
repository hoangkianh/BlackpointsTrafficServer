-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2014 at 06:50 AM
-- Server version: 5.5.34
-- PHP Version: 5.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `blackpointstraffic_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `countPOIByCity`()
SELECT A.name AS city, IFNULL(B.count,0) AS count
FROM city A
LEFT JOIN
(
SELECT city, COUNT( * ) AS count
FROM  `poi` 
WHERE isDeleted=false
GROUP BY city
) B
ON A.id = B.city$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countPOIByDistrict`()
    NO SQL
SELECT
	B.name AS city,
	A.name AS district,
	IFNULL(C.count,0) AS count
FROM district A
INNER JOIN city B ON A.city=B.id
LEFT JOIN
(
    SELECT district, COUNT( * ) AS count
	FROM poi
	WHERE isDeleted = FALSE
	GROUP BY district
	LIMIT 0 , 30
) C
ON A.id = C.district$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countUserInGroup`(IN `gID` INT)
    NO SQL
SELECT COUNT( * ) AS count
FROM user
WHERE groupID = gID
GROUP BY groupID
LIMIT 0 , 30$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`id`, `name`) VALUES
(1, 'Hà Nội'),
(2, 'TP. HCM');

-- --------------------------------------------------------

--
-- Table structure for table `district`
--

CREATE TABLE IF NOT EXISTS `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `city` (`city`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=62 ;

--
-- Dumping data for table `district`
--

INSERT INTO `district` (`id`, `name`, `city`) VALUES
(1, 'Quận Ba Đình', 1),
(2, 'Quận Hoàn Kiếm', 1),
(3, 'Quận Tây Hồ', 1),
(4, 'Quận Long Biên', 1),
(5, 'Quận Cầu Giấy', 1),
(6, 'Quận Đống Đa', 1),
(7, 'Quận Hai Bà Trưng', 1),
(8, 'Quận Hoàng Mai', 1),
(9, 'Quận Thanh Xuân', 1),
(10, 'Quận Hà Đông', 1),
(12, 'Huyện Từ Liêm', 1),
(13, 'Thị xã Sơn Tây', 1),
(14, 'Huyện Ba Vì', 1),
(15, 'Huyện Chương Mỹ', 1),
(16, 'Huyện Mỹ Đức', 1),
(17, 'Huyện Phú Xuyên', 1),
(18, 'Huyện Phúc Thọ', 1),
(19, 'Huyện Quốc Oai', 1),
(20, 'Huyện Sóc Sơn', 1),
(21, 'Huyện Thạch Thất', 1),
(22, 'Huyện Thanh Oai', 1),
(23, 'Huyện Thanh Trì', 1),
(24, 'Huyện Thường Tín', 1),
(25, 'Huyện Ứng Hòa', 1),
(26, 'Huyện Đan Phượng', 1),
(27, 'Huyện Đông Anh', 1),
(31, 'Huyện Gia Lâm', 1),
(32, 'Huyện Hoài Đức', 1),
(33, 'Huyện Mê Linh', 1),
(34, 'Quận 1', 2),
(35, 'Quận 2', 2),
(36, 'Quận 3', 2),
(37, 'Quận 4', 2),
(38, 'Quận 5', 2),
(39, 'Quận 6', 2),
(40, 'Quận 7', 2),
(41, 'Quận 8', 2),
(42, 'Quận 9', 2),
(43, 'Quận 10', 2),
(44, 'Quận 11', 2),
(45, 'Quận 12', 2),
(46, 'Quận Thủ Đức', 2),
(47, 'Quận Gò Vấp', 2),
(48, 'Quận Bình Thạnh', 2),
(49, 'Quận Tân Bình', 2),
(50, 'Quận Tân Phú', 2),
(51, 'Quận Phú Nhuận', 2),
(52, 'Quận Bình Tân', 2),
(53, 'Huyện Củ Chi', 2),
(54, 'Huyện Hóc Môn', 2),
(55, 'Huyện Bình Chánh', 2),
(56, 'Huyện Nhà Bè', 2),
(61, 'Huyện Cần Giờ', 2);

-- --------------------------------------------------------

--
-- Table structure for table `poi`
--

CREATE TABLE IF NOT EXISTS `poi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `district` int(11) DEFAULT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geometry` geometry DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `bbox` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geoJson` text COLLATE utf8_unicode_ci,
  `createdOnDate` datetime DEFAULT NULL,
  `createdByUserID` int(11) DEFAULT NULL,
  `updatedOnDate` datetime DEFAULT NULL,
  `updatedByUserID` int(11) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT NULL,
  `deletedOnDate` datetime DEFAULT NULL,
  `deletedByUserID` int(11) DEFAULT NULL,
  `restoreOnDate` datetime DEFAULT NULL,
  `restoreByUserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subCategoryID` (`categoryID`),
  KEY `createdByUserID` (`createdByUserID`),
  KEY `updatedByUserID` (`updatedByUserID`,`deletedByUserID`,`restoreByUserID`),
  KEY `deletedByUserID` (`deletedByUserID`,`restoreByUserID`),
  KEY `restoreByUserID` (`restoreByUserID`),
  KEY `city` (`city`),
  KEY `city_2` (`city`),
  KEY `district` (`district`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `poiID` int(11) NOT NULL,
  `key` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`poiID`,`key`),
  KEY `fcode` (`poiID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `temppoi`
--

CREATE TABLE IF NOT EXISTS `temppoi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` int(11) DEFAULT NULL,
  `district` int(11) DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `createdByUserID` int(11) DEFAULT NULL,
  `createdOnDate` datetime DEFAULT NULL,
  `updatedByUserID` int(11) DEFAULT NULL,
  `updatedOnDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdByUserID` (`createdByUserID`),
  KEY `updatedByUserID` (`updatedByUserID`),
  KEY `categoryID` (`categoryID`),
  KEY `city` (`city`),
  KEY `city_2` (`city`),
  KEY `city_3` (`city`),
  KEY `district` (`district`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayName` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `groupID` int(11) DEFAULT NULL,
  `isActivated` tinyint(1) DEFAULT NULL,
  `salt` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdOnDate` datetime DEFAULT NULL,
  `activatedOnDate` datetime DEFAULT NULL,
  `updatedOnDate` datetime DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `userName_UNIQUE` (`userName`),
  KEY `groupID` (`groupID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `userName`, `password`, `displayName`, `description`, `email`, `photo`, `lastLogin`, `groupID`, `isActivated`, `salt`, `createdOnDate`, `activatedOnDate`, `updatedOnDate`) VALUES
(1, 'admin', 'fcea920f7412b5da7be0cf42b8c93759', 'Administrator', '', 'admin@gmail.com', NULL, '2014-04-12 09:33:57', 1, 1, '', '2014-01-13 22:53:20', NULL, '2014-02-26 11:12:23'),
(2, 'normaluser', 'fcea920f7412b5da7be0cf42b8c93759', 'hoangkianh', '', 'username@gmail.com', NULL, '2014-04-09 11:40:40', 3, 1, '6ed90ab898b8a30280545c52da1dd511', '2014-01-22 18:05:00', NULL, '2014-04-03 22:32:34');

-- --------------------------------------------------------

--
-- Table structure for table `usergroup`
--

CREATE TABLE IF NOT EXISTS `usergroup` (
  `userGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` tinyint(4) DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdByUserID` int(11) DEFAULT NULL,
  `createdOnDate` datetime DEFAULT NULL,
  `updatedByUserID` int(11) DEFAULT NULL,
  `updatedOnDate` datetime DEFAULT NULL,
  PRIMARY KEY (`userGroupID`),
  KEY `createdByUserID` (`createdByUserID`),
  KEY `updatedByUserID` (`updatedByUserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `usergroup`
--

INSERT INTO `usergroup` (`userGroupID`, `name`, `level`, `description`, `createdByUserID`, `createdOnDate`, `updatedByUserID`, `updatedOnDate`) VALUES
(1, 'Super Administrator', 1, 'Nhóm Admin có quyền cao nhất', NULL, '2014-01-13 22:42:51', NULL, NULL),
(2, 'Administrator', 2, 'Nhóm Admin chỉ có các quyền thêm, cập nhật điểm đen ', NULL, '2014-01-13 22:47:35', NULL, NULL),
(3, 'Normal user', 3, 'Nhóm người dùng thông thường', NULL, '2014-01-13 22:47:46', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `district`
--
ALTER TABLE `district`
  ADD CONSTRAINT `district_ibfk_1` FOREIGN KEY (`city`) REFERENCES `city` (`id`);

--
-- Constraints for table `poi`
--
ALTER TABLE `poi`
  ADD CONSTRAINT `poi_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`) ON DELETE SET NULL,
  ADD CONSTRAINT `poi_ibfk_3` FOREIGN KEY (`createdByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `poi_ibfk_4` FOREIGN KEY (`updatedByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `poi_ibfk_5` FOREIGN KEY (`deletedByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `poi_ibfk_6` FOREIGN KEY (`restoreByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `poi_ibfk_7` FOREIGN KEY (`city`) REFERENCES `city` (`id`),
  ADD CONSTRAINT `poi_ibfk_8` FOREIGN KEY (`district`) REFERENCES `district` (`id`);

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `property_ibfk_1` FOREIGN KEY (`poiID`) REFERENCES `poi` (`id`);

--
-- Constraints for table `temppoi`
--
ALTER TABLE `temppoi`
  ADD CONSTRAINT `tempPoi_ibfk_1` FOREIGN KEY (`createdByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `tempPoi_ibfk_2` FOREIGN KEY (`updatedByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `tempPoi_ibfk_3` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`) ON DELETE SET NULL,
  ADD CONSTRAINT `tempPoi_ibfk_4` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tempPoi_ibfk_5` FOREIGN KEY (`district`) REFERENCES `district` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`groupID`) REFERENCES `usergroup` (`userGroupID`) ON DELETE SET NULL;

--
-- Constraints for table `usergroup`
--
ALTER TABLE `usergroup`
  ADD CONSTRAINT `userGroup_ibfk_1` FOREIGN KEY (`createdByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL,
  ADD CONSTRAINT `userGroup_ibfk_2` FOREIGN KEY (`updatedByUserID`) REFERENCES `user` (`userID`) ON DELETE SET NULL;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
