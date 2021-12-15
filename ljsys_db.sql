-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: ljsys
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

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
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int DEFAULT NULL,
  `equipment_name` varchar(50) DEFAULT NULL,
  `equipment_status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'设备组1',0),(2,'设备组2',0),(3,'设备3',0),(4,'设备测试4',1),(5,'设备5',1),(6,'测试设备',1),(7,'测试设备2333',1),(8,'111111',1),(9,'1111111',1);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factory`
--

DROP TABLE IF EXISTS `factory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factory` (
  `factory_id` int NOT NULL,
  `factory_name` varchar(50) DEFAULT NULL,
  `factory_address` varchar(50) DEFAULT NULL,
  `factory_status` int DEFAULT NULL,
  PRIMARY KEY (`factory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factory`
--

LOCK TABLES `factory` WRITE;
/*!40000 ALTER TABLE `factory` DISABLE KEYS */;
INSERT INTO `factory` VALUES (1,'工厂1','苏州相城某地',1),(2,'工厂2','苏州相城',0),(3,'gon','扬州',0),(4,'新增工厂测试','新增工厂地址',1),(5,'新增工厂测试2','新增工厂测试2',0),(6,'测试3','南京',1),(7,'相城工厂','相城',0),(8,'！@#','相城',0),(9,'NewFactory','SuZhou',0),(10,'工厂2','江苏苏州',1),(11,'\"æä»å¨ç»ç»\"','\"æ±èæ¬å·éæ±Xè·¯XXå·\"',0),(12,'\"某仓储组织\"','\"江苏扬州邗江X路XX号\"',0),(13,'\"某仓储组织\"','\"江苏扬州邗江X路XX号\"',0),(14,'某仓储组织','江苏扬州邗江X路XX号',0),(15,'某仓储组织2','江苏扬州邗江X路XX号2',0),(16,'扬子津工厂01','扬子津校区',1);
/*!40000 ALTER TABLE `factory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `function_authority`
--

DROP TABLE IF EXISTS `function_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `function_authority` (
  `fa_id` int NOT NULL,
  `fa_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`fa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `function_authority`
--

LOCK TABLES `function_authority` WRITE;
/*!40000 ALTER TABLE `function_authority` DISABLE KEYS */;
INSERT INTO `function_authority` VALUES (1,'网页登陆'),(2,'微信小程序登陆'),(3,'查询用户具体信息'),(4,'新增用户'),(5,'删除用户'),(6,'修改用户信息'),(7,'新增角色群组'),(8,'删除角色群组'),(9,'查看角色群组详情'),(10,'修改角色群组'),(11,'新增仓库组织'),(12,'删除仓库组织'),(13,'查看仓库组织详情'),(14,'新增货位'),(15,'删除货位'),(16,'查看货位详情'),(17,'新增二维码样式'),(18,'删除二维码样式'),(19,'查看二维码样式'),(20,'修改二维码样式'),(21,'打印二维码标签'),(22,'重置打印次数');
/*!40000 ALTER TABLE `function_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gp`
--

DROP TABLE IF EXISTS `gp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gp` (
  `gp_id` int NOT NULL,
  `gp_name` varchar(20) DEFAULT NULL,
  `gp_status` int DEFAULT NULL,
  PRIMARY KEY (`gp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gp`
--

LOCK TABLES `gp` WRITE;
/*!40000 ALTER TABLE `gp` DISABLE KEYS */;
INSERT INTO `gp` VALUES (1,'admin',1),(2,'test',0),(3,'ADMIN',1),(4,'TEST',0),(5,'普通员工',1),(6,'车间工人',1),(7,'测试群组',0),(8,'测试人员',0),(9,'新增测试',1),(10,'管理',1),(11,'测试新增群组',1),(12,'0724测试',1),(13,'系统管联络员',1),(14,'系统管理员',1),(15,'测试管理员',1),(16,'新增群组',0),(17,'新增群组2',0),(18,'新增群组3',0),(19,'新增群组4',0),(20,'新增群组5',0),(21,'新增群组6',0),(22,'新增群组8',0),(23,'新增群组7',0),(24,'0820测试',0),(25,'æ°å¢ç¾¤ç»æµè¯',0),(26,'新增群组测试',0),(27,'新增群组测试',1),(28,'资料员',1),(29,'堆场管理员',1),(30,'测试日志',1),(31,'10月31测试',1);
/*!40000 ALTER TABLE `gp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gp_function_authority`
--

DROP TABLE IF EXISTS `gp_function_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gp_function_authority` (
  `gp_fa_id` int NOT NULL,
  `gp_id` int DEFAULT NULL,
  `fa_id` int DEFAULT NULL,
  PRIMARY KEY (`gp_fa_id`),
  KEY `gp_id` (`gp_id`),
  KEY `fa_id` (`fa_id`),
  CONSTRAINT `gp_function_authority_ibfk_1` FOREIGN KEY (`gp_id`) REFERENCES `gp` (`gp_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `gp_function_authority_ibfk_2` FOREIGN KEY (`fa_id`) REFERENCES `function_authority` (`fa_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gp_function_authority`
--

LOCK TABLES `gp_function_authority` WRITE;
/*!40000 ALTER TABLE `gp_function_authority` DISABLE KEYS */;
INSERT INTO `gp_function_authority` VALUES (4,4,1),(5,4,2),(6,4,3),(9,6,2),(11,7,1),(13,8,1),(14,8,2),(18,9,1),(19,9,2),(21,10,1),(24,11,3),(25,11,2),(26,3,2),(27,3,1),(28,9,3),(29,15,1),(30,15,2),(31,15,3),(41,1,9),(42,1,10),(43,1,11),(44,1,12),(45,1,13),(46,1,14),(47,1,15),(48,1,16),(49,1,17),(50,1,18),(51,1,19),(52,1,20),(54,5,1),(55,1,21),(56,27,1),(57,1,22),(58,1,4),(59,1,1),(60,1,2),(61,1,3),(62,1,5),(63,1,6),(64,1,7),(65,1,8),(66,28,17),(67,28,18),(68,28,19),(69,28,20),(70,28,21),(71,29,2),(72,29,11),(73,29,12),(74,29,13),(75,29,14),(76,29,15),(77,29,16),(78,29,1),(79,31,1),(80,31,14),(81,31,11);
/*!40000 ALTER TABLE `gp_function_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gp_process_content`
--

DROP TABLE IF EXISTS `gp_process_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gp_process_content` (
  `gp_pc_id` int NOT NULL,
  `gp_id` int DEFAULT NULL,
  `pc_id` int DEFAULT NULL,
  PRIMARY KEY (`gp_pc_id`),
  KEY `gp_id` (`gp_id`),
  KEY `pc_id` (`pc_id`),
  CONSTRAINT `gp_process_content_ibfk_1` FOREIGN KEY (`gp_id`) REFERENCES `gp` (`gp_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `gp_process_content_ibfk_2` FOREIGN KEY (`pc_id`) REFERENCES `process_content` (`pc_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gp_process_content`
--

LOCK TABLES `gp_process_content` WRITE;
/*!40000 ALTER TABLE `gp_process_content` DISABLE KEYS */;
INSERT INTO `gp_process_content` VALUES (2,1,1),(3,7,1),(4,8,1),(5,6,1),(6,9,1),(7,10,1),(8,11,1),(9,15,1),(10,27,1),(11,31,1);
/*!40000 ALTER TABLE `gp_process_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pps`
--

DROP TABLE IF EXISTS `pps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pps` (
  `pps_id` int NOT NULL,
  `process_id` int DEFAULT NULL,
  `process_content_id` int DEFAULT NULL,
  `pps_pre_id` int DEFAULT NULL,
  `pps_next_id` int DEFAULT NULL,
  PRIMARY KEY (`pps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pps`
--

LOCK TABLES `pps` WRITE;
/*!40000 ALTER TABLE `pps` DISABLE KEYS */;
INSERT INTO `pps` VALUES (1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `pps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printtask`
--

DROP TABLE IF EXISTS `printtask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `printtask` (
  `pt_id` int DEFAULT NULL,
  `pt_time` datetime DEFAULT NULL,
  `pt_user_id` int DEFAULT NULL,
  `pt_name` varchar(30) DEFAULT NULL,
  `pt_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printtask`
--

LOCK TABLES `printtask` WRITE;
/*!40000 ALTER TABLE `printtask` DISABLE KEYS */;
INSERT INTO `printtask` VALUES (1,'2021-07-03 16:21:44',1,'DEFAULT','处理中'),(2,'2021-07-03 16:24:02',1,'test','已完成'),(3,'2021-07-04 01:03:36',1,'PrintTaskTest','已完成'),(4,'2021-07-04 01:05:08',1,'NoTurnOver','已完成'),(5,'2021-07-04 01:29:28',1,'TestStyle5','已完成'),(6,'2021-07-04 14:15:16',1,'74','已完成'),(7,'2021-07-04 14:16:51',1,'74noturnover','已完成'),(8,'2021-07-04 14:17:30',1,'74qq','已完成'),(9,'2021-07-10 10:26:32',1,'7月10号项目','已完成'),(10,'2021-10-31 11:20:32',1,'test','处理中'),(11,'2021-10-31 11:20:38',1,'test','处理中');
/*!40000 ALTER TABLE `printtask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process`
--

DROP TABLE IF EXISTS `process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `process` (
  `process_id` int NOT NULL,
  `process_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process`
--

LOCK TABLES `process` WRITE;
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
INSERT INTO `process` VALUES (1,'墙板制造');
/*!40000 ALTER TABLE `process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_content`
--

DROP TABLE IF EXISTS `process_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `process_content` (
  `pc_id` int NOT NULL,
  `pc_name` varchar(50) DEFAULT NULL,
  `pc_status` int DEFAULT NULL,
  PRIMARY KEY (`pc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_content`
--

LOCK TABLES `process_content` WRITE;
/*!40000 ALTER TABLE `process_content` DISABLE KEYS */;
INSERT INTO `process_content` VALUES (1,'完工',1);
/*!40000 ALTER TABLE `process_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produce`
--

DROP TABLE IF EXISTS `produce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produce` (
  `produce_id` varchar(60) NOT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `process_content_id` int DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  `produce_time` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`produce_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produce`
--

LOCK TABLES `produce` WRITE;
/*!40000 ALTER TABLE `produce` DISABLE KEYS */;
INSERT INTO `produce` VALUES ('050170102060179_1','050170102060179',1,NULL,'2021-11-01 13:49:53',1),('050170104060179_1','050170104060179',1,NULL,'2021-10-31 12:18:18',1),('050170104060197_1','050170104060197',1,NULL,'2021-10-31 19:46:22',1),('product1_1','product1',1,NULL,'2021-08-23 19:40:05',1),('product2_1','product2',1,NULL,'2021-08-23 19:51:43',1),('product27_1','product27',1,NULL,'2021-10-30 12:19:58',1),('product4101_1','product4101',1,NULL,'2021-11-01 18:06:52',1),('product4102_1','product4102',1,NULL,'2021-11-01 18:06:59',1),('product4103_1','product4103',1,NULL,'2021-11-01 18:07:11',1),('product4104_1','product4104',1,NULL,'2021-11-01 18:07:18',1),('product4105_1','product4105',1,NULL,'2021-11-01 18:07:23',1),('product4106_1','product4106',1,NULL,'2021-11-01 18:08:53',1),('product4107_1','product4107',1,NULL,'2021-11-01 18:08:58',1),('product4108_1','product4108',1,NULL,'2021-11-01 18:09:02',1),('product4109_1','product4109',1,NULL,'2021-11-01 18:09:05',1),('product4110_1','product4110',1,NULL,'2021-11-01 18:09:09',1);
/*!40000 ALTER TABLE `produce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` varchar(50) NOT NULL,
  `process_id` int DEFAULT NULL,
  `project_id` varchar(50) DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `qrcode_id` int DEFAULT NULL,
  `process_content_id` int DEFAULT NULL,
  `print` int DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('050170101050165',1,NULL,NULL,NULL,1,1),('050170101050172',1,NULL,NULL,NULL,1,1),('050170102060179',1,NULL,NULL,NULL,NULL,1),('050170102060197',1,NULL,NULL,NULL,1,1),('050170102070219',1,NULL,NULL,NULL,1,1),('050170102070237',1,NULL,NULL,NULL,1,1),('050170104060179',1,NULL,16,NULL,NULL,1),('050170104060197',1,NULL,NULL,NULL,NULL,1),('050170104070219',1,NULL,NULL,NULL,1,1),('050170104070237',1,NULL,NULL,NULL,1,1),('050170104080259',1,NULL,NULL,NULL,1,1),('050170104080277',1,NULL,NULL,NULL,1,1),('050170107060179',1,NULL,NULL,NULL,1,1),('050170107060197',1,NULL,NULL,NULL,1,1),('050170107070219',1,NULL,NULL,NULL,1,1),('050170107070237',1,NULL,NULL,NULL,1,1),('050170109060191',1,NULL,NULL,NULL,1,1),('050170109060193',1,NULL,NULL,NULL,1,1),('050170110100351',1,NULL,NULL,NULL,1,1),('050170110100353',1,NULL,NULL,NULL,1,1),('product0',1,NULL,NULL,NULL,NULL,1),('product1',1,'project1',1,1,NULL,1),('product10',1,NULL,NULL,NULL,NULL,1),('product11',1,NULL,NULL,NULL,NULL,1),('product12',1,NULL,NULL,NULL,NULL,1),('product13',1,NULL,NULL,NULL,NULL,1),('product14',1,NULL,NULL,NULL,NULL,1),('product15',1,NULL,NULL,NULL,NULL,1),('product16',1,NULL,NULL,NULL,NULL,1),('product17',1,NULL,NULL,NULL,NULL,1),('product19',1,NULL,NULL,NULL,NULL,1),('product2',1,'product2',1,1,NULL,1),('product20',1,NULL,NULL,NULL,NULL,1),('product21',1,NULL,NULL,NULL,NULL,1),('product2101',1,NULL,NULL,NULL,1,1),('product2102',1,NULL,NULL,NULL,1,1),('product2103',1,NULL,NULL,NULL,1,1),('product2104',1,NULL,NULL,NULL,1,1),('product22',1,NULL,NULL,NULL,NULL,1),('product23',1,NULL,NULL,NULL,NULL,1),('product24',1,NULL,NULL,NULL,NULL,1),('product25',1,NULL,NULL,NULL,NULL,1),('product26',1,NULL,NULL,NULL,NULL,1),('product27',1,NULL,16,NULL,NULL,1),('product3',1,NULL,NULL,NULL,NULL,1),('product3101',1,NULL,NULL,NULL,1,0),('product3102',1,NULL,NULL,NULL,1,0),('product3103',1,NULL,NULL,NULL,1,0),('product3104',1,NULL,NULL,NULL,1,0),('product4',1,NULL,NULL,NULL,NULL,1),('product4101',1,NULL,20,NULL,NULL,1),('product4102',1,NULL,20,NULL,NULL,1),('product4103',1,NULL,20,NULL,NULL,1),('product4104',1,NULL,20,NULL,NULL,1),('product4105',1,NULL,20,NULL,NULL,1),('product4106',1,NULL,20,NULL,NULL,1),('product4107',1,NULL,20,NULL,NULL,1),('product4108',1,NULL,20,NULL,NULL,1),('product4109',1,NULL,NULL,NULL,NULL,1),('product4110',1,NULL,NULL,NULL,NULL,1),('product5',1,NULL,NULL,NULL,NULL,1),('product6',1,NULL,NULL,NULL,NULL,1),('product7',1,NULL,NULL,NULL,NULL,1),('product8',1,NULL,NULL,NULL,NULL,1),('product9',1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_item`
--

DROP TABLE IF EXISTS `project_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_item` (
  `pi_id` int NOT NULL AUTO_INCREMENT,
  `pi_key` varchar(50) DEFAULT NULL,
  `pi_value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_item`
--

LOCK TABLES `project_item` WRITE;
/*!40000 ALTER TABLE `project_item` DISABLE KEYS */;
INSERT INTO `project_item` VALUES (1,'storey','楼层'),(2,'projectName','项目名'),(3,'produceTime','生产时间'),(4,'productId','构件号'),(7,'title','公司名'),(8,'newProjectItem','新增项目字段'),(9,'newItem','新增字段'),(10,'department','生产部门'),(11,'size','规格'),(12,'buildid','构建编号'),(13,'buildvolume','构建方量'),(14,'demoProjectText','测试项目字段');
/*!40000 ALTER TABLE `project_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrcode`
--

DROP TABLE IF EXISTS `qrcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrcode` (
  `qrcode_id` int NOT NULL,
  `qrcode_name` varchar(50) DEFAULT NULL,
  `qrcode_content` varchar(500) DEFAULT NULL,
  `qrcode_status` int DEFAULT NULL,
  PRIMARY KEY (`qrcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrcode`
--

LOCK TABLES `qrcode` WRITE;
/*!40000 ALTER TABLE `qrcode` DISABLE KEYS */;
INSERT INTO `qrcode` VALUES (1,'test','{\"xsize\":\"500\",\"ysize\":\"200\",\"qRCode\":{\"qRCodeContent\":[\"projectName\",\"produceTime\",\"productId\"],\"xsituation\":\"14\",\"ysituation\":\"18\"},\"items\":[{\"content\":\"storey\",\"xsituation\":\"189\",\"ysituation\":\"129\"},{\"content\":\"projectName\",\"xsituation\":\"189\",\"ysituation\":\"97\"},{\"content\":\"produceTime\",\"xsituation\":\"188\",\"ysituation\":\"28\"},{\"content\":\"productId\",\"xsituation\":\"189\",\"ysituation\":\"61\"},{\"content\":\"title\",\"xsituation\":\"189\",\"ysituation\":\"163\"}]}',1),(2,'TEST','{\"xsize\":\"300\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"produceTime\",\"storey\",\"projectName\"],\"xsituation\":\"65\",\"ysituation\":\"29\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"45\",\"ysituation\":\"200\"},{\"content\":\"projectName\",\"xsituation\":\"45\",\"ysituation\":\"250\"},{\"content\":\"produceTime\",\"xsituation\":\"45\",\"ysituation\":\"300\"}]}',1),(3,'测试样式','{\"xsize\":\"400\",\"ysize\":\"200\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"produceTime\"],\"xsituation\":\"221\",\"ysituation\":\"13\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"33\",\"ysituation\":\"46\"},{\"content\":\"projectName\",\"xsituation\":\"32\",\"ysituation\":\"109\"}]}',1),(4,'test','{\"xsize\":\"400\",\"ysize\":\"300\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"produceTime\"],\"xsituation\":\"20\",\"ysituation\":\"38\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"191\",\"ysituation\":\"47\"},{\"content\":\"projectName\",\"xsituation\":\"194\",\"ysituation\":\"194\"},{\"content\":\"produceTime\",\"xsituation\":\"191\",\"ysituation\":\"123\"}]}',1),(5,'TEST','{\"xsize\":\"400\",\"ysize\":\"600\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"projectName\",\"produceTime\",\"storey\",\"title\"],\"xsituation\":\"119\",\"ysituation\":\"373\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"126\",\"ysituation\":\"118\"},{\"content\":\"projectName\",\"xsituation\":\"128\",\"ysituation\":\"189\"},{\"content\":\"produceTime\",\"xsituation\":\"113\",\"ysituation\":\"310\"},{\"content\":\"storey\",\"xsituation\":\"134\",\"ysituation\":\"249\"},{\"content\":\"title\",\"xsituation\":\"113\",\"ysituation\":\"54\"}]}',1),(6,'newStyle','{\"xsize\":\"400\",\"ysize\":\"600\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"produceTime\",\"projectName\"],\"xsituation\":\"199\",\"ysituation\":\"8\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"68\",\"ysituation\":\"235\"},{\"content\":\"produceTime\",\"xsituation\":\"124\",\"ysituation\":\"343\"}]}',1),(7,'aaaa','{\"xsize\":\"400\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"storey\",\"produceTime\",\"projectName\"],\"xsituation\":\"230\",\"ysituation\":\"9\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"25\",\"ysituation\":\"51\"},{\"content\":\"produceTime\",\"xsituation\":\"28\",\"ysituation\":\"315\"},{\"content\":\"storey\",\"xsituation\":\"31\",\"ysituation\":\"236\"},{\"content\":\"projectName\",\"xsituation\":\"27\",\"ysituation\":\"137\"},{\"content\":\"title\",\"xsituation\":\"224\",\"ysituation\":\"193\"}]}',1),(8,'7月10号新样式','{\"xsize\":\"400\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"produceTime\",\"storey\"],\"xsituation\":\"112\",\"ysituation\":\"84\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"109\",\"ysituation\":\"256\"},{\"content\":\"title\",\"xsituation\":\"112\",\"ysituation\":\"299\"}]}',1),(9,'7月19号样式','{\"xsize\":\"400\",\"ysize\":\"600\",\"qRCode\":{\"qRCodeContent\":[],\"xsituation\":\"68\",\"ysituation\":\"163\"},\"items\":[{\"content\":\"produceTime\",\"xsituation\":\"89\",\"ysituation\":\"108\"},{\"content\":\"title\",\"xsituation\":\"101\",\"ysituation\":\"346\"},{\"content\":\"storey\"}]}',1),(10,'新增',NULL,0),(11,'8月10日新样式',NULL,0),(12,'0820Style',NULL,1),(13,'0820Style2',NULL,0),(14,'0820新增样式2',NULL,0),(15,'0820新增样式2',NULL,1),(16,'1031样式','{\"xsize\":\"500\",\"ysize\":\"265\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"department\",\"size\"],\"xsituation\":\"13\",\"ysituation\":\"57\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"180\",\"ysituation\":\"20\"},{\"content\":\"department\",\"xsituation\":\"180\",\"ysituation\":\"70\"},{\"content\":\"size\",\"xsituation\":\"180\",\"ysituation\":\"120\"},{\"content\":\"buildid\",\"xsituation\":\"180\",\"ysituation\":\"170\"},{\"content\":\"buildvolume\",\"xsituation\":\"180\",\"ysituation\":\"220\"}]}',1),(17,'1031样式2',NULL,0),(18,'1031二维码一','{\"xsize\":\"400\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"projectName\",\"produceTime\"],\"xsituation\":\"10\",\"ysituation\":\"5\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"150\",\"ysituation\":\"10\"},{\"content\":\"projectName\",\"xsituation\":\"150\",\"ysituation\":\"40\"},{\"content\":\"title\",\"xsituation\":\"150\",\"ysituation\":\"70\"},{\"content\":\"size\",\"xsituation\":\"150\",\"ysituation\":\"100\"}]}',1),(19,'1031二维码二','{\"xsize\":\"400\",\"ysize\":\"600\",\"qRCode\":{\"qRCodeContent\":[],\"xsituation\":\"\",\"ysituation\":\"\"},\"items\":[]}',0),(20,'1031二维码三','{\"xsize\":\"400\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[],\"xsituation\":\"3\",\"ysituation\":\"11\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"100\",\"ysituation\":\"100\"},{\"content\":\"projectName\",\"xsituation\":\"\",\"ysituation\":\"\"},{\"content\":\"title\",\"xsituation\":\"\",\"ysituation\":\"\"},{\"content\":\"department\",\"xsituation\":\"\",\"ysituation\":\"\"}]}',0),(21,'1031二维码四','{\"xsize\":\"400\",\"ysize\":\"400\",\"qRCode\":{\"qRCodeContent\":[\"productId\",\"department\",\"size\",\"produceTime\"],\"xsituation\":\"20\",\"ysituation\":\"20\"},\"items\":[{\"content\":\"productId\",\"xsituation\":\"165\",\"ysituation\":\"40\"},{\"content\":\"department\",\"xsituation\":\"165\",\"ysituation\":\"80\"},{\"content\":\"size\",\"xsituation\":\"165\",\"ysituation\":\"120\"},{\"content\":\"produceTime\",\"xsituation\":\"165\",\"ysituation\":\"160\"}]}',1);
/*!40000 ALTER TABLE `qrcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_wxid` varchar(30) DEFAULT NULL,
  `user_pwd` varchar(30) DEFAULT NULL,
  `user_status` int DEFAULT NULL,
  `wx_session_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin',NULL,'1234567',1,NULL),(2,'adasdf',NULL,'aaami',1,NULL),(3,'刘洋',NULL,'123456',1,NULL),(4,'韩寒',NULL,'abcabc',1,NULL),(5,'诸晨西',NULL,'123456',0,NULL),(6,'测试1',NULL,'123456',0,NULL),(7,'测试人员1',NULL,'123456',0,NULL),(8,'winterdotc',NULL,'123456',1,NULL),(9,'POST测试2',NULL,'123456',1,NULL),(10,'测试3点03分',NULL,'123456',1,NULL),(11,'测试人员A',NULL,'123456',1,NULL),(12,'测试修改人员',NULL,'123456',1,NULL),(13,'测试人员C',NULL,'123456',0,NULL),(14,'测试人员D',NULL,'123456',0,NULL),(15,'测试人员E',NULL,'123456',0,NULL),(16,'测试人员F',NULL,'654321',1,NULL),(17,'测试人员D1',NULL,'123456',1,NULL),(18,'测试人员E1',NULL,'123456',1,NULL),(19,'测试人员F1',NULL,'123456',0,NULL),(20,'',NULL,'123456',0,NULL),(21,'赵四',NULL,'123456',0,NULL),(22,'赵四',NULL,'123456',0,NULL),(23,'赵四',NULL,'123456',0,NULL),(24,'赵四',NULL,'123456',0,NULL),(25,'赵四',NULL,'123456',1,NULL),(26,'赵四',NULL,'123456',1,NULL),(27,'赵四',NULL,'123456',0,NULL),(28,'1',NULL,'123456',0,NULL),(29,'1',NULL,'123456',0,NULL),(30,'1',NULL,'123456',0,NULL),(31,'1',NULL,'123456',0,NULL),(32,'1',NULL,'123456',0,NULL),(33,'1',NULL,'123456',0,NULL),(34,'测试人员D1',NULL,'123456',0,NULL),(35,'测试人员E1',NULL,'123456',0,NULL),(36,'测试人员D1',NULL,'123456',0,NULL),(37,'测试人员F1',NULL,'123456',0,NULL),(38,'测试人员D1',NULL,'123456',0,NULL),(39,'测试人员D1',NULL,'123456',0,NULL),(40,'测试人员E1',NULL,'123456',0,NULL),(41,'',NULL,'123456',0,NULL),(42,'测试人员D1',NULL,'123456',0,NULL),(43,'测试人员E1',NULL,'123456',0,NULL),(44,'测试人员F1',NULL,'123456',0,NULL),(45,'测试人员D1',NULL,'123456',0,NULL),(46,'测试人员E1',NULL,'123456',0,NULL),(47,'测试人员F1',NULL,'123456',0,NULL),(48,'5',NULL,'123456',0,NULL),(49,'测试人员D1',NULL,'123456',0,NULL),(50,'测试人员E1',NULL,'123456',1,NULL),(51,'测试人员F1',NULL,'123456',1,NULL),(52,'杨海洋',NULL,'123456',1,NULL),(53,'杨海洋',NULL,'123456',1,NULL),(54,'张三',NULL,'123456',1,NULL),(55,'王二',NULL,'123456',1,NULL),(56,'麻子',NULL,'123456',1,NULL),(57,'啦啦啦',NULL,'123456',0,NULL),(58,'黄波',NULL,'123456',1,NULL),(59,'0808Test',NULL,'123456',1,NULL),(60,'0808Test2',NULL,'123456',1,NULL),(61,'0808Test6',NULL,'123456',1,NULL),(62,'0808Test5',NULL,'123456',1,NULL),(63,'测试人员42',NULL,'123456',0,NULL),(64,'测试人员43',NULL,'123456',0,NULL),(65,'测试人员44',NULL,'123456',0,NULL),(66,'测试人员42',NULL,'123456',1,NULL),(67,'测试人员43',NULL,'123456',1,NULL),(68,'测试人员44',NULL,'123456',1,NULL),(69,'测试人员46',NULL,'123456',1,NULL),(70,'测试人员47',NULL,'123456',1,NULL),(71,'测试人员48',NULL,'123456',1,NULL),(72,'测试人员50',NULL,'123456',1,NULL),(73,'测试人员51',NULL,'123456',1,NULL),(74,'测试人员52',NULL,'123456',1,NULL),(75,'测试人员53',NULL,'123456',1,NULL),(76,'测试人员54',NULL,'123456',1,NULL),(77,'测试人员55',NULL,'123456',1,NULL),(78,'测试人员56',NULL,'123456',1,NULL),(79,'测试人员57',NULL,'123456',1,NULL),(80,'测试人员58',NULL,'123456',1,NULL),(81,'测试人员59',NULL,'123456',1,NULL),(82,'测试人员60',NULL,'123456',1,NULL),(83,'测试人员61',NULL,'123456',1,NULL),(84,'0820新增用户',NULL,'123456',1,NULL),(85,'测试新增aaa',NULL,'123456',1,NULL),(86,'0820新增用户测试',NULL,'123456',1,NULL),(87,'0820新增用户测试',NULL,'123456',1,NULL),(88,'黄波',NULL,'123456',1,NULL),(89,'',NULL,'123456',1,NULL),(90,'20210907',NULL,'123456',1,NULL),(91,'gyy',NULL,'123456',1,NULL),(92,'张三',NULL,'123456',1,NULL),(93,'李四',NULL,'123456',1,NULL),(94,'张三',NULL,'123456',1,NULL),(95,'王五二',NULL,'123456',1,NULL),(96,'测试人员1001',NULL,'123456',1,NULL),(97,'测试人员1002',NULL,'123456',1,NULL),(98,'测试人员1003',NULL,'123456',1,NULL),(99,'赵敏',NULL,'123456',1,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_gp`
--

DROP TABLE IF EXISTS `user_gp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_gp` (
  `ugp_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `gp_id` int DEFAULT NULL,
  PRIMARY KEY (`ugp_id`),
  KEY `gp_id` (`gp_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_gp_ibfk_1` FOREIGN KEY (`gp_id`) REFERENCES `gp` (`gp_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_gp_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_gp`
--

LOCK TABLES `user_gp` WRITE;
/*!40000 ALTER TABLE `user_gp` DISABLE KEYS */;
INSERT INTO `user_gp` VALUES (1,1,1),(2,2,6),(3,3,6),(4,4,5),(5,5,1),(6,6,1),(7,7,1),(8,10,6),(9,11,5),(10,12,6),(11,13,5),(12,14,5),(13,15,5),(14,16,5),(15,17,5),(16,18,5),(17,19,5),(18,20,1),(19,21,5),(20,22,5),(21,23,5),(22,24,5),(23,25,5),(24,26,5),(25,27,5),(26,34,5),(27,35,5),(28,37,5),(29,39,5),(30,40,5),(31,42,5),(32,43,5),(33,44,5),(34,45,5),(35,46,5),(36,47,5),(37,49,5),(38,50,5),(39,51,5),(40,52,9),(41,53,9),(42,54,5),(43,55,5),(44,56,5),(45,57,6),(46,58,15),(50,1,15),(51,1,22),(52,59,1),(53,60,1),(54,60,5),(55,60,6),(60,62,1),(64,61,6),(65,63,5),(66,63,5),(67,63,5),(68,63,5),(69,64,5),(70,64,5),(71,65,5),(72,65,5),(73,66,5),(74,66,1),(75,66,10),(76,67,5),(77,67,6),(78,68,5),(79,68,16),(80,69,5),(81,69,1),(82,69,10),(83,70,5),(84,70,6),(85,71,5),(86,71,16),(87,72,5),(88,72,1),(89,72,10),(90,73,5),(91,73,6),(92,74,5),(93,74,16),(94,75,5),(95,75,1),(96,75,10),(97,76,5),(98,76,6),(99,77,5),(100,77,16),(101,78,5),(102,78,1),(103,78,10),(104,79,5),(105,79,6),(106,80,5),(107,80,16),(108,81,5),(109,81,1),(110,81,10),(111,82,5),(112,82,6),(113,83,5),(114,83,16),(115,84,1),(116,84,5),(117,84,10),(118,85,5),(119,85,9),(120,85,12),(121,86,5),(122,86,9),(123,86,17),(124,87,5),(125,87,9),(126,87,17),(127,1,5),(128,21,26),(129,21,27),(130,88,1),(131,92,28),(132,92,27),(133,93,29),(134,96,5),(135,96,6),(136,96,10),(137,97,5),(138,97,6),(139,98,5),(140,98,6),(141,99,31);
/*!40000 ALTER TABLE `user_gp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `warehouse_id` int NOT NULL,
  `warehouse_name` varchar(50) DEFAULT NULL,
  `factory_id` int DEFAULT NULL,
  `warehouse_status` int DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'墙板A区库房',1,1),(2,'墙板B区库房',1,1),(3,'墙板C区库房',1,1),(4,'7月10号仓库',1,1),(5,'7月9号仓库',1,0),(6,'仓库1号',6,1),(7,'测试仓库',1,0),(8,'新增仓库测试',4,0),(9,'墙板D区库房',1,0),(10,'墙板E区库房',1,1),(11,'墙板D区库房',1,1),(12,'0821新货位',1,1),(13,'0821新增库位2',1,1),(14,'0821新增库位3',1,1),(15,'0821新增库位4',1,1),(16,'10月31号测试货位',4,1),(17,'0821新增库位5',1,0),(18,'0821新增库位6',1,1),(19,'0821新增库位6',16,1),(20,'0821新增库位7',16,1);
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_info`
--

DROP TABLE IF EXISTS `warehouse_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_info` (
  `wi_time` datetime DEFAULT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `wi_type` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_info`
--

LOCK TABLES `warehouse_info` WRITE;
/*!40000 ALTER TABLE `warehouse_info` DISABLE KEYS */;
INSERT INTO `warehouse_info` VALUES ('2021-05-12 09:00:00','product1',1,1,1),('2021-08-26 12:09:26','product2',1,1,1),('2021-08-26 12:11:34','product2',1,0,1),('2021-08-26 12:11:34','product1',1,0,1),('2021-08-26 12:12:10','product2',1,1,1),('2021-08-26 12:12:11','product1',1,1,1),('2021-08-26 18:00:40','product1',1,0,1),('2021-08-26 18:00:40','product2',1,0,1),('2021-08-26 18:08:37','product1',1,1,1),('2021-08-26 18:08:37','product2',1,1,1),('2021-10-30 14:19:19','product27',1,1,1),('2021-10-30 14:20:22','product27',1,0,1),('2021-10-30 14:20:58','product27',1,1,1),('2021-10-30 14:22:29','product27',1,0,1),('2021-10-30 14:22:42','product27',1,1,1),('2021-10-31 10:35:36','product27',1,0,1),('2021-10-31 10:36:17','product27',1,1,16),('2021-10-31 12:21:49','050170104060179',1,1,16),('2021-10-31 12:22:02','050170104060179',1,0,16),('2021-10-31 12:22:13','050170104060179',1,1,16),('2021-11-01 13:50:24','050170102060179',1,1,1),('2021-11-01 13:50:30','050170102060179',1,0,1),('2021-11-01 13:50:46','050170102060179',1,1,1),('2021-11-01 13:50:54','050170102060179',1,0,1),('2021-11-01 15:06:27','050170104060179',1,0,16),('2021-11-01 15:06:41','050170104060179',1,1,16),('2021-11-01 18:08:43','product4101',1,1,20),('2021-11-01 18:08:43','product4102',1,1,20),('2021-11-01 18:08:43','product4103',1,1,20),('2021-11-01 18:08:43','product4104',1,1,20),('2021-11-01 18:08:43','product4105',1,1,20),('2021-11-01 18:08:43','product4106',1,1,20),('2021-11-01 18:08:43','product4107',1,1,20),('2021-11-01 18:09:56','product4108',1,1,20),('2021-11-01 18:09:56','product4109',1,1,20),('2021-11-01 18:09:56','product4110',1,1,20),('2021-11-01 18:13:18','product4110',1,0,20),('2021-11-01 18:13:18','product4109',1,0,20);
/*!40000 ALTER TABLE `warehouse_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-02 22:14:46
