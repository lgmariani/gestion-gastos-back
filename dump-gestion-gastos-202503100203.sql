-- MySQL dump 10.13  Distrib 8.4.0, for Win64 (x86_64)
--
-- Host: localhost    Database: gestion-gastos
-- ------------------------------------------------------
-- Server version	8.4.0

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
-- Table structure for table `cuenta_presupuesto`
--

DROP TABLE IF EXISTS `cuenta_presupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuenta_presupuesto` (
  `id_cuenta` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `anio` int DEFAULT NULL,
  `asignado` int DEFAULT NULL,
  `consumido_ind` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuenta_presupuesto`
--

LOCK TABLES `cuenta_presupuesto` WRITE;
/*!40000 ALTER TABLE `cuenta_presupuesto` DISABLE KEYS */;
INSERT INTO `cuenta_presupuesto` VALUES (1,5,2024,10000,0),(2,5,2024,10000,0),(3,5,2024,10000,0),(4,5,2024,10000,0),(5,5,2024,10000,0),(6,5,2024,10000,0),(7,5,2024,10000,0),(9,5,2024,10000,0),(10,5,2024,10000,0),(11,5,2024,10000,0),(12,5,2024,10000,0),(13,5,2024,10000,0),(14,5,2024,10000,0),(15,5,2024,10000,0),(16,5,2024,10000,0),(17,5,2024,10000,0),(18,5,2024,10000,0),(19,5,2024,10000,0),(20,5,2024,10000,0),(21,5,2024,10000,0);
/*!40000 ALTER TABLE `cuenta_presupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `mes` int DEFAULT NULL,
  `anio` int DEFAULT NULL,
  `nombre` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asignado` int DEFAULT NULL,
  `ck_consumo_compartido` int DEFAULT NULL,
  `consumido_ind` int DEFAULT NULL,
  `forma_pago` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grupo` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_gasto` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES (1,1,NULL,NULL,'Carnicería y Pollo',10000,NULL,NULL,'Manual','','Variable'),(2,2,NULL,NULL,'Panadería',10000,NULL,NULL,'Manual','','Variable'),(3,3,NULL,NULL,'Quesería',10000,NULL,NULL,'Manual','','Variable'),(4,4,NULL,NULL,'Supermercado',10000,NULL,NULL,'Manual','','Variable'),(5,5,NULL,NULL,'Verdulería',10000,NULL,NULL,'Manual','','Variable'),(6,6,NULL,NULL,'Leña y carbon',10000,NULL,NULL,'Manual','','Variable'),(7,7,NULL,NULL,'Almacén',10000,NULL,NULL,'Manual','','Variable'),(9,9,NULL,NULL,'Roberto',10000,NULL,NULL,'Manual','','Variable'),(10,10,NULL,NULL,'Delivery´s',10000,NULL,NULL,'Manual','','Variable'),(11,11,NULL,NULL,'Salidas',10000,NULL,NULL,'Manual','','Variable'),(12,12,NULL,NULL,'Hogar & Mantenimiento',10000,NULL,NULL,'Manual','','Variable'),(13,13,NULL,NULL,'Jardinería',10000,NULL,NULL,'Manual','','Variable'),(14,14,NULL,NULL,'Remises & Transportes',10000,NULL,NULL,'Manual','','Variable'),(15,15,NULL,NULL,'Prestamos Soquetudenses',10000,NULL,NULL,'Manual','','Variable'),(16,16,NULL,NULL,'Regalos',10000,NULL,NULL,'Manual','','Mensual'),(17,17,NULL,NULL,'Combustible',10000,NULL,NULL,'','','Variable'),(18,18,NULL,NULL,'Mantenimiento y taller',10000,NULL,NULL,'Manual','','Mensual'),(19,19,NULL,NULL,'Vacaciones',10000,NULL,NULL,'Manual','','Variable'),(20,20,NULL,NULL,'Seguro Auto',10000,NULL,NULL,'Deb-Auto','','Mensual'),(21,21,NULL,NULL,'Alquiler',425000,NULL,NULL,'Manual','','Mensual');
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_n`
--

DROP TABLE IF EXISTS `cuentas_n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_n` (
  `id_cuenta` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `nombre` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forma_pago` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grupo` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_gasto` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ck_consumo_compartido` int DEFAULT NULL,
  PRIMARY KEY (`id_cuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_n`
--

LOCK TABLES `cuentas_n` WRITE;
/*!40000 ALTER TABLE `cuentas_n` DISABLE KEYS */;
INSERT INTO `cuentas_n` VALUES (1,1,'Carnicería y Pollo','Manual','','Variable',NULL),(2,2,'Panadería','Manual','','Variable',NULL),(3,3,'Quesería','Manual','','Variable',NULL),(4,4,'Supermercado','Manual','','Variable',NULL),(5,5,'Verdulería','Manual','','Variable',NULL),(6,6,'Leña y carbon','Manual','','Variable',NULL),(7,7,'Almacén','Manual','','Variable',NULL),(9,9,'Roberto','Manual','','Variable',NULL),(10,10,'Delivery´s','Manual','','Variable',NULL),(11,11,'Salidas','Manual','','Variable',NULL),(12,12,'Hogar & Mantenimiento','Manual','','Variable',NULL),(13,13,'Jardinería','Manual','','Variable',NULL),(14,14,'Remises & Transportes','Manual','','Variable',NULL),(15,15,'Prestamos Soquetudenses','Manual','','Variable',NULL),(16,16,'Regalos','Manual','','Mensual',NULL),(17,17,'Combustible','','','Variable',NULL),(18,18,'Mantenimiento y taller','Manual','','Mensual',NULL),(19,19,'Vacaciones','Manual','','Variable',NULL),(20,20,'Seguro Auto','Deb-Auto','','Mensual',NULL),(21,21,'Alquiler','Manual','','Mensual',NULL);
/*!40000 ALTER TABLE `cuentas_n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gastos`
--

DROP TABLE IF EXISTS `gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gastos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor` float DEFAULT NULL,
  `fecha` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagador` int DEFAULT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria` int DEFAULT NULL,
  `repartirentre` int DEFAULT NULL,
  `updatedAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastos`
--

LOCK TABLES `gastos` WRITE;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
INSERT INTO `gastos` VALUES (3,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(4,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(5,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(6,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(7,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(8,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(9,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(10,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(11,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(12,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(13,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(14,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(15,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(16,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(17,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(18,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(19,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(20,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(21,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(22,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(23,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(24,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(25,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(26,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(27,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(28,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(29,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(30,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(31,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(32,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(33,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(34,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(35,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(36,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(37,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(38,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(39,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(40,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(41,200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(42,100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(43,2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),(44,200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),(45,5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00');
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gastosviews`
--

DROP TABLE IF EXISTS `gastosviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gastosviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `pagador` int DEFAULT NULL,
  `total` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastosviews`
--

LOCK TABLES `gastosviews` WRITE;
/*!40000 ALTER TABLE `gastosviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `gastosviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `total_by_account`
--

DROP TABLE IF EXISTS `total_by_account`;
/*!50001 DROP VIEW IF EXISTS `total_by_account`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_by_account` AS SELECT 
 1 AS `month`,
 1 AS `year`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `total_by_people`
--

DROP TABLE IF EXISTS `total_by_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_by_people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `pagador` int DEFAULT NULL,
  `total` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `repartirentre` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total_by_people`
--

LOCK TABLES `total_by_people` WRITE;
/*!40000 ALTER TABLE `total_by_people` DISABLE KEYS */;
/*!40000 ALTER TABLE `total_by_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `total_by_person`
--

DROP TABLE IF EXISTS `total_by_person`;
/*!50001 DROP VIEW IF EXISTS `total_by_person`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_by_person` AS SELECT 
 1 AS `month`,
 1 AS `year`,
 1 AS `pagador`,
 1 AS `repartirentre`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'gestion-gastos'
--

--
-- Final view structure for view `total_by_account`
--

/*!50001 DROP VIEW IF EXISTS `total_by_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ggadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `total_by_account` AS select month(`a`.`fecha`) AS `month`,year(`a`.`fecha`) AS `year`,sum(`a`.`valor`) AS `total` from (`gastos` `a` join `cuentas` `b`) where ((`a`.`categoria` = `b`.`id_categoria`) and (`b`.`forma_pago` = 'Mensual')) group by `a`.`fecha` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_by_person`
--

/*!50001 DROP VIEW IF EXISTS `total_by_person`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ggadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `total_by_person` AS select month(`gastos`.`fecha`) AS `month`,year(`gastos`.`fecha`) AS `year`,`gastos`.`pagador` AS `pagador`,`gastos`.`repartirentre` AS `repartirentre`,sum(`gastos`.`valor`) AS `total` from `gastos` group by `gastos`.`fecha`,`gastos`.`pagador`,`gastos`.`repartirentre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-10  2:03:44
