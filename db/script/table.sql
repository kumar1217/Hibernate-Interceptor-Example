CREATE DATABASE IF NOT EXISTS hibernate;
USE hibernate;

--
-- Definition of table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
CREATE TABLE `auditlog` (
  `AUDIT_LOG_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ACTION` varchar(100) NOT NULL,
  `DETAIL` text NOT NULL,
  `CREATED_DATE` date NOT NULL,
  `ENTITY_ID` bigint(20) unsigned NOT NULL,
  `ENTITY_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUDIT_LOG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auditlog`
--

--
-- Definition of table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CATEGORY_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(20) NOT NULL,
  `DESC` varchar(255) NOT NULL,
  PRIMARY KEY (`CATEGORY_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `STOCK_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `STOCK_CODE` varchar(10) NOT NULL,
  `STOCK_NAME` varchar(20) NOT NULL,
  PRIMARY KEY (`STOCK_ID`) USING BTREE,
  UNIQUE KEY `UNI_STOCK_NAME` (`STOCK_NAME`),
  UNIQUE KEY `UNI_STOCK_CODE` (`STOCK_CODE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock`
--


--
-- Definition of table `stock_category`
--

DROP TABLE IF EXISTS `stock_category`;
CREATE TABLE `stock_category` (
  `STOCK_CATEGORY_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `STOCK_ID` int(10) unsigned NOT NULL,
  `CATEGORY_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`STOCK_CATEGORY_ID`),
  UNIQUE KEY `UNI_STOCK_CAT_ID` (`STOCK_ID`,`CATEGORY_ID`),
  KEY `FK_STOCK_CATEGORY_CATEGORY_ID` (`CATEGORY_ID`),
  KEY `FK_STOCK_CATEGORY_STOCK_ID` (`STOCK_ID`),
  CONSTRAINT `FK_STOCK_CATEGORY_CATEGORY_ID` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `category` (`CATEGORY_ID`),
  CONSTRAINT `FK_STOCK_CATEGORY_STOCK_ID` FOREIGN KEY (`STOCK_ID`) REFERENCES `stock` (`STOCK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock_category`
--

--
-- Definition of table `stock_daily_record`
--

DROP TABLE IF EXISTS `stock_daily_record`;
CREATE TABLE `stock_daily_record` (
  `DAILY_RECORD_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PRICE_OPEN` float(6,2) DEFAULT NULL,
  `PRICE_CLOSE` float(6,2) DEFAULT NULL,
  `PRICE_CHANGE` float(6,2) DEFAULT NULL,
  `VOLUME` bigint(20) unsigned DEFAULT NULL,
  `DATE` date NOT NULL,
  `STOCK_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`DAILY_RECORD_ID`) USING BTREE,
  UNIQUE KEY `UNI_STOCK_DAILY_DATE` (`DATE`),
  KEY `FK_STOCK_DAILY_RECORD_STOCK_ID` (`STOCK_ID`),
  CONSTRAINT `FK_STOCK_DAILY_RECORD_STOCK_ID` FOREIGN KEY (`STOCK_ID`) REFERENCES `stock` (`STOCK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock_daily_record`
--

--
-- Definition of table `stock_detail`
--

DROP TABLE IF EXISTS `stock_detail`;
CREATE TABLE `stock_detail` (
  `STOCK_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `COMP_NAME` varchar(100) NOT NULL,
  `COMP_DESC` varchar(255) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `LISTED_DATE` date NOT NULL,
  PRIMARY KEY (`STOCK_ID`) USING BTREE,
  CONSTRAINT `FK_STOCK_ID` FOREIGN KEY (`STOCK_ID`) REFERENCES `stock` (`STOCK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock_detail`
--

/*!40000 ALTER TABLE `stock_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_detail` ENABLE KEYS */;


--
-- Definition of procedure `GetStocks`
--

DROP PROCEDURE IF EXISTS `GetStocks`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStocks`(int_stockcode varchar(20))
BEGIN
   SELECT * FROM stock where stock_code = int_stockcode;
   END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
