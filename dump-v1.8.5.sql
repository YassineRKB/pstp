-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: db_dev
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allblogs`
--

DROP TABLE IF EXISTS `allblogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allblogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `short_description` varchar(200) DEFAULT NULL,
  `author` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allblogs`
--

LOCK TABLES `allblogs` WRITE;
/*!40000 ALTER TABLE `allblogs` DISABLE KEYS */;
INSERT INTO `allblogs` VALUES (1,'First Blog Post','This is the content of the first blog post.','First post.','John Doe','2023-12-17 15:46:49'),(2,'Second Blog Post','This is the content of the second blog post.','Second post.','Jane Smith','2023-12-17 15:46:49'),(3,'Third Blog Post','This is the content of the third blog post.','Third post.','Alice Johnson','2023-12-17 15:46:49'),(4,'Fourth Blog Post','This is the content of the fourth blog post.','Fourth post.','Bob Anderson','2023-12-17 15:46:49'),(5,'Fifth Blog Post','This is the content of the fifth blog post.','Fifth post.','Emily Clark','2023-12-17 15:46:49');
/*!40000 ALTER TABLE `allblogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allclients`
--

DROP TABLE IF EXISTS `allclients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allclients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_name` varchar(100) NOT NULL,
  `client_email` varchar(100) NOT NULL,
  `client_phone` varchar(20) NOT NULL,
  `pet_serial` varchar(100) DEFAULT NULL,
  `pet_id` int DEFAULT NULL,
  `pet_type` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `checked_in_timestamp` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pet_id` (`pet_id`),
  CONSTRAINT `allclients_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `allpets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allclients`
--

LOCK TABLES `allclients` WRITE;
/*!40000 ALTER TABLE `allclients` DISABLE KEYS */;
INSERT INTO `allclients` VALUES (1,'John Doe','john@example.com','+123456789',NULL,1,'cat','male','2023-01-01 08:00:00','2023-12-17 15:46:49'),(2,'Jane Smith','jane@example.com','+987654321',NULL,2,'dog','female','2023-02-05 10:30:00','2023-12-17 15:46:49'),(3,'Alice Johnson','alice@example.com','+1122334455',NULL,NULL,NULL,NULL,'2023-03-10 14:45:00','2023-12-17 15:46:49'),(4,'Bob Anderson','bob@example.com','+9988776655',NULL,4,'cat','male','2023-04-15 06:00:00','2023-12-17 15:46:49'),(5,'Emily Clark','emily@example.com','+5544332211',NULL,5,'dog','female','2023-05-20 08:00:00','2023-12-17 15:46:49');
/*!40000 ALTER TABLE `allclients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allfood`
--

DROP TABLE IF EXISTS `allfood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allfood` (
  `id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(100) NOT NULL,
  `food_stock` int NOT NULL,
  `food_type` varchar(20) NOT NULL,
  `food_expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allfood`
--

LOCK TABLES `allfood` WRITE;
/*!40000 ALTER TABLE `allfood` DISABLE KEYS */;
/*!40000 ALTER TABLE `allfood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allpets`
--

DROP TABLE IF EXISTS `allpets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allpets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serial` varchar(100) NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `pet_type` varchar(20) NOT NULL,
  `pet_status` varchar(20) DEFAULT NULL,
  `background_story` text,
  `medical_history` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allpets`
--

LOCK TABLES `allpets` WRITE;
/*!40000 ALTER TABLE `allpets` DISABLE KEYS */;
INSERT INTO `allpets` VALUES (1,'123ABC','Fluffy','male','cat','not adopted','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','{\"checkups\": [\"checkup1\", \"checkup2\"]}','2023-12-17 15:46:49'),(2,'456DEF','Buddy','female','dog','adopted','Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','{\"checkups\": [\"checkup3\"]}','2023-12-17 15:46:49'),(3,'789GHI','Max','male','cat','not adopted','Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.','{\"checkups\": [\"checkup4\"]}','2023-12-17 15:46:49'),(4,'ABC123','Snowball','female','cat','not adopted','Aliquip ex ea commodo consequat.','{\"checkups\": [\"checkup5\"]}','2023-12-17 15:46:49'),(5,'DEF456','Rocky','male','dog','not adopted','Sunt in culpa qui officia deserunt mollit anim id est laborum.','{\"checkups\": [\"checkup6\"]}','2023-12-17 15:46:49'),(6,'GHI789','Luna','female','cat','adopted','Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.','{\"checkups\": [\"checkup7\"]}','2023-12-17 15:46:49');
/*!40000 ALTER TABLE `allpets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allusers`
--

DROP TABLE IF EXISTS `allusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allusers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(64) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allusers`
--

LOCK TABLES `allusers` WRITE;
/*!40000 ALTER TABLE `allusers` DISABLE KEYS */;
INSERT INTO `allusers` VALUES (1,'Yassine','Rakibi','YassineRKB','admin@pstp.ga','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','admin'),(2,'John','doe','workPanda','worker@pstp.ga','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','worker'),(3,'John','Doe','PreemClient','client@pstp.ga','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','client');
/*!40000 ALTER TABLE `allusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medic_history`
--

DROP TABLE IF EXISTS `medic_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_id` int NOT NULL,
  `checkup_timestamp` timestamp NOT NULL,
  `checkup_summary` text,
  PRIMARY KEY (`id`),
  KEY `pet_id` (`pet_id`),
  CONSTRAINT `medic_history_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `allpets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medic_history`
--

LOCK TABLES `medic_history` WRITE;
/*!40000 ALTER TABLE `medic_history` DISABLE KEYS */;
INSERT INTO `medic_history` VALUES (1,1,'2023-01-15 07:00:00','Routine checkup for male cat Fluffy'),(2,2,'2023-02-20 09:30:00','Follow-up checkup for female dog Buddy'),(3,3,'2023-03-25 10:45:00','Initial health check for male cat Max'),(4,5,'2023-04-30 12:00:00','Vaccination for male dog Rocky'),(5,2,'2023-05-10 07:30:00','Deworming for female dog Buddy');
/*!40000 ALTER TABLE `medic_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter_overview`
--

DROP TABLE IF EXISTS `shelter_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter_overview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_regi_pets` int DEFAULT '0',
  `total_food` int DEFAULT '0',
  `total_checkup` int DEFAULT '0',
  `total_clients` int DEFAULT '0',
  `total_users` int DEFAULT '0',
  `total_blogs` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter_overview`
--

LOCK TABLES `shelter_overview` WRITE;
/*!40000 ALTER TABLE `shelter_overview` DISABLE KEYS */;
INSERT INTO `shelter_overview` VALUES (1,6,0,5,5,1,5,'2023-12-17 17:12:12');
/*!40000 ALTER TABLE `shelter_overview` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-21  8:10:02
