-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: Fc_erp
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Fc_bill_items`
--

DROP TABLE IF EXISTS `Fc_bill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_bill_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `client_id` int NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '1.00',
  `unit_price` decimal(12,2) NOT NULL,
  `product_price_snapshot` decimal(12,2) DEFAULT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`),
  KEY `product_id` (`product_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `Fc_bill_items_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `Fc_bills` (`id`),
  CONSTRAINT `Fc_bill_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`),
  CONSTRAINT `Fc_bill_items_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `Fc_clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_bill_items`
--

LOCK TABLES `Fc_bill_items` WRITE;
/*!40000 ALTER TABLE `Fc_bill_items` DISABLE KEYS */;
INSERT INTO `Fc_bill_items` VALUES (1,1,'1','T/cake',4,3.00,30.00,30.00,90.00,1,'2026-06-07 11:08:29',1,'2026-06-07 11:08:29',NULL),(2,2,'1','T/cake',3,5.00,22.00,22.00,110.00,1,'2026-06-07 11:08:51',1,'2026-06-07 11:08:51',NULL),(3,3,'1','T/cake',3,7.00,22.00,22.00,154.00,1,'2026-06-07 11:13:11',1,'2026-06-07 11:13:11',NULL),(4,4,'8','Papa',2,3.00,8.00,8.00,24.00,1,'2026-06-07 17:22:55',1,'2026-06-07 17:22:55',NULL),(5,5,'1','T/cake',1,2.00,22.00,22.00,44.00,1,'2026-06-07 20:21:47',1,'2026-06-07 20:21:47',NULL),(6,6,'1','T/cake',1,2.00,22.00,22.00,44.00,1,'2026-06-07 20:22:17',1,'2026-06-07 20:22:17',NULL),(7,7,'1','T/cake',1,2.00,22.00,22.00,44.00,1,'2026-06-08 19:38:26',1,'2026-06-08 19:38:26',NULL),(8,8,'1','T/cake',1,5.00,22.00,22.00,110.00,1,'2026-06-08 19:45:48',1,'2026-06-08 19:45:48',NULL);
/*!40000 ALTER TABLE `Fc_bill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_bills`
--

DROP TABLE IF EXISTS `Fc_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clientId` int DEFAULT NULL,
  `priceListId` int DEFAULT NULL,
  `clientName` varchar(120) NOT NULL,
  `inhouse` tinyint(1) DEFAULT '0',
  `items` json NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `paidAmount` decimal(12,2) DEFAULT '0.00',
  `previousAmount` decimal(12,2) DEFAULT '0.00',
  `payment_status` enum('UNPAID','PARTIAL','PAID') DEFAULT 'UNPAID',
  `original_bill_id` int DEFAULT NULL,
  `version_number` int DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `fk_bill_price_list` (`priceListId`),
  CONSTRAINT `Fc_bills_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Fc_clients` (`id`),
  CONSTRAINT `fk_bill_price_list` FOREIGN KEY (`priceListId`) REFERENCES `Fc_price_lists` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_bills`
--

LOCK TABLES `Fc_bills` WRITE;
/*!40000 ALTER TABLE `Fc_bills` DISABLE KEYS */;
INSERT INTO `Fc_bills` VALUES (1,4,1,'Faraz',1,'[{\"qty\": 3, \"total\": 90, \"productId\": \"1\", \"unitPrice\": 30, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 10, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 60, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 5, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 60, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 60, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 10, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 10, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 60, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 20, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 60, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 10, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 30, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 30, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 60, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 30, \"productName\": \"5_Cream_Donut\"}]',90.00,0.00,0.00,'UNPAID',1,1,1,'2026-06-07 11:08:29',1,NULL,'2026-06-07 11:08:29'),(2,3,3,'Dhrub',1,'[{\"qty\": 5, \"total\": 110, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 42, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',110.00,0.00,0.00,'UNPAID',2,1,0,'2026-06-07 11:08:51',1,NULL,'2026-06-07 11:13:11'),(3,3,3,'Dhrub',1,'[{\"qty\": 7, \"total\": 154, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 42, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',154.00,0.00,0.00,'UNPAID',2,2,1,'2026-06-07 11:13:11',1,NULL,'2026-06-07 11:13:11'),(4,2,2,'Prabhu',1,'[{\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 40, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3.75, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 40, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 40, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 3, \"total\": 24, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 40, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 40, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 42, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',24.00,0.00,0.00,'UNPAID',4,1,1,'2026-06-07 17:22:55',1,NULL,'2026-06-07 17:22:55'),(5,1,3,'Telaram',1,'[{\"qty\": 2, \"total\": 44, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 48, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',44.00,0.00,0.00,'UNPAID',5,1,0,'2026-06-07 20:21:46',1,NULL,'2026-06-07 20:22:17'),(6,1,3,'Telaram',1,'[{\"qty\": 2, \"total\": 44, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 48, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',44.00,0.00,0.00,'UNPAID',5,2,0,'2026-06-07 20:22:17',1,NULL,'2026-06-08 19:38:26'),(7,1,3,'Telaram',1,'[{\"qty\": 2, \"total\": 44, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 48, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',44.00,0.00,0.00,'UNPAID',5,3,1,'2026-06-08 19:38:26',1,NULL,'2026-06-08 19:38:26'),(8,1,3,'Telaram',1,'[{\"qty\": 5, \"total\": 110, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 42, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',110.00,0.00,44.00,'UNPAID',8,1,1,'2026-06-08 19:45:48',1,NULL,'2026-06-08 19:45:48');
/*!40000 ALTER TABLE `Fc_bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_client_ledger`
--

DROP TABLE IF EXISTS `Fc_client_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_client_ledger` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `entry_type` enum('BILL','BILL_REVERSAL','PAYMENT','PAYMENT_REVERSAL') NOT NULL,
  `reference_type` enum('BILL','PAYMENT') NOT NULL,
  `reference_id` int NOT NULL,
  `debit` decimal(12,2) DEFAULT '0.00',
  `credit` decimal(12,2) DEFAULT '0.00',
  `entry_date` datetime NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `Fc_client_ledger_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Fc_clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_client_ledger`
--

LOCK TABLES `Fc_client_ledger` WRITE;
/*!40000 ALTER TABLE `Fc_client_ledger` DISABLE KEYS */;
INSERT INTO `Fc_client_ledger` VALUES (1,4,'BILL','BILL',1,90.00,0.00,'2026-06-07 16:38:30',NULL,1,'2026-06-07 11:08:29',1,NULL,'2026-06-07 11:08:29'),(2,4,'PAYMENT','PAYMENT',1,0.00,0.00,'2026-06-07 16:38:30',NULL,1,'2026-06-07 11:08:29',1,NULL,'2026-06-07 11:08:29'),(3,3,'BILL','BILL',2,110.00,0.00,'2026-06-07 16:38:52',NULL,1,'2026-06-07 11:08:51',1,NULL,'2026-06-07 11:08:51'),(4,3,'PAYMENT','PAYMENT',2,0.00,0.00,'2026-06-07 16:38:52',NULL,1,'2026-06-07 11:08:51',1,NULL,'2026-06-07 11:08:51'),(5,3,'BILL_REVERSAL','BILL',2,0.00,110.00,'2026-06-07 16:43:12',NULL,1,'2026-06-07 11:13:11',1,NULL,'2026-06-07 11:13:11'),(6,3,'PAYMENT_REVERSAL','PAYMENT',2,0.00,0.00,'2026-06-07 16:43:12',NULL,1,'2026-06-07 11:13:11',1,NULL,'2026-06-07 11:13:11'),(7,3,'BILL','BILL',3,154.00,0.00,'2026-06-07 16:43:12',NULL,1,'2026-06-07 11:13:11',1,NULL,'2026-06-07 11:13:11'),(8,2,'BILL','BILL',4,24.00,0.00,'2026-06-07 22:52:56',NULL,1,'2026-06-07 17:22:55',1,NULL,'2026-06-07 17:22:55'),(9,2,'PAYMENT','PAYMENT',4,0.00,0.00,'2026-06-07 22:52:56',NULL,1,'2026-06-07 17:22:55',1,NULL,'2026-06-07 17:22:55'),(10,1,'BILL','BILL',5,44.00,0.00,'2026-06-08 01:51:47',NULL,1,'2026-06-07 20:21:47',1,NULL,'2026-06-07 20:21:47'),(11,1,'PAYMENT','PAYMENT',5,0.00,0.00,'2026-06-08 01:51:47',NULL,1,'2026-06-07 20:21:47',1,NULL,'2026-06-07 20:21:47'),(12,1,'BILL_REVERSAL','BILL',5,0.00,44.00,'2026-06-08 01:52:18',NULL,1,'2026-06-07 20:22:17',1,NULL,'2026-06-07 20:22:17'),(13,1,'PAYMENT_REVERSAL','PAYMENT',5,0.00,0.00,'2026-06-08 01:52:18',NULL,1,'2026-06-07 20:22:17',1,NULL,'2026-06-07 20:22:17'),(14,1,'BILL','BILL',6,44.00,0.00,'2026-06-08 01:52:18',NULL,1,'2026-06-07 20:22:17',1,NULL,'2026-06-07 20:22:17'),(15,1,'BILL_REVERSAL','BILL',6,0.00,44.00,'2026-06-09 01:08:26',NULL,1,'2026-06-08 19:38:26',1,NULL,'2026-06-08 19:38:26'),(16,1,'BILL','BILL',7,44.00,0.00,'2026-06-09 01:08:26',NULL,1,'2026-06-08 19:38:26',1,NULL,'2026-06-08 19:38:26'),(17,1,'BILL','BILL',8,110.00,0.00,'2026-06-09 01:15:48',NULL,1,'2026-06-08 19:45:48',1,NULL,'2026-06-08 19:45:48'),(18,1,'PAYMENT','PAYMENT',8,0.00,0.00,'2026-06-09 01:15:48',NULL,1,'2026-06-08 19:45:48',1,NULL,'2026-06-08 19:45:48');
/*!40000 ALTER TABLE `Fc_client_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_clients`
--

DROP TABLE IF EXISTS `Fc_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `address` text,
  `gstNumber` varchar(50) DEFAULT NULL,
  `price_list_id` int DEFAULT NULL,
  `credit_limit` decimal(12,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT '0.00',
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_clients`
--

LOCK TABLES `Fc_clients` WRITE;
/*!40000 ALTER TABLE `Fc_clients` DISABLE KEYS */;
INSERT INTO `Fc_clients` VALUES (1,'Telaram','NA','telaram@example.com','CKP, Jharkhand','19ABCDE1234F1Z5',3,50000.00,1,'2026-03-22 09:09:13',1,154.00,NULL,'2026-06-08 19:45:48'),(2,'Prabhu','NA','global@example.com','Delhi, India','07PQRSX5678L1Z2',2,100000.00,1,'2026-03-22 09:09:13',1,24.00,NULL,'2026-06-07 17:22:55'),(3,'Dhrub','NA','modernshop@example.com','Patna, Bihar','NA',3,20000.00,1,'2026-03-22 09:09:13',1,154.00,NULL,'2026-06-07 11:13:11'),(4,'Faraz','NA','faraz@example.com','Banglatand, Ward no 19, CKP','NA',1,500.00,1,'2026-05-28 16:22:25',NULL,90.00,NULL,'2026-06-07 11:08:29');
/*!40000 ALTER TABLE `Fc_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_inventory_transactions`
--

DROP TABLE IF EXISTS `Fc_inventory_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_inventory_transactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` varchar(50) NOT NULL,
  `transaction_type` enum('PRODUCTION','SALE','ADJUSTMENT') NOT NULL,
  `quantity` decimal(12,3) NOT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` bigint DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Fc_inventory_transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_inventory_transactions`
--

LOCK TABLES `Fc_inventory_transactions` WRITE;
/*!40000 ALTER TABLE `Fc_inventory_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_inventory_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_payments`
--

DROP TABLE IF EXISTS `Fc_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference_number` varchar(120) DEFAULT NULL,
  `note` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `Fc_payments_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Fc_clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_payments`
--

LOCK TABLES `Fc_payments` WRITE;
/*!40000 ALTER TABLE `Fc_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_permissions`
--

DROP TABLE IF EXISTS `Fc_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `code` varchar(150) DEFAULT NULL,
  `description` text,
  `created_by` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_permissions`
--

LOCK TABLES `Fc_permissions` WRITE;
/*!40000 ALTER TABLE `Fc_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_price_list_products`
--

DROP TABLE IF EXISTS `Fc_price_list_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_price_list_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price_list_id` int DEFAULT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `price_list_id` (`price_list_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Fc_price_list_products_ibfk_1` FOREIGN KEY (`price_list_id`) REFERENCES `Fc_price_lists` (`id`),
  CONSTRAINT `Fc_price_list_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_price_list_products`
--

LOCK TABLES `Fc_price_list_products` WRITE;
/*!40000 ALTER TABLE `Fc_price_list_products` DISABLE KEYS */;
INSERT INTO `Fc_price_list_products` VALUES (3,1,'1',30.00,1,'2026-05-21 20:43:51',1,1,'2026-05-21 20:44:51'),(4,2,'1',22.00,1,'2026-05-21 20:44:51',1,1,'2026-05-21 20:44:51'),(47,1,'2',10.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(48,2,'2',8.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(49,1,'3',60.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(50,2,'3',40.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(51,1,'4',5.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(52,2,'4',3.75,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(53,1,'5',60.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(54,2,'5',40.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(55,1,'6',60.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(56,2,'6',40.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(57,1,'7',10.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(58,2,'7',8.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(59,1,'8',10.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(60,2,'8',8.00,1,'2026-05-28 16:00:17',NULL,NULL,'2026-05-28 16:00:17'),(61,1,'9',60.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(62,2,'9',40.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(63,1,'10',20.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(64,2,'10',18.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(65,1,'11',60.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(66,2,'11',40.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(67,1,'12',10.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(68,2,'12',8.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(69,1,'13',30.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(70,2,'13',22.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(71,1,'14',30.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(72,2,'14',22.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(73,1,'15',60.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(74,2,'15',42.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(75,1,'16',30.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(76,2,'16',22.00,1,'2026-05-28 16:11:04',NULL,NULL,'2026-05-28 16:11:04'),(77,3,'1',22.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(78,3,'2',8.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 18:52:11'),(79,3,'3',42.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(80,3,'4',3.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-06-06 18:27:57'),(81,3,'5',42.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(82,3,'6',42.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(83,3,'7',8.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(84,3,'8',8.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(85,3,'9',42.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(86,3,'10',18.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(87,3,'11',44.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(88,3,'12',8.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(89,3,'13',22.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(90,3,'14',22.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(91,3,'15',44.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43'),(92,3,'16',22.00,1,'2026-05-28 16:20:43',NULL,NULL,'2026-05-28 16:20:43');
/*!40000 ALTER TABLE `Fc_price_list_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_price_lists`
--

DROP TABLE IF EXISTS `Fc_price_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_price_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_price_lists`
--

LOCK TABLES `Fc_price_lists` WRITE;
/*!40000 ALTER TABLE `Fc_price_lists` DISABLE KEYS */;
INSERT INTO `Fc_price_lists` VALUES (1,'Retail Price','Default retail pricing',1,'2026-03-22 09:08:49',NULL,NULL,'2026-05-21 20:24:01'),(2,'Wholesale Price','Bulk customer pricing',1,'2026-03-22 09:08:49',NULL,NULL,'2026-05-21 20:24:01'),(3,'Salesman Price','Salesman wholwsale price',1,'2026-05-28 16:01:15',NULL,NULL,'2026-05-28 16:01:15');
/*!40000 ALTER TABLE `Fc_price_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_production_entries`
--

DROP TABLE IF EXISTS `Fc_production_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_production_entries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `production_date` date NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `quantity` decimal(12,3) NOT NULL,
  `remarks` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `Fc_production_entries_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`),
  CONSTRAINT `Fc_production_entries_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `Fc_users` (`id`),
  CONSTRAINT `Fc_production_entries_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `Fc_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_production_entries`
--

LOCK TABLES `Fc_production_entries` WRITE;
/*!40000 ALTER TABLE `Fc_production_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_production_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_products`
--

DROP TABLE IF EXISTS `Fc_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_products` (
  `id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `unit` varchar(20) DEFAULT 'KG',
  `category` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_products`
--

LOCK TABLES `Fc_products` WRITE;
/*!40000 ALTER TABLE `Fc_products` DISABLE KEYS */;
INSERT INTO `Fc_products` VALUES ('1','T/cake',30.00,'KG',NULL,1,'2026-03-22 09:56:53',NULL,NULL,'2026-05-28 12:13:24'),('10','C_Bis',20.00,'KG',NULL,1,'2026-05-28 12:13:24',NULL,NULL,'2026-05-28 12:13:24'),('11','5_Box_Biscuit',60.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('12','5_Laccha_Bun',10.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('13','Small_C/Roll',30.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('14','5_Small_kachory',30.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('15','5_Box_Cupcake',60.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('16','5_Cream_Donut',30.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('2','Bread',10.00,'KG',NULL,0,'2026-03-22 09:56:53',NULL,NULL,'2026-06-06 23:15:48'),('3','Big_C/Roll',60.00,'KG',NULL,0,'2026-03-22 09:56:53',NULL,NULL,'2026-06-06 23:15:48'),('4','Roti',5.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('5','5_Big_Kachory',60.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('6','5_Big_Petis',60.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('7','Jam_Cake',10.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('8','Papa',10.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48'),('9','5_pakiza',60.00,'KG',NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48');
/*!40000 ALTER TABLE `Fc_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_role_permissions`
--

DROP TABLE IF EXISTS `Fc_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_role_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `Fc_role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `Fc_roles` (`id`),
  CONSTRAINT `Fc_role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `Fc_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_role_permissions`
--

LOCK TABLES `Fc_role_permissions` WRITE;
/*!40000 ALTER TABLE `Fc_role_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_roles`
--

DROP TABLE IF EXISTS `Fc_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_roles`
--

LOCK TABLES `Fc_roles` WRITE;
/*!40000 ALTER TABLE `Fc_roles` DISABLE KEYS */;
INSERT INTO `Fc_roles` VALUES (1,'ADMIN','System Administrator',1,'2026-03-22 09:04:00',NULL,'2026-05-21 20:24:00'),(2,'MANAGER','Business Manager',1,'2026-03-22 09:04:00',NULL,'2026-05-21 20:24:00'),(3,'STAFF','Regular Staff User',1,'2026-03-22 09:04:00',NULL,'2026-05-21 20:24:00');
/*!40000 ALTER TABLE `Fc_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_settings`
--

DROP TABLE IF EXISTS `Fc_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(120) DEFAULT NULL,
  `setting_value` text,
  `created_by` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_settings`
--

LOCK TABLES `Fc_settings` WRITE;
/*!40000 ALTER TABLE `Fc_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_users`
--

DROP TABLE IF EXISTS `Fc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `Fc_users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `Fc_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_users`
--

LOCK TABLES `Fc_users` WRITE;
/*!40000 ALTER TABLE `Fc_users` DISABLE KEYS */;
INSERT INTO `Fc_users` VALUES (1,'Admin User','admin@fcerp.com','$2b$10$examplehash1',1,1,'2026-03-22 09:04:30',NULL,NULL,'2026-05-21 20:24:00'),(2,'Manager User','manager@fcerp.com','$2b$10$examplehash2',2,1,'2026-03-22 09:04:30',1,NULL,'2026-05-21 20:24:00'),(3,'Staff User','staff@fcerp.com','$2b$10$examplehash3',3,1,'2026-03-22 09:04:30',1,NULL,'2026-05-21 20:24:00'),(4,'Demo Admin','demo@admin.com','123456',1,1,'2026-03-22 09:05:32',NULL,NULL,'2026-05-21 20:24:00');
/*!40000 ALTER TABLE `Fc_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09  1:38:54
