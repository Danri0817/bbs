-- MySQL dump 10.17  Distrib 10.3.16-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: bbs
-- ------------------------------------------------------
-- Server version	10.3.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'ダンリ','a@pin.jp','011c945f30ce2cbafc452f39840f025693339c42','20190811015300','2019-08-11 08:53:04','2019-08-10 23:53:04'),(2,'あす','b@pin.jp','fea7f657f56a2a448da7d4b535ee5e279caf3d9a','20190811015446','2019-08-11 08:54:53','2019-08-10 23:54:53'),(3,'あ','ｃ@pin.jp','f56d6351aa71cff0debea014d13525e42036187a','20190811062119スクリーンショット (22).png','2019-08-11 13:21:21','2019-08-11 04:21:21'),(4,'い','d@pin.jp','92f2fd99879b0c2466ab8648afb63c49032379c1','','2019-08-11 14:48:16','2019-08-11 05:48:16');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `member_id` int(11) NOT NULL,
  `reply_message_id` int(11) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'おはよう',1,0,'','2019-08-11 08:53:46','2019-08-10 23:53:46'),(2,'こんにちは',1,0,'','2019-08-11 08:53:55','2019-08-10 23:53:55'),(3,'こんばんは',1,0,'','2019-08-11 08:54:26','2019-08-10 23:54:26'),(4,'good morning',2,0,'','2019-08-11 08:55:45','2019-08-10 23:55:45'),(5,'hello',2,0,'','2019-08-11 08:55:51','2019-08-10 23:55:51'),(6,'good afternoon',2,0,'','2019-08-11 08:56:07','2019-08-10 23:56:07'),(9,'11',1,0,'','2019-08-11 10:33:32','2019-08-11 01:33:32'),(10,'22',1,0,'','2019-08-11 10:34:40','2019-08-11 01:34:40'),(12,'33',1,0,'','2019-08-11 10:47:43','2019-08-11 01:47:43'),(15,'44',1,0,'','2019-08-11 11:57:43','2019-08-11 02:57:43'),(23,'55',1,0,'','2019-08-11 12:19:17','2019-08-11 03:19:17'),(24,'11',1,0,'','2019-08-11 12:33:27','2019-08-11 03:33:27'),(25,'12',1,0,'','2019-08-11 12:34:24','2019-08-11 03:34:24'),(28,'13',1,0,'','2019-08-11 12:39:51','2019-08-11 03:39:51'),(29,'14',1,0,'','2019-08-11 12:43:00','2019-08-11 03:43:00'),(39,'16',1,0,'','2019-08-11 13:04:02','2019-08-11 04:04:02'),(62,'',1,0,'20190811073814スクリーンショット (25).png','2019-08-11 14:38:14','2019-08-11 05:38:14'),(63,'17',1,0,'20190811074134スクリーンショット (19).png','2019-08-11 14:41:34','2019-08-11 05:41:34'),(69,'',4,0,'20190811081744スクリーンショット (21).png','2019-08-11 15:17:44','2019-08-11 06:17:44'),(77,'55',4,0,'','2019-08-11 15:48:12','2019-08-11 06:48:12'),(78,'',4,0,'20190811084901スクリーンショット (24).png','2019-08-11 15:49:01','2019-08-11 06:49:01'),(79,'66',1,0,'','2019-08-11 15:49:45','2019-08-11 06:49:45'),(80,'',1,0,'20190811084956スクリーンショット (25).png','2019-08-11 15:49:56','2019-08-11 06:49:56'),(82,'@ダンリ ',1,80,'20190811085039スクリーンショット (24).png','2019-08-11 15:50:39','2019-08-11 06:50:39'),(87,'',1,0,'20190811094455スクリーンショット (25).png','2019-08-11 16:44:55','2019-08-11 07:44:55');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-11 22:06:53
