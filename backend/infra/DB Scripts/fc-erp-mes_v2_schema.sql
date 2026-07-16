-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: Fc_erp
-- ------------------------------------------------------
-- Server version	8.0.46

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_bill_items`
--

LOCK TABLES `Fc_bill_items` WRITE;
/*!40000 ALTER TABLE `Fc_bill_items` DISABLE KEYS */;
INSERT INTO `Fc_bill_items` VALUES (3,3,'5','5_Big_Kachory',1,5.00,42.00,42.00,210.00,1,'2026-06-14 09:08:45',1,'2026-06-14 09:08:45',NULL),(4,4,'5','5_Big_Kachory',1,3.00,42.00,42.00,126.00,1,'2026-06-14 09:09:24',1,'2026-06-14 09:09:24',NULL),(17,17,'5','5_Big_Kachory',3,4.00,42.00,42.00,168.00,1,'2026-06-15 17:06:19',1,'2026-06-15 17:06:19',NULL),(18,18,'5','5_Big_Kachory',1,4.00,42.00,42.00,168.00,1,'2026-06-19 15:22:36',1,'2026-06-19 15:22:36',NULL),(19,18,'6','5_Big_Petis',1,2.00,42.00,42.00,84.00,1,'2026-06-19 15:22:36',1,'2026-06-19 15:22:36',NULL),(20,19,'6','5_Big_Petis',3,5.00,42.00,42.00,210.00,1,'2026-06-19 15:23:53',1,'2026-06-19 15:23:53',NULL),(21,20,'5','5_Big_Kachory',1,5.00,42.00,42.00,210.00,1,'2026-07-08 16:30:44',1,'2026-07-08 16:30:44',NULL),(22,20,'11','5_Box_Biscuit',1,6.00,44.00,44.00,264.00,1,'2026-07-08 16:30:44',1,'2026-07-08 16:30:44',NULL),(23,20,'12','5_Laccha_Bun',1,5.00,8.00,8.00,40.00,1,'2026-07-08 16:30:44',1,'2026-07-08 16:30:44',NULL),(24,21,'5','5_Big_Kachory',1,4.00,42.00,42.00,168.00,1,'2026-07-08 16:38:39',1,'2026-07-08 16:38:39',NULL),(25,22,'5','5_Big_Kachory',3,4.00,42.00,42.00,168.00,1,'2026-07-08 16:50:07',1,'2026-07-08 16:50:07',NULL);
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
  `pdf_path` varchar(500) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_bills`
--

LOCK TABLES `Fc_bills` WRITE;
/*!40000 ALTER TABLE `Fc_bills` DISABLE KEYS */;
INSERT INTO `Fc_bills` VALUES (3,1,3,'Telaram',1,'[{\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 5, \"total\": 210, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 42, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',210.00,0.00,0.00,'UNPAID',3,1,'uploads/invoices/bill-3.pdf',0,'2026-06-14 09:08:45',1,NULL,'2026-06-14 09:09:24'),(4,1,3,'Telaram',1,'[{\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"2\", \"unitPrice\": 8, \"productName\": \"Bread\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"3\", \"unitPrice\": 42, \"productName\": \"Big_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"4\", \"unitPrice\": 3, \"productName\": \"Roti\"}, {\"qty\": 3, \"total\": 126, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"8\", \"unitPrice\": 8, \"productName\": \"Papa\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"9\", \"unitPrice\": 42, \"productName\": \"5_pakiza\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"13\", \"unitPrice\": 22, \"productName\": \"Small_C/Roll\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"15\", \"unitPrice\": 44, \"productName\": \"5_Box_Cupcake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}]',126.00,0.00,0.00,'UNPAID',3,2,'uploads/invoices/bill-4.pdf',1,'2026-06-14 09:09:24',1,NULL,'2026-06-14 09:09:25'),(17,3,3,'Dhrub',1,'[{\"qty\": 4, \"total\": 168, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',168.00,0.00,0.00,'UNPAID',17,1,'uploads/invoices/bill-17.pdf',1,'2026-06-15 17:06:19',1,NULL,'2026-06-15 17:06:22'),(18,1,3,'Telaram',1,'[{\"qty\": 4, \"total\": 168, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 2, \"total\": 84, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',252.00,0.00,126.00,'UNPAID',18,1,'uploads/invoices/bill-18.pdf',1,'2026-06-19 15:22:36',1,NULL,'2026-06-19 15:22:39'),(19,3,3,'Dhrub',1,'[{\"qty\": 0, \"total\": 0, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 5, \"total\": 210, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',210.00,120.00,168.00,'PARTIAL',19,1,'uploads/invoices/bill-19.pdf',1,'2026-06-19 15:23:53',1,NULL,'2026-06-19 15:23:55'),(20,1,3,'Telaram',1,'[{\"qty\": 5, \"total\": 210, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 6, \"total\": 264, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 5, \"total\": 40, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',514.00,0.00,378.00,'UNPAID',20,1,'uploads/invoices/bill-20.pdf',1,'2026-07-08 16:30:44',1,NULL,'2026-07-08 16:30:47'),(21,1,3,'Telaram',1,'[{\"qty\": 4, \"total\": 168, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',168.00,0.00,892.00,'UNPAID',21,1,'uploads/invoices/bill-21.pdf',1,'2026-07-08 16:38:39',1,NULL,'2026-07-08 16:38:40'),(22,3,3,'Dhrub',1,'[{\"qty\": 4, \"total\": 168, \"productId\": \"5\", \"unitPrice\": 42, \"productName\": \"5_Big_Kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"6\", \"unitPrice\": 42, \"productName\": \"5_Big_Petis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"11\", \"unitPrice\": 44, \"productName\": \"5_Box_Biscuit\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"16\", \"unitPrice\": 22, \"productName\": \"5_Cream_Donut\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"12\", \"unitPrice\": 8, \"productName\": \"5_Laccha_Bun\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"14\", \"unitPrice\": 22, \"productName\": \"5_Small_kachory\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"10\", \"unitPrice\": 18, \"productName\": \"C_Bis\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"7\", \"unitPrice\": 8, \"productName\": \"Jam_Cake\"}, {\"qty\": 0, \"total\": 0, \"productId\": \"1\", \"unitPrice\": 22, \"productName\": \"T/cake\"}]',168.00,0.00,258.00,'UNPAID',22,1,'uploads/invoices/bill-22.pdf',1,'2026-07-08 16:50:07',1,NULL,'2026-07-08 16:50:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_client_ledger`
--

LOCK TABLES `Fc_client_ledger` WRITE;
/*!40000 ALTER TABLE `Fc_client_ledger` DISABLE KEYS */;
INSERT INTO `Fc_client_ledger` VALUES (1,1,'BILL','BILL',3,210.00,0.00,'2026-06-14 14:38:45',NULL,1,'2026-06-14 09:08:45',1,NULL,'2026-06-14 09:08:45'),(2,1,'PAYMENT','PAYMENT',3,0.00,0.00,'2026-06-14 14:38:45',NULL,1,'2026-06-14 09:08:45',1,NULL,'2026-06-14 09:08:45'),(3,1,'BILL_REVERSAL','BILL',3,0.00,210.00,'2026-06-14 14:39:24',NULL,1,'2026-06-14 09:09:24',1,NULL,'2026-06-14 09:09:24'),(4,1,'PAYMENT_REVERSAL','PAYMENT',3,0.00,0.00,'2026-06-14 14:39:24',NULL,1,'2026-06-14 09:09:24',1,NULL,'2026-06-14 09:09:24'),(5,1,'BILL','BILL',4,126.00,0.00,'2026-06-14 14:39:24',NULL,1,'2026-06-14 09:09:24',1,NULL,'2026-06-14 09:09:24'),(6,3,'BILL','BILL',17,168.00,0.00,'2026-06-15 22:36:19',NULL,1,'2026-06-15 17:06:19',1,NULL,'2026-06-15 17:06:19'),(7,3,'PAYMENT','PAYMENT',17,0.00,0.00,'2026-06-15 22:36:19',NULL,1,'2026-06-15 17:06:19',1,NULL,'2026-06-15 17:06:19'),(8,1,'BILL','BILL',18,252.00,0.00,'2026-06-19 20:52:37',NULL,1,'2026-06-19 15:22:36',1,NULL,'2026-06-19 15:22:36'),(9,1,'PAYMENT','PAYMENT',18,0.00,0.00,'2026-06-19 20:52:37',NULL,1,'2026-06-19 15:22:36',1,NULL,'2026-06-19 15:22:36'),(10,3,'BILL','BILL',19,210.00,0.00,'2026-06-19 20:53:53',NULL,1,'2026-06-19 15:23:53',1,NULL,'2026-06-19 15:23:53'),(11,3,'PAYMENT','PAYMENT',19,0.00,120.00,'2026-06-19 20:53:53',NULL,1,'2026-06-19 15:23:53',1,NULL,'2026-06-19 15:23:53'),(12,1,'BILL','BILL',20,514.00,0.00,'2026-07-08 22:00:44',NULL,1,'2026-07-08 16:30:44',1,NULL,'2026-07-08 16:30:44'),(13,1,'PAYMENT','PAYMENT',20,0.00,0.00,'2026-07-08 22:00:44',NULL,1,'2026-07-08 16:30:44',1,NULL,'2026-07-08 16:30:44'),(14,1,'BILL','BILL',21,168.00,0.00,'2026-07-08 22:08:40',NULL,1,'2026-07-08 16:38:39',1,NULL,'2026-07-08 16:38:39'),(15,1,'PAYMENT','PAYMENT',21,0.00,0.00,'2026-07-08 22:08:40',NULL,1,'2026-07-08 16:38:39',1,NULL,'2026-07-08 16:38:39'),(16,3,'BILL','BILL',22,168.00,0.00,'2026-07-08 22:20:08',NULL,1,'2026-07-08 16:50:07',1,NULL,'2026-07-08 16:50:07'),(17,3,'PAYMENT','PAYMENT',22,0.00,0.00,'2026-07-08 22:20:08',NULL,1,'2026-07-08 16:50:07',1,NULL,'2026-07-08 16:50:07');
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
INSERT INTO `Fc_clients` VALUES (1,'Telaram','NA','telaram@example.com','CKP, Jharkhand','19ABCDE1234F1Z5',3,50000.00,1,'2026-03-22 09:09:13',1,1060.00,NULL,'2026-07-08 16:38:39'),(2,'Prabhu','NA','global@example.com','Delhi, India','07PQRSX5678L1Z2',2,100000.00,1,'2026-03-22 09:09:13',1,0.00,NULL,'2026-06-13 13:35:50'),(3,'Dhrub','NA','modernshop@example.com','Patna, Bihar','NA',3,20000.00,1,'2026-03-22 09:09:13',1,426.00,NULL,'2026-07-08 16:50:07'),(4,'Faraz','NA','faraz@example.com','Banglatand, Ward no 19, CKP','NA',1,500.00,1,'2026-05-28 16:22:25',NULL,0.00,NULL,'2026-06-13 13:35:50');
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
-- Table structure for table `Fc_product_recipe_mapping`
--

DROP TABLE IF EXISTS `Fc_product_recipe_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_product_recipe_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` varchar(50) NOT NULL,
  `raw_material_id` bigint NOT NULL,
  `quantity_required` decimal(12,3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `raw_material_id` (`raw_material_id`),
  CONSTRAINT `Fc_product_recipe_mapping_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`),
  CONSTRAINT `Fc_product_recipe_mapping_ibfk_2` FOREIGN KEY (`raw_material_id`) REFERENCES `Fc_raw_materials` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_product_recipe_mapping`
--

LOCK TABLES `Fc_product_recipe_mapping` WRITE;
/*!40000 ALTER TABLE `Fc_product_recipe_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_product_recipe_mapping` ENABLE KEYS */;
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
  `produced_packets` int NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_production_entries`
--

LOCK TABLES `Fc_production_entries` WRITE;
/*!40000 ALTER TABLE `Fc_production_entries` DISABLE KEYS */;
INSERT INTO `Fc_production_entries` VALUES (1,'2026-06-13','11',12.000,25,NULL,'2026-06-13 16:36:09',NULL,'2026-06-13 16:36:09',NULL),(2,'2026-06-13','12',12.000,200,NULL,'2026-06-13 19:17:02',NULL,'2026-06-14 17:11:19',NULL),(3,'2026-06-14','16',20.000,120,NULL,'2026-06-14 09:44:39',NULL,'2026-06-14 09:44:39',NULL),(4,'2026-06-14','10',12.000,100,NULL,'2026-06-14 09:55:07',NULL,'2026-06-14 09:55:07',NULL),(5,'2026-06-15','1',116.000,500,NULL,'2026-06-15 16:56:15',NULL,'2026-06-15 16:56:15',NULL),(6,'2026-06-15','7',15.000,110,NULL,'2026-06-15 16:56:48',NULL,'2026-06-15 17:05:26',NULL),(7,'2026-06-25','10',15.000,9,NULL,'2026-06-26 10:23:47',NULL,'2026-06-26 10:23:47',NULL),(8,'2026-06-25','11',45.000,255,NULL,'2026-06-26 10:24:09',NULL,'2026-06-26 10:24:09',NULL),(9,'2026-06-25','14',15.000,255,NULL,'2026-06-26 10:24:26',NULL,'2026-06-26 10:24:26',NULL),(10,'2026-06-26','1',100.000,100,NULL,'2026-06-26 12:01:39',1,'2026-06-26 12:01:39',1),(11,'2026-06-26','10',100.000,100,NULL,'2026-06-26 12:01:39',1,'2026-06-26 12:01:39',1),(12,'2026-06-26','2',100.000,200,NULL,'2026-06-26 12:09:31',1,'2026-07-08 17:10:26',1),(13,'2026-06-26','11',500.000,100,NULL,'2026-06-26 12:09:31',1,'2026-06-26 12:09:31',1),(14,'2026-06-26','12',200.000,100,NULL,'2026-06-26 12:09:31',1,'2026-06-26 12:09:31',1),(15,'2026-07-08','2',10.000,10,NULL,'2026-07-08 16:23:43',1,'2026-07-08 17:09:25',1),(16,'2026-07-08','1',10.000,10,NULL,'2026-07-08 16:25:46',1,'2026-07-08 16:25:46',1),(17,'2026-07-08','1',10.000,10,NULL,'2026-07-08 17:15:31',1,'2026-07-08 17:15:31',1),(18,'2026-07-08','2',20.000,100,NULL,'2026-07-08 17:15:31',1,'2026-07-08 17:15:31',1);
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
  `batch_size` decimal(10,3) NOT NULL DEFAULT '0.000',
  `packets_per_batch` int NOT NULL DEFAULT '0',
  `rate_per_kg` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price` decimal(12,2) NOT NULL,
  `unit` varchar(20) DEFAULT 'KG',
  `current_stock` decimal(12,0) NOT NULL DEFAULT '0',
  `category` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_products`
--

LOCK TABLES `Fc_products` WRITE;
/*!40000 ALTER TABLE `Fc_products` DISABLE KEYS */;
INSERT INTO `Fc_products` VALUES ('1','T/cake',19.500,166,10.00,20.00,'KG',830,NULL,1,'2026-03-22 09:56:53',NULL,NULL,'2026-07-09 18:13:45',NULL),('10','C_Bis',0.000,0,0.00,20.00,'KG',209,NULL,1,'2026-05-28 12:13:24',NULL,NULL,'2026-06-26 12:01:39',NULL),('11','5_Box_Biscuit',0.000,0,0.00,60.00,'KG',374,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-07-08 16:30:44',NULL),('12','5_Laccha_Bun',0.000,0,0.00,10.00,'KG',295,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-07-08 16:30:44',NULL),('13','Small_C/Roll',0.000,0,0.00,30.00,'KG',0,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48',NULL),('14','5_Small_kachory',0.000,0,0.00,30.00,'KG',255,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-26 10:24:26',NULL),('15','5_Box_Cupcake',0.000,0,0.00,60.00,'KG',0,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48',NULL),('16','5_Cream_Donut',0.000,0,0.00,30.00,'KG',120,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-14 09:44:39',NULL),('2','Bread',0.000,0,0.00,10.00,'KG',100,NULL,0,'2026-03-22 09:56:53',NULL,NULL,'2026-07-08 17:15:31',NULL),('3','Big_C/Roll',0.000,0,0.00,60.00,'KG',0,NULL,0,'2026-03-22 09:56:53',NULL,NULL,'2026-06-06 23:15:48',NULL),('4','Roti',0.000,0,0.00,5.00,'KG',0,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48',NULL),('5','5_Big_Kachory',0.000,0,0.00,60.00,'KG',20,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-07-08 16:50:07',NULL),('6','5_Big_Petis',0.000,0,0.00,60.00,'KG',43,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-19 15:23:53',NULL),('7','Jam_Cake',0.000,0,0.00,10.00,'KG',110,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-15 17:05:26',NULL),('8','Papa',0.000,0,0.00,10.00,'KG',0,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48',NULL),('9','5_pakiza',0.000,0,0.00,60.00,'KG',0,NULL,0,'2026-05-28 12:13:24',NULL,NULL,'2026-06-06 23:15:48',NULL);
/*!40000 ALTER TABLE `Fc_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_raw_materials`
--

DROP TABLE IF EXISTS `Fc_raw_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_raw_materials` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `material_name` varchar(200) NOT NULL,
  `unit_id` int NOT NULL,
  `current_stock` decimal(12,3) DEFAULT '0.000',
  `reorder_level` decimal(12,3) DEFAULT '0.000',
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `unit_id` (`unit_id`),
  CONSTRAINT `Fc_raw_materials_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `Fc_units` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_raw_materials`
--

LOCK TABLES `Fc_raw_materials` WRITE;
/*!40000 ALTER TABLE `Fc_raw_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fc_raw_materials` ENABLE KEYS */;
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
-- Table structure for table `Fc_stock_adjustments`
--

DROP TABLE IF EXISTS `Fc_stock_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_stock_adjustments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` varchar(50) NOT NULL,
  `old_stock` decimal(12,3) NOT NULL,
  `new_stock` decimal(12,3) NOT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `fk_stock_adjustment_product` FOREIGN KEY (`product_id`) REFERENCES `Fc_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_stock_adjustments`
--

LOCK TABLES `Fc_stock_adjustments` WRITE;
/*!40000 ALTER TABLE `Fc_stock_adjustments` DISABLE KEYS */;
INSERT INTO `Fc_stock_adjustments` VALUES (1,'5',0.000,45.000,'added',NULL,'2026-06-14 09:03:22'),(2,'5',42.000,41.000,'added',NULL,'2026-06-14 09:22:27'),(3,'6',0.000,52.000,'adjustment',NULL,'2026-06-14 09:42:57'),(4,'7',0.000,0.000,'',NULL,'2026-06-14 17:08:01'),(5,'6',52.000,50.000,'',NULL,'2026-06-15 17:05:46');
/*!40000 ALTER TABLE `Fc_stock_adjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fc_units`
--

DROP TABLE IF EXISTS `Fc_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fc_units` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_code` varchar(20) NOT NULL,
  `unit_name` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unit_code` (`unit_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fc_units`
--

LOCK TABLES `Fc_units` WRITE;
/*!40000 ALTER TABLE `Fc_units` DISABLE KEYS */;
INSERT INTO `Fc_units` VALUES (1,'KG','Kilogram',1,'2026-06-26 09:32:25','2026-06-26 09:32:25'),(2,'ML','Miligram',1,'2026-06-26 09:46:00','2026-06-26 09:47:07');
/*!40000 ALTER TABLE `Fc_units` ENABLE KEYS */;
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

-- Dump completed on 2026-07-16 21:52:07
