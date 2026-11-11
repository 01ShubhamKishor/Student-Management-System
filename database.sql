CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `admin_detail`
--

DROP TABLE IF EXISTS `admin_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_detail` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(45) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `ROLE` varchar(20) NOT NULL,
  `ADDRESS` varchar(45) NOT NULL,
  `DOB` date NOT NULL,
  `CONTACT` varchar(45) NOT NULL,
  `ACTIVE` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_detail`
--

LOCK TABLES `admin_detail` WRITE;
/*!40000 ALTER TABLE `admin_detail` DISABLE KEYS */;
INSERT INTO `admin_detail` VALUES (1,'Shubham kumar ','shubhamkishor416@gmail.com','Shubham@125','SUPER_ADMIN','Hazaribag,Jharkhand','2002-10-01','9608674280','1'),(2,'Alex','Alex@gmail.com','Alex@123','ADMIN','Ranchi','2004-01-05','89754522258','1');
/*!40000 ALTER TABLE `admin_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_detail`
--

DROP TABLE IF EXISTS `course_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_detail` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `COURSE_CODE` varchar(50) NOT NULL,
  `COURSE` varchar(50) NOT NULL,
  `DEPARTMENT` varchar(100) NOT NULL,
  `DURATION_YEAR` int NOT NULL,
  `TOTAL_SEMESTER` int NOT NULL,
  `FEE` decimal(10,2) NOT NULL,
  `DESCRIPTION` varchar(45) NOT NULL,
  `ACTIVE` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_course_code` (`COURSE_CODE`),
  UNIQUE KEY `unique_course_department` (`COURSE`,`DEPARTMENT`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_detail`
--

LOCK TABLES `course_detail` WRITE;
/*!40000 ALTER TABLE `course_detail` DISABLE KEYS */;
INSERT INTO `course_detail` VALUES (1,'BTECH-CSE','B.Tech','Computer Science',4,8,120000.00,'B.Tech in Computer Science','1'),(2,'BTECH-IT','B.Tech','Information Technology',4,8,110000.00,'B.Tech in IT','1'),(3,'BTECH-ECE','B.Tech','Electronics & Communication',4,8,105000.00,'B.Tech in ECE','1'),(4,'BTECH-EEE','B.Tech','Electrical Engineering',4,8,100000.00,'B.Tech in Electrical','1'),(5,'BTECH-ME','B.Tech','Mechanical Engineering',4,8,100000.00,'B.Tech in Mechanical','1'),(6,'BTECH-CE','B.Tech','Civil Engineering',4,8,95000.00,'B.Tech in Civil','1'),(7,'BTECH-AI','B.Tech','Artificial Intelligence',4,8,150000.00,'B.Tech in AI and Data Science','1'),(8,'BTECH-DS','B.Tech','Data Science',4,8,145000.00,'B.Tech in Data Science','1'),(9,'BTECH-CY','B.Tech','Cyber Security',4,8,140000.00,'B.Tech in Cyber Security','1'),(10,'BTECH-AIML','B.Tech','AI & ML',4,8,155000.00,'B.Tech in AI ML','1'),(11,'BCA-GEN','BCA','Computer Application',3,6,60000.00,'Bachelor of Computer Applications','1'),(12,'BCA-DS','BCA','Data Science',3,6,75000.00,'BCA in Data Science','1'),(13,'BCA-AI','BCA','Artificial Intelligence',3,6,80000.00,'BCA in AI','1'),(14,'MCA-GEN','MCA','Computer Application',2,4,90000.00,'Master of Computer Applications','1'),(15,'MCA-AI','MCA','Artificial Intelligence',2,4,110000.00,'MCA in AI','1'),(16,'BBA-GEN','BBA','Business Administration',3,6,65000.00,'Bachelor of Business Administration','1'),(17,'BBA-FIN','BBA','Finance',3,6,70000.00,'BBA in Finance','1'),(18,'BBA-MKT','BBA','Marketing',3,6,70000.00,'BBA in Marketing','1'),(19,'BBA-HR','BBA','Human Resource',3,6,65000.00,'BBA in HR','1'),(20,'BBA-IB','BBA','International Business',3,6,85000.00,'BBA in IB','1'),(21,'MBA-GEN','MBA','Business Administration',2,4,150000.00,'Master of Business Administration','1'),(22,'MBA-FIN','MBA','Finance',2,4,160000.00,'MBA in Finance','1'),(23,'MBA-MKT','MBA','Marketing',2,4,160000.00,'MBA in Marketing','1'),(24,'MBA-HR','MBA','Human Resource',2,4,150000.00,'MBA in HR','1'),(26,'BSC-CS','B.Sc','Computer Science',3,6,40000.00,'B.Sc in Computer Science','1'),(27,'BSC-IT','B.Sc','Information Technology',3,6,40000.00,'B.Sc in IT','1'),(28,'BSC-PHY','B.Sc','Physics',3,6,35000.00,'B.Sc in Physics','1'),(29,'BSC-CHE','B.Sc','Chemistry',3,6,35000.00,'B.Sc in Chemistry','1'),(30,'BSC-MATH','B.Sc','Mathematics',3,6,35000.00,'B.Sc in Mathematics','1'),(31,'MSC-CS','M.Sc','Computer Science',2,4,60000.00,'M.Sc in CS','1'),(32,'MSC-IT','M.Sc','Information Technology',2,4,60000.00,'M.Sc in IT','1'),(33,'BCOM-GEN','B.Com','Arts',1,6,30000.00,'Bachelor of Commerce','1'),(34,'BCOM-HON','B.Com','Commerce Honors',3,6,40000.00,'B.Com Honors','1'),(35,'MCOM-GEN','M.Com','Commerce',2,4,45000.00,'Master of Commerce','1'),(36,'BA-ENG','B.A','English',3,6,25000.00,'B.A in English','1'),(37,'BA-HIS','B.A','History',3,6,25000.00,'B.A in History','1'),(38,'BA-ECO','B.A','Economics',3,6,28000.00,'B.A in Economics','1'),(39,'MA-ENG','M.A','English',2,4,35000.00,'M.A in English','1'),(40,'BPHARM','B.Pharm','Pharmacy',4,8,110000.00,'Bachelor of Pharmacy','1'),(41,'MPHARM','M.Pharm','Pharmacy',2,4,130000.00,'Master of Pharmacy','1'),(42,'DIPL-CSE','Diploma','Computer Science',3,6,45000.00,'Diploma in CSE','1'),(43,'DIPL-ME','Diploma','Mechanical',3,6,40000.00,'Diploma in Mechanical','1'),(44,'DIPL-CE','Diploma','Civil',3,6,40000.00,'Diploma in Civil','1'),(45,'BARCH','B.Arch','Architecture',5,10,130000.00,'Bachelor of Architecture','1'),(47,'LLB','LLB','Law',3,6,75000.00,'Bachelor of Law','1');
/*!40000 ALTER TABLE `course_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STUDENT_ID` int DEFAULT NULL,
  `COURSE_CODE` varchar(20) DEFAULT NULL,
  `TOTAL_FEE` int DEFAULT NULL,
  `PAID_FEE` int DEFAULT NULL,
  `DUE_FEE` int DEFAULT NULL,
  `PAYMENT_DATE` date DEFAULT NULL,
  `PAYMENT_MODE` varchar(20) DEFAULT NULL,
  `REMARK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `STUDENT_ID` (`STUDENT_ID`),
  KEY `COURSE_CODE` (`COURSE_CODE`),
  CONSTRAINT `fee_ibfk_1` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student_details` (`ID`),
  CONSTRAINT `fee_ibfk_2` FOREIGN KEY (`COURSE_CODE`) REFERENCES `course_detail` (`COURSE_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee`
--

LOCK TABLES `fee` WRITE;
/*!40000 ALTER TABLE `fee` DISABLE KEYS */;
INSERT INTO `fee` VALUES (3,7,'MCA-GEN',90000,90000,0,'2026-11-08','CASH',NULL),(4,7,'MCA-GEN',90000,10000,80000,'2026-11-08','CASH',NULL),(6,17,'BTECH-ECE',105000,90000,15000,'2026-11-11','CASH',NULL);
/*!40000 ALTER TABLE `fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_details`
--

DROP TABLE IF EXISTS `student_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_details` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FULL_NAME` varchar(45) NOT NULL,
  `ROLL_NUMBER` varchar(45) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `PHONE` varchar(45) NOT NULL,
  `DOB` date NOT NULL,
  `ADMISSION_YEAR` int DEFAULT NULL,
  `SEMESTER` int NOT NULL,
  `ADDRESS` varchar(45) NOT NULL,
  `ACTIVE` varchar(45) NOT NULL,
  `STATUS` varchar(20) DEFAULT 'ACTIVE',
  `ROLE` varchar(20) NOT NULL,
  `PASSWORD` varchar(30) NOT NULL,
  `COURSE_CODE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ROLL_NUMBER_UNIQUE` (`ROLL_NUMBER`),
  KEY `fk_stud_course_code` (`COURSE_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_details`
--

LOCK TABLES `student_details` WRITE;
/*!40000 ALTER TABLE `student_details` DISABLE KEYS */;
INSERT INTO `student_details` VALUES (7,'Shubham Kishor','23SCSE2030572','shubhamkishor416@gmail.com','9608674280','2002-10-01',2026,1,'Baihari,Hazaribag,Jharkhand','1','ACTIVE','STUDENT','LMS1234','MCA-GEN'),(17,'Lucky ','Ls-39824','Lucky@gmail.com','8051869548','2002-10-10',2026,1,'Hazaribag','1','ACTIVE','STUDENT','LMS1234','BTECH-ECE');
/*!40000 ALTER TABLE `student_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12  0:52:06
