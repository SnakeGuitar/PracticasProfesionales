-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: practicasprofesionales
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `autoevaluacion`
--

DROP TABLE IF EXISTS `autoevaluacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autoevaluacion` (
  `ID_Autoevaluacion` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL,
  `criterio1` int NOT NULL,
  `criterio2` int NOT NULL,
  `criterio3` int NOT NULL,
  `criterio4` int NOT NULL,
  `criterio5` int NOT NULL,
  `criterio6` int NOT NULL,
  `criterio7` int NOT NULL,
  `criterio8` int NOT NULL,
  `criterio9` int NOT NULL,
  `criterio10` int NOT NULL,
  `puntuacion_final` int DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Org_Vinculada` int NOT NULL,
  `ID_Responsable` int NOT NULL,
  `ID_Proyecto` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_Autoevaluacion`,`ID_Estudiante`,`ID_Org_Vinculada`,`ID_Responsable`,`ID_Proyecto`,`ID_Periodo`),
  KEY `fk_autoevaluacion_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_autoevaluacion_Proyecto1_idx` (`ID_Proyecto`),
  KEY `fk_autoevaluacion_Org_Vinculada1_idx` (`ID_Org_Vinculada`),
  KEY `fk_autoevaluacion_Responsable1_idx` (`ID_Responsable`),
  CONSTRAINT `fk_autoevaluacion_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`),
  CONSTRAINT `fk_autoevaluacion_Org_Vinculada1` FOREIGN KEY (`ID_Org_Vinculada`) REFERENCES `organizacion_vinculada` (`ID_Org_Vinculada`),
  CONSTRAINT `fk_autoevaluacion_Proyecto1` FOREIGN KEY (`ID_Proyecto`) REFERENCES `proyecto` (`ID_Proyecto`),
  CONSTRAINT `fk_autoevaluacion_Responsable1` FOREIGN KEY (`ID_Responsable`) REFERENCES `responsable_tecnico` (`ID_Responsable`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoevaluacion`
--

LOCK TABLES `autoevaluacion` WRITE;
/*!40000 ALTER TABLE `autoevaluacion` DISABLE KEYS */;
INSERT INTO `autoevaluacion` VALUES (1,'2024-05-15 14:30:00',8,7,9,8,7,8,9,8,7,8,81,1,1,1,1,2),(2,'2024-05-20 10:15:00',9,8,8,9,8,7,8,9,8,8,82,2,2,2,2,2),(3,'2024-11-10 16:45:00',7,8,7,8,9,8,7,8,9,7,78,3,3,3,3,3),(4,'2024-11-12 09:20:00',9,9,8,9,8,9,8,7,8,9,84,4,4,4,4,3),(5,'2024-11-15 13:10:00',8,8,9,8,7,8,9,8,8,7,80,5,5,5,5,3),(6,'2025-05-10 11:30:00',8,9,8,7,8,9,8,8,7,9,81,2,2,2,8,4),(7,'2025-05-12 15:45:00',9,8,7,8,9,8,7,9,8,8,81,4,4,4,9,4),(8,'2025-05-15 14:20:00',7,8,9,8,8,7,9,8,8,9,81,4,4,4,10,4),(9,'2025-06-24 17:31:54',5,4,5,4,5,3,5,4,5,4,44,8,4,4,4,4),(10,'2025-06-25 01:44:40',5,0,0,0,0,0,0,0,0,0,5,7,7,7,11,4);
/*!40000 ALTER TABLE `autoevaluacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinador`
--

DROP TABLE IF EXISTS `coordinador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinador` (
  `ID_Coordinador` int NOT NULL AUTO_INCREMENT,
  `num_personal` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `puesto` varchar(100) NOT NULL,
  `ID_EE` int NOT NULL,
  `ID_Usuario` int DEFAULT NULL,
  PRIMARY KEY (`ID_Coordinador`,`ID_EE`),
  KEY `fk_Coordinador_Experiencia_Educativa1_idx` (`ID_EE`),
  KEY `fk_Coordinador_Usuario1_idx` (`ID_Usuario`),
  CONSTRAINT `fk_Coordinador_Experiencia_Educativa1` FOREIGN KEY (`ID_EE`) REFERENCES `experiencia_educativa` (`ID_EE`),
  CONSTRAINT `fk_Coordinador_Usuario1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinador`
--

LOCK TABLES `coordinador` WRITE;
/*!40000 ALTER TABLE `coordinador` DISABLE KEYS */;
INSERT INTO `coordinador` VALUES (1,43211,'Dr. Miguel Dominguez Carrera','Coordinador de Servicio Social',1,NULL),(2,40812,'Dra. Maria Fernanda Ortiz','Coordinadora de Servicio Social',2,NULL),(3,43722,'Mtro. Santiago Sanchez de JesÃºs','Coordinador de Servicio Social',3,NULL),(4,44642,'Mtra. Guadalupe Martinez de Isolde','Coordinadora de Servicio Social',5,9),(5,45721,'Dr. Angel Juan Sanchez Garcia','Coordinador de Servicio Social',4,1);
/*!40000 ALTER TABLE `coordinador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_final`
--

DROP TABLE IF EXISTS `documento_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento_final` (
  `ID_Doc_Final` int NOT NULL AUTO_INCREMENT,
  `fecha_entrega` datetime DEFAULT NULL,
  `tipo` enum('ReporteFinal','Autoevaluacion','EvaluacionFinalPorOV','CartaLiberacion') NOT NULL,
  `estado` enum('Pendiente','Entregado','Aceptado','Rechazado') DEFAULT NULL,
  `documento` longblob,
  `ID_Entrega_Doc_Final` int NOT NULL,
  PRIMARY KEY (`ID_Doc_Final`,`ID_Entrega_Doc_Final`),
  KEY `fk_Documento_Final_Entrega_Doc_Final1_idx` (`ID_Entrega_Doc_Final`),
  CONSTRAINT `fk_Documento_Final_Entrega_Doc_Final1` FOREIGN KEY (`ID_Entrega_Doc_Final`) REFERENCES `entrega_doc_final` (`ID_Entrega_Doc_Final`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_final`
--

LOCK TABLES `documento_final` WRITE;
/*!40000 ALTER TABLE `documento_final` DISABLE KEYS */;
INSERT INTO `documento_final` VALUES (1,'2023-12-04 19:45:22','ReporteFinal','Aceptado',NULL,1),(2,'2023-12-04 19:45:23','Autoevaluacion','Aceptado',NULL,1),(3,'2023-12-04 19:45:25','EvaluacionFinalPorOV','Aceptado',NULL,1),(4,'2023-12-04 19:45:25','CartaLiberacion','Aceptado',NULL,1),(6,'2024-07-02 09:22:41','ReporteFinal','Aceptado',NULL,3),(7,'2024-07-02 09:22:42','Autoevaluacion','Aceptado',NULL,3),(8,'2024-07-02 09:22:44','EvaluacionFinalPorOV','Aceptado',NULL,3),(9,'2024-07-02 09:22:45','CartaLiberacion','Aceptado',NULL,3);
/*!40000 ALTER TABLE `documento_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_inicial`
--

DROP TABLE IF EXISTS `documento_inicial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento_inicial` (
  `ID_Doc_Inicial` int NOT NULL AUTO_INCREMENT,
  `fecha_entrega` datetime DEFAULT NULL,
  `tipo` enum('CartaAceptacion','Cronograma','OficioAsignacion','HorarioUV','ConstanciaSeguro') NOT NULL,
  `estado` enum('Pendiente','Entregado','Aceptado','Rechazado') DEFAULT NULL,
  `documento` longblob,
  `ID_Entrega_Doc_Inicial` int NOT NULL,
  PRIMARY KEY (`ID_Doc_Inicial`,`ID_Entrega_Doc_Inicial`),
  KEY `fk_Documento_Inicial_Entrega_Doc_Inicial1_idx` (`ID_Entrega_Doc_Inicial`),
  CONSTRAINT `fk_Documento_Inicial_Entrega_Doc_Inicial1` FOREIGN KEY (`ID_Entrega_Doc_Inicial`) REFERENCES `entrega_doc_inicial` (`ID_Entrega_Doc_Inicial`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_inicial`
--

LOCK TABLES `documento_inicial` WRITE;
/*!40000 ALTER TABLE `documento_inicial` DISABLE KEYS */;
INSERT INTO `documento_inicial` VALUES (1,'2023-08-15 13:22:53','CartaAceptacion','Aceptado',NULL,1),(2,'2023-08-15 13:22:53','Cronograma','Aceptado',NULL,1),(3,'2023-08-15 13:22:53','OficioAsignacion','Aceptado',NULL,1),(4,'2023-08-15 13:22:53','HorarioUV','Aceptado',NULL,1),(5,'2023-08-15 13:22:53','ConstanciaSeguro','Aceptado',NULL,1),(6,'2025-06-22 13:38:00','CartaAceptacion','Aceptado',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nxœO»j1\ìú‡)\íÀİ­V\'\Ë!\ğ=lrE\ğA!…\ç*Nüÿ•\"I•-vw˜\ÙÇ ÚŸ3b¬†\ö¾U‡y\Â\âx)†—eJhºZQI9‚aV’}`|µz¾Ã¬U3jUm\r„ßµ2\"\"°\ã\Ò{x\neÀx\Íno\ÓEbºA\ó\rwZ½F\"\æT\ØH\Ænˆúu\òÒ®6\rÑ¶–Ê‚]¦“‹d» k2\\g:u4)/p¢\â\æª|\Ãø U/?>i\õ_3ü×Œu¡dû\Ã\Ì\Õ\Â\í\ñ–¿ Z|ÿEW\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250622133747-06\'00\') /ModDate(D:20250622133747-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 303>>\r\nstream\r\nxœ]‘\Ëj\Ã0E\÷ú\n-\ÓE°\åWZ0†4®Á‹>¨\Óp¤q*¨e!+ÿ}¥‘“–$8Ì½š\ËLth\ëVIK£3\ñ,¤\æ\éb8\Ğœ¥\",¡Br»¾|\ì5‰œ¹[fc«†‰”%>]q¶f¡›½˜N\ğ@¢w#ÀHu¦›¯Cç¸»hı#(KcRUTÀ\à>z\í\õ[?Ğ¶m…«K»l\çOq\\4\Ğ™…0|0ëƒ\é\ÕH»SÑ²q§\" \Ä]½®\ÓÀ¿{\ã\ÕI\â\Ôqœe\Òc \é%P‘\"5Y ¬±d¥} \ç@\ì¹şÎ®½®\ÑXÊ¼Œ¥¡gQ¯\êP\Ïï¢±td\r¶\Ès¤]ŒT¬”\n\ÊFK\ë\'¤$şÆ\Âo\ì6g~1Æ×Š³\õS•\nn›×“\ö.•g t\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8024/Length1 21328>>\r\nstream\r\nxœ\í|\rx×•\è¹3#Y¶e#0?4b°È¶À\ÆÛ„Ì¯±\rX‚\Ç\Ò\Ø\Ö’lc‰Û”Àª\rä…†¶4)!Ù„4iš1ùƒ\ì6Mš¦û\Ş6$Mw\ÛfS6Ù¦ù¶/M»m_7kÏ½3’e\Ç\É\î—ı\Ò\ì\ÛeFs\æ\Şs\Ï=ÿ\÷\Ü!\0¦ À½¥\İU¹ş_\Ï\Z\È~\Ävµw¬\îx\å\ò\Ë)€\Öu\Ø?\è\r\ÉÑ’\åS\00ı(\ö\Ïy¢ı\î\é\ß¸\æ{\Ø¶\'\Ú\Ú\ñ\Ù)€’•\È\ô–\Ş\àP\Ï\è+¿º`\á\í\0¹m~E\ö-¸\÷§\ö2^5~D˜/<ˆ\ò–a?”\Ø}Qşl\ìÿÀT5\ñÊ¯,ş¡`\é\0y–¼?j\nMù\ïDz1¤$\äšû\ö·lYƒ8.,‡”\é}Sÿ ş\÷8¿<\Z‰\'R§¡\ÇPúhL‰F§¦”>ÀMj;\Ç\ÏÿF\Í\ã{¦¬üä›€¯şeÿ»\ôşş\Ê\ê\Ë\ä\Ê\Å\Ü~\Ó4\ì\Z\íÀy9·\\ù&\ê\ä¸Lş\ô;‡\ñ‡\ğ\n¥1\ä@úu\n\ğ8\Ó.B•\Ü8\å\ì„ƒ\äv0€\ÉP%\\\Ä)§´;wz¸Ÿ\á=‚\Ü\çÓ¼7µ‹\"<W.k:˜¦qU\"\ÓtŒ\É\Ğ@-µx\nL\ô‚O\ğ0u2¼Ÿÿ\ß\é0¶ı\÷·\ñ\ê\ñ\Ñ¡\n\öNŠ?øø\å“\ãÿ9\È[©7\è5\Ù7NN†7ş\0\Î8\óa|…½>¿‡\Æt\áùp½&;¸“X™\'\ò\Ü_øOª\õ?\â\à#\ĞÎŸ€\öOZ«\Ç\Õ\ã\êq\õ¸z\\=®ÿ³r\Ïœ–\ë„G>6E>\æƒû\ÜúI\ëp\õ¸züù\ò‹O@(ıv‘~\Ë7\r!aw¾‚\÷9`AŒ\æ\Ãjh‚M \àob\ĞÁ\Ó\ğ·<•ú\ßjXƒ£^\r\âh\"{4\õ,\ãˆø%Ú—\ï¥V¾r\æ f~‰x9\Æ\âÿC˜ŠrÂ¯\àmø=q’¥¤’Ô‘mD!ø\Ö\í^ÿ¥/~\á\ä‘[\æ–Ojø\æ›¼\ñÀ\ĞşÁşD<¶/\Z	‡‚}{ş\Ş\Å\çí–»\öÜ°ûú];=;¶o\ëh\ßÚºe\ó¦Ö·¬[Û¼\Ğf\É\Ë-##ùyR£’W^#yù\Ø\Ì//#ª±Q\ÍaHu‹ST\İ[;\í\Ú:›\ÖX\ívU²«nU(m¢—\ìKz\Ód³p.²\Ø\Ğ.mØº³SlJv±A\ÄtŒ\ëi\ã+2czK\å\Z;:\Õf\'\ö²úkY?\Ó]7a¸%=,‰*´&“¾\àKï¶\Ö04~Öƒ–x$µ\Û)Ù¥NiGL`¶wt5bËœnq-r\Ï[ /\ï\é<\Ñ[;;U±«Ç³©+UÙ§ı<TKûµv—*zEQ5–Jİ­I»Jº$«\Şo\ëDÙš´Kv\Ñ\ã9Ÿzn¥–\ìÈ‹ƒ†‰\İ:\â&G\Ûwv^°`6\í\è<\Ç®±«Á3²\0\Ç:/`‚¸–£XŠ¤‘v`ÁÈœ\ãLŒ\ŞzÁ\r0\ÌF†`}/ZÁp¦4€\÷<§\á,š \ä\Æ\Õ\à=/h#\î4µ€8“†Ö¨\ê\Ô&±Ğ‘§Ãµ\Ãµ½„‘q\ç\Ü&w®\Û\ÌpŠ:‡˜§‘6—ÀcfR@¬#È³¡Ï“\á‘\\·\õ\ãÔ¦S#%\Å\rgp¨9%\Ëb„\ò4Ã·Y°mg\çcf@ş\"E=\ÊËšF¸\ÍNi,­·vb\ôšF\Èfg¦6\í\ò¥M\"¦µ\ênï¤´]V\Ìy\Ì\î5\åe4»\ÄNI±J‘iÓ’Ñ¦‹¥qC²s%Øˆltt9“Z\Ê\ÑD“,u˜¦|i‹Wj\îB	—\r~Z\å\İ.v©\İ]NlŠ–\æd3\Í\n™RC\ÉÇ—¡”¬‚U\è7£YÍ“”5_jÈŒ\\\×i#F:’#5¨¤D\óz“\Ô$\Î$½R7f »µ³\×\Úã‘‘·\ê–dU\Z¬#4\àz™IĞ¤¦\Ø\ìD\Û6`nq¶\î\ÂEJ!&“k\Ä·\à½2\í¯±\ãºO\êCÒš5¬MbRu\Ë\Ş.¤h\ò0b\\‰ˆl’dÑ‡^Fs\Ñs\í6w\î¤s:vv&\Í>\É\'¡‡\İî¤Œf[E¯Çš\ôx™\Çq>ª\åe†±\ê¤\'®ùRo‚\ó\"twI\İ\Z‚®Î‰¸Ş‰ˆ¤\Ê\ÆI\ë©8v\'\ì\\/5ù‚^²O\å1\ã\ì¢Ï£¥´²º\ñD$‹HÄ˜2\æIK}ºG\ôv\ğ“T{\Çwı™n3½º\ĞkZ®¨‚ƒf^§]\İkUƒg†DV‡»Å¤h‘\ê$\n\Ø\äµ\ô\êR\r\Ø\öÊ´8i\î!b=\"\Ä\În\Ìed\ØÜ•LgNIj\Ø9%–TÒ¢¹Rj:\Ü*vyÄ®.\Ä\â\ê±[EÕ€w±G¦\ÉE\Ën«fO+\Ö~¼\É\ÉvœtY\Õ\ÜzdE²cµV\é¢Õ¼OuP;h\ïTÁšLJI• Š¥\ÍHŒ\ìª\Ñ\ÑBoø‰:%YÁ Ry¢¬°¹Í¨.\ó\åfm’\ì$\áJ™/\ÑqX-º)\ğ&1\Õİ¸\Ú¥E\É\â¤X›Äªµ®\à\ğn\ï\ÂmA´ˆ\Í\"µŒ™L\ĞB{d¤\æ–RBœ\Ï>5\äÙS:†aŸˆS#61®¨Y[§Úš&\Éal\ìsªÜŒ8H\'mX?(\ê<Ciº×Ye¥³E•\ë\è\Ô\Ã\Ã\æ·Ğ©\ÖtÀ´iˆae—n‹\ö´¾ùš¾šP#û˜\Ù\'·T5•b UuĞ†s¨9cI€mTZ›\Ã3u5°¢D}„Ò¥w„R…Ù¤m‡\"-Ÿø  K\ô²O=ÛŠ5²K¢—\ÇCÅ›˜ :ƒ±NjŒ©»Œtp2Wè’´O>ı´0²\Ñy\ì“\Ãt¦cšI†\ñ×½w\Ğ4\Ï\Ù\õƒ\æµ\òˆ¾*\õu§XU¿\Ç\é\Óf\õ\n.bE\Å\Ê\í\İÊ6v\áj\ì9X\Ç\Ğ|\\U¢\Ú\î\ÄM„\ÙvD\ó\êz­:Ğ¬$\Í4c\é\r(¤u„À¥%­S9\ìfZ\Ò9ˆIZAo¹ÒŠ\ä`µ§\Å\ÈR`\ÆBŸ\ôvù´\Z½+¬+é£‘‘:—\Åv€–¦NƒU\ğ°”q¨ƒN=‹58\àÌŒ\Ò5™“\ö¤‰%3ƒ\ÆnP\Ë\r‡œ¦Ig%Mÿ1a&=šj.£\Õ\ÈaúpQ¼ \õZ¸\Ös\Z\ç\õZ@¬Ã›L\Ò\Ò6²»®P³£\ñÅ¨Z-*Y«k‰¾9ˆª´R\Ñ&†a]\\n9T-l¥ù8`A\Ú\ç´\Ô\Î\ÇAj\óœU£\Â\Ï|\Øp¦©5\' \Şy¥Z\ë\Ãúl-;l5Ó«Išé¥¯¤|}•š\'T}½\Ó\Ü\ñƒR†\İ\è¥G\Ú!f|¬”\è-\è®:\æOªŠıd\İ\Éq\èJÀ•\Ö%“ù\éúO\Ëÿ|\0\öp	\äD„zã±.˜|\Ä4[À\Ğz”2wŠÔ—C^£š\ßHŸ_\èŞ”K \ã{\è½\æ°Ç‰,\Ç0]Š\ÙØ™\Ô\÷9\é’q¦\ç¦ı\ÖÃ–´>w¶£\ób©§^ ;‰J\ğnp\Ø\ée¥®c\ÒhGœúƒ\î!\Z\İO3vŸvŠb\0Ÿ³\Z	>m\áF [•H©MV\ä’øÀeV‡\Øk\ÌL|–j£O\Çø YD²Vj/C’ş{€PÚ¹\ÒZ\ëÁ\÷Š\ó©·\æx´R\Å\á&WGR-E8”‹\ñEC=\ÌÜ«I‡»¸Ñ¡SQ\ã\â\Ô\è¨\öf.¹¡@\ß\È\òVX\ó\è[^ú\ë‹\Î\é|¬R\êi¿ºB\İ.\r\á\ÃB£¤Š\â\õX¹v\'™\Ä\í4)\Ñ7©\í\Z¤C¤l}2 O1:­u¾£u\Íshº\É\çSÍ¡¯Ki7¦¥\ÅP\Zm$\Ó\âT\ï¤\Òh–‘]Z®á‡©?R’&_p\èB“\×\'w\âû¡]K\ëz`·p‡q@M¾H5wjÏ’”í†¥)\ÛnW\Ìv½\ë„m—+e\ÛY‘²y*.\Ú:\ËR¶\å)\Û\ö\ò‹¶mÎ”­c\Ñz[û¢”­mqÊ¶u\ñÃ¶\ÖE¢m\Ë\Â&\Û\æ…\Û6-L\Ù6^“²mp¤l\ëN[Ë‚^Ûºmk¤lÍ¥)[S\éÃ¶5R\Ê\Ö8?ek°_´­¶§lnûÃ¶\ëÄ‹¶Ub\Êv­xÂ¶Rt\Ù\ê\ç\Ålu\óR¶Z[Ê¶\Â6l[>7f«™›²UÏ½h[6ç¢­jN\ÊV9\ça\Û\Ò%1[EÙµ¶\ò²˜m\ñ¢l¥(kÁl\ë¬\ë¥ùn\Û|~\ö¬\ë\í³¯µ‰+±a›\×k›·hf\É\õsg¤lsJR6k\õ¬º]3kJ\êv\Ív·\Ò\öÚ>«¾Ä¿sjm\ñ¶¢ZË¶b\ÅSPk\Şf¨\å¶	x™=Sj\n·\å\×\æmË©5n+\ô\äyŒ\ğ\äÖš¶\ñ8j\òp\ğn·\\ ·C‡s\ÃùœT\Û\ÕÔºK%G\Õ\Òv\n\ñµA5Ua\Û\Î]#„\ó¾\í6˜Û°A½½½\ó\Ø\Ä\'I®qk\çˆÀ\ó4€œN\'\è\'k\ê}§“d€ı€Skh\ã:¹\Ş\ÎtœiR?nd&\Z\è	Å©¥\Ş\ä\rE\0©·\Ó\×\è©\Ôÿ5Ì€b­\áS\Âs|x\Ò\öˆ\Â\0´ƒı„^¤\èC‡½\ğa\'Ä )z\áF¤¾ü8c\0\á>\ìº ‚œn„M8¿“q‘2ˆ£\Èı\ãD\éÛ°À\Ñ[\ç6\ä\éCl¶\ÂØû\ğÑ~\ó\ô‚a=\ğ0¦B9¸Ü³\Ïg_cX \äM\ä	K\Å\ÜS§.¦\Z_iùNeQgQ\ñŒ\Ú%K\÷Ù‹J\ç;ª—\ÕTU–LŸf4Ø‹\ì\ÄQ³¼¦¦z™Cšoœ.¥GrŒ\Æş…\ÑY–,Y° ²rt5¿\ê\ò·ˆ\"\Ô\×\×Õ´m\ï\Ø½\÷SŸşrk\ã\òù‚aı»O¾\æZ°ÀE¯»„o]şc[_y\ÙÚšú-­‡\ìk\õ-sn¨¦\ß\á™\ğ9şQŒ@\ä\Õ]\'˜ŒF@]¦,\êX\ëª*B-ã¤ŠH¼Ÿj\çM\äOÏ\ß>=|\åû·>Eş\ö\rCÃ»Ï¡\Ñ#œ…»p\Çf\Ï\ô[Ab^v\à\õ“\\>!dÿvp.£RU\0C!JÍƒ\é`yj:\Ê\Ë\×\åU¢¨\"{¥P<}\Z\'H¥U•\Ì\r	·\Ó~@\ßu\÷è¿?ú›·F~¹/ş\æ\×\ß24œış4úı¯|a\ß[#\ê›1”‰¼…|\ä³\Üfƒ\É²\ÏM³§\ö0\Ó\íú¥\ò»®x¸}Wsg\r\r\'G\Û??\ê<	\Z\Ã\ä3lnŸ[À›\ÍF0\"/S†Wq­‹F0^„¾!UE’~W_ ¯µ?;²jtùÀ\è’U††\Ëo\ò³\Ş}Fø\Ú\å\÷x\Ã{”û\Ş\ÔoøÿÃ¿\ó¨\×f\Ì‹)\'6\ò5\ÖÅµµ.×’¥M\ó41hüKfH–\ÓJJ\Ğ+Ë«\n9®ü3/\Æ\÷}\÷È¾\'‚üıÆƒ}\Ç>·\ê¦ún\å\ï\çCŠ\"¯=ø\à¥}\ë\ïŒ\İ|^\í¿oG¤o\à\î\Í\Ô\÷{So\ó?§kl0\×m)Ì‹@lv>JŸj\Ñ\ÄWÒsœ\ôEh\Ş5F\ã5(¹(­y{\ğ\ë{”\ó‡ü§\\g¿’»\ì/7\õ+[tX9|\ä\æ\â\Ø\ëgø‡}»6s\æwŸ9¶\Ö\ó\ÊZ2\Ø\Ö\÷Ì£O<£k\ğ\"\Ú>\ì¨A¡µ¦ “©i\ó1JÅµU\ã4 ùoŸ\Ç\é¦;S‚«9ı\İ\î=ÏŸü›\ä¸+\ëIıp zš\ï{|T\æ¦\ñG‡|¶ø\ğ?¿\ó\õ\áw.MY”»\çtWÀ\Û{\çV\Îs\ô\ö\ãÀ¥\Ş=Ev\Öb¦Ì€©\î\Übs1F ©\ğ&bc5J«FË§¥©Y+t³¥\å\ì‘S]4Huu£§6mJ\Şû\Ó§ÿ¼|\ñ\â\å\ô\Â3ş\ëø—\á“Y¬\Ç3Ö™e1Á\ì 	ø[Œ‘g\Z –yúL™:„N,©ªšN.\ŞT\ñ€\ËS¾\á6¯s™\ì\ê:Š\Ş=`\\\Éÿ¦A)H\î\ây³\ívoÌ‰c¬4?_\ãTT…u¨ol-T\Í\Ğ<Œ	¼Œ¹5K’ŞºF:s\ÑùÀÁ{=8wsK\ï1§°i\î\æuşc³\êFÉ¿t²>\ğ\ÌCW>\Ç]¿6|·ş\ÊfÖ\ë¸\Ã¡Vü+L«nsZ]ª\Ë\èb\Ë¼\å;\Î\Î\Û\Ôú|9ô‡³iı\0ü%ºR±š\Ì\ÄD²¤iü\Â\Ø\Ñ\Ö*\Ê|#[KÜ’\ã/\ö\õ½xü—#‘—\ï¯X1\ÜXSs£e\èÒ—O¿~\àÀë§¿|i\è\ğ³{ƒ\É\òCÁ½g\÷P™gFO	S1‡\õU4µ¨0?6K7‹\ÅÙ©­£%K\Û\Óv1\ñ\Ò|\Ç5E¤R¯\í9E%%g\î5,»?´Ÿ®¤ƒş»\\d\Ú\á#7\è;±h\á\Ñ\ÑS†e§7w\ïû\Å\Ùû/\Å\Û×‘W¿9\ò\Ø3±£G7\î\Ñ|\Ê\å\n…0İŸ›§\Ïx´j:µ}y·q\Ñı\Óf´„\ÛDş¥6\ö|\É\ÑXv…U#9\íÁ\èXİ…\Æ\Â\ÂüÜ½9ù\ÆX±ŸJgUQU:ù¤\êª\êª\é\ÈTO\Â_\Ü\äº\ï¾\Şy\Ç\åÙ‹‰È™¼\öÚ‘+—w\ÉG(\ç/¤~\Ëÿ×€\÷¼\Ø\Ù\æe\êŒVe´ŒfeM¯3\ä\Ç_=ùà¼-\áÏ—?x\Æ\àzx\Ê_\ß\Ï¼\ò\åİ®•Ü¹Ë•\'\ëúhÚ¹r\î=C\ÌF¡@œ;\×nšbš\É\Ï\óTpU}»rFmQU%\Õ}µ\Ë\Çmª4\×\ôªV\ÍÒ¬oØ·æ–·\ï½a\İÆO\ßq|\Ûm9\Ënsµ\Şdÿ\î£-\\ù²Ş}}¹šk\ÖnI\ŞX\\ù¡k\×\ì\Ûr\İmü†­u\ršFüj\Ôh\n\êTø„\Å&Ô„f\â\ê\÷g¢ˆT\ğ·cx<\ÄÚ½û¡CJYwG¿\ÏÇ•Ë\Z~¢K~\â\æC\ËC\÷µ\r¯¿\ç\à\Ğ=\Ô\öGR$c\È\Å=«X,yB ¯˜FŸE«\İÁ1¿r9|V\íºb™\ñ\èŒ\"×Š––5k×’»¤\ôİ½OŒş4>\êi©®in®©n¡üo\åƒ\\„ñŸŠ–\ä	°·PH[‚†`ĞŠœi‘·\ÌS\ÎŒn6[î’\Ï\÷¨{w\ï\îûZwú„ü\Â\ğ$\ï5>OJyı9†\õ\Ô*ù\Ös£)Ã“¤`\ô_\Ø?\åí£p\ê?yş\ï¬\ó\×\î“X¯Ygg\Öù¥¬\óÕ\÷\ä\n¸\ÅYçº¬\ó\÷Ü„\ó½r\ò×²³û\Ï\ã™\ó™ÿz§#¬¼z^=¯WÏ\å~¬\çW\ÏO\äü\êŸ\÷¤¿\ò\"/±ß˜\Ñ\ï\ÚV\0\èm\ìı\×h9ü>½\Ígá…¬¶ŠøızÛ˜…Ï\ÚL»€|›ÿ½]N\Ã&½mÉ¢/\Z“E0\Zt\Ä\0\ÃMz;7‹¦Ì†[\ô\öJ¤?N1\'\ä¢QÃz›@Ù ·9(4\êm>/dµ\r0\ß|Xo³\ğ9Ë´MPl¸Oo\ç\Â\óY½\æ\ç\õ¶–\Ì\Ğ\ÛüÑ‚µz»¶[^\ÖÛ–,şEcº¡\í\æ¢R½m€¼¢¥z;7‹¦f\Õ\ë\í•H\ßşU±rI\å2qSÀ‹\Ä#=	±1‹Fbr\"	Wˆ«ƒA±-\Ğ\ëO\Ä\Å6%®\Ä_…\Ø\áW\Äù}J,<_L\È\İAEŒ\ôˆ	 .\öD\Â	qP‹>e@	F¢ŠO„Å¨Kˆı\ñ@¸W”\Åx¢\ß7$v‰«Ã¾\Ø1±¹\ßë‹‘0\ÎWÄ˜Tä°—1¤üé”¨ˆ\ÅÅ…şD\"\Z¯s¹z	w…7r\É\ÈA)\ï¡\\:u9£vu#İ®O(1\×Æ–Æ¦\Í\íM!ß¢\n´-:£\æ \ÑKk³u¨[•X(£\Ù\"š\âWb\nj\Ù“\Ã	\ÅW&\ö\Ä¦–\×/\Çz•21\å\ğUbqœ\éNÈ°f¡ed<B=:(\Ç$\ö‰r<\ñd\ä\'ú\"\ŞşN07‹= ‚6R\Ìo\×g\Ì_Ä„ø9HH\Ç\ÒC\â :!ÒŸ@‡\Å±€—\ò(C\"o°\ßGuH¡€.¹W‹#2í£T\Ï21\ñz\è]afEû»ƒ¸¿L\ô(\ë\îş\"\ã\éU\Ât\Ú\áŠ\ÄÄ¸‚‰¨7³uL;FC¥D©Cº‹˜\ÜA$4\Şš4ıº¸_as|t“¸W\ñ&(†’\÷D‚Á\È 5\Í	ûÔ¢xKC¹;2 0S´°†#	\ÔTÓ€ú?:T}(\î—Q\õnE\÷—–¢r–51*=À¸\Ğ\õ¸˜¸‰VV¬&\"qª¿,&b²O	É±¾4\Ñ\Øb\êEú£,o\"¡¨FmJoPmG·Pµ*+–,­\ßRUS=6)\Ş¨]O¢\'\Ò/†\ä!\Zµ¬e†®\ñ\Æ™\Æc\r\ÊCšã£±\0¢Ÿ˜^˜rzh\Òa>S\í\ôXŠ¸:B\Ì^½Ñ£\å\Åûlˆ\Æ\"¾~o£‚\ë\ç–\Ñ9i\è¼AÀ\ëŸP\0\Ò\Î\Ó>‰‹D%Ô­ø²È‘Ã‡i\Ë\ÈYZge{|\\\ô2¼\ê™PJB	\Ñ* T_d0ŒÈ¾\ñŞ“5W)1jNE!\ìODq\İ`\õ¢™‚4~%\ïQ,‰¸\ì5r\Zšc±ˆ?\Ğ@+\ÒU\n—w¼\"”\ö «V‰¡h«I\Ô?\äÂ¤\íO\ìPh\Â\îøş-Q\ÌLÌµ\öÀ¥%!c|\à« B%,Ák¶6A\0¼ƒ\Ä\ñ\ê\â\Z±ƒ(ƒ2b\Ø\nCû!wO\Ú\×~‹³‚w©úe*xŸ}l$Œ-\ée\èFt„J£?\ò¢\\z˜*©(Æ‡t”cG¢Œ³ˆ´a„Q¤ˆ1\Ú~¤¤¸^l\Ëx\ÅÛ”C\Ø\îfp5úú-l7\ã˜%Æ™ü°.Ÿjcr¨<\ñ\Ş,\r\Óú§¥P\Ù\ÄP™ˆ‹C¸\ğ\ì\Å1Ê³¥W Ÿ„+\ë:(P<\Ó:¸&\ğ.\Ï\â\íb~Š t!™\ÙEi]°Z0BM°\ÚV\à¨1Ÿ72?\r!U::Z¤—B\íú\ÎkeœC,q=Ú¢?St_\ö²Œ3]|PÆ¢FGÇ¼E¹\Ò\Ø\ô\"®Œù7\Â\"f\ó£Œ[\\—@­K0‹\Ã\ãb\è\Õ\íx¤st\ÉPt\Î>v³Q/RÊº~4ƒ(¦mS˜\Öc\ÙL5°ˆkqLd\òµ}‚Œù\è\İ1KhN\Êl\r\Æ\å\Ï\ÄY4‹µLˆ ü„a4Š1¶\â\Òz”éœ¼È³Ÿı´æ‡‰³ƒ\Ø1\\¶\rcÙ›½5MûÙš,\Ë\ò\'m‡°M¥\ôdúJV´¢,oƒ\Ì\Û~†ñ±¶¦u7\ÓE£Œg(½Ì·iYZ<\\¬vˆ«UM‡€\îï±¸Næ»²¬¸j¶D3š˜Ec\ö2o…>4&\éJÓ¯¯º8£“\ãcr³q/Rx™\\&ÍÖ« [£ƒ™¨y™N>¦g@×¯.«\Z\Ò\êa5m,*Ù«5Œ¸„\î\Ól¤\ó\Ì\Ù+uü¬8[š×»u«\Ç\ò+»Š\Ê›X\Æ\ö8Ë·0\ã®e½¶+ŒY\÷\ïÅ²\ëN”y.\ñ¿\Ì\èi%¡ú„e\ßû8M¶3\õ²~?r«74\æQ¦¥fAÛz\ÙE(\ç\íz¶¤½U‰´&\Ö\Ã¨‚\Z¨FúNC¥Ê¬¢+z~¥\ë»V\İ\ÙYÁ\"0^·±ZŸÀ˜R/iµ2Š†›\Ş\İ\âz=Ï–\ñş”{<\Ãs2OÄ™¢lj1MK \İÃ¼$2IC™Z0ùn«eµ—EKÎ¬om\İG™‡Æ­\È(\ËXm®W\ç¢\è}yB–&2•X\Û?Ò±_7D}oe\å\ßxLÏ¸z\ö\ï\çI”\õ}l—K\èkY{>\Ñ\ä–e\äL´@[ƒzü\à³\ô\ÊÄ•5™\ï\éœ k-DúEx§9ß©;\ï\ç®\é\ğQ};\Æ}l7™|\ï™Ì‚\ì}m¼^\õY9@-\ÑlI0y\ég\Å\ÛS‡\ôJ:\È,°uşa¹\'\Ë*…\Å%¢Ã„ş\"\ê;aT\ßµg\Ãt\Í\Óøø\Ùnı\ĞÕb\ÃzdÆ¸§WHº\Î\Òü\ñ³=/ û¹\â}\Ïz\Ú\ÓEü#\Õm\' ¶\ì@\î\é`¶|L«-¬jR®Z\İm\Ç\ö¤laY[?ù\Ûk©»\èß’›\ô úş;¾;\ô\émŸ/\î\Åû\ñªkmú\×Şª\éKLG$\Ä\×\àe\Ëj+–Ô‹ı=‘ÊDXU±”v{ƒCQ|c »N¬©À³^\Å\é¬ \Å,©¨­XQO\ß\\\Økvo€~—0 /¤ubµ×»t‰·Ú»QN„\Ë\ÄÆ¡X°L\\S”¾2q P®a»{ËµxLo\ô\÷±\ÆGš\Ä<@À\Ä~½7ÁeÀE¢\ñ¤`ß“ˆ\0d_•ˆ¸\0¾\"‘•\èU\ÌÁMb%ûŸ¯¡ß\ä\Ï:\öı#¡8r;²\áu\É\àµy\Ö_¨€k\Ãvbf³ÿ\ÛJ3·\è\÷Œu¸´¬Â“€\Ë]@¿[†ÿ…\ğ<Œ\ğ\ëp\á_ı±\ïÀ\ïş\õ%$\å’O\Ì\É\"„N²\áV\âE¨Co&I„Ÿ#_Gø(9‡º=I\Ä\öy\ò4\Âoo |–ü-\Â\éw¯\ä{\ä‡L~‚\ğU\ò*\ÂK\ä\Â\×\É/ş t\ò{\òG„\") \Ï\å \Ì\å\òÒ¿]\ÈssÚ¸\ÅË¸\n„\Õ\\-Â•Üµ¹M·r[¶s·s;z¸»8\ô\ç\ã\ö\"q!„Q.ŠpFx+w+\Âc\Ü¿\Äİƒ\ğ^\îk\åF>\Î=\ğ)\î)„Osh\÷M\îY„\ß\á\Ğ.\î{Üş„û;„?\å~Š\ğ\ç\Ü\Ïş\÷\Z\ÂK\ÚÈ½Áı\Z\áo¸wşCK¹?r—r£@x4a>\çùB„Ş‚°˜/FXÂ— œ\É\ÏD8Ÿ‡p>_p	¿¡›_°‘o\"¬0\ÖB“Ğ„\ğ\á„§…\Ó\Î/<&<\í\'…¿\Ç\öÏ„ŸaûM\áW\ß6X.\ó\ì;j`ÿ?º’ı½\Æs\Â\Âw„¿Áü\âq\Ş\Ó\0\Â_ÏƒAø.\ò( 9(ü•\ğ\íªAZø\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  34[ 686]  40[ 556]  232[ 525]  244[ 527]  292[ 239]  299[ 260]  305[ 853 551]  314[ 552]  341[ 561]  357[ 323]  362[ 559]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-22T13:37:47-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-22T13:37:47-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:DocumentID><xmpMM:InstanceID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Filter/FlateDecode/Length 108>>\r\nstream\r\nxœ-Ì½@@\àw\"‰\Ñ#Ö‚H\Úa” ×‚‘P‡D*8gŸ\r\ö›\Ùİ·@(\ïU\è9\ğ±’[P`J²M°=\áĞ\ä \ÌE\Ü\Å \Ã\Ïšb‰#Šü—Q\È%§\Ä\ÓA\È.¡š…º!\Ğ\îÀØ”\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003030 00000 n\r\n0000011144 00000 n\r\n0000011310 00000 n\r\n0000011337 00000 n\r\n0000014518 00000 n\r\n0000014563 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] >>\r\nstartxref\r\n14872\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Prev 14872/XRefStm 14563>>\r\nstartxref\r\n15629\r\n%%EOF',13);
/*!40000 ALTER TABLE `documento_inicial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_parcial`
--

DROP TABLE IF EXISTS `documento_parcial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento_parcial` (
  `ID_Doc_Parcial` int NOT NULL AUTO_INCREMENT,
  `fecha_entrega` datetime DEFAULT NULL,
  `tipo` enum('ReporteParcial','EvaluacionParcialPorOV') NOT NULL,
  `estado` enum('Pendiente','Entregado','Aceptado','Rechazado') DEFAULT NULL,
  `documento` longblob,
  `ID_Entrega_Doc_Parcial` int NOT NULL,
  PRIMARY KEY (`ID_Doc_Parcial`,`ID_Entrega_Doc_Parcial`),
  KEY `fk_Documento_Parcial_Entrega_Doc_Parcial1_idx` (`ID_Entrega_Doc_Parcial`),
  CONSTRAINT `fk_Documento_Parcial_Entrega_Doc_Parcial1` FOREIGN KEY (`ID_Entrega_Doc_Parcial`) REFERENCES `entrega_doc_parcial` (`ID_Entrega_Doc_Parcial`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_parcial`
--

LOCK TABLES `documento_parcial` WRITE;
/*!40000 ALTER TABLE `documento_parcial` DISABLE KEYS */;
INSERT INTO `documento_parcial` VALUES (1,'2023-10-03 14:17:10','ReporteParcial','Aceptado',NULL,1),(2,'2023-10-03 14:17:11','EvaluacionParcialPorOV','Aceptado',NULL,1),(3,'2024-05-02 11:45:54','ReporteParcial','Aceptado',NULL,2),(4,'2024-05-02 11:45:55','EvaluacionParcialPorOV','Aceptado',NULL,2),(5,'2024-10-05 17:33:12','ReporteParcial','Aceptado',NULL,3),(6,'2024-10-05 17:33:15','EvaluacionParcialPorOV','Aceptado',NULL,3),(7,'2025-06-23 20:44:00','ReporteParcial','Entregado',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 217>>\r\nstream\r\nxœO\Ëj\Ã0¼\ôsL\n±w\õ²FP?Z\êCˆ!\ÒC©O5m\óÿĞ­“C“Su\Ğ\ìh†\Õ\ò\İ\çqBU\å}\óÔ‚\ò—\ã4bq:¯ú\Ã2%\Ômƒ/­(£\ßÙ€\ä.¢Á\÷I«ı&­\êA«|\Íax×Š\ÅD`˜2_  ˜E\â\Ù\ì˜0e!\Æ\å+\İh\õZ•EZYÁµ#\ö\Ø>\n–\ÉU\ÄÁ\ÏÏ¶bsÉ‘Øšv–\Ù\ËÜ•I€9¤xUL\Ş0<k\ÕI¾­Vÿ-b\î‹X\ç3gÿ™\ã_B/°¼ù]\ß\à*D\ã\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203827-06\'00\') /ModDate(D:20250623203827-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 288>>\r\nstream\r\nxœ]\Ñ\İjƒ0\ğû<E.»‹bb«mA„N\'x±f\÷\0š»ÀŒ!¦¾ı’“\ÒÁ\n?Nşù8Iª¶nµr4ù°³\èÀ\ÑQiia™oV\0\àª4\áŒJ%\Ü]øSoH\â\Ãİº8˜Z=Î¤(h\òé‹‹³+İœ\å<ÀIŞ­«\ô•n¾ªÎ»»\óhG)K*a\ô½\öæ­Ÿ€&Û¶\Ò×•[·>\ó7\ã²\Z )š\ÇÃˆY\Âbz¶\×W \ó£¤E\ãGI@\Ëu\Æ\Ø0Š\ïŞ†\éÇ½Ÿ\ÎX\ÆJ\Ô!*EU5*ç¨—c\Ô\Õ\Ä\\qGP\ésT…Ú£\ZT–¡,*®yÀıx~¯\íƒv\õ	•2¼\Èı\Ä\áJ¡\ó~‰›µ¾Uø<Ø£\Ğ¥\á\ñ‚f6!¾_x*†\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8106/Length1 21412>>\r\nstream\r\nxœ\í|x×™\èfFÛ²‘m°\Z![È–\r6$66\Ø\æalO¥±%,YBL\ÜPQ›\Çmšl’¦Í«	m\Ò4c\ò‚\ìnÍ£\ÛmHºû\ín·4É¦›l\ï×¦io›Û¦`\İÿœ=L»7·iº\ßeF\ó\Ï9ÿù\Ïÿ>ÿ™\Â@\0`\\›{ªk;şpB@ ¶¿§wM\ï?œ}5	\Ğu\'\öy‚RxqÎ“\0scÿ\ÏhL´~e\ÎK\0—½ıg\ÃCÁíŸŸe(Ù€L\Æ\ß\Ûû\ã\0K\îÈ¹\Í\'K\Ş\ò{wÒÅ«Á‡\Ó\Ùü¯£¼\å\Ø/\÷c¶]—ÿ\ØÿW€b%\òH\ï(ÿs@\íJ€\\sP:6gı\Çû^\Ê1©\á¾=\0›oC7\"\å9\Ã\Å\0X½\çW…C\ÑX\ò.¨\Åqj\È\á\ğ\Ñd1@\Å\÷¸Y@m\ç¸	?¿|\ï¬Õ¿ƒ<#\Ğãµ¯\Å? \÷\ó\ÕÖŸ%\ç\Î\äÄ³±«\Ô\çœ{u²Ÿ%¿ÿ\r\Ã\ÌCøJ£3€ıjgš¡šP%7\Ì:‚=‚pˆ\Ü:0\ê\ê„38\å\õÎA\î\Çx\Ï£‡ w\Çù\ï=¢\ÏBş¹³ª\Æ\Ù\\\ä.:Æ¿¢k¦–Ï¿ˆZ<	FzÁ¥\ãS9\ôİ |\Ú:¤\á«]„ş\å\è\õ—t.\Ø\÷g“UwaYÂ¡À¯ø\ó\év±ƒü¾€\×=\Â\\\Ü¸\õ\ã\Î\öıc6‘±›{ø\Ã>ø\Ï\îV¬\Ìÿ\r\á\ğ§Ÿ{|zø›¡\ç\Ó\Ö\ã\Òq\é¸t\\:.—K\Çÿ\ß¹û¿N\Ë\õÁÃŸ˜\"Ÿ\ğÁı®ı´u¸t\\:2yù\æÿ\Æ\'\Ëÿ‚ıv‘~\Ë7!aw}OSo‹a\rl„.\è	d\ğC\0\Â<OÁsdoH&~\÷—¡\ò0ªĞ‡©’\Ï\"\÷\åP£€u\é„oÃ¯I.ü1¹&ù6QP~y–f‹²`\ÖÁÿÿ™Pÿ\ï\ÂoI\Ù\ê\ê¸ı¶¿º\õØµG?w\äš\ÏN^}x\â\ĞU\ÇŒ\Æc\Ñ\Èşph$\Ş\ç\÷\r\r\Ê^Ï€Ô¿w\Ï\î];w¸û¶o\Û\ÚÛ³¥k\ó¦:;\Ú×¯k[b1\ç\æT’©¼\Ü[‹œ[U	S¹y\ØÌ«ª$Š¾E10¤²\Ù!*®-}\Ö\Î\î¾ÖµeV«»\ÌfU\\ŠP\ÑJ/É›\ğ¤\Ü\Èg\á\\d\Ñ\Ùc\ëÜ²£OlM\ô³A\Ä\ô\Î\è©\ã+\ÓcZK\áZzû”6\ö²ú\ëX?\İ]\Şp{j\Ø&*Ğ•Hx§€¯@¼«lŠ°†®\å\ón´\ÄmS6«­OF\Ú)#˜¬½ı-\Ø2¥ZD\\‡\ÅSfÀË³\İvŠh­}Š\Ø?\è^\ÔÀU(\ì\Ós\n\êm\Ôv¿\"zDQ\ÑW\ØºúV…\ô\ÛÊ´~wzŒHe	«\Í*ºİ§’\Ï- \Ô6+\ò\â y\ÊFo™r‘\ã=;úN›1³\÷\ö\ä\×\Ò\ß\ì*Ç±¾\Ó\"€‹a9Š¥H\Úi:	F\æ$gd\ôe§]\0“lT`\Ö\÷ gL\áxNq*Î¬\n²3A.\\S‚:\âJQˆ3ª¸I•z‰Fm\Ä3y\n8\\KlP=\ĞKW®\Îet\å¸L\\>‡± ¨“ˆy\nis<j\"ù¤l\nyv3\ô)29•\ã*;\Í8uk”“HIq“ijNÉ²¡<\Õ\ğ­¶\î\è{\ÔÈŸA¤h¦GUe\ë·\ÉaË¤\õ–>Œ^\ë\Ù\ä\è\ÇÔ¦]¾¢UÄ´V\\=}”¶¿s³{mU%\Í.±\Ï&—\Ù\ÜS³g\'Â­SfsKg¢s%Ø”¤·\÷;j\Ê\ÑD³™›0MùŠv­­Il¸l\ğÓ(\Ï6±_\èw`S4·%\ÚhVH”\ZJ¦8¾bŠ\äJ¸ı¦7)¹6¹YÉ³5§G>ŸQG\ôt\Ä`kVH‰\ê\õV[«8×Ÿ\ğ\Ø0]]}Ceƒn	y+.›¤¶\æ²)šq½\Ì%hR\ëlr m˜ƒ›];q‘Rgˆ‰\ÄZq\Ê%\Ø%Dûk­¸\îÚm\íZwÖŒV1¡¸$O?R´º1®DD¶\Ú$Ñ‹^Fs\Ñs=6l\î\ØA\ç\ô\î\èK˜¼6¯\r=\ìr%$4»L\ô¸\Ën\ó8\ÎGÕ ªR—©NZq\âèš¯\ğ\"8%\Â@¿m@E\Ğ\Õy>n\è|\Ä Re\ãlT»vOt\ØZ½HA/É«\ğ˜qV\Ñ\ëVSºX\İøH\"’E$bL\ó„yUªG´v\ğ“P†fv}\én½ú\ÑkN5WÁN3¯Ïª\ì+SnGšDR&Ä„h¶5\Ù(`“\×Ñ«_\Ñac\Ò#\Ñâ¤§¹‡ˆDˆ}˜\ËÈ°­?‘\Ê8œ&\ØÓ’”\Ç–XRI/Š\æ*¨9\Êd—\Ø\ïûû‹«\ÇZ&*:¼‹ƒM.Zv»T{º°\ö\ãMJ\ô\à\\ ¨L1\à0(\É6+Vk….Z\ÕûTGµƒ>\Ê	[B!¨bE#{»¢··\Ó~\Â›$c©<Q’\Ù\Ü6T—y‡r+kµY\İH\ÂU0_¢\ã°ZP\àI`6*»qµ\é*\nE	±1Uk7\\Á\î\ÙÖÛ‚h\ÛDj	3™:¡\ö\Ü\ÈH%Ì© „8Ÿ}\ìJ\Ğ1µ\ÛP‘Á°OÈ¡WÔ¬»O\éJ‘\Øû\nWº©\ñ¤\ë‡ÀE§«hG\÷º0«\Ê\èlQ\ázû´\ğ°ù\ítjY*`\ê4Ä°²K·EkJ\ß<U_U¨}L\ì“S¡+0ĞŠ€:¨\ÃjN&	°J«sx¦®j\0¶Q”¨0CúµP!3›\Ô\íP¤\å$½\ÊN%Ÿ\í\Â\Z\Ùo£—\ÛM\Å™ :ƒ±N¨Œ©»\ôt\ğB®\Ğ$©Ÿ<úig&d£s\Ù\ÇÀt¦cªIº™×¼w\Z\ĞT\ÏYµƒ\æµ\ò˜¶*µu\'—)>·Ã«\Î\Òk\\ÄŠŠ•Û³…=m\ì\Ä\Õ`³\Z°¡ù¸ªD¥Ç›³\í˜\ê\Õµ:Ğ¬$m6h\Ã\Ò\ZP‚ ¶\õ„À¥e[¯p\ØM·l\'9 F\ÛJzË±­œ\âˆ«=-F\æ|ú„§ß«n\Ô\èeXY¶š>\Z\éY sXlGii\ê\íÓ•	n–2veÌ¡e±\nG\é\ñ1º&\r)O\Z\éX\"=¨c\ì\Æ\ÔÜ°kp\Ôa¼à¬„\ñ¿&Ì¨ES\Éac´\ZÙÅ«\êP\Ã\ÕÁ©œ;\Ô:X»\'‘ ¥mjw]¡&{!\â‹PµFT²Q\Ó}sUé¢¢Ãº¸\ÜT5ly8`F\Ú\ç\Ô\Ô\Î\ÃA3j\ó\\™J…Ÿ\Óø°?\êHQ«N@½s+\Ô<×†µ\Ùjv9\Ü\Øj£W?’´\ÑK[Iy\Ú*5W\õ5\öjLsf\Ú\Ò\Ì\èFoKs¤½)b\Âg`¡L‡\í¢\İ\Õ\ÄüiGU±Ÿhš\"»F £\\ES\"‘—ªÿ´üŸ\ÆP`—\àNœP&0\ëü\Ï\Ç\æ3´\åü\ô\"µ\åÛ¢\äµ\Ğ\çº7\å\Ğpb|\'^\Ôj{œ\ÈrCÑ¥˜K}oH•„#57\å·A¶¤µ¹\ça{û&K=\õ\"\İI‚w\İJ¯2\ê:&\æxÈ¡=\èN\Ğ\è^\Ã\Ø]\ãE?>gµ|\ÚÂ\ÒO·*‘R\í¬\È%\ğ\Ç/I¬±×˜¹ø,\ÕMŸ\ñ\rÀf\ÉjX­¾Ù´\÷\Ü„Š¾\Õen|¯8•üù·Zª8\Ü\ä\ñ\êMˆ¢¹‡b¾h(G™{µ1\Ã\á.®·kTÔ‚£¸8U:ª½‰Kt\ö \èY\îÊ²\\ú–—zÁº\Íq±a‘\Î\Ç*¥\ìµ°RW(\Ûl\ãø°\ĞbSDq–DD®[\àN$p;M\Ø\è›Ô¶>\Ò!R¹€>Ğ§¶l¾£eº¦4İ¤S\ÉG\Ğ×¥´´«R\Ò\"(6)qŠ\ç‚\Òh–‘j®á‡©?\Õ\06U¾`×„&v%v\àû¡UYHkz`·`›q@Mn£š€+¹·&iÙ³,i\Ù]±ìª¾Ù²³:i\Ù\áLZ\Ü\Î3–¾Ê¤e{UÒ²­\êŒe«#i\é]\Úa\éYš´t_´l¹ü!K\×RÑ²yI«eÓ’‡,—$-.KZ:\íIK‡\İai/²¬/?cYW´´U$-­Y\ÖÚ’––\ÅIK³\õŒe5iqY²|F<c¹RLZ®o¶¬«-«E,M‹’–FKÒ²\Ò2iY±0biX˜´\Ô/<cY¾\àŒ¥nA\ÒR»\à!Ë²šˆ\ÅYy…¥ª2b¹|\éK\Ê*Ÿ_6o—m±Ë²˜Ÿ?o—uşq56,‹†,‹–\Î-Ùµ°4iYP’´”\Õ\Ïk\Ú9·¡¤i\ç|Wm—\Ò\öœy«J|;Š‹¶6š·¹\Í\îüF\ÓV]#·UÀ\Ë\ä\ÕP°5¯1w«¡Q¿µÀ\ëÖ»Á\Óh\Ü\Ê\ã¨\ÑÍ¹\ÍÀ»\\:rš\Ü½\ÎS†dw§b\ìÚ©\ãJE…øÚ \è+°u\ÇÎ¾)Bnp½şzX\ØÜ©\Ü\Ô\Ów’l\â“$×²¥oJ\àop7ƒh\'kj}‡ƒd€ı€Cm¨\ã\Z¹\ÖNw)R\r?cd.\èš\é	E\ÉN¾\Ãÿ\n’ï¦®\é;’¿Ô•B‘Ú‡C\ğY\â9^<iû „az@†8`)†Faü\0$\Ø\èEŠ!¸\n©¯\ÎE¸ûŸƒ~!§«`#\Î\ïc$¤\à\è(rŸ`œ(}7\öü8zynE^\ÄF`l‡\İH±\è7M/\ê:€‡YPUP\íšy©8ÿ2]¹;ÛŸ+˜\ÍÎ…\å\ÅÅ„‹€1‚\Æ×š_ª-¬C\à(,*m¬Y¶¿\ĞZX±\Ø^¿¼¡®¶d\Îl½\ÎZh%\ö†\r\r\õ\Ë\í¶\Åú9¶ÔˆA¯7\ğ/N\Ï+¯©)/¯­^\Ã_y\ö\ÛDV­jj\è\ŞÖ»7|\ïg¯ùrWËŠÅ‚®\ãƒ\'^¯./¯¦×Â·Ï¾\ß=\\U¹®a\Õæ¾®‰ã‡†»¼\Ë\õ\ô;=#>\Ç?‚0@.”¹\òs£^¨«À”E«\ë\nQ\Ë(©#6\Ş\Ê[y#ùı\Ó\ä\×OMû\ÇkŸ$ÿ3]\óO“\ñ\écœ™»\Zp\Çf\õ\Ï\ë\í\ô[B¢^µ\ã\õ\\!\äÀ6p,§¿OT\0t\÷ \ÔY`q™ùœ|\ŞdÒƒ\Å\Z5±µ…E\Õ\Ô;\ÑB”K\ê\nm\Ú]y‘¼\ŞNş\åÙ©+§WŒN\×\\©k>û?ïƒ§…oı#¯ûc/µ	¹›‘»	\æ@©+/?/\æd\ÜO-¢|­µ%Ô©z›µ\Û\Ì\ÙV…¼=\ñw±\Ø\ßML¿B\Êş\Õm\ã\Ó?\Ñ5\ï=}í‘“»\Îı’ûú\Ä\ÕÇ¯\ÑøßüK@„…®‚œ\Ò\Ò9s@D	³\ÒÚ£Œ¢\Æ,)†E\\i±wrš´”¸s\ñg\"7&6¬™\Ûwj\ã\ì»6N¿@j;¬;z\õ\ôwu\Í_=<ù˜˜·\á³{§!\õ=\ñ+Î½\Ä}\å¾\Îı‡Q‹}\Éwùo\ğ¯\Ã\"XVW\áüÜˆ\Ñf›¦Ù†ˆe\äQE˜&…uše­‹\í4\Å\ÊWd’\n³j7§\Ğv™^YmÃŠzA?gv	¹³\÷\ó=_#•\ß=´WN\Ü;\ôx¼\óº \ëNC\ËT‡\÷\î†\é\÷\ß\Ù]\äš\Øu\äø2n\í\Ä\îÁ‘_Z» \ã¨ÿ\\üK;\'\÷¬‰\ß3Ü¾\ã»/ù+ş»L7Ì©üùù\óÁl4DJU­µE\Õ\Õihv—”\Ú\ìL¯\Ù%%u¨L]\ÇU}\î\å\èş\ï\Ûÿx€¿_hø†/\\yx\Ï\ğµüı|\ğta\è\õ¯ı\Íı·D\öW\â\÷m\r~eh^ù	­(`ÁØ˜r#ù™Ÿ‡Ò‹\Íi§\Ô:3¤—Ö¥\İP˜Òƒ¼;\ö­½\ò©	\ß\Õ\'¾š³ük‡o¨\\zT>z\ì\ê¢\È[\'ø\éş›8\ÓOß°\Î}¼Œu?ı\È\ãOk\Z¼Œ¶\Ï+Í²˜…iNH™\ÙQ\ÔX7Cš\"\ÖEœf:±2%¸†»¾7°\÷ù[¿\óow®ƒ¬š\ô‡£ù\ŞÇ¦%n6|ü\àç‹şû·¼5ùŞ›³–\æì½«\ß\ïºe\ç>~Ó¨\Çp¡\íÖ­cu\Éüd®@\ôÈ¥+\à•Z¶¬\nù¬¢sÏ‰\Şj\Z”¦&ş•³µ\Â\Ñ—_¾‚^\Ë{\Ïzş\äcz<\ÍC\åp\Ï	Jk^“¥·“Rl„\'§\éw\ö¹2¡Wj–!Ÿ[q\ä\×lU<¡ƒH.cT‹œ$\ê\ä6»¤®n9=v\Øù@µ»ª\óz`8Kv\ög>}O\0şMZ/Ğ–¹\èLsÊ™3Óˆ.\è\Ë\Ô\åE=\Èò‰«¹\ñ\å\á\á—oüâ«¡Ğ«_L®\\9\ğ_\Õ\Ğp•yü\Í/\ß\õ\ÖÁƒo\İ\õ\å7Ç\î=±/\ğ $=\Øwb/Í¤{¦\ïŠ1Z&\äE\æ\ñzC„\ÚT@ \æRÍ²ÂºÒŒx\Ûbûe…¤V«Ş†Â’’{\î\Õ-¿?x€f\Ó!ß\Õd\ö\Ñc‡ß¼t\É\ñ\é;t\Ë\ï\Ú4°ÿ\÷¿\íY?]H^{f\êÑ§#¦oØ«ú;\Îÿ\n`+/\'%<WÎ‚@%\×Í¡¶\Z\n\ïùŠ~\é\ã³K\ÛGºEş•6\Şno©<\×K+®ˆœv\n\Ãl\\‘ú‚‚¼œ}†<}¤H‹B­£®°.\n[}]}\İdª…\ä\í\Ñ\Ã\Õ\÷\İ\÷À{\ïU»\÷aX8Ó±\×_?v\î\ìNé˜º\â~É¿\Æÿ”ù©\Â5{VnÄ¤”\Îgk®¤8½\ê°\n1p\ŞÊ«¿\Ğ\Êû\Õø#»½ONowÒ•wÿ\æ\àM%\Ç\ä#\×M\ï\ãoDwt\Şr¶\ö\æÎ\Çıd|³üœ\ò\è\ßPMz¸*îº^X\0vŒX¾¸p¡\Õ8\Ë8—Ÿ¦b¨®{¡¶ka-µs¦ÁŠ[lIV1d©C:š\÷¯=\ò\î½{\Öo¼ù‰·ß¸\õz\Ã\òë«»[¿\÷H;Wµ|h\Ã\ğ\ğ®aû\Úu›W9£şsÿ;x\Å\Úı›?s=ß¹¥©YÕˆ_ƒ\Z\ÍB\n7Á_jDMhÖ®ùp\ÖjIK¿yÀ\í~ 2ú\à\î\İNÈ•½q¯—«’›˜|¼_zü\ê‰Ç¤\ñ»Ç»\';\î>4~7µı\á\äû\ä!\\]9¸\ç»rÀl\Îü¹E4SXd{\ì[cœ!{ÙŸ3—>RZX½²½}eÃºu\ä+1Rq3\İ\ËoşQt\Ú\İ^\ß\Ğ\Ö\ÖP\ßNù_\Ë¸\ã_Œ–\ä\n°¯@HY‚†`¾\Ğ\n–n‘Ÿ›f\İS?½\Éd¾wVØ«\ìÛ½{ø›©;\ò²p”û*Ö§<¬ \ßP\í`^I+\Ç\Õc9¢%)«\á¼7tO\ğı\óXpI\Í+®Ã‘o?7\Ô=A\ò§ÿVŸ½p\îøo}~\÷Orşd\õ_Ğ™øX\çw2\'g\Ì:7ü	\Î0wMúü\ÒEÏ“=\ñqN\Ş\ÉÎ<\'?Á\ó\Åÿ\×S(Z.—\ÎK\ç¥\ó9£Ÿ\èy\ç¥\óOrú¿<_ş\óø<h\'¯°ß­\Ñ\ï\ëVhm:\ì\ín~¿\Ö\æ³\ğBV[…ü­­\Ï\Â 1\İ\Î\'/\ğ\×i\íp\è6jms}aF@¯\Óx\èt‡µvN\Í*0\éh\í\ÕH#ıƒJ„u·hm¹&\Ö\æ À4¦µù,¼\Õ\ÖÁb\ÓQ­­\Ï\Â ’n¡HwŸ\ÖÎ¦Z;zM\Ïkm\Ô\ä—j\í|şxş:­]\0\ÛÌ¯jmsÿÂŒnh»©°Bk\ë ·p™\Ö\ÎÉ¢YsWi\í\ÕH\ß\ó\r±¶¦v¹¸\Ñï‰„¢¡Á˜\ØŠ„C)\æ8\Å5€\Ø\í\òÅ¢b·•#£²\×)\öúdq\ñ°Y,Æ¤€,†Å˜\ÏC#1qLŠŠ^yT„Â²W\ôˆa)\ãQÿÈ(‰\ÑX\Ü;.Œ‹kF¼‘Ä¶¸\ÇC#8_#r@•F<Œ!\åO§„%$*.\ñ\Åb\á(¾Áùc¾ø€\Ó\nVK\ÈA®\Z¤ª5\ê*F]=\rT¥hLTohoi\İ\Ô\Ó\êz—:Ñ¶\ğx„šƒF/k\Ì\ÖÁ)vÉ‘ ?\ZE³E4\Å\'Gd\Ôr(\"\Ädo¥8‘™ZŸ’+\ÅXH”F\ÆÅ°‰\â„\Ğ@L\ò¨zPF\Ú#Ô£cRDFb¯(E£!_B~¢7\ä‰\å‘s³8\è\Èh#\õÁ\âm\Æ\â¥LˆW–Ô‰t,5$¡B\ñ:,\Z‹ø=”G%yq/\Õ!5\ğıš\æ^5\È4E¨•b0\ä\õÒ»\Ì\Ì\n\Çş¨¯R\ôú)\ëx‘QŠ\ô\È#t\ÚQŠˆQ9øQofkF;FC¥„©Ccš‹˜\Ü1_(8\Óš4q]\Ô\'³9\ŞºŒI\Ü\'{bC\ÉC@hŒš\æ	xıÔ¢hKCi 4*3SÔ°„b¨©ª\õ8Tm(\ê“P\õYó—š¢R–5*=\ZÃ¸û\Ñ\õ¸˜¸\ó­t®	\ÇBQª¿$\Æ\"’WJ‘\áQf1\rEB\ñ0Ë›P0, \0g·<H‘m\èªV­³fÙª\Íu\r\õ™I\Ñx8\ğ£ft=9Ew(.¥q\Zµ¬e†®\ñDd‰\ÆcH\ãª\ã\Ã?¢Ÿb˜^˜rZh\Òa>S\í´XŠ¸:‚\Ì^­1¨\æÅ‡lGBŞ¸\'†QÁ\õs+éœ”\0tŞ˜\Ï\ï\ñW\0R\Î\Íh\Z	Œ‹KüKE98 {³È‘\ÃÅ´e\ä,­³²=:#zi^«˜–øQJL\Ò*\ñ£Tohl$’¼3½\'©®’#ÔœŠB…q\İ`\õ¢™‚4>9\éQ,‰¸\ìUr\Zšc‘\Ï?\àG©*…\Ë;\ê¦<ÈªUl<\Âj\öWc\Ò\Æc\Ûeš°\ÛıŞ˜os3s­\ÇPnIøˆP5x-\Ç\ÖF\ğƒ\"‚(^ƒC\\û±w˜A	1~l€“ı(<€§İˆEYOÆ»ŒÔ£½Œ²Ge¼/†a62‚-\é%@t„J£\ò¢\\™*©(Æ‹t”#ı\ñy˜q‘va)\"Œ6”7„m	¯(b\ãH9\í\×\à¨©\í6\ó \Ä(“?¢É§\ÚD˜*OB¼\'KÃ”ş))T¶1”\Ç\æƒ\â¢\Ğ\Õx\á\åG\éN\ä‚ b%MªgJ‡\ê\óxWe\ñ®f~\n!¬F³‹\ÒV\Ãh\Çµ\Â&\èA\è\ÄQ/,e>oa~\ZGªTt\ÔH/ƒÆ\ô\×\Å8Y¢Z´E-*>6&k¾b1\Ât\ñB%‹\Z\Íx‹r¥±B\\%\óoˆEf„\Í3nQMµ.\Æ,™CfÇ‡s$•£cL†¬q\ö²{”\Òÿ¬ iú\Ñ¢˜8\Ú&3­3\ÙL5\÷³ˆ«qŒ¥\óµ\ç<‹Ñ»KhNJl\røg\ä\Ïù³h«™Bù1-\Ãh#lÅ¥\ô¨\Ô8ygœı#¶\ê‡\óg°d¸l2Ù›½UM\ãlMVfù“¶ƒØ¦R\Ó}9+Za–·\æm\ÃxY[\Õz€\é¢RFÓ”\æÛ”,5Õ¬vˆ«VU¿\æ\ïL\\/\ä»Ê¬¸ª¶„\Ó\Z;/‹2\ö1o/\Z“T¥‰k«.\Ê(3r¼R\Î\÷!…‡\ÉUiR\Üi½\n°5:–š‡\é\äezú5ıš²ª!­~!V\Ó2Q\É^­#ˆ‹i>\Í\öA*ÿ3~\È^©3gE\Ù\nT½> YÉ¯\ì**}Dl\"iÛ£,\ßFw5\ë\Ã\Ú\ò§½\ñX:±î„™\ç¢iÿKŒVªOQˆÓ…v¦!Ö#\ÇL½¡13-Uœl?\Zb?6¡œ·iÙ’\òV-RĞš¸\n6C4@=\ê\Óv\Z*Ub]\Ö\ò+U\ß\Õ\ê>\ÆN\'‹ÀL\İ2µ>†1¥^Rke9Œ#6µ»Eµz-\ã\Ã3(\÷hš\ç…<e^³¨\Æ4%Vt7\ó’\È$§kÁ…w[5«=,ZRz}«\ë>\Ì|8>cE†YÆªs=\ZY\ëK\çei,]‰\Õı#Û™uC\Ô\ö¶`Vş\Í\ÄÎ¨gÿy„Y\ß\Ëv¹˜¶–\Õ\çUneZ\Îù¨+cL‹\ï#|–zB9e]\È\÷tN€µ– ıR¼ÓœH×sWuø¸¾\Íp\Ï\ì&\Ş{.dA\ö¾6S¯UY9@-Qm‰1y©g\Å\ÛSÇµJ:\Æ,±u~±Ü“fd•\Ì\â\Ò`L{µ0¬\í‡\ê³aª\æ©||l·	_4GÕ§\Ø-2\î©’ª³4|l\Ï\ók~v~\èYO}ºˆ~¬z \îÔ–\í\ì¿aª;Àvly™V›YÕ¤\\ÕºÛƒ\íƒH\Ù\Î*²º~ ı\÷Ü’wÒ¿OwÁƒhwú·\ñøÀ«µ½\ŞÀ\È\ŞoÃ«>ª¶\é_«§/1½¡P\0_ƒ—;—7:kV‰\ñÁP\í`¬I¬s.£İ¡Àx\Ø\İ\àhœx®ƒQ:+@15\ÎF\ç\ÊU\ôÍ…½fù\éw	£~úB\Ú$\Ö{<\Ëj<\õ\rRl¤Rl*\ÅuY®GıU*v`¨JˆF´F|˜5>\Ö$\æF\öÀ\Ù..$«\0\Æ\ğ=‰@\Æ\ğU‰\è€\ó\ã+Y^5\Â\Ü$V³ÿM\Ëú\İ@Ş¼;ÀÌ¾$GnB\Ö¼N1£\ó²6\ÏÚ \á\Ô\0p\İ\Ø\îG\Ì|¼\èo.#ú=c.-W\âIÀ…\åƒÀN \ß-N\Âÿ@x3<„\ğ[p\Z\á_Ã»ßƒ\ß ü-\êKˆ\å’GL\ÈR„²\á\âA(“	„W“\Â/o!|„œDİ O`ûy\n\áß’¿Eø,ù{úoı\ô»W\ò}\òOÿ…ü\0\ák\ä5„o’7¾E\ŞFø‚\Ò\Éo\ÉûO’@83 \Ì\á\òĞ¿‡\ÈqZ¸\ËVrN„\õ\\#\Â\Õ\Ü[¸·p[\öp½·q\Ûº¹û9\ô\ç\å\ö!rA„a.ŒpŒ›Dx-w-\Â¸/\"¼»\á½\Ü7>\ÂM!|Œ{\á“Ü“Ÿ\â\Ğ.\î\îY„/qh\÷}\îŸş€ûW„?\â~„\ğ\'\ÜOş”{\á›\Ú\ÈıŒû\Â_q\ï!ü\r‡–r\ïsgNs\Ó@x4¡GŸ\ó|B3oFX\Ä!,\áK\Î\å\ç\"\\\Ä/B¸˜¯BX\Ã\× t\ñk¶\ğ-@„+Œµ\Ğ*´\"\Ü#\ìAx—pÂ‡…“À\ncû	\á‡\Øş±\ğcl¿#ü\Âwu:–\Ë<û\Z0‡\0W=ı\'……—„\ï`~\ñ8\ï)\0\áo„\çA\'|y\ä\ÓşZx\áÿ\0¼\ß\Ò\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  132[ 577]  135[ 606]  205[ 531]  232[ 525]  244[ 527]  278[ 239]  299[ 260]  314[ 552]  341[ 561]  344[ 334]  357[ 323]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:38:27-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:38:27-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:3377F257-081F-43DD-9DB0-81931A5948B7</xmpMM:DocumentID><xmpMM:InstanceID>uuid:3377F257-081F-43DD-9DB0-81931A5948B7</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] /Filter/FlateDecode/Length 109>>\r\nstream\r\nxœc`\0‚ÿÿ¤ ˆZ¡nƒ)Æ`ŠYBMPÀ‹7„‚²6B¨\í\ê-˜bƒÈ±7100\Íc`‚P\ÌŠB±B(FU\É\ÔÇ±¬+LqS\Ú\ÇÁ”N6„jSŸ\0\ÍQG\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000788 00000 n\r\n0000000916 00000 n\r\n0000000944 00000 n\r\n0000001099 00000 n\r\n0000001172 00000 n\r\n0000001409 00000 n\r\n0000001463 00000 n\r\n0000001517 00000 n\r\n0000001684 00000 n\r\n0000001922 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002648 00000 n\r\n0000003011 00000 n\r\n0000011207 00000 n\r\n0000011371 00000 n\r\n0000011398 00000 n\r\n0000014579 00000 n\r\n0000014624 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] >>\r\nstartxref\r\n14934\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] /Prev 14934/XRefStm 14624>>\r\nstartxref\r\n15691\r\n%%EOF',11),(8,'2025-06-23 20:44:00','EvaluacionParcialPorOV','Entregado',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 251>>\r\nstream\r\nxœPMK\Ä0½\ò\æ¸+´IÚ¤0\Ğ/\Åd\n\âakOuÿ?8iÔ“9d2\ï½yaÇ·\Ó1cw\Ów§e†\İù’{fhûŞµ\Â\Ó	d\0Á\Éíƒ³VW°h\ÕNZ\×BL/Z‘ˆŒ\r¹\à1\ä¦W\Ñ„0_\Äæ­¥¯\ö \ÕSD45g6\"ù±\ë9=M‹\ä\Z1!ˆC\ÍNPrHVk\Ğ\ö³R\èºd\ë7U5SWy\âDÿ\í\ÓHB«Š³Zªm\Ö	1^Í¤¢LFj\Ó\ò3L·Z\r²\ä½VÿM\ÃüM\Ãz“—\öG\Zk\Û\æ;\Øÿú†±ƒO\í\ãS\Ñ\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203923-06\'00\') /ModDate(D:20250623203923-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 333>>\r\nstream\r\nxœ]’_kƒ0\Å\ß\ó)\ò\Ø=VmAg+ø°?\Ì\íi\ìÁ&\×N˜1\Ä\ôÁo¿\ä¦\íF	ü¸\ç„ssTÍ¾‘ƒ¡Á«x†\öƒ\Z\æ\é¬9\Ğ#œIXD\ÅÀÍ…\ğ\äc§H`\Í\í2\ÙO$\Ïi\ğf‹³\Ñ]•b:\Â	^´\0=\È]}T­\å\ö¬\ÔŒ \r\rIQP½½\è©S\Ï\İ4@Ûº¶>˜em=Š\÷E™\Ã\'³\ê8\èN€\ä¡]\Ík»\nR\Ü\Õw\Şu\ìùw§:\ÚZun’\ÂQº\óT#m7HIˆT>zJ‘ª=RÊş–4v\ÄX\êi‡y_Z!Å‘§¦»\ä`\×T\×&X\\:‹­\÷\Ó\Ékt\Õq\ñ\åm^˜\ÜuÃ’u&f‰O•EHi\é	;e™ÏŸa7\ñ\Ş\÷…ÿS¹\×sC¾†Ÿµ¶SÁŸ€\ãpƒ$\Ü>‹š”s¹ıI™«\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8298/Length1 21668>>\r\nstream\r\nxœ\í|x\å¹\ğû\Í\Ìn6W6$e“ln$$’uIH \á’\0Y®™\ìN²K\ö\Æ\ìnB(Qº\õUk­\n­bµ\Ö	VO\ë¥V\Û\n¶§ÿ©\çX­z\ô©§\Ï\Ó\Ú\ËiµG!û¿\ß7³›\r \Ç\ãQ\Û\çù™\Ùyç»¼\ß{\ßofY\0¦ À±¦«²ºı¿\ÈN\í\í\ê^\Òı\óS/\Ç\ÖŞı\İ.¿²¼[\ô\Ï\0\Ó\÷cÿ\×PD´~cú\0s±\Ï\ô‡ü¾2\Å\ïC¢{|#ı‹›\Î\Æùg\02†<²\ä.>\ô×»\÷^u\È:•ı \ò[ˆıb?²sûOrk±ÿ¯\0SU_\Ğ%=˜û\ĞQ€šE¸\Ş\ì—v†L~³	\ç{_\ô\Ë©\î›;»\0:\î\Ä1. ù\å\éƒSÿ\à\Òå¸¾<G\â\÷B5\ÎS}Ä\"‡Bû\âSJşÀMª;\Ç\İt¤\ñOK·MYüW\È4Q=\à\õoE?¤\÷\÷T×\"§O¤GMÓ°k´×¥\í=ı4\ÊTzŠü\í\Ï8“\á\çÇh\×b\àq¥*	rå”½\Ø# »\É\Í`\0“¡F8K\î\Ò\î\Ü	\è\ç~…\÷L8z\"p\×\á<Ÿ ½ªK\á\È>}J“Á4«\ÜK\çø“†&ª)\ğü\ó(\Å`¢üBÔ¿·Ÿ\÷a\ì<¿†\×À\÷‰\Â=ÿ¸\öıÇˆQÁÛ¿0^5\ç\æ%\ìş\âdø4ù-\\\×ÁsZš\Üt¸ı\ã\æ\ïÙ¼&\Ío‡\í\ôú´¼ÿ\'‡0:!\÷\Èù\åú\Ä4w\ÂŸz\ğ\÷|V”&Â•ÿ˜\äƒ\Ğ\Å€®¿·Ç…\ã\Âq\á¸p\\8şÿ>\È}Ÿ—\ëG>7A>\çƒû+\\û\÷–\á\Âq\á˜8\ÈKúı•Ï‰ş›Ÿ\İ\ó\ô\ÛEú-\ß4„„\İø\Şçƒˆ­˜K VA¬	\Ü\à„@!x„g\á?\É\ği\ñ8\Ğo\05\Ü5\×\Åpˆ=7şLüm \ßo®c\ßF=O#ü\r\Ú >Š/\å\ñßcDE‰\æ\ër²/{¡”Á\âd+\å\àÿG˜Š<¯ÿ€\÷H5i \ë\Èv2\êhÿÚw\Ü~İµû®\Ù{\õ—\ö\\u\å\è\î+v\ìŠF\ÂÊP0\à\÷\rn\÷zúe·«O\êİ¶u\Ë\æM=Ö¯\ë\îZÛ±f\õª•+\ÚÛ–/kk1g¤—‘±ÌŒf[³œQ^c™\Ø\Ì,/#ª±YMcƒ\ê\Z»¨:\Ö\öXWt\ö´,-´Z…6«\êP…’zI\î˜+1\áD¸\n\×\"‰]¶k7\öˆ-±^6‰#İ“z\Úü¢\äœ\ŞR¹\æ\îµÕ½”ş2\ÖOv—Ÿ1İ–˜¶‰*t\Äb\î1\àKp\ÜQ8FX\Ã\Ğü\'jâ´©}v›\Õ\Ö##\î˜	²¬İ½\Í\Ø\ÊJ´ˆ¸)Š\Ç\ÌĞ‡—kƒ\í\Ñ[{T±·ß¹±+QÙ§\ë\Ô\Úvj\í^Ut‰¢j,±\õu\ôÄ¬*\éµ\êı\Î´‘\ncV›Ut:ÅŸ-¢\Ø6+\Ò\â i\ÌF\ö¯sı]{›1\æ\öw\÷\á\×\Ü\Û\ä+Æ¹\ã\"€ƒrt”ÒH;°‚ gp&†_x\Ü°‡\Í\nl€\õ]¨3%\Æ¸qÚ˜YcT\Ê90{\\\ÇmÆ‘ÀpÌ¤\íÑ°\ç\ê\Ø&œ1Ó™\'\Ã\\c“ÚVB\Ï82“#İ‘\Åes\è:tGD\Üte‘lR8†4;\Ù\ğ1²g,\İQxœQ\ê\Ô1\÷ &Û“C\É)Z\n!\ä§)¾nBƒu{\Ë¤\Ï b4Ñ£¼¬eŒ[m·M„\õ\Ú\ô^\ËYm\ï\ÅĞ¦]¾¤EÄ°V]=··c£{iy.±\Ç&ÚœcÓ¦\ÅB-cfs\óŠX32\Æ\Z°1\ÉX\Úki!G\ÍfnÀ0\åK\Ú\\¶\Ö^D±a\Ú\à§\r‡\\\ë\Å^µ¯×M\Ñ\Ü\Zk¥Q!Ql\È\ãø’1\"”\Ë\à2´›1KÍ°\ÉMj¦­)9s9\\®\Í\éLš­I%ùš\Õ[l-\âo\Ìe\ë\Ãtt\ô\ö;%¤­:l’*Øš\n\Çh\Â|™AP¥–1XmG\İV`®±wl\Â$¥\Æc±¥\â˜C(•\\\í/µb\Ş\Ç\ô)\ÛÒ¥Î”-bLuH®^\Ähq2d\ÌDl±I¢­Œ\ê¢\åºl\ØÜ¸‘®\é\Ş\Ø\Ër\Û\Ü6´°\Ã“P\íB\Ñ\å,Œ9]\Ì\â¸Eƒ\ò2\ÃDuÒ‹Gs¾\ÄÕ\à˜}½¶>m€f\ç™cg\ô#Vê˜­²cw\Â\î±v[‹1\è%¹U#\Î*ºZ\È@«‹DRD\ô)#37&zD\ïa?1u`r×“\ì¶Ò«­V¡ÅŠ*”\Ò\Èë±ª\ÛUŸÓD‘\Ô=}bL4\Û\Zl°\Å\Ë\èÕ«\Z°±\Ç%\Ñ\âd¤±‡\í8 \ö\ôa,#Á\Ö\ŞX\"\âp™Pš\ä¤\ì“HbI%\İÈš+¡\ê¨{:\Ä^§\ØÛ‹£˜=\ÖBQ5\à]\ì—hpÑ²Û¡\éÓµoR¬\×M B5\rw€~I¶Y±Z«4i5\ëS”ºzT(Œ\Ål1• ˆ%­ˆŒ\äKUci½\á\'d·I2:‘\ò%™­mEq™u(µ\Â›Õ‰(\\	³%\Z«E®F£º³\ÍP’Ë‹‰\õ1¬Z[°\à\n¥®\õ½¸-ˆf±Ud®–0’©\ÚhÏ‰„4\Ä\ôŠˆ\ëÙ§T\õ\ÛÇ¶¤•LŒ°OĞ®!›U”¬³G\íH ¤±6v\ØU®`NR\åI\'\Ö9Š\Z\ÏPÒ†\æu`T\ÒÕ¢\Êu\÷\è\îa\ë\Û\è\ÒÂ„Ã´e8\Â\Ê.\İ­	y35y5¦F\ö\ÉbŸ\ô\ÕT‚V”A›N£\êL¶Qhm\r\Ï\Ä\ÕÀ6²\õ¦H¯\ŞJd¦“¶Š´|âƒ‚d£W\á±ø3X#{m\ôr:){cDW0\Ò105—‘N\Ë:\'\í“I?mL…\Ô\á\öIc2\Ó9M%\Ãd\Ã\ë\Ö;4\ËY\õƒ\Æ\Õ\ò:=+\õ¼“U\Ó\î\ÖV\õ\n.bE\Å\Ê\íZË66a6Ø¬iX\ÇP}\Ì*Q\í²\ã&\Ât»N³j»VhT’V´b\é\r\Èl\Ë	€©e[®r\ØM¶lG8 &\Û\"zK·-\Z\ãH\ZV{ZŒ\Ì\ÙYX\èc®^·¶Q£•aQ\ábúhddNg¾¢¥©»\ÇP(8YÈ”ª\Ãv=Š58dO\ÎÓœLKX\ÒD\çb\ÉI#7¬\ÅF©‡\ì¦s®Š™>3“\îM5\Í\ÑjTj:?+^sP»\æ®vN£Ü®\Õ	-u\Åb´´mÉ¡šUš‹\ãy(Z=\nY¯K‰¶Ù¢tP\Ö&6Âº˜niT\Ím%™8aF\Ügµ\Ğ\Î\ÄI3J\ól¡†…Ÿ\ãø0dO`kF@¹3J´8×§\õ\ÕZtÛ\Øj¥W/¢´\ÒKÏ¤L=K³Î¨ú:yÍ§\é“\'mIbt£·%)\Ò\Ş\É\Âg`¡Ğ€KE3š«Ù³E\Å~¬aŒ¤•\êŠÀ•4\Äb™‰úO\Ëÿq|\0\öp	\ÎØ™\ê(ú}}\îÓ™£\ÙlX\÷rv\òN\õt\ÈhV3›\é\óİ›\Òi\0T GŸ\×k{œH1¢©˜::ƒ\Ú>-Q‚\ö\ÄÚ„\İúYJ\ëk\Ï\í\î\ÅQj©\ç\éN¢¼J­\ô*¤¦c\ÜhŒ\íúƒ\î(\õ\îÕŒ\Ü\ÕvQ\ô\âsV3Á§-\Ü(½t«)¶©”¹>\ğx%‰\Õ!\ö\Z3Ÿ¥:\é\Ó1¾\Ø\Ì\"Y‹µ—!›ş{€PÒ³¸°Ş‰\ï\Ç\â¿-rj¥Š\ÃM¯\î˜(šsq*&\æá‹†º™WŸ³±1\ÜÅ¥:\Õ`&§†G¥\Ï\âb+º\Ğ\ô,cQa}\ËK¼`\İi?ß´H\×c•R·\ÙvZ©)\Ô\õ¶|Xh¶©¢¸K\".+r\Æb¸\Æl\ôMj}\é)+¢O\ô)F\Ç-,\Âw´‰nV\r7\éXü±\"úº”\ävE‚›‚\Üh#–`§º\ÎÉFÙ¤\Å\Z~˜øcu`\Óø¥:\Ó\Ø\æ\ØF|?´ª³(c]\ì\æ9”\äN*	8\âÛªâ–­\â–-•Šes\åË¦Ê¸ecE\Ü\â¬8a\é)‹[6”\Ç-\ë\ËOX\Ö\Ù\ã–\îyí–®yqK\çü¸e\íü‡-\óDËš¹-–\Õs¶¬š·¬¼8nYQ\Z·´—\Ú-m\Å–\å\Å\',ËŠ\ã–Ö’¸¥¥\äa\ËR[\Ü\Ò<\'ni²°,±\Æ-\ëÃ–\Ë\Å–\ËÄ¸\åR\ñ€e±Xiiœ­X\Zf\Ç-\õ–¸e‘e\å’YŠ¥nV\ÜR;\ë„ea\Ñ	KMQ\ÜR]\ô°eA•b©(»\ÔR^¦X\æ\Ï\Ûj)A^\Å3/\Úl›\ã°\Ì\ág^´\Ù:\óR‹¸–\Ù–\Ù\óf\äoU·\å\Ç-…µ5lšQ—ß°i¦£ƒ¶h{úEùS\ë\ó\Ö\åÖ›\×\å9\Í\Î\ìú¬u†zn€W–sJ]Îº\ÌúŒui\õ\Æu9\Î§\Ñ	\Î\ôz\Ó:gMN\Îi\Ş\á0\ã\äfè¶¯8–\ï\\¡š:6©d¿Z\ÒE!¾6¨\Æı*¬Û¸©gŒûn¸f5­Po\î\ê9\Â6\ñI’k^\Û3&\ğ7:›Àv»\ô“5\õ¾\İNRNÀ‹~À®5´y]o\';\öª>>ifš\è	y\ñ‰¿\Ëÿr\â\ï%®\ñ»\â¿7@Ö‡\İ\ğ%\ğ\ã9n<i{„`º@†(ø`\01†a;¼lºc\0®@\ìkÁƒ+†\îÀş5\ĞA¤t¬\Â\õ=Œ‚„˜>œBê£Œ\Å\ïd\ßtEa/\Ò\\‡4\İ8ªÀZ\Ø\0[c>:\Ğoœ7´S`*”C¥c\æüq\æÅ†b!cš7C0›+fOJ8L\n*_m~¡:·=7¯ ¾jÁ\\knÉœ\ÒÚ…u5\ÕùÓ§\r\Ö\\+)­»¤®®va©mqº-1“f4¦\ñÏ_T\\UU\\\\]=¾„¿\ì\Ô‰,466\Ôu®\ï\Ş:\ô¥«¿\Ş\Ñ|\ÉÁ\Ğş\á\Ñ7*‹‹+\éu·\ğ\ÃS\ïw–—-«k\\\Ó\Ó1º\÷`‡{¡}E-ı\Î\ÏDÿ„Hƒ(tdg&£PV	‹2\ÖW\Öä¢”aRCl¼•Ÿj\åM\äoO‘?=¹\ç\ô?_ûù\É;†¦Ÿ\"#\ã\×qf\î*À›Q4>g,¥\ß\"£\ğr)>Q\å2	!;×ƒ}!ıı¢Š8™\È5.rdL&eºÎ²š\òD¹\Ö\éVıRùM§Ü\Ó7q‡\rM·w\İ6n¿]§c8ˆt¦€\Åa\æÓ³ù¬,#‘–)I+¯¾’Z9œ‹\ò“š\\›~WŸ\'o´‘_>3v\Ùø%C\ãU—šN½\Ë_\ô\áS\ÂwN}\Ä>ê¦¶\ñ\Å\ß3İ”:˜Ÿ˜a\â3¤kd«´\Ì)\æj\æ\×TyÓ§q\Â\Å\Õ\Ìa\Ôc\Æ\é\Ó\ò\ó¹\÷~1ş\ï·\ÜBfÿ\â¤\è–[\Æ\ßùÅ¡·ly\ñĞ¡o\Şüc\ÜZ\ê^z‰,R\Õ\ñ_ziü\'\ê[?¸ıø\à\Û?¸•\ò¦ZƒšeÁt(pdfgf\Â\ô‰JZ¨:Ÿ†\Ñf\Í\Å6«J~3úb$\ò\â\èøIR¼\ë;G\Æ_34m;~\í\Ş#›Oÿ{p\ôªıW£å¨—Ğ–`„\é†\âyh/	ıM?¿/zš\ÜLn}j¼À\Ğ\ô\Ñn\ášŸB\é¶\Ç\ß\ã¿Í¿³a.X¹33“\Í6²¦¥)–\"È¤6b~¬Ï­±SS•\Ò\ğ.¾d\" 1¢gs\Ósmh¸Kjj3rw\÷Wº¾E\Ê~¼{›;4\ğxtÅ—ı»Óš\Ç\Ú\İ\÷Õ¿ÿ\î–<\Ç\è\æ½ûpKG·\ôvŞ¶´¨}Ÿ\÷t\ô¶›\öl]ş¿u°mj¶=şş\ÇL6Œ\ç\ì™\Ù3ÁlJS\n4©\ì\Õy\õ\õ••I™hf\åØ˜Û¨\×jP˜š+¿\æ¥\ğŸ^·\ãq¿q\÷\à\×_v\å\ÖÁkùûyÿ\ñ\Ü\à>øÖ\ö¯*[}Ï©\Ñon}c5\èVyV3Œ—YsN†’\r\Ê\ÌL\ä>Õœ4Jµ\İ>‰{AnM\Ò¹	9\È{\Ã\ß\İ&\õ\ÜUyø\ô…\ßZ5xcÙ¼}\ò¾\ë®\ÊS\Ş>üÀ¯wlZ\Íe}øÔËœ_–—‘\á\ÎÁ§}œú\åzLŠ-†e¬™Ÿ\ÈˆQ\êÔ“\Õ,rù”Bs\ğpw%5FC\òTµ°\ï’ù\ó/¡\Ú\ğ \ÒYÎŸD:Y\'ih¦Ø˜\ç:/c))ÀVš\ğ\Ä8ı\æ>\ã1\Æ\Ô~²jÒ¡Iú\'\Å9G\r d0B\ÕHI¢@j\Ó\òkj¦“\ã\ÃWV<P\é,_qƒKH;E6\õ\î\×d\àÎ¿\Ó0ş³Ì¼1MAÂ™:´#§€\Ù)WK½´Üƒ\÷\Ë\Ü{ß­‡g¯j\ó\ßVÎŸ¼½\Ñûƒ‡O_\Ïm^¸\Ü\ÕxZ\÷\Ô\à\ßJfvšbN\Ä\Ç\äĞ \ÉuVfW\İ\ô\Ò\à\àK7\İúr0ø\ò­¾=‹\í\ñy¯¨«»\Â<\ò\Ö\×\ï}{×®·\ïıú[#û¶\Ş\î{H’\òm?¼\ÖE\Æ\Ó\àB{5°ºx<\Î\ê¢h\"dX«‹¿K˜Š±«G\Ğ\ÔÜœL\å\"]uÈ¡N\Ğb¨jAWBw-ÿ\ç”^œKª\õ#-7?ÿ\à!\Ã\Âûı;i\í\ö\Ü]I¦\í»\î\Ê]ƒ\æ\Í\İ?~—aá½«ûv¼yøş·\Â]\Ë\Çs\É\ëO=\ö”²r|ÿ\Êmšİ¹ıü«ƒ•!3=Á<Cg´z\Ítj´\÷7Œ\ónN+htŠü\ÉV\ö­´¹\ìt7­\Îw\ÄÿÄ¿‚Q¤y0C™\"•¼Œd&hy EK<=\È/¿}ûƒ³»\×n+\ğ ¡\ò\á)ß¿Ÿ\Û}ú\ëM†M‹¹#§ªood¿§¿8D\êZ3€!)\æ\ä\n64#\"±=4~3F\î/ùù§ªYüÿ5³t‰cÚ”%Ë¨\ÌdÙš?5™¯X¿8#gkÏ•³yt‹û‰Qÿ\×*h\ÎŞ¿\Æ³}\îu\ò\Ş/ï™º\ã\Í¿Ş¸â«§ª¬Ø´\ß\ÛNF\Ö\ÈÏª}Ÿú¼‹+\ç>\Â]¦J\Ñ\ç\Ù\â¬YV\Ó\Ó~&dM…ÊšU`Eª,\Ñ%¸dÒƒA~JeJÚ›v,\İûŞ¡­\ËW\ö8zÓ†›\Öİ¶\ğ†Ê+­?}´+_8°rpp.W·a\é²5±+*\Â\Ş\Óø/]ºc\Í\å7\ğ+\Ö64i\ñKØ¾W9›M\à-0¡$47–œzjP\Æ?Rp:P†Ú²å¡¡Q¹¬¯;\êvs\å\Ò\÷F\÷<\Ş+=~\Õ\è\÷¤‘ûF:\÷´ß·{\ä>ªû#\ñ\÷\É\ÃX\Òq—›\êH³9C\ğf\äQ\'\ÖP»J9\\Zj\á:m.x´ ·rQ[Û¢ºe\Ë\È7\"¤\ä\0}90şjx\Ü\ÙV[\×\ÚZW\ÛF\é_\Ëû¸ £?5\É`{\Ğ©­¡OU\Öd‹ü6k\ÊÁœ\ì\ñ\ÕY\æCS2y\ß6uû–-ƒ\ß\éKÜ—„}\Ü=Xa±=\Æ\í\0•vf•¤p\\-TZTS\n*®{EXÏ»\r.¬¨¸$\ÖM\Åø|\å§?ÿ‹°dÿ\'\â½i8Ê»ŒÏ\ï\Í>;7ex\ô\Øû\á®\Ï\ğ|\ê??ù$\öOunúL\Ï]ŸÁù\â§99C\Ê\ÙúŸÛ¹\İ\É\ó\Æ\óß™t¾:ù\ä§\ñ¥Ÿ\â\ô°\ó†Op~ÿ¿ú\ä§ ş¯O¯pÏ…\ó\Ây\á¼p~.\ç\É\Ï\õü\à\ÂùYœ†©x^ü?8¿Ø“şœ\ÔŞŠ\ğ½h\èoH\r\Ø#ú/ü\Òøz›OR\Ú\È\åw\êmc\Êx\Z\Ô\'\Û\Ù\äGü—\õv\Ø\r«\ô¶9?w‚Àh\Ği|O3\\©·\ÓSp\Z!Ë°Wo/Fü›\è¯…t\"døª\Ş&‘e\Ğ\Û\äd\r\ëm>e\\Hi`N\Ö>½mLO%\Ù6A\á›z;Š²\ë\íL\è\ÎzNogAUv\Ş\Î\æ\÷g/\Ó\Û9°\Şü²\Ş6§\ĞÏ\ru\Ï\Ê-\Ñ\Û\È\È] ·\ÓSp\ZaFn£\Ş^Œø]\ß««ªŠ«¼.%\öG\Ä\æ \n*R\ÄTˆK|>±\Ó;\à‰„\ÅN9,+C²»B\ì\ö\È\âœAY	\Ì#RŸOƒıb\Ä\ã\r‹ıÁ@D–Â¢[’}Á\ì½1$)1\Z\öDIG¢\î±oD\\p+7Š­Q—\',¸^\Ù\'I#H\é\Ó%!É«„Å¹H$\Æwo\Ä\í«pı•R\Ëû)…J»œaW\öù‚}•~)‘•Ê•m\Í-«»Z*ü\îy¨[hD¡\ê \Ò\êSe¨;d\Å\ï\r‡QmU\ñÈŠŒR(R \"»\Ë\Ä~Efb¹<’2 —‰‘ (FÄ¬„qA°/\"yš†.ä‘´µè°¤Èˆ\ì¥p8\è\òJHOt]Q¿ˆ03‹ı^ŸŒ:R\Ì\é\ÒWÌ™Ç˜¸e\ÉGH\çS\â0\Z! Á\Â\Å\ë¢4\Ê\Éå‹º©‰iŸ\×\ï\Õ90\ój~D¢\Ñ0j@\å,ıA··Ÿ\Şe¦V(\Ú\ç\ó†=e¢\ÛKI\÷E#8¦ƒ.9@W¡•AE\ËHÁ‹r3]\'¤c8”Kˆ\Z4¢›ˆ\ñ\öı“5¡AE×…=2[\ã¢\É\Ç\í²+BG(z\Ğ\çS\Õ\\Á€\ÛK5\n7°0”ú‚C2SEsk AI5	¨ıCNÕ§\Â	E\ï“u{i!*¥h£P\î\áúİ‹¦\ÇT`\ì\ÎÔ²bI(Sù%1¢Hn\Ù/)ƒ	¤‰d\ZP‚\Ñ‹› ?$AE§<\õI\Êz4«º¢jAãššºÚ‰E\áh(\ä\ó¢d4Ÿ*Dg0*ú¥êµ”4CÓ¸Y¢şA_…|Òˆfø\â\ÅY´S\ÃCNw\r:Œg*\îK³\Ã\Ï\ô\ÕıZ\\œ¥CH	º£®z\ó×–\Ñ5	h¼a\×\å9£\0$Œ;!}0\à\çzç‰²¿Ov§ #…\óI\Ë\ĞYX§D{x’\÷’´\Z™\æz‘KD\ö\Ó*¦x‘«;8\ğ%\÷d\ëIš©d…ªDV£‘\æ\rV/\Z)ˆ\ã‘}¡\ÉÅ’ˆi¯¡S‡\ĞS‚oŸe®HT)L\ïp…?aAV­\"#¡ V“g¤ƒ6\Z\Ù Ó€\İ\àuG<kB™k]\Ş]r[DBÿÀ·A„j¨\Âk!¶V\\ @\Âx\õCÇš±¥@ˆA	G¼\Ø\n@û9¼O:ql\0<8f=\ï2û½n†Ù³2\Ş\çÀ ›	`KD|	ú¡\Ü\èˆiQ*ıŒ\å?ŒXtÄx”¢gBŒ²ˆ¸„!\ÄPn1\é\Ø\0¶%¼\Â8\ZE\Ìl\÷1¸gİˆı[l·\âœ9†ÿ€ÎŸJ£0>”Ÿ„\ã®	\ò\'¸P\Ş^¡4\æ2Dp,\rP‰\ç\0\ÎQšQ\ä^t‚\à\ÇQI—A†r¤™¡\ò\Ú\å)´+™‚+‘‚\Ä\ô¢¸•°\Ú\ĞC-°\ZºV\à¬\æ1›73; V\Â;š§@ı\ÇÚ®\ë`”ı\Ìa\İÛ¢\î›“u[°ˆ0Y\ÜPÆ¼Fg\'¬E©R\ß\àX³oy&ÀÖ‡µ°Îja\Z&ùĞ¥\ëqvŒ$bt˜\ñu\Ênv³YúŸ4$]>\ZAt$Šº\ÉL\ê‰h¦’{™\Ç5?F’\ñ\Úu9h\İ	MhLJ,¼“\â\ç\ÌU4ŠµH\"ÿˆaÔ‹\nË¸„e:%ÒŒ²¤\×\ìp\æj\öıl,U‡‰\èM\ÍGM\Ò(\ËÉ²{Ò¶Û”K²/§x+\Ä\â\ÖÇ¬\ía#n\ÖÖ¤\îc²h˜\á$¦‹\Ù6ÁK\óG%«\"\Õ*†&ƒW·\÷„_\Ïe»²¿jº„’\Z9#Š&\ôf\Ö\òŸ\×\'‰JÕ³.\Ì0\'ø¸¤”\'tÜ.\ÆW\ÃIP§\õ\Ê\Çrt8\é5“\É\Í\ä\ô\ê\ò5¤TCZı‚¬¦Mx%5[8\ÑmšjƒDüO\Ø!5S\'¯\n³Ô¬Ş§k=_©UTú\ß(I\İ\Ã,\ŞŒº\õÚ®0¡\İ\ç\Ë\n¬;!f¹p\Òş\ÃW\Ø¿’YuS°I\é\\;\Ó\0\ëG‘\âD½¡>1)5\r*\Ø~4À~LC)¯×£%a­jÄ 5±\Ö@\r\ÔA-\Ê\Ñw\Z\ÊUb]\Ö\ã+Qßµ\ê>\Ì\Î\n\æÉ²M\Ôúú”ZI«•!¤0‚£‰\İ-¬\×\óTg¯ \Ô\ÃIš\ç²D˜Y!\Ä2P\ói‚­\èNf%‘q\ZIÖ‚s\ï¶ZT»˜·¤d~kyb6™”‘!±\ÚZ—NE\Öû\ÒQ\ZIVbmÿHøvr\İ\õ½ÍŸ“Gú\'Õ³ÿ>NB¬\ïf»\\D\Ïe\íùD\ã[–\äs¦Zf\ë>\ğ|Œ\ÍO(gfÖ¹lO\×øXk.\â\Ï\Ã;ù¾d\İ9›º&Ã§µ\í\õ‰\İ\ä\Ü{Ï¹4H\İ\×&\ËÕ˜TM—\ã—xVTØ:¢W\Òa¦y\åùùbOšU2\óKP‡ı	D\ÔwÂ¾jÏ†‰š§\Ñ\ñ°\İ&t\ŞÕbºg&¨\'2$QgiüxØ\ç\Õ\í\\qÖ³\ötşT\õ@\Û	¨.zbØ€-7“j\r«š”ªVw»°½1\ÛXE\Ö\ò’\Ï.~7ıû|\ç<ˆ~§\ï\óú\Üz\Û\í\ö\ğ~\'^µa­Mÿ‚^-}‰\é}ø\Z¼°ba}EU£\íV\÷G\ZÄšŠ´;\à	y\Â+½}\rb]¢?LWù\èHUE}Å¢Fú\æ\Â^³¼\ô»„!/}!mk]®U®Z\×J)(›G_™¸L‘\åÁ2q\È[®\ö\r”kaEoDY\ãS-b ¿£¿pœ\Æ\àB\à‚¡\ğ.\Ò0Œ\ïID\02Œ¯J\Ä\0œ_‘\Èb´ª	Šp“X\Ìş71G\èwg\0™\İf\öı#¡c\äf$­\àuŒ\ñ\à›µy\Ö}<Gs\0×‰\í^™‰ı•Á4¢\ß36`j¸O,6ınqÜ‚\ğ\0<Œ\ğ»p\á?Á{ÿFø”—4\äCH&\ÉB˜C\æ!´“5\×B™Œ\"¼Š\Ä^O¾‹\ğQre;Jbûy\á\È>C~B@¿{%?#ÿ\á/\É+_\'¯#|‹¼…\ğm\ò„&Èü…¼\ğo$„\ã¹4„\é\\&\Âú\÷ ¹<nB7aW°–«G¸˜»a3·\n\áZn-\Â.®\áznB\'·a/‡6\â\Ü\Üv„~Î0Ä…s{^\Ë]‹\ğF\îV„_\ã\îCxˆû\ÂG¹1„\ßã¾‡\ğ	\î	„Or¨\÷4\÷\Â8Ô‹û\÷/_\áş\á«Ü«_\ã^Cøk\î\r„oq¨#\÷\÷;„\àşˆ\ğ\ÏjÊ½ÏB8Î\áQU„i<Úœ\Ï\ásšy3\Â<>a>Ÿp?\ál~6\Â9|9\Â*¾\n¡ƒ_‚°™o\"\\& ¯…¡\áVa+\Â{…{>\"^xLx\ÛG…\Ã\ö¯„_aû]\á?¾g0°X\æ\ÙwÔ€1˜\õ\ôo`^ş\Æ\ë¾/<\á§H#›Æ \ğOÂşŒÌ›\Õ\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  40[ 556]  105[ 732]  132[ 577]  171[ 585]  205[ 531]  232[ 525]  278[ 239]  299[ 260]  306[ 551]  314[ 552 552]  341[ 561]  344[ 334]  362[ 559]  381[ 452]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:39:23-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:39:23-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:DocumentID><xmpMM:InstanceID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nxœ-\ÌÁ\r@P\ĞùøˆH„ƒœ¸:\èIŠq¡‰6$¨B|3\ö°/\Ù\İYÀ\Õ\ó\×s\àc17\ñ[±ˆ½\Ğ\Ğ*gfB»h<\÷³„\'|+Œø/C—‹OÆ“¤©wÒŒb%]¼%\İ\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000822 00000 n\r\n0000000950 00000 n\r\n0000000978 00000 n\r\n0000001133 00000 n\r\n0000001206 00000 n\r\n0000001443 00000 n\r\n0000001497 00000 n\r\n0000001551 00000 n\r\n0000001718 00000 n\r\n0000001956 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002682 00000 n\r\n0000003090 00000 n\r\n0000011478 00000 n\r\n0000011678 00000 n\r\n0000011705 00000 n\r\n0000014886 00000 n\r\n0000014931 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] >>\r\nstartxref\r\n15239\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Prev 15239/XRefStm 14931>>\r\nstartxref\r\n15996\r\n%%EOF',11),(9,'2025-06-24 19:28:00','ReporteParcial','Entregado',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nxœOMk\Ã0½üŞ±-4‘\ì8®!\Z§-\Ëa4°ÁØ¡‡.§†~ü˜\Ò\ì\Ğ\í4$¤\÷¤‡|>¨ª¼MO\r(9=f\ÇÛ²}ŸÇˆºI¸hEØ€PJ\öÁ\àz\Ô\êmA«º\Ó*\ß2è¾´b!\Æù¬\ğ²€\î$œİ	ıM¢ŸZşiwZ}TD+—V\ê¶ vØ®¥®bQ—\î>¶M *y¢X#pŠ~„\×1ˆ05Ä¦Y£\È:ŠŸèµ\ÚÈ‹¯Zı×‹ù\ëÅº\"+ìƒ—»ƒ\é\ïæ¿`\Ó&|ù\óEr\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nxœ]\Ñ\Íj\Ã0\0à»Ÿ\Â\Ç\îP\âüµ„@—¬\Ã~X¶Hm¥3,q\ÜC\Ş~¶T:˜!I¶%\'M\×vF{¼»Y\ö\àù¨r°\ÌW\'Ÿ\á¢\rKWZú›\ğ/§Á²$\÷\ë\âa\ê\Ì8³ª\â\ÉG.Ş­|sT\óX\ò\æ8m.|\ó\Õ\ôÁı\Õ\Ú˜Àx.X]sc\Ø\èe°¯\Ã<Á²m§B\\ûujş2>W<C§t9+X\ì Á\r\æ¬aÕ¼:…U30\ê_<-¨\ì<\Ê\ïÁ\Å\ô]\ZÒ…(\Ú:\ê°G•ªiQ!%\êTÊ¨4{\"5¨<#=“¤ª,Q{A:2RC\ÊQ»[fA¢]\öx^^\nTw\É\ÛGT&°\É[7±\İø*\÷YÊ«saŒøt8¿89m\àşºv¶±*~¿g“	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nxœ\í|xÕ™\è93£‡eÙ–±C\äD#\Ë6	\ò+~%¶CP\ìØ\í<\ÛI¤8ÁKcK¶^Ivœ†lHP\á\Ş\Ğh!-”\"\óLØ–Gy\ì×–@w\÷n»}\0M\é\İ\Ş\î\×ei·\åvib\İÿœÉ²1”-”\ì½_\æhş9\ç?ÿù\ß\çŸù0B(\0‡l[z+«;ÿ\ó”\Z!¼°ƒ½}\ëúşşüq„z\î„\ñ§O\î¨ş\àf„ıÆ§\ãa\Şü¥E¯\"´\Ü\ã†ƒ#¾_\È2 ”ÿ\r`zx\Ä;9Œªµ­€\é\ôZ·(¸Šø\Ã\İ08g½ú\óo¼Z»}\á½\ã›\r50şg„\ò\n½§°eoOBµ0¯3ø„½A­/\ë}˜·=\ï\ÃBıW\ö\ö\"´\õVÀ1~Á\'.\Z\ËıO„Ö®G(·<…\ã\'Q5Ì‡	}PƒÁ#\ñ\\„J\'“…ˆ\ís|\Ûm\Ïd­ùJU\áx\ó«‘\È\õ\î\êº\óø\ÂÙ´ˆ6†j\Ä ù€uš\ÃJ\Ï\ã?ş\æ\Ñ\ÜC¥!4\0W‚_³+\r¨%7f†Fw\0ßŒTH«ª\á\ÎÂ’»\å+s\r3?…k:\ârp<b\Â<›à½©—\ç\Ñ(\ã\ÂyYmS\Ã#|’Ì±¯«š‰¥ˆe_>ƒ´\äD—‹r¨{P\ìb\ë°\ĞÁıø¿§^û\àlh\ô¢\ëp`a¸U_·¿\ÖÁ,B·\Ô\çA\÷\ÜZn\ô\ó\ówpV\æÑ¹z±\ï \á?·¹*\ó|{\ÑŸ‰rÅƒ;t\ñs\r ^\ö\ê½\Øz\\:.—KÇ¥\ãÿ\ïƒkƒw¬‹t0\Ï \ã\'¢{\Ù>	\İ\'µ\èş\õ\É=&?KºO{\\,}\ğ}Ÿœ–±£G?KÙŸ\çÁü]±u¸t\\:>¿ÿübk\ğ\×: ÆŸù&“|£˜\Ó+‡¾\n\×e\È\0˜LT„V¢uh\êA‘Q=ŒE/\ò\×\Æ\ãˆ|\Ã8;\ï‚y?’`şLb5\Å_\0u0ƒ\Ğ\óD.\Ö!_\÷N#H[–¢\ÎbzR\ô`\Ìş’\ËE\ï¢\ß\ãjÜˆ·a;Ş…E<Ê¾‚Ÿ²u\Şu\ç·½ş\È\ß¾\îÚ©k<°\ß\äŞ‰\ñH8$\í	ü>\ïØ¨\Ç=2,ºœC\Â\àÀÕ»w\õ\ït\Øwl\ß\Ö×»µ{\Ë\æM»:;6´·-7tiex:]\×biu\åehZ—\İ\ô\ò2S·\Ä4\Ûb\åc¶­vsW½u½\Ñlv-\æ˜-Æ•´’SpE‰	°€U°Xt\õZº¶\î´\ó­\ÑA:	˜¾9#y~urN\éÅ˜–>{¬\Í\n£”q;\'‡\æMw$¦-|uG£®iÄ–\0\ŞfœÆ´£jù‚,qXbCV‹\ÙbvZ‹\ô\æ¾Á\è\é=Ì·Gş´\rÁ\é\Üa9•\ŞN{Œvl\0jÄ”\Ä\è§\÷4ª³\ì•ûƒ1\Ş\É\ó1u‰e¨\Û5\Ç\ğ Å¨Œ{\ì\à1,£f‹™w8N\Ç_,$\Ô3\ğbP\ó´\Û:m\Ã\Çzw\Ú\Ï \õ\Ùg0\Ó2\Ø\ì˜.†9ûH\n\Å2KdÀ“\ê\Â™\Ç-¥7±!4Eg9Š c\'XAq\Ú#\çiF\ÆdA¥T\rv„\ó4\'\Ï\Ø\Ô\à´2nJ¦^®Pka\Æ@fE\ì:)\à%ˆŒM§²imi6=“Á@,\êqÀ<´i=¡\Ç\Ø8\r<{(ú4šN³\ÏPN=\n\åP\ÜTš²F O6|Û¬\ÛvÚŸ\Ğ#\àO!P4“£¼¬uš\ÙlµÌ¦\õV;D¯u\Zo¶Bj“![\Ò\ÊCZ\Çl½vB;h„œ‡\ì^_^F²‹·[D£\Å1—\r¶N-]\ÑHd\È5š`Ó‚ºt\Ğ\Z•S$š\Å\ĞiÊ–t8-mƒ@bmŸ@9·óƒ±¡A+tyC[´d…@¨Qş4Ã–Lc®¯EkÁoj}Lg›c\é–\æ\ä\ÌU\è*yFMf4–\æÎ—½\Şji\å{¢N\Ëd ­\Û>bvÀ;f³1\Î\Òlœ\æP3\ì—\ÅLjF›­`[\ä\àkw?lR\â>\Z]\ÏOÛ¸RÁ)\ñz3\ìû¨2eY¿Ş‘²¢•\Æl‚s(Z”v\" [-\ï/ƒ¹\à¹^tw\î$kúvÚ£z—\Åe\ÛlQ\Ì6\òN‡1\êpR\ÃzP\r•—©f«“Rœ²\çKœ\Ã\0N\óhh\Ğ2$#\Èîœ™ªTœ¥“ˆ£WL¯\ÑNK«(\È)¸b,dœ™w9\ä”Aİ´n|$N!\â!¦”y\ÔĞ”aeøDc#s‡\îä°œƒ\àµ\n9Wb\\)\É<»96jŒy\Ö$‰›\Zâ£¼Á\Òh!€.n\'\ç`L)§@Š“š\ä :ÁÛ‡ —a\Û`4‘q°Œ+MJŠù­sXBI\Å} š)!\æÄ¦ºùA?8X\Ø=f#SÁ•Hr‘²\Û-\Û\Ó\rµ.B´\Ö\"²Œ1\r\Ü†\Ñb†j#›V\ö>Ñ‘\íP¯=†ŒÑ¨%\ZÃ bIûÒ˜º´ƒ\\\à´Z‚H\ä\ñ‚H×¶º\Ô;„›±\Õbv\0	SB}	ƒj1D€3\n\Ù\Û\r»MU’Í‰\ò\rQ¨Z»¡\àr¥\Î\íƒp[\à\r|OC-@&\'t‘É„i%„\Ö\ÓOi\ÌgŞ­)™\Å\ĞOÀ*k)WĞ¬\Ç\ëNh\è:{¬1¦`5L\ãq\ÔŠ8OU\Ò\îµAV\Éj>\Æ\ôÙ•\ğ\Ğ\õd©10y`h\Ù%·EsB\ßtY_Y¨š~\ô\ô“VÓ–@ c\è Okˆ9³I\0}PZ^\ÃRue ¢xe†\Z2¨¸‘\Ú$\ßyR>\áAA°\Óx:şB7\Ô\ÈA9\"^K‘”uTfLÜ¥&“¹B‘$\ÒÉ§ƒšŠ\ÖÑ†\êL\æd“Ts¯x\ï<É3+\Éb\åQeW*ûN4\Æ\Ü«K^¥V*8*·s+}\Ú\è‡\İ`1k ù°«øX¯n\"Ô¶£²W;\å\ê@²·YP\ä\ÒAù(†,0¶–eCŒa²gyœAXkYM.i–\Õ\Ó\Ö@µ\'\ÅÈ¡‡Buº\ä5x­6®!Fj\Z\è4\Z\ÛqRšú\ì*#\ç )S\Z›°*Y,\Ãqkr~‚\ìIMÂ“Z2MNª(»	97J8n\Õ.¸*ªıdÂ´J4citT£R\íÇ‹b\å\0u\Ê\á\êddÎr\0l©3\Z%¥mzw&Ù¡ú\ÒlÀ\ç€j\r dƒ¢%ø\æ\0¨\ÒMDk)†a»iˆ:r\ØJ\Òa\Â\0´/Ê©“\Ğ\æE£LŸ3\ğ°?nMP\ËN\0½u%r+\Ó\Êj9;\'¬èµ‘sH\ÚÈ©\ì¤te—\ê\çU}…½Ó´¹“–$3r£·$9’\Ñ4\Ö\Ã30gT\ÄR\Ş\0\îj¤ş,UamœÆšR…@E˜’\Æh4=QÿIù‡w%¢—\Èˆ„x@¬3\Ñ\Î\ÇfP´\åŒ\ä• •\í k‰¥·\çroJ#	P\ñ=øŠRs\è\ãDŠc(Šl\ÅT\ìb\â{M¢$¬‰µ	¿\r\Ó-­¬‡\í³,\ñ\Ô+\äN\ÃpU•š\Éi$®£\ÒH¬Êƒ\îA\İ\ë(»\ë¬<\ï\ç¬O[p£\ô[O¨µ¥´\ÈE\á\Ç#´\Ñ×˜\Å\ğ,\ÕC\á\rÀb\à\ñ\Z´F~²(\ïp\àJ\ìkŒ\rx¯8ÿu¡C.U\Ü\ä\á\ì‹\ò¼!¦¢|¼hÄP\÷*sŠƒ»¸ºT¡\"\Í)\Ó\í\õL´«œ@\Ş\Èt«:\ò–—xÁº\Óúq\Ó<YU*6`\Ùk&®ˆm·L\Â\ÃB‹%\Æ\ó» $²½\Ğ\Â\í4j!oR\Û\í2$S¸¬<§…\ÖX\ïh³C}!I7\átü‰Bòº””¶?!Mi¤Mˆ‹9”F²\÷Ë¹ªşt=²\È\ò¹REhtWt\'¼šcK‰`Ef:(\Ğ\äN¢	²\Åªâ¦«W\ÆM»+%Ó®\Ê¦şÊ¸igE\Ü\ä¨8k²—\ÅM;\Ê\ã¦\í\ågMÛ¬qSßŠNSïŠ¸©çŠ¸i\ë˜ºW\ğ¦-\Ë[M›—?bÚ´<n\Úxy\Ü\ÔU\Z7u–ZM\Å#¦\r\ÅgM\í\ÅqS[I\Ü\ÔZ\òˆi½%nj)Š›š\ÍgM\ë\Ìq“\Íüˆ\é*ş¬i-7]ÉŸ0­\á+MM\Ë$Sã²¸©Á7­6M™V-•L\õKã¦º¥gMµ…gM5…qSu\á#¦•U’©¢\ìJSy™dºb\ÅÕ¦U¼\Äx\Ù.K‘\ÍT\Ä.¹l—yÉ•&~\rtL\ËFL\ËV,\Îßµ´ n*Ì›Œu—5\ö/®\Ïo\ì_b\ë&ı\Ò_tYS¾{gnCÎ¶\ìÃ¶‡Á‘Ñ ß¦j`¶qp\êY\õ™\Û\Òt\Û4\r\êm™C\í@´\í6fµ\Æa@¬Í¦\Âg\ğÍ¨\Ï\ÚuZ\ï\éŠi»ûcøX¬¤—@xmˆ©\ÅĞ¶ı\öiŒor¹\ñF´´¹+vs¯ıqA$™–­\öi½\ÉÑŒ¬\Èjµ\"¥Ñ®2¶ZqJCp’²\Êy^!WúÉ5Aª\à\ç\Ì,Fªf\ÒPNüŸ\â¿bƒ²Š¿›8g\îÿ›ª\0\å\Èct\0]‹|\Ğ&\Z\é\ïCA4z‘ˆ\"È‹F€b`¢!\íD\êŠ´¨¯GnX1pŒÿ\r¢\0pÚ6Áz;\å \0¥fÇûAÊ‰\Ğ\÷À\È³‡\ç6\à\é¬„¶¢h7P\ìG\ò­\Ó+ªNÄ¢,”‹\ÊQ¥m\Éü’\ËUÅœ.Ï£\ã†Š¥Å¹¹˜‘V\ã«\r¯Vg\×\0°f\ç4T­Ü“m\Î.)*­«­¯©\Î_”§V™³Í¸´~U}}]m©¥H½È’˜Ñ¨\Õ\Z\ö•™ËŠ«ªŠ‹««gÖ±k\Ï‹\\SSc}\Ï\ö¾\à\×^wOwËª\"N\ÕùÁ\ÓoWW’\ó^\î;\ç\ß\ï+/k¯o\Úb\ï>x\ìÀX·«\Ö\ÚUG¾\Ç\Ó\Âsüc\r\Ò!£-C\Çi\ÕjºrTYĞ±¡²&´\á\Zla\Íl®™\Õ\â?>‡û\ìÔ…¸şü½_ªš?xO\Îe\Ì5\îØ”£ú%u)ùf«¹7J\á‰úi&c¼w;²Ö’\ßŒ!¤º¤f!“\ÍÀ¦e°z½\Z©A¬V[\ÓPI¼\Ê¹¸&Û¢\\c¯\à·;\ğ_˜^;³j|¦j­ªùü¯\Ø\Ë>xû\Æù?±ª?\õ›€;wp\ÏG<Zj\ËL+(X´\ñÀ=+\É¬Ê¡\Ü\Í\ÕùÔµË˜‚\\[ÁX\ÌÙ€“}o\á‘\ç¥\ãÑC\ë\ÛOo\Ê[µk\Ó\ÌË¸ºsoû‘kf¾«j\îü\ò¡©\'ù\ô\×\Ì<†\ëz#W^x•ùÁ\êÑ®=‡@‹\Ñø»\ì\×Ù·\Ñ2´™m\ÙKt’\Öb\ÉBú<d*D\éDªICvµjekQ)I\âU³A‡¨/ce[.W«/¯®_UÇ©\å\å\ã{û¾\ĞûU\\\ö\İbô‘§\"]7øl\÷jZ¦;]\÷\ÕÏ¼ÿ«\İ9¶ƒ»[É¬?¸{Ø¿\÷\Ö\õ…G<\"·v\õO]½\áU\öê±Šn?#û™ÀC†L”¤%\éZ”kHªVmÕ‹d`AvMR™\ìRª%\è\ó\î\Ä7\Ä\Ó\İwWúrZ\íW7\İT¶\âˆx\ä\è59\Ò;§zkOÿfFÿÁs7µ;n\Û\ñD\Ï\Øs=\õœ¢Ák\à%\ÈLbd\ÌGYDY>QNC\Í\rH \ÌË˜\ZP &“ÁfªS\òûC/\İşw¿`˜¸i\Ê<\Ä>Èºœ˜<\ö\Ø\ä¾/\äù_\Ço{g\ê½sY+\ÒNzœ#·me\Çn>™x;¤\ãoÁz”ù´\nI:¤£Ò«V\nD,Xœ—_S³Ÿ™8T\ñP¥£¼\ëF\'§9ûÁ\Úûa\çÿ=û3”‡\nlz«\ÖHX-¥+À4{d\Í!k©ºš\ìû\ïS—\í\ğ}·œZ¶©\Ãwk9ûú\íMo?r\á‹Ì®vÿUÎ¦›\õ\Ï{bÏ‘‚\Ï,\Ç™\ã\â’°„=‰I>Suüµ±±×\ß\òF \ğ\Æ-Ş©Õ«§¼ı\õ\õû\r“\ç\î9ùÎ¾}ïœ¼\ç\Üä‘S£Ş‡\áa\ï\è©\"\óş™»¹\\ˆ‰’¹Ù™\é\ÒeŠY(“\Ô.9/ªV\ö&\ì¢\â-E¥—g\ãj¥^i²\ó\ó\ï@Uû o/ÉŒ\î{+qŞ‘£‡\öX±ü\Ø\ÌİªÚ“›‡\öüüÔƒ\çB½f²\ñ›\ÏO?\ñœ´q\æ\Ø\ÆÙ§\Ì1\ö\'(-²¥§%„\ë\áI\Ö,\"¶‚/¿¤^qK$¯ \Ã\ßÃ³¯?´qø®Ò–²}¤\ÆC†kª\Ğ2[N™^µ|Yn±™k¤´„+in-ª`\êj \ÎÔ‚\ËaP»–¡{\ÏR«dy~Œ\ò \å>\è9¼\êşG\ö¾(İ»y•\óúÍ›¬y\à€cg°z\Üå»µ«\ÉscN\ñ\ækvJ»;ú6´™\í¾\Şu\Îfs\ñÆ½}\î\í¶\õ—\×[/Ù°Ç¾1\Ğ^D´\äÁ\Ş~\îQ\È!£-S™™6ªIWK9JU[k²k\Éh©«©«Y¦+Iù/\ã‡*¿\ò•‡\Ş{¯\Ò1\n‰\Éè¾ı\ö\Ñ\çû…£„\ó\ñß²?b_W²S\'eqÀV—\Ü\İ\òŞ–3œ˜¾J\Ù\İø‡_¿ık\Ëú¶øo-ÿ\Úıª\ÊG²¾\õ s\à\Â=\Í\î\Æş5\Ì\ã\ç«oo“\ó\ó\ß\Ø7Ù·h®”\Ø\ò²t’^-,¡5$?7YE ¶Q0¯’\Ô-TIş}\ò±İ®gú\îª •\äÁ-¾›­ËŠ‡o˜\Ê\İ\ó\ó‡Nı<´³\ë¶\ó\Õ\'ºúy:\ñ\ä\ñ\Å\Ø\ß\"š\ô2\åÌŸT}¨•B\Öf\ğK—šµY\Ú\Å\ì¤\ÏE•5/W@…­&^\\§h°jÎ5?¥\Ä\Ò\íƒ;›\÷¬?ü\îWo\Ø8|\â\é\ã;o»QS{ce\÷!\ó\÷\ë`\ÊkG6-g\êw¬o\ß\İ_\ò\\ø?¾+\×\ï\ÙrÕl\×\Ö\ÆfY#vh”:e>e\Ğ\"O4!;wİ‡w®²q‰\à—¥‡‡¤\ñ‡w\ï~xü X6\Ôq¹˜r\áÉƒSO\r\nO]s\ğIa\ò¾É©\ÎûL\ŞGbü8à»ªeP½\nl\é*µZ§\×KX\Ç)wnš9Ù™Œ¦n-³ª&›Ybt\ë\ë=\î3\İ\Ãm(i­\×9³s°\ìƒ_\0#0û\r\å³È¦>X—|Z©\Ç\Û\ò·…\Ú\Û\÷\r,¹#\Ée œr·T†gÿ¥.œJ…\Ó[7Á¶¬\Â%ly \Ğq­\Óx\'¯ÙsR\ß\Ö\ÅùrxzP,R«\Ùn\òc?\ò%\Ì[ÀsV³ù<g\í«^<pİ–\Í7Œ\ŞÁ\Ä\Í\Í5z…+p™V\ç\Ø|\Ğ,\çª\ZMC•Öššùj9\nƒ}\õımùû™©I@_¶z\éù%O5“L>§*°;\È\ß~\ÌL3>‡\í2f¦™`\Ø\Ä\çÔ¿–1 3ƒ¿»K\ZZ„rmi\È`\Ğq]QŸŠ\î-e\èd4l\Ê\àCÁcÙ•«;:V×··\ã/…q\É	\ò„ub\æ\'¡GG]}[[}]\Éı\ëY/ üs!\Ót\Z\Í\ä™‰Õ‚\Ü1“=ük}\Öı™3›\õ†²\ÒY\ï@lt\÷\î±o%®ãŸ«f\ê—\àiV\÷Â£¼¼rk`\æ;/\Î\ÄUOãŒ™ÿ\0\ÉgÀ\Â\ÍB)A0×™1ª%\×m\İzÃˆé™j\æ{\\Wq[½şÌ®A\ë¿¸\õV\òÀ<€¡»ÿŸn\ßı\ì\Z\Öÿ7j;?u»\'¥½ı¹¶©±\Îk\â_\ÔN\Ñ\öš\ÜXÓ‡\Ú\Æd\Ûÿ™·>m\ãÒ¸µ—Ú¥v©ı\ÛĞ§jGh§h-\Ğşa\ö´\óÿ\õ¦Z\è\ÈüTm\í_µ\\j¥\íÿ\\ù{\îRü:ı=B\ò]\êjú\ÜO\é©`$\÷¤a\÷(}6Ï¥\ôU(›İ«\ô\Õ)x\rjH\ö3\ğ\Ë\ì\rJ?YU›”¾!…>{V\æZ¥\ğ\Ä*¤RRúi)4MH¯:¬\ô\×\0ıq\ò[‘\\\Z(Tİ¦\ô1\Ò\éUJŸA™ú	¥Ï¦à¹”¾\n\é(}u\n^ƒ¤d_‹rT_Qúi¨PJé§£>ıKJ_ª2\n”~{,£]\ég¢\í†7”¾!…\ö¬n`»>»Dé«.{¥\ÒOK¡iB‹³›”ş\Z \ïı:_]U]\Ëo\ò8¥@(0\æ[R0 	aOÀ_Á¯\ózùÏˆ;\â{Ä(‹®\n¾\Ï-\òEc¢\ä/\â\ÃÂW\ä\Ã|\Ø\í	\ñ\Ã˜ŸB¼K½ \è\â=~>(Ha>\òøGx…#®I~h’_\çwI7\ñm§;\Äü°^\ä%\Ñ+~\'eHø“%AÁ#…ø\å\îp8j¬¬\ñ„İ‘¡\ngÀW)\0±|˜p¨T¨\Ë)u\å70T\éBaQª\Ü\Ø\ÑÒº¹·µ\Â\çZQ¶\'%b½²!U‡\n¾[”|P\Ì\æÁ·(‰ \åˆ$øÃ¢«Œ–Dª–\Ó-H#b\ğ‚’ŠR†Â‚\Ç/[\èIN’\Ä.^…N\0üxWÀ\ñ‰ş0u3?\ì\ñŠ`#\ñAQ¯²¢h\â/q\"™KL\ñ\à„@$…%“\ğ(\"§7\â\":$¦½ŸG‘@\İ+\Ç˜FB`Ñ³Œ\÷\\ar©YÁÈ\×r—\ñ.a=	2DN\ÑOV•‰‰ÀÁzS[gµ£4DJ84¬¸ˆÊp|s-!IĞ…\Ü\"]\ã\n€Ë¨\ÄQ\Ñ&B>\ğz\Ä4gÀ\ï\ò‹B4\r…¡À¸HM‘\Ã\ê„ASY\âÿ\àlP•©[\0Õ‡D\Å_rŠ\n)\ÖHDz(q\÷€\ëa+Pq\ó­¬XBDK‚K\ô	\ÒX‚hv3HH\æMÀü  ¢G‰xi;¸…¨U]Qµ²iKM}\İ\ì¢P$\ôz@3²Ÿ*xG \Âû„Iµ”m®qJ¢@\â±\nz…I\Ù\ñA\É³\à§0¤¤œ’t\ÏD;%–<\ìµW\é\Ëy\ñ!‚RÀq†!*°ÿamY“\0Î›p{œ\îy \á\ÜY\í~\ï$¿Ü³‚}C¢+…8|œ¶”œ¦uJ¶‡\æD/É«‰z`¹¤„E©b’¤º~o@p\Í\õ »J”ˆ90Â¾\êE2hÜ¢78×£Pa\Û\Ë\ä$ $Ç¤€\Û3\ä+U\n¶w¨Â—\ğ ­V\á\É`\0ªI\Ğ=Y	I	\ïI\Â\î\ğ¸\Â\î-A\ÈLÈµ^\Ï>±#,@|\Ğ\×ªQœµ\ĞÛ„<È‰$@!8‡Qp-Ğ“PB0\èùQÌ¬C^h<\ê\Ür\Ã\\ˆD¸Š@=\ĞE)û`V„k\Z£3~\è\ñ@/ !\à@fˆ4‚q/\Âe˜J!\ò\'€Š`\\@7Nÿh \0\Ú\Î<\ĞúB¢´ $¸\èp†\0\ÊI\èQ¸f]@ık\è·Áœ$†¨|¿\"Ÿh#Q9D\0xgŠ†	ıRˆl`\å\ÔaÀ…P#ª„6s„g¤W\0Ÿ\0\òVPtQ9\ğL\èP9wy\n\ïJ\ê§\0ÀJ\à P»m%Úˆ: B­h3\êX³.´‚ú¼…úi¨Ñ‘#½5|¤Èºn\Ê\ÙG\ãR¢\Í+Qq\Ó9Q\ñ\å\Í?\ÕÅ…\Êh\Ô\Èì¬·W›À•Qÿhdüt}r)ˆuaj±NŠÎ‘DNP¢\Â\ÙE¯!:\ëJAÑdÁDÀ6‘j=›\ÍDs¸\Çp2_{\ç\É(\ï\ÎZBrR {À3\'\æ¯\"Y,gB\0ä‡•#Q”\èK\èQ¦pr\Ïı\Ù\óW{aì£¸Tf³7u?ÊšF\è,K\ñ\'\éû O¤\'\ÇbJ´‚4o½\Ô\ÛnŠqÑ¾¬\õ\ÕE¦%)Ô·	Yr<*i\í\à)V®²\Åß³q]\Èwe)q•m	&34</‹fí \Ş\ò}lL•&¢\ìº¥œ•ã¢pµq(œT®L“\àNê•—\îÑ‰dÔœT\'\ÕÓ£\è×˜R\rI\õĞš6•\Ô\İ\ê\\X\ñiªù?\ë‡Ô:wUˆ\î@\Ù\ëCŠÕ³ù•ZE…ˆ”´=D\ó\ÍO¹\ËY/\ßf­ûs±¬€º¤%ı/Pz‰şÁ—H«›•p>§…\îL#t³\õ†\Ä<Hµ”-¨ \÷£ú‹@„\óv%[Şª\nR›\ĞTƒ\êQ\èV\î4Dª@+º¨\äW¢¾\Ë\Õ}‚¶\n\Z¹º\Í\Öú0Ä”xI®•A\à0	\Ø\Ä\İ-¤\Ô\óT^A¸‡’<\òDˆz!Hw Ó„R\Ñ\ÔK<•4™¬\ßm\å¬v\Òh	\Éı-\ïû \õ\á\äœ¤+¯u*\\De,\Ì\Ë\Òp²\Ë\÷Dl\ç\Ö\r^¹·ùR\òo.fxN=û\óy¤c½Ë…•½,?Ÿ\ÈrË’r\æ[ \ïŒ	%\î\ğY\â	eş\ÎZ\È\÷d—\ö–ı\n¸’œJÖs—uøK};\Ë}\ön²\ğ½g!R\ïks\õjJ\Éb‰lK˜\ÊK<+J\ô:©T\Ò	jy€\î\ó\Ë=aNV‰4.†•\'^¹•û¡ül˜¨y2·\ò¦—£\òS¬_‰\Ì,\÷\ÄI\ÔY’?nz\Ï\ó(~®øĞ³ütú‹\ê|\' ¶\ì\0\î‰;Àè¹¨V[h\Õ$\\\åº\Ûı}@\ÙA+²¼P\òù\Å\ï%ÿ›pÁ+W\ò\Ù!×¥\ô].¯®\äÿ1Ö…\ä>ù\ïu\ä%¦/\ğ\ÂkpmEmCEUT‡ùšŠ•d8\âºC=C|}´&\Ş\"«¼SU\ÑP±º‰¼¹\Ğ\×\ìù.a\ÜC^Hù:§se•³Î¹Qû\Ëø–I\É[Æ·K¢8VÆ{\Êe\ì\ĞH¹<’”NdŒvş¢E\Ôi\éog\æQX‹˜@0´7!4\ïI˜Cx^•°\n1xE\ÂkÀ«ZT7‰5\ô¯›L¾;C(ı²»\ÉO¸\éÿ\\¾XKp¦2J\ç¢}–\ö‘‚Ï”À\ô@0K\à$¿¡‚a‘\ïaka´\Zù½	À~D¾[œBÿ\à	\ôÀo¢3\0ÿ½\ğ=\ô;€¿}1Ö€ŒÓ±`&^ĞŠ·\0ÜŠ\0E|\à58\n\ğ‹ø›\0ÃƒnOã§¡\Z?\ğ\Ûø\Û\0_À\ßø\Zù\îÿ\0ÿO€?\Ä?ø&~\à9|\à;ø_\0şƒtü{ü>À?\â8\Â\Ëh\0¦1\é\03\Éÿ\Âdr˜¥\0M\Ì\0Ë˜\n€uLÀ5Ì•\0[˜M\0·2[\ö2}\0·3;\0:˜\0\ğ\ãbFúÀ 8ÁL¼¹\àM\Ì-\0\ïb\îø\0\ó\r€1\Ó\0Ÿdø\óÀg°‹yy\à«\Ø\Åü€ù\'€?bş\àO˜Ÿ\0ü\ó3€o1o<Ç€\Ì/™\ß\0üw\æ=€¿cÀR\æ}\æ<ÀfaL¨aÁ\çl&›	\ĞÀ\Z\0\æ°9\0\ó\Ù|€‹\Ù\Å\0—±\Ë\0±\å\0«\Ø*€6vÀ¶a\òs%€­\\+À«¹«\äN|”{±\Ü\ÜS\Ğšû1\ô\Êıú¿\âş7ÀwU*š\Ë,ı\ZÑ¿u¯¦ÿÿ\óq\î\îU\î\ï ¿XX\÷,BÜ·¸—Šû>\ğ\È 9\Èı-\÷\òÿš\ó©¿\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nxœ-\Ì\Í@@à·¿\'c\ô@\npÕ€vĞ‚»\Ü\èAªPÁZyr\È7“\äˆ‚Š½\0>6r\êLEV²v º‰„9\Ï]2:ş,¡‰!–8¢\È\éc.=%B~	MO‚\Ğ\ÖB·\0/\İg\Å\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',13),(10,'2025-06-24 19:28:00','EvaluacionParcialPorOV','Entregado',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 251>>\r\nstream\r\nxœPMK\Ä0½\ò\æ¸+´IÚ¤0\Ğ/\Åd\n\âakOuÿ?8iÔ“9d2\ï½yaÇ·\Ó1cw\Ów§e†\İù’{fhûŞµ\Â\Ó	d\0Á\Éíƒ³VW°h\ÕNZ\×BL/Z‘ˆŒ\r¹\à1\ä¦W\Ñ„0_\Äæ­¥¯\ö \ÕSD45g6\"ù±\ë9=M‹\ä\Z1!ˆC\ÍNPrHVk\Ğ\ö³R\èºd\ë7U5SWy\âDÿ\í\ÓHB«Š³Zªm\Ö	1^Í¤¢LFj\Ó\ò3L·Z\r²\ä½VÿM\ÃüM\Ãz“—\öG\Zk\Û\æ;\Øÿú†±ƒO\í\ãS\Ñ\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203923-06\'00\') /ModDate(D:20250623203923-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 333>>\r\nstream\r\nxœ]’_kƒ0\Å\ß\ó)\ò\Ø=VmAg+ø°?\Ì\íi\ìÁ&\×N˜1\Ä\ôÁo¿\ä¦\íF	ü¸\ç„ssTÍ¾‘ƒ¡Á«x†\öƒ\Z\æ\é¬9\Ğ#œIXD\ÅÀÍ…\ğ\äc§H`\Í\í2\ÙO$\Ïi\ğf‹³\Ñ]•b:\Â	^´\0=\È]}T­\å\ö¬\ÔŒ \r\rIQP½½\è©S\Ï\İ4@Ûº¶>˜em=Š\÷E™\Ã\'³\ê8\èN€\ä¡]\Ík»\nR\Ü\Õw\Şu\ìùw§:\ÚZun’\ÂQº\óT#m7HIˆT>zJ‘ª=RÊş–4v\ÄX\êi‡y_Z!Å‘§¦»\ä`\×T\×&X\\:‹­\÷\Ó\Ékt\Õq\ñ\åm^˜\ÜuÃ’u&f‰O•EHi\é	;e™ÏŸa7\ñ\Ş\÷…ÿS¹\×sC¾†Ÿµ¶SÁŸ€\ãpƒ$\Ü>‹š”s¹ıI™«\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8298/Length1 21668>>\r\nstream\r\nxœ\í|x\å¹\ğû\Í\Ìn6W6$e“ln$$’uIH \á’\0Y®™\ìN²K\ö\Æ\ìnB(Qº\õUk­\n­bµ\Ö	VO\ë¥V\Û\n¶§ÿ©\çX­z\ô©§\Ï\Ó\Ú\ËiµG!û¿\ß7³›\r \Ç\ãQ\Û\çù™\Ùyç»¼\ß{\ßofY\0¦ À±¦«²ºı¿\ÈN\í\í\ê^\Òı\óS/\Ç\ÖŞı\İ.¿²¼[\ô\Ï\0\Ó\÷cÿ\×PD´~cú\0s±\Ï\ô‡ü¾2\Å\ïC¢{|#ı‹›\Î\Æùg\02†<²\ä.>\ô×»\÷^u\È:•ı \ò[ˆıb?²sûOrk±ÿ¯\0SU_\Ğ%=˜û\ĞQ€šE¸\Ş\ì—v†L~³	\ç{_\ô\Ë©\î›;»\0:\î\Ä1. ù\å\éƒSÿ\à\Òå¸¾<G\â\÷B5\ÎS}Ä\"‡Bû\âSJşÀMª;\Ç\İt¤\ñOK·MYüW\È4Q=\à\õoE?¤\÷\÷T×\"§O¤GMÓ°k´×¥\í=ı4\ÊTzŠü\í\Ï8“\á\çÇh\×b\àq¥*	rå”½\Ø# »\É\Í`\0“¡F8K\î\Ò\î\Ü	\è\ç~…\÷L8z\"p\×\á<Ÿ ½ªK\á\È>}J“Á4«\ÜK\çø“†&ª)\ğü\ó(\Å`¢üBÔ¿·Ÿ\÷a\ì<¿†\×À\÷‰\Â=ÿ¸\öıÇˆQÁÛ¿0^5\ç\æ%\ìş\âdø4ù-\\\×ÁsZš\Üt¸ı\ã\æ\ïÙ¼&\Ío‡\í\ôú´¼ÿ\'‡0:!\÷\Èù\åú\Ä4w\ÂŸz\ğ\÷|V”&Â•ÿ˜\äƒ\Ğ\Å€®¿·Ç…\ã\Âq\á¸p\\8şÿ>\È}Ÿ—\ëG>7A>\çƒû+\\û\÷–\á\Âq\á˜8\ÈKúı•Ï‰ş›Ÿ\İ\ó\ô\ÛEú-\ß4„„\İø\Şçƒˆ­˜K VA¬	\Ü\à„@!x„g\á?\É\ği\ñ8\Ğo\05\Ü5\×\Åpˆ=7şLüm \ßo®c\ßF=O#ü\r\Ú >Š/\å\ñßcDE‰\æ\ër²/{¡”Á\âd+\å\àÿG˜Š<¯ÿ€\÷H5i \ë\Èv2\êhÿÚw\Ü~İµû®\Ù{\õ—\ö\\u\å\è\î+v\ìŠF\ÂÊP0\à\÷\rn\÷zúe·«O\êİ¶u\Ë\æM=Ö¯\ë\îZÛ±f\õª•+\ÚÛ–/kk1g¤—‘±ÌŒf[³œQ^c™\Ø\Ì,/#ª±YMcƒ\ê\Z»¨:\Ö\öXWt\ö´,-´Z…6«\êP…’zI\î˜+1\áD¸\n\×\"‰]¶k7\öˆ-±^6‰#İ“z\Úü¢\äœ\ŞR¹\æ\îµÕ½”ş2\ÖOv—Ÿ1İ–˜¶‰*t\Äb\î1\àKp\ÜQ8FX\Ã\Ğü\'jâ´©}v›\Õ\Ö##\î˜	²¬İ½\Í\Ø\ÊJ´ˆ¸)Š\Ç\ÌĞ‡—kƒ\í\Ñ[{T±·ß¹±+QÙ§\ë\Ô\Úvj\í^Ut‰¢j,±\õu\ôÄ¬*\éµ\êı\Î´‘\ncV›Ut:ÅŸ-¢\Ø6+\Ò\â i\ÌF\ö¯sı]{›1\æ\öw\÷\á\×\Ü\Û\ä+Æ¹\ã\"€ƒrt”ÒH;°‚ gp&†_x\Ü°‡\Í\nl€\õ]¨3%\Æ¸qÚ˜YcT\Ê90{\\\ÇmÆ‘ÀpÌ¤\íÑ°\ç\ê\Ø&œ1Ó™\'\Ã\\c“ÚVB\Ï82“#İ‘\Åes\è:tGD\Üte‘lR8†4;\Ù\ğ1²g,\İQxœQ\ê\Ô1\÷ &Û“C\É)Z\n!\ä§)¾nBƒu{\Ë¤\Ï b4Ñ£¼¬eŒ[m·M„\õ\Ú\ô^\ËYm\ï\ÅĞ¦]¾¤EÄ°V]=··c£{iy.±\Ç&ÚœcÓ¦\ÅB-cfs\óŠX32\Æ\Z°1\ÉX\Úki!G\ÍfnÀ0\åK\Ú\\¶\Ö^D±a\Ú\à§\r‡\\\ë\Å^µ¯×M\Ñ\Ü\Zk¥Q!Ql\È\ãø’1\"”\Ë\à2´›1KÍ°\ÉMj¦­)9s9\\®\Í\éLš­I%ùš\Õ[l-\âo\Ìe\ë\Ãtt\ô\ö;%¤­:l’*Øš\n\Çh\Â|™AP¥–1XmG\İV`®±wl\Â$¥\Æc±¥\â˜C(•\\\í/µb\Ş\Ç\ô)\ÛÒ¥Î”-bLuH®^\Ähq2d\ÌDl±I¢­Œ\ê¢\åºl\ØÜ¸‘®\é\Ş\Ø\Ër\Û\Ü6´°\Ã“P\íB\Ñ\å,Œ9]\Ì\â¸Eƒ\ò2\ÃDuÒ‹Gs¾\ÄÕ\à˜}½¶>m€f\ç™cg\ô#Vê˜­²cw\Â\î±v[‹1\è%¹U#\Î*ºZ\È@«‹DRD\ô)#37&zD\ïa?1u`r×“\ì¶Ò«­V¡ÅŠ*”\Ò\Èë±ª\ÛUŸÓD‘\Ô=}bL4\Û\Zl°\Å\Ë\èÕ«\Z°±\Ç%\Ñ\âd¤±‡\í8 \ö\ôa,#Á\Ö\ŞX\"\âp™Pš\ä¤\ì“HbI%\İÈš+¡\ê¨{:\Ä^§\ØÛ‹£˜=\ÖBQ5\à]\ì—hpÑ²Û¡\éÓµoR¬\×M B5\rw€~I¶Y±Z«4i5\ëS”ºzT(Œ\Ål1• ˆ%­ˆŒ\äKUci½\á\'d·I2:‘\ò%™­mEq™u(µ\Â›Õ‰(\\	³%\Z«E®F£º³\ÍP’Ë‹‰\õ1¬Z[°\à\n¥®\õ½¸-ˆf±Ud®–0’©\ÚhÏ‰„4\Ä\ôŠˆ\ëÙ§T\õ\ÛÇ¶¤•LŒ°OĞ®!›U”¬³G\íH ¤±6v\ØU®`NR\åI\'\Ö9Š\Z\ÏPÒ†\æu`T\ÒÕ¢\Êu\÷\è\îa\ë\Û\è\ÒÂ„Ã´e8\Â\Ê.\İ­	y35y5¦F\ö\ÉbŸ\ô\ÕT‚V”A›N£\êL¶Qhm\r\Ï\Ä\ÕÀ6²\õ¦H¯\ŞJd¦“¶Š´|âƒ‚d£W\á±ø3X#{m\ôr:){cDW0\Ò105—‘N\Ë:\'\í“I?mL…\Ô\á\öIc2\Ó9M%\Ãd\Ã\ë\Ö;4\ËY\õƒ\Æ\Õ\ò:=+\õ¼“U\Ó\î\ÖV\õ\n.bE\Å\Ê\íZË66a6Ø¬iX\ÇP}\Ì*Q\í²\ã&\Ât»N³j»VhT’V´b\é\r\Èl\Ë	€©e[®r\ØM¶lG8 &\Û\"zK·-\Z\ãH\ZV{ZŒ\Ì\ÙYX\èc®^·¶Q£•aQ\ábúhddNg¾¢¥©»\ÇP(8YÈ”ª\Ãv=Š58dO\ÎÓœLKX\ÒD\çb\ÉI#7¬\ÅF©‡\ì¦s®Š™>3“\îM5\Í\ÑjTj:?+^sP»\æ®vN£Ü®\Õ	-u\Åb´´mÉ¡šUš‹\ãy(Z=\nY¯K‰¶Ù¢tP\Ö&6Âº˜niT\Ím%™8aF\Ügµ\Ğ\Î\ÄI3J\ól¡†…Ÿ\ãø0dO`kF@¹3J´8×§\õ\ÕZtÛ\Øj¥W/¢´\ÒKÏ¤L=K³Î¨ú:yÍ§\é“\'mIbt£·%)\Ò\Ş\É\Âg`¡Ğ€KE3š«Ù³E\Å~¬aŒ¤•\êŠÀ•4\Äb™‰úO\Ëÿq|\0\öp	\ÎØ™\ê(ú}}\îÓ™£\ÙlX\÷rv\òN\õt\ÈhV3›\é\óİ›\Òi\0T GŸ\×k{œH1¢©˜::ƒ\Ú>-Q‚\ö\ÄÚ„\İúYJ\ëk\Ï\í\î\ÅQj©\ç\éN¢¼J­\ô*¤¦c\ÜhŒ\íúƒ\î(\õ\îÕŒ\Ü\ÕvQ\ô\âsV3Á§-\Ü(½t«)¶©”¹>\ğx%‰\Õ!\ö\Z3Ÿ¥:\é\Ó1¾\Ø\Ì\"Y‹µ—!›ş{€PÒ³¸°Ş‰\ï\Ç\â¿-rj¥Š\ÃM¯\î˜(šsq*&\æá‹†º™WŸ³±1\ÜÅ¥:\Õ`&§†G¥\Ï\âb+º\Ğ\ô,cQa}\ËK¼`\İi?ß´H\×c•R·\ÙvZ©)\Ô\õ¶|Xh¶©¢¸K\".+r\Æb¸\Æl\ôMj}\é)+¢O\ô)F\Ç-,\Âw´‰nV\r7\éXü±\"úº”\ävE‚›‚\Üh#–`§º\ÎÉFÙ¤\Å\Z~˜øcu`\Óø¥:\Ó\Ø\æ\ØF|?´ª³(c]\ì\æ9”\äN*	8\âÛªâ–­\â–-•Šes\åË¦Ê¸ecE\Ü\â¬8a\é)‹[6”\Ç-\ë\ËOX\Ö\Ù\ã–\îyí–®yqK\çü¸e\íü‡-\óDËš¹-–\Õs¶¬š·¬¼8nYQ\Z·´—\Ú-m\Å–\å\Å\',ËŠ\ã–Ö’¸¥¥\äa\ËR[\Ü\Ò<\'ni²°,±\Æ-\ëÃ–\Ë\Å–\ËÄ¸\åR\ñ€e±Xiiœ­X\Zf\Ç-\õ–¸e‘e\å’YŠ¥nV\ÜR;\ë„ea\Ñ	KMQ\ÜR]\ô°eA•b©(»\ÔR^¦X\æ\Ï\Ûj)A^\Å3/\Úl›\ã°\Ì\ág^´\Ù:\óR‹¸–\Ù–\Ù\óf\äoU·\å\Ç-…µ5lšQ—ß°i¦£ƒ¶h{úEùS\ë\ó\Ö\åÖ›\×\å9\Í\Î\ìú¬u†zn€W–sJ]Îº\ÌúŒui\õ\Æu9\Î§\Ñ	\Î\ôz\Ó:gMN\Îi\Ş\á0\ã\äfè¶¯8–\ï\\¡š:6©d¿Z\ÒE!¾6¨\Æı*¬Û¸©gŒûn¸f5­Po\î\ê9\Â6\ñI’k^\Û3&\ğ7:›Àv»\ô“5\õ¾\İNRNÀ‹~À®5´y]o\';\öª>>ifš\è	y\ñ‰¿\Ëÿr\â\ï%®\ñ»\â¿7@Ö‡\İ\ğ%\ğ\ã9n<i{„`º@†(ø`\01†a;¼lºc\0®@\ìkÁƒ+†\îÀş5\ĞA¤t¬\Â\õ=Œ‚„˜>œBê£Œ\Å\ïd\ßtEa/\Ò\\‡4\İ8ªÀZ\Ø\0[c>:\Ğoœ7´S`*”C¥c\æüq\æÅ†b!cš7C0›+fOJ8L\n*_m~¡:·=7¯ ¾jÁ\\knÉœ\ÒÚ…u5\ÕùÓ§\r\Ö\\+)­»¤®®va©mqº-1“f4¦\ñÏ_T\\UU\\\\]=¾„¿\ì\Ô‰,466\Ôu®\ï\Ş:\ô¥«¿\Ş\Ñ|\ÉÁ\Ğş\á\Ñ7*‹‹+\éu·\ğ\ÃS\ïw–—-«k\\\Ó\Ó1º\÷`‡{¡}E-ı\Î\ÏDÿ„Hƒ(tdg&£PV	‹2\ÖW\Öä¢”aRCl¼•Ÿj\åM\äoO‘?=¹\ç\ô?_ûù\É;†¦Ÿ\"#\ã\×qf\î*À›Q4>g,¥\ß\"£\ğr)>Q\å2	!;×ƒ}!ıı¢Š8™\È5.rdL&eºÎ²š\òD¹\Ö\éVıRùM§Ü\Ó7q‡\rM·w\İ6n¿]§c8ˆt¦€\Åa\æÓ³ù¬,#‘–)I+¯¾’Z9œ‹\ò“š\\›~WŸ\'o´‘_>3v\Ùø%C\ãU—šN½\Ë_\ô\áS\ÂwN}\Ä>ê¦¶\ñ\Å\ß3İ”:˜Ÿ˜a\â3¤kd«´\Ì)\æj\æ\×TyÓ§q\Â\Å\Õ\Ìa\Ôc\Æ\é\Ó\ò\ó¹\÷~1ş\ï·\ÜBfÿ\â¤\è–[\Æ\ßùÅ¡·ly\ñĞ¡o\Şüc\ÜZ\ê^z‰,R\Õ\ñ_ziü\'\ê[?¸ıø\à\Û?¸•\ò¦ZƒšeÁt(pdfgf\Â\ô‰JZ¨:Ÿ†\Ñf\Í\Å6«J~3úb$\ò\â\èøIR¼\ë;G\Æ_34m;~\í\Ş#›Oÿ{p\ôªıW£å¨—Ğ–`„\é†\âyh/	ıM?¿/zš\ÜLn}j¼À\Ğ\ô\Ñn\ášŸB\é¶\Ç\ß\ã¿Í¿³a.X¹33“\Í6²¦¥)–\"È¤6b~¬Ï­±SS•\Ò\ğ.¾d\" 1¢gs\Ósmh¸Kjj3rw\÷Wº¾E\Ê~¼{›;4\ğxtÅ—ı»Óš\Ç\Ú\İ\÷Õ¿ÿ\î–<\Ç\è\æ½ûpKG·\ôvŞ¶´¨}Ÿ\÷t\ô¶›\öl]ş¿u°mj¶=şş\ÇL6Œ\ç\ì™\Ù3ÁlJS\n4©\ì\Õy\õ\õ••I™hf\åØ˜Û¨\×jP˜š+¿\æ¥\ğŸ^·\ãq¿q\÷\à\×_v\å\ÖÁkùûyÿ\ñ\Ü\à>øÖ\ö¯*[}Ï©\Ñon}c5\èVyV3Œ—YsN†’\r\Ê\ÌL\ä>Õœ4Jµ\İ>‰{AnM\Ò¹	9\È{\Ã\ß\İ&\õ\ÜUyø\ô…\ßZ5xcÙ¼}\ò¾\ë®\ÊS\Ş>üÀ¯wlZ\Íe}øÔËœ_–—‘\á\ÎÁ§}œú\åzLŠ-†e¬™Ÿ\ÈˆQ\êÔ“\Õ,rù”Bs\ğpw%5FC\òTµ°\ï’ù\ó/¡\Ú\ğ \ÒYÎŸD:Y\'ih¦Ø˜\ç:/c))ÀVš\ğ\Ä8ı\æ>\ã1\Æ\Ô~²jÒ¡Iú\'\Å9G\r d0B\ÕHI¢@j\Ó\òkj¦“\ã\ÃWV<P\é,_qƒKH;E6\õ\î\×d\àÎ¿\Ó0ş³Ì¼1MAÂ™:´#§€\Ù)WK½´Üƒ\÷\Ë\Ü{ß­‡g¯j\ó\ßVÎŸ¼½\Ñûƒ‡O_\Ïm^¸\Ü\ÕxZ\÷\Ô\à\ßJfvšbN\Ä\Ç\äĞ \ÉuVfW\İ\ô\Ò\à\àK7\İúr0ø\ò­¾=‹\í\ñy¯¨«»\Â<\ò\Ö\×\ï}{×®·\ïıú[#û¶\Ş\î{H’\òm?¼\ÖE\Æ\Ó\àB{5°ºx<\Î\ê¢h\"dX«‹¿K˜Š±«G\Ğ\ÔÜœL\å\"]uÈ¡N\Ğb¨jAWBw-ÿ\ç”^œKª\õ#-7?ÿ\à!\Ã\Âûı;i\í\ö\Ü]I¦\í»\î\Ê]ƒ\æ\Í\İ?~—aá½«ûv¼yøş·\Â]\Ë\Çs\É\ëO=\ö”²r|ÿ\Êmšİ¹ıü«ƒ•!3=Á<Cg´z\Ítj´\÷7Œ\ónN+htŠü\ÉV\ö­´¹\ìt7­\Îw\ÄÿÄ¿‚Q¤y0C™\"•¼Œd&hy EK<=\È/¿}ûƒ³»\×n+\ğ ¡\ò\á)ß¿Ÿ\Û}ú\ëM†M‹¹#§ªood¿§¿8D\êZ3€!)\æ\ä\n64#\"±=4~3F\î/ùù§ªYüÿ5³t‰cÚ”%Ë¨\ÌdÙš?5™¯X¿8#gkÏ•³yt‹û‰Qÿ\×*h\ÎŞ¿\Æ³}\îu\ò\Ş/ï™º\ã\Í¿Ş¸â«§ª¬Ø´\ß\ÛNF\Ö\ÈÏª}Ÿú¼‹+\ç>\Â]¦J\Ñ\ç\Ù\â¬YV\Ó\Ó~&dM…ÊšU`Eª,\Ñ%¸dÒƒA~JeJÚ›v,\İûŞ¡­\ËW\ö8zÓ†›\Öİ¶\ğ†Ê+­?}´+_8°rpp.W·a\é²5±+*\Â\Ş\Óø/]ºc\Í\å7\ğ+\Ö64i\ñKØ¾W9›M\à-0¡$47–œzjP\Æ?Rp:P†Ú²å¡¡Q¹¬¯;\êvs\å\Ò\÷F\÷<\Ş+=~\Õ\è\÷¤‘ûF:\÷´ß·{\ä>ªû#\ñ\÷\É\ÃX\Òq—›\êH³9C\ğf\äQ\'\ÖP»J9\\Zj\á:m.x´ ·rQ[Û¢ºe\Ë\È7\"¤\ä\0}90şjx\Ü\ÙV[\×\ÚZW\ÛF\é_\Ëû¸ £?5\É`{\Ğ©­¡OU\Öd‹ü6k\ÊÁœ\ì\ñ\ÕY\æCS2y\ß6uû–-ƒ\ß\éKÜ—„}\Ü=Xa±=\Æ\í\0•vf•¤p\\-TZTS\n*®{EXÏ»\r.¬¨¸$\ÖM\Åø|\å§?ÿ‹°dÿ\'\â½i8Ê»ŒÏ\ï\Í>;7ex\ô\Øû\á®\Ï\ğ|\ê??ù$\öOunúL\Ï]ŸÁù\â§99C\Ê\ÙúŸÛ¹\İ\É\ó\Æ\óß™t¾:ù\ä§\ñ¥Ÿ\â\ô°\ó†Op~ÿ¿ú\ä§ ş¯O¯pÏ…\ó\Ây\á¼p~.\ç\É\Ï\õü\à\ÂùYœ†©x^ü?8¿Ø“şœ\ÔŞŠ\ğ½h\èoH\r\Ø#ú/ü\Òøz›OR\Ú\È\åw\êmc\Êx\Z\Ô\'\Û\Ù\äGü—\õv\Ø\r«\ô¶9?w‚Àh\Ği|O3\\©·\ÓSp\Z!Ë°Wo/Fü›\è¯…t\"døª\Ş&‘e\Ğ\Û\äd\r\ëm>e\\Hi`N\Ö>½mLO%\Ù6A\á›z;Š²\ë\íL\è\ÎzNogAUv\Ş\Î\æ\÷g/\Ó\Û9°\Şü²\Ş6§\ĞÏ\ru\Ï\Ê-\Ñ\Û\È\È] ·\ÓSp\ZaFn£\Ş^Œø]\ß««ªŠ«¼.%\öG\Ä\æ \n*R\ÄTˆK|>±\Ó;\à‰„\ÅN9,+C²»B\ì\ö\È\âœAY	\Ì#RŸOƒıb\Ä\ã\r‹ıÁ@D–Â¢[’}Á\ì½1$)1\Z\öDIG¢\î±oD\\p+7Š­Q—\',¸^\Ù\'I#H\é\Ó%!É«„Å¹H$\Æwo\Ä\í«pı•R\Ëû)…J»œaW\öù‚}•~)‘•Ê•m\Í-«»Z*ü\îy¨[hD¡\ê \Ò\êSe¨;d\Å\ï\r‡QmU\ñÈŠŒR(R \"»\Ë\Ä~Efb¹<’2 —‰‘ (FÄ¬„qA°/\"yš†.ä‘´µè°¤Èˆ\ì¥p8\è\òJHOt]Q¿ˆ03‹ı^ŸŒ:R\Ì\é\ÒWÌ™Ç˜¸e\ÉGH\çS\â0\Z! Á\Â\Å\ë¢4\Ê\Éå‹º©‰iŸ\×\ï\Õ90\ój~D¢\Ñ0j@\å,ıA··Ÿ\Şe¦V(\Ú\ç\ó†=e¢\ÛKI\÷E#8¦ƒ.9@W¡•AE\ËHÁ‹r3]\'¤c8”Kˆ\Z4¢›ˆ\ñ\öı“5¡AE×…=2[\ã¢\É\Ç\í²+BG(z\Ğ\çS\Õ\\Á€\ÛK5\n7°0”ú‚C2SEsk AI5	¨ıCNÕ§\Â	E\ï“u{i!*¥h£P\î\áúİ‹¦\ÇT`\ì\ÎÔ²bI(Sù%1¢Hn\Ù/)ƒ	¤‰d\ZP‚\Ñ‹› ?$AE§<\õI\Êz4«º¢jAãššºÚ‰E\áh(\ä\ó¢d4Ÿ*Dg0*ú¥êµ”4CÓ¸Y¢şA_…|Òˆfø\â\ÅY´S\ÃCNw\r:Œg*\îK³\Ã\Ï\ô\ÕıZ\\œ¥CH	º£®z\ó×–\Ñ5	h¼a\×\å9£\0$Œ;!}0\à\çzç‰²¿Ov§ #…\óI\Ë\ĞYX§D{x’\÷’´\Z™\æz‘KD\ö\Ó*¦x‘«;8\ğ%\÷d\ëIš©d…ªDV£‘\æ\rV/\Z)ˆ\ã‘}¡\ÉÅ’ˆi¯¡S‡\ĞS‚oŸe®HT)L\ïp…?aAV­\"#¡ V“g¤ƒ6\Z\Ù Ó€\İ\àuG<kB™k]\Ş]r[DBÿÀ·A„j¨\Âk!¶V\\ @\Âx\õCÇš±¥@ˆA	G¼\Ø\n@û9¼O:ql\0<8f=\ï2û½n†Ù³2\Ş\çÀ ›	`KD|	ú¡\Ü\èˆiQ*ıŒ\å?ŒXtÄx”¢gBŒ²ˆ¸„!\ÄPn1\é\Ø\0¶%¼\Â8\ZE\Ìl\÷1¸gİˆı[l·\âœ9†ÿ€ÎŸJ£0>”Ÿ„\ã®	\ò\'¸P\Ş^¡4\æ2Dp,\rP‰\ç\0\ÎQšQ\ä^t‚\à\ÇQI—A†r¤™¡\ò\Ú\å)´+™‚+‘‚\Ä\ô¢¸•°\Ú\ĞC-°\ZºV\à¬\æ1›73; V\Â;š§@ı\ÇÚ®\ë`”ı\Ìa\İÛ¢\î›“u[°ˆ0Y\ÜPÆ¼Fg\'¬E©R\ß\àX³oy&ÀÖ‡µ°Îja\Z&ùĞ¥\ëqvŒ$bt˜\ñu\Ênv³YúŸ4$]>\ZAt$Šº\ÉL\ê‰h¦’{™\Ç5?F’\ñ\Úu9h\İ	MhLJ,¼“\â\ç\ÌU4ŠµH\"ÿˆaÔ‹\nË¸„e:%ÒŒ²¤\×\ìp\æj\öıl,U‡‰\èM\ÍGM\Ò(\ËÉ²{Ò¶Û”K²/§x+\Ä\â\ÖÇ¬\ía#n\ÖÖ¤\îc²h˜\á$¦‹\Ù6ÁK\óG%«\"\Õ*†&ƒW·\÷„_\Ïe»²¿jº„’\Z9#Š&\ôf\Ö\òŸ\×\'‰JÕ³.\Ì0\'ø¸¤”\'tÜ.\ÆW\ÃIP§\õ\Ê\Çrt8\é5“\É\Í\ä\ô\ê\ò5¤TCZı‚¬¦Mx%5[8\ÑmšjƒDüO\Ø!5S\'¯\n³Ô¬Ş§k=_©UTú\ß(I\İ\Ã,\ŞŒº\õÚ®0¡\İ\ç\Ë\n¬;!f¹p\Òş\ÃW\Ø¿’YuS°I\é\\;\Ó\0\ëG‘\âD½¡>1)5\r*\Ø~4À~LC)¯×£%a­jÄ 5±\Ö@\r\ÔA-\Ê\Ñw\Z\ÊUb]\Ö\ã+Qßµ\ê>\Ì\Î\n\æÉ²M\Ôúú”ZI«•!¤0‚£‰\İ-¬\×\óTg¯ \Ô\ÃIš\ç²D˜Y!\Ä2P\ói‚­\èNf%‘q\ZIÖ‚s\ï¶ZT»˜·¤d~kyb6™”‘!±\ÚZ—NE\Öû\ÒQ\ZIVbmÿHøvr\İ\õ½ÍŸ“Gú\'Õ³ÿ>NB¬\ïf»\\D\Ïe\íùD\ã[–\äs¦Zf\ë>\ğ|Œ\ÍO(gfÖ¹lO\×øXk.\â\Ï\Ã;ù¾d\İ9›º&Ã§µ\í\õ‰\İ\ä\Ü{Ï¹4H\İ\×&\ËÕ˜TM—\ã—xVTØ:¢W\Òa¦y\åùùbOšU2\óKP‡ı	D\ÔwÂ¾jÏ†‰š§\Ñ\ñ°\İ&t\ŞÕbºg&¨\'2$QgiüxØ\ç\Õ\í\\qÖ³\ötşT\õ@\Û	¨.zbØ€-7“j\r«š”ªVw»°½1\ÛXE\Ö\ò’\Ï.~7ıû|\ç<ˆ~§\ï\óú\Üz\Û\í\ö\ğ~\'^µa­Mÿ‚^-}‰\é}ø\Z¼°ba}EU£\íV\÷G\ZÄšŠ´;\à	y\Â+½}\rb]¢?LWù\èHUE}Å¢Fú\æ\Â^³¼\ô»„!/}!mk]®U®Z\×J)(›G_™¸L‘\åÁ2q\È[®\ö\r”kaEoDY\ãS-b ¿£¿pœ\Æ\àB\à‚¡\ğ.\Ò0Œ\ïID\02Œ¯J\Ä\0œ_‘\Èb´ª	Šp“X\Ìş71G\èwg\0™\İf\öı#¡c\äf$­\àuŒ\ñ\à›µy\Ö}<Gs\0×‰\í^™‰ı•Á4¢\ß36`j¸O,6ınqÜ‚\ğ\0<Œ\ğ»p\á?Á{ÿFø”—4\äCH&\ÉB˜C\æ!´“5\×B™Œ\"¼Š\Ä^O¾‹\ğQre;Jbûy\á\È>C~B@¿{%?#ÿ\á/\É+_\'¯#|‹¼…\ğm\ò„&Èü…¼\ğo$„\ã¹4„\é\\&\Âú\÷ ¹<nB7aW°–«G¸˜»a3·\n\áZn-\Â.®\áznB\'·a/‡6\â\Ü\Üv„~Î0Ä…s{^\Ë]‹\ğF\îV„_\ã\îCxˆû\ÂG¹1„\ßã¾‡\ğ	\î	„Or¨\÷4\÷\Â8Ô‹û\÷/_\áş\á«Ü«_\ã^Cøk\î\r„oq¨#\÷\÷;„\àşˆ\ğ\ÏjÊ½ÏB8Î\áQU„i<Úœ\Ï\ásšy3\Â<>a>Ÿp?\ál~6\Â9|9\Â*¾\n¡ƒ_‚°™o\"\\& ¯…¡\áVa+\Â{…{>\"^xLx\ÛG…\Ã\ö¯„_aû]\á?¾g0°X\æ\ÙwÔ€1˜\õ\ôo`^ş\Æ\ë¾/<\á§H#›Æ \ğOÂşŒÌ›\Õ\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  40[ 556]  105[ 732]  132[ 577]  171[ 585]  205[ 531]  232[ 525]  278[ 239]  299[ 260]  306[ 551]  314[ 552 552]  341[ 561]  344[ 334]  362[ 559]  381[ 452]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:39:23-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:39:23-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:DocumentID><xmpMM:InstanceID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nxœ-\ÌÁ\r@P\ĞùøˆH„ƒœ¸:\èIŠq¡‰6$¨B|3\ö°/\Ù\İYÀ\Õ\ó\×s\àc17\ñ[±ˆ½\Ğ\Ğ*gfB»h<\÷³„\'|+Œø/C—‹OÆ“¤©wÒŒb%]¼%\İ\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000822 00000 n\r\n0000000950 00000 n\r\n0000000978 00000 n\r\n0000001133 00000 n\r\n0000001206 00000 n\r\n0000001443 00000 n\r\n0000001497 00000 n\r\n0000001551 00000 n\r\n0000001718 00000 n\r\n0000001956 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002682 00000 n\r\n0000003090 00000 n\r\n0000011478 00000 n\r\n0000011678 00000 n\r\n0000011705 00000 n\r\n0000014886 00000 n\r\n0000014931 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] >>\r\nstartxref\r\n15239\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Prev 15239/XRefStm 14931>>\r\nstartxref\r\n15996\r\n%%EOF',13);
/*!40000 ALTER TABLE `documento_parcial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega_doc_final`
--

DROP TABLE IF EXISTS `entrega_doc_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega_doc_final` (
  `ID_Entrega_Doc_Final` int NOT NULL AUTO_INCREMENT,
  `fecha_apertura` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_Entrega_Doc_Final`,`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Entrega_Doc_Final_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  CONSTRAINT `fk_Entrega_Doc_Final_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_doc_final`
--

LOCK TABLES `entrega_doc_final` WRITE;
/*!40000 ALTER TABLE `entrega_doc_final` DISABLE KEYS */;
INSERT INTO `entrega_doc_final` VALUES (1,'2023-12-01 07:00:00','2023-12-05 23:59:59',1,1),(3,'2024-07-01 07:00:00','2024-07-05 23:59:59',2,2),(4,'2024-12-01 07:00:00','2024-12-05 23:59:59',3,3),(5,'2025-06-29 07:00:00','2025-06-30 23:59:00',4,4),(6,'2025-06-29 07:00:00','2025-06-30 23:59:00',5,4),(11,'2025-06-29 07:00:00','2025-06-30 23:59:00',10,4),(12,'2025-06-29 07:00:00','2025-06-30 23:59:00',8,4),(13,'2025-06-29 07:00:00','2025-06-30 23:59:00',9,4),(14,'2025-06-29 07:00:00','2025-06-30 23:59:00',7,4),(15,'2025-06-29 07:00:00','2025-06-30 23:59:00',6,4);
/*!40000 ALTER TABLE `entrega_doc_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega_doc_inicial`
--

DROP TABLE IF EXISTS `entrega_doc_inicial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega_doc_inicial` (
  `ID_Entrega_Doc_Inicial` int NOT NULL AUTO_INCREMENT,
  `fecha_apertura` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_Entrega_Doc_Inicial`,`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Entrega_Doc_Inicial_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  CONSTRAINT `fk_Entrega_Doc_Inicial_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_doc_inicial`
--

LOCK TABLES `entrega_doc_inicial` WRITE;
/*!40000 ALTER TABLE `entrega_doc_inicial` DISABLE KEYS */;
INSERT INTO `entrega_doc_inicial` VALUES (1,'2023-08-12 07:00:00','2023-08-17 23:59:59',1,1),(3,'2024-02-10 07:00:00','2024-02-17 23:59:59',2,2),(6,'2024-08-22 07:00:00','2024-08-27 23:59:59',3,3),(7,'2025-02-20 07:00:00','2025-02-28 23:59:00',4,4),(8,'2025-02-20 07:00:00','2025-02-28 23:59:00',5,4),(13,'2025-02-20 07:00:00','2025-02-28 23:59:00',10,4),(14,'2025-02-20 07:00:00','2025-02-28 23:59:00',8,4),(15,'2025-02-20 07:00:00','2025-02-28 23:59:00',9,4),(16,'2025-02-20 07:00:00','2025-02-28 23:59:00',7,4),(17,'2025-02-20 07:00:00','2025-02-28 23:59:00',6,4);
/*!40000 ALTER TABLE `entrega_doc_inicial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega_doc_parcial`
--

DROP TABLE IF EXISTS `entrega_doc_parcial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega_doc_parcial` (
  `ID_Entrega_Doc_Parcial` int NOT NULL AUTO_INCREMENT,
  `fecha_apertura` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_Entrega_Doc_Parcial`,`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Entrega_Doc_Parcial_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  CONSTRAINT `fk_Entrega_Doc_Parcial_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_doc_parcial`
--

LOCK TABLES `entrega_doc_parcial` WRITE;
/*!40000 ALTER TABLE `entrega_doc_parcial` DISABLE KEYS */;
INSERT INTO `entrega_doc_parcial` VALUES (1,'2023-10-01 07:00:00','2023-10-05 23:59:59',1,1),(2,'2024-05-01 07:00:00','2024-05-06 23:59:59',2,2),(3,'2024-10-01 07:00:00','2024-10-06 23:59:59',3,3),(4,'2025-06-23 07:00:00','2025-06-24 23:59:00',4,4),(5,'2025-06-23 07:00:00','2025-06-24 23:59:00',5,4),(10,'2025-06-23 07:00:00','2025-06-24 23:59:00',10,4),(11,'2025-06-23 07:00:00','2025-06-24 23:59:00',8,4),(12,'2025-06-23 07:00:00','2025-06-24 23:59:00',9,4),(13,'2025-06-23 07:00:00','2025-06-24 23:59:00',7,4),(14,'2025-06-23 07:00:00','2025-06-24 23:59:00',6,4);
/*!40000 ALTER TABLE `entrega_doc_parcial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega_reporte`
--

DROP TABLE IF EXISTS `entrega_reporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega_reporte` (
  `ID_Entrega_Reporte` int NOT NULL AUTO_INCREMENT,
  `num_reporte` int NOT NULL,
  `fecha_apertura` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_Entrega_Reporte`,`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Entrega_Reporte_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  CONSTRAINT `fk_Entrega_Reporte_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_reporte`
--

LOCK TABLES `entrega_reporte` WRITE;
/*!40000 ALTER TABLE `entrega_reporte` DISABLE KEYS */;
INSERT INTO `entrega_reporte` VALUES (1,1,'2023-09-01 07:00:00','2023-09-07 23:59:59','2023-09-05 14:27:32',1,1),(2,2,'2023-10-01 07:00:00','2023-10-07 23:59:59','2023-10-04 09:52:13',1,1),(3,3,'2023-11-01 07:00:00','2023-11-07 23:59:59','2023-11-04 19:48:21',1,1),(4,4,'2023-12-01 07:00:00','2023-12-07 23:59:59','2023-12-02 10:22:45',1,1),(5,1,'2024-03-01 07:00:00','2024-03-07 23:59:59','2024-03-01 22:10:03',2,2),(6,2,'2024-04-01 07:00:00','2024-04-07 23:59:59','2024-04-01 18:44:27',2,2),(7,3,'2024-05-01 07:00:00','2024-05-07 23:59:59','2024-05-06 08:17:07',2,2),(8,4,'2024-06-01 07:00:00','2024-06-07 23:59:59','2024-06-07 12:45:56',2,2),(27,1,'2025-06-15 07:00:00','2025-06-22 23:59:00','2025-06-22 18:50:43',10,4),(28,2,'2025-06-23 07:00:00','2025-06-25 23:59:00','2025-06-23 21:33:02',10,4),(29,3,'2025-06-26 07:00:00','2025-06-27 23:59:00',NULL,10,4),(30,4,'2025-06-28 07:00:00','2025-06-29 23:59:00',NULL,10,4),(31,1,'2025-06-15 07:00:00','2025-06-22 23:59:00',NULL,8,4),(32,2,'2025-06-23 07:00:00','2025-06-25 23:59:00',NULL,8,4),(33,3,'2025-06-26 07:00:00','2025-06-27 23:59:00',NULL,8,4),(34,4,'2025-06-28 07:00:00','2025-06-29 23:59:00',NULL,8,4),(35,1,'2025-06-15 07:00:00','2025-06-22 23:59:00',NULL,9,4),(36,2,'2025-06-23 07:00:00','2025-06-25 23:59:00',NULL,9,4),(37,3,'2025-06-26 07:00:00','2025-06-27 23:59:00',NULL,9,4),(38,4,'2025-06-28 07:00:00','2025-06-29 23:59:00',NULL,9,4),(39,1,'2025-06-15 07:00:00','2025-06-22 23:59:00',NULL,7,4),(40,2,'2025-06-23 07:00:00','2025-06-25 23:59:00','2025-06-24 19:30:46',7,4),(41,3,'2025-06-26 07:00:00','2025-06-27 23:59:00',NULL,7,4),(42,4,'2025-06-28 07:00:00','2025-06-29 23:59:00',NULL,7,4),(43,1,'2025-06-15 07:00:00','2025-06-22 23:59:00',NULL,6,4),(44,2,'2025-06-23 07:00:00','2025-06-25 23:59:00',NULL,6,4),(45,3,'2025-06-26 07:00:00','2025-06-27 23:59:00',NULL,6,4),(46,4,'2025-06-28 07:00:00','2025-06-29 23:59:00',NULL,6,4);
/*!40000 ALTER TABLE `entrega_reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadistica`
--

DROP TABLE IF EXISTS `estadistica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadistica` (
  `ID_Periodo` int NOT NULL,
  `hombres_sector_privado` int NOT NULL,
  `mujeres_sector_privado` int NOT NULL,
  `hombres_sector_publico` int NOT NULL,
  `mujeres_sector_publico` int NOT NULL,
  `hombres_sector_social` int NOT NULL,
  `mujeres_sector_social` int NOT NULL,
  `num_hablantes_idioma_indigena` int NOT NULL,
  PRIMARY KEY (`ID_Periodo`),
  CONSTRAINT `fk_Estadistica_Periodo` FOREIGN KEY (`ID_Periodo`) REFERENCES `periodo` (`ID_Periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadistica`
--

LOCK TABLES `estadistica` WRITE;
/*!40000 ALTER TABLE `estadistica` DISABLE KEYS */;
INSERT INTO `estadistica` VALUES (1,11,4,0,1,0,0,0),(2,9,4,2,0,0,1,0),(3,10,3,1,1,0,0,2),(4,8,2,1,0,2,1,1),(5,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `estadistica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiante` (
  `ID_Estudiante` int NOT NULL AUTO_INCREMENT,
  `matricula` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `genero` enum('H','M') NOT NULL,
  `correo` varchar(50) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `semestre` int NOT NULL,
  `promedio` float NOT NULL,
  `habla_idioma_indigena` tinyint(1) NOT NULL,
  `ID_Proyecto` int DEFAULT NULL,
  `ID_Usuario` int DEFAULT NULL,
  PRIMARY KEY (`ID_Estudiante`),
  UNIQUE KEY `matricula_UNIQUE` (`matricula`),
  KEY `fk_Estudiante_Proyecto1_idx` (`ID_Proyecto`),
  KEY `fk_Estudiante_Usuario1_idx` (`ID_Usuario`),
  CONSTRAINT `fk_Estudiante_Proyecto1` FOREIGN KEY (`ID_Proyecto`) REFERENCES `proyecto` (`ID_Proyecto`),
  CONSTRAINT `fk_Estudiante_Usuario1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES (1,'S19287321','Victor Aguilar AlvarÃ©z','H','zs19287321@estudiantes.ux.mx','21785631',9,8.4,0,1,NULL),(2,'S20827776','Maria Fernanda Dominguez','M','zS20827776@estudiantes.uv.mx','2267469088',8,8.7,0,2,NULL),(3,'S20349810','JosÃ© HernÃ¡ndez ZacarÃ­as','H','zS20349810@estudiantes.uv.mx','2254891021',10,7.6,0,3,NULL),(4,'S19834121','Diana GÃ³mez LomelÃ­','M','zs19834121@estudiantes.ux.mx','2187432149',11,9,1,4,2),(5,'S20432114','Jorge Ramirez Morales','H','zs20432114@estudiantes.ux.mx','2287609842',10,8.7,0,5,3),(6,'S19824523','JosÃ© Vicente Carrera','H','zS19824523@estudiantes.uv.mx','2081649822',11,8,0,9,NULL),(7,'S21894511','Ester SÃ¡nchez DomÃ­nguez','M','zS21894511@estudiantes.uv.mx','1987029843',10,9,0,11,13),(8,'S21890657','Juan Perez Fernandez','H','zS21894511@estudiantes.uv.mx','2176491021',10,8,0,4,10),(9,'S19327102','Daniela Garcia JuarÃ©z','M','zS19327102@estudiantes.uv.mx','2287105478',11,9,0,11,NULL),(10,'S22087162','Lucio Salazar Venevidez','H','zS22087162@estudiantes.uv.mx','2398764512',9,10,0,10,12);
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expediente`
--

DROP TABLE IF EXISTS `expediente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expediente` (
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  `estado` enum('Activo','Concluido','Cancelado') DEFAULT NULL,
  `horas_acumuladas` int DEFAULT NULL,
  PRIMARY KEY (`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Expediente_Periodo1_idx` (`ID_Periodo`),
  CONSTRAINT `fk_Expediente_Estudiante1` FOREIGN KEY (`ID_Estudiante`) REFERENCES `estudiante` (`ID_Estudiante`),
  CONSTRAINT `fk_Expediente_Periodo1` FOREIGN KEY (`ID_Periodo`) REFERENCES `periodo` (`ID_Periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expediente`
--

LOCK TABLES `expediente` WRITE;
/*!40000 ALTER TABLE `expediente` DISABLE KEYS */;
INSERT INTO `expediente` VALUES (1,1,'Concluido',420),(2,2,'Concluido',420),(3,3,'Concluido',420),(4,4,'Activo',0),(5,4,'Activo',0),(6,4,'Activo',0),(7,4,'Activo',7),(8,4,'Activo',0),(9,4,'Activo',0),(10,4,'Activo',257);
/*!40000 ALTER TABLE `expediente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiencia_educativa`
--

DROP TABLE IF EXISTS `experiencia_educativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencia_educativa` (
  `ID_EE` int NOT NULL AUTO_INCREMENT,
  `nrc` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ID_Periodo` int NOT NULL,
  PRIMARY KEY (`ID_EE`,`ID_Periodo`),
  KEY `fk_Experiencia_Educativa_Periodo1_idx` (`ID_Periodo`),
  CONSTRAINT `fk_Experiencia_Educativa_Periodo1` FOREIGN KEY (`ID_Periodo`) REFERENCES `periodo` (`ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencia_educativa`
--

LOCK TABLES `experiencia_educativa` WRITE;
/*!40000 ALTER TABLE `experiencia_educativa` DISABLE KEYS */;
INSERT INTO `experiencia_educativa` VALUES (1,15037,'Practicas Profesionales de IngenierÃ­a de Software',1),(2,15037,'Practicas Profesionales de IngenierÃ­a de Software',2),(3,15038,'Practicas Profesionales de IngenierÃ­a de Software',3),(4,15038,'Practicas Profesionales de IngenierÃ­a de Software',4),(5,15038,'Practicas Profesionales de IngenierÃ­a de Software',5);
/*!40000 ALTER TABLE `experiencia_educativa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficio_asignacion`
--

DROP TABLE IF EXISTS `oficio_asignacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oficio_asignacion` (
  `ID_Oficio` int NOT NULL AUTO_INCREMENT,
  `ID_Periodo` int NOT NULL,
  `ID_Estudiante` int NOT NULL,
  `documento` longblob NOT NULL,
  PRIMARY KEY (`ID_Oficio`),
  UNIQUE KEY `uq_estudiante_periodo` (`ID_Estudiante`,`ID_Periodo`),
  KEY `ID_Periodo` (`ID_Periodo`),
  CONSTRAINT `oficio_asignacion_ibfk_1` FOREIGN KEY (`ID_Periodo`) REFERENCES `periodo` (`ID_Periodo`),
  CONSTRAINT `oficio_asignacion_ibfk_2` FOREIGN KEY (`ID_Estudiante`) REFERENCES `estudiante` (`ID_Estudiante`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficio_asignacion`
--

LOCK TABLES `oficio_asignacion` WRITE;
/*!40000 ALTER TABLE `oficio_asignacion` DISABLE KEYS */;
INSERT INTO `oficio_asignacion` VALUES (1,4,4,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1577\n/Filter /FlateDecode\n>>\nstream\r\nxœµWko\Û6ı_Á\ëPd’ø²€`€FQi€4\nle\Ã\öM\Õ.C\ëd¶3 û\õ»’’l§C€\rHl™\Ï{\Ï=\çú©;û¡\ÉE‹\î\ãY®Îµ\è®\Ït&l–‰n}v¡&7\Î\ä63yQ+m¼-|ms«¶U\áŠLx*`”´…\rm06“…Tğ¤Œ†\Ï\n\Æ{Sš&¶@/ş\ëE\÷\ÇY\÷=ş](§J%k\â“Vª\Ñ<ÁjZª\\y%\ÕÂ•º*2¥¬3 FZ\ë*®\õİ¥_u\í²µ·\Ë\öW\ïºv\õ&vÖ·]{]µ_U\Ëe{}\İ\â¯U·lo.©–>›Äª½¾sW\í_‰U\\(i\Z\ã0`\É5¹i¬„\ç\ÒÀ\'ş’ Ã¤Â}\0˜¶\n@\Éi~Sx™K“\0\ä!c\ÈOgŠW^®Ö¹\Ö\nre\äá©€QùSh\Z·ºÚ€¼„\ğ$·™…\ñƒ‡\í¡\Ï*«¥\í\Âf<†—C¥r T\ZH±0´ÇŠ§U©¦\Zfzä¢UsL\Û`–¡¡ş4\Ï14°vJZq@!d\ß¹04\Â\r7¶†É¤‘Š\Ô\Ç\ÛcxfX˜)¦65×†G2\0FR8\r\íT\ãz@n…ezÓÓ¦\n+$\"P°µT5•)\Ø\à³r®Ni`~Œ)&A\Ë\êi¾8\í\ÅD),ø®©S„py––@‘R.¤”\n\n™\Ç$©¥¡\ğyx¶„uhÁD¨²\ÅD%\'Š%Õ¬®VOªq\í\rpÿZ¼»ª—\ím{s\åÚ·¢»g±~ø´y\÷ı\ö\Ó#4<\õ\Ûı\ÃV¬‡\Ï\"_À—ø8|\Ø\ÛGjy\Ú»a³’~\ïwû^\Ü?\Ø\Â`›x\"]\×Ä—asÿ\ğ¸\é·\â\Ï\çAÀ\ôa·^?\ô°\0Luú$»„a\ÜBN\ÖS>\Ú2\Ïf$Fx\ğ¯< ì˜Ÿ&\ğ\Õ\ZB\ñbnZY\"®ò†¹…Ox6\0F\å0Ò¤\"™*\ŞP\õ\ê	¹B/\ë\ê\ß`Æ…úÁX9f\ì\\\ÆX×º\á‘S7MÙ~)\ãr\Â-\ê1\ÈGI€\ÙBk\Ê\ä\ñ~u\î×b=\Â‹¥\Û\îú\r´B\İ{ª\Ón\è”ùi\Ø\ã\à¯bÿø†M¨™\è?e\rN¡3¹)\ĞP\0r\ö­dQ\Ûd\"¥­Mµ\çft¢¬:\Ã\İüTL\Z¦•\Ö\èG6:/	‹˜\ÈÁ¤«} \Û2\æ\\\ÊZ\"\n\ä`S\ë5™²Á2\"I\'6H}\Ûw\\‚³!\Ès\ÈÁ\ÔJ\Ó\×a“šFG59>À\ØŒÁÿ*®I+9\Z—\à \İO\Ä6N\ÂKø¼@\ö\ä\Ë()D¤$Á;ÃŒ‚NDO‰Xw\Âq²º;6xº\ğú)(\Ô~ ›…­\äT£a	|#im\Ä)”úÈ—|S¡ŠitLT\Æ\äøxC,O“S±K•\äM\rL\çL\ö$Š#\ó#\í\å\ói1\İQ	H–¯´,À(fÍ\ÅX¥x\ôC2@¦É±\æ3½\Úc½†{’Mªÿ·¥iM\Z\áT\ÙVƒ¸œ¨5vœQC\Ñp\Ù\ìi½i!¹\ì’HŒ)¸-ÿC\à0\ò(n\Ò±\õDI–)q7¶¢½4\0e\÷\ç\óF\Ò*.<\ó\Ü,D˜\åA=l\"\æ	£t„†[\Ô\åx\Õ 3\Ğ<ß¬;¢®‡Š\0\Ï\É\ì \ÄS\Ö\Î=¯ºTUd1!;ú\áx\ã\à\Û±m	t\õ’\'\Ú\ó¯\÷\âpk£U“¦G%{rh:+\éB½4q¿	\õÁ\î¸Ï Q¥\ËÇŒ\\Á\ì®·\"2½¦¶vU\'³K\Ê	¥‡$OÌ“#\â\èLš9))Oƒ›Ò¹@)VW\n´\Â\æÓ™À)’*‰l\' ßœm1\Ù\á˜E\Ç\Z“\ò£\Şm¼Zp\r\ç#–\rŠ‡7\ê †ÿ\Ä]ºÛnÏ­’y\êC¦ApùÁ-´F0\n4‹J\Ê\ò\Ä\öF\Ò;Ÿ&[˜œF˜bµ\Çk\Ş¼\ç¿}3i\ß-«sqyW\Õ\Õ\õİ­\ï«ewu\ãÃ·‹+x›®ıü-zúZ©8Q¶£Q,$d\Ñq¡^w\×û_^6\î6\r\Û\İÃº_‹Ÿ‡m¿}ş»\ß\ğË‹\ï\Îş\à\÷\İ\ç\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001899 00000 n\r\n0000001932 00000 n\r\n0000001963 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<FBD92506CB97B721AD6891E140C22626> <FBD92506CB97B721AD6891E140C22626>]\n/Size 8\n>>\nstartxref\n2060\n%%EOF\n'),(2,4,8,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1577\n/Filter /FlateDecode\n>>\nstream\r\nxœµWkO\ãFıÎ¯˜\İjEm\Ï+–P%w<f‘XŒÓªıfˆw›j	\Ô	•¶¿¾\÷1\ÛI\Ø\n©• q\æy\ï¹\çœÿÔœıP¥\"ME\ó\é,U\çZ4\×g:6ID³>»\Ğ“\ZgR›˜4+•6\Şf¾´©\ÕF\Û\"sY¢\r<e0J\ÚÌ†6›\ÈL*xRF\Ãg\ã½\ÉM5´@/ş\ëE\ó\ÇY\ó=ş](§r%3k\â“Vª\Ò<ÁjZªTy%\Õ\Â\åº\È¥¬3 FfZ\ëbX\ë»K¿j\êe!J/n—\õ¯\Ş5\õ\ê\İ\ĞY\Ş6\õ9v•~U,—\õ\õu¿VÍ²¾¹ü¥Xú8rl«úú\Î]\Õ7~%V\Å0\àBIS‡+H®JMe%</\n>\ñ—$\0&­†\Ô\àx\èÀ´U\0JJ\ó«\Ì\ËTª!	@2†üt¢y\åu\æJj­ WF2u?…¦q¨ \r\ÈKOrK–X\Ø?1x\Øú¬‚À°Z\Ú.lÁcx)T*\å\È\0J¥‚3ƒA{¬x\\•jªa¦G(Z5\Å\ô±\rfZ\êO\óC¸kÇ¤B\Æ\ğ-‘C#\Üpck˜L\Z©H}¼=†g`†…yqAajSrmx$`$…S\ÑN%®\äVHQ¦7\í\é0mªpÀ1%‚]\r¹È©Ô¤˜#ãŠ‰\Ğ\Òzš3²\÷\Õd)4ø.©Ó„y–– ›T.d\n2Rƒ\ìB¢T\Ó\ÜP\nˆ><[\Â;´`2T\İ\Êb²’“Åˆ¢rVW«\Æ$\å¸úø->\\•\Ëú¶¾¹r\õ{ÑŠİ‹Xo>oŸ\ÄC\Û~‚†\ç¶\ßoz±î¾ˆt_\âSw\ßwıµ<\÷İ®\Ûî»¨©\ß\Ûİ¾/\÷=\ÌÆ‰ \ÔÕ¹p\í}\'»\í\Ã\æi\Û\ö\âÏ—NÀ\ôn·YoZX\0¦À:m”^Dˆ0~!/\Ë)\'m>\Ğ&$Hx\ğ¯4 ì˜£&p\Ö\ZB\ñb~jY\"®‡¹™xV\0F\õ0Ò¤$+^Q\õ\Ê	ÁB/k\ê_aÆ…\Z\ÂX9f\ìœ±®u\Å#§\Z³!\rS\Æù„[\Ôc’\\³…Ö˜\É1\â\í\êÜ®Ÿ\Äz¶„¥\ëw\íZ¡\î-\Õi×µ\Êü\Ü\íq\ğW±zÄ‡nj&\Ú/c\Ù@‡S B\èGj2´”€œ|+Y\Ô7In‹c#B}\æ\óC:QV\à\î~*&\rÓ‡J\ë\ô#+—„EL\ä`Ò•>­\óNe-r±©ıšŒŒ\Ù`‘¤›\0¤¾\í;.\ÂY‘\äŒ9d‘\àj%„\éË°II£59>\Ä\ØŒÁÿbX“Vr4.\ÂA»Ÿˆmœ„\ñy…\ìÑ›QRˆHN‚A‡\Æ\nˆC\İ	\Ç\É\ê\î\Ø8††×A¡\ö\İ,l%§\Z\rK\è\àQk#®H± \ô\ØG¾\ä«e€TŒ£‡D\åqˆ\åir*v©œ¼©\â‘\ñœ)\ãDq„`~¬½~> Æ»@ *\É\ò•–8ˆY³g1V1=ÁÂir¬ùL¯\öX¯\á®d£\êÿmiZE“F8U¶Õ \'.\'jg\Ô\Ğ`¸l\ö´Ş´\\vI¤\ÆÜŒ–ÿ!p\é n\Ò±\õDI\æ1q7¶f¢½4\0e\÷\ç\óF\Ò*.<\ó\Ü$D˜fùA=¬\Ì#F\ñ\r7©\Ê\ÃUƒ\ÌB\ó|»b\ìˆN¸RhpüxN`!²v\îy\Ó\ñ¤ª²£7¾M\ëÙ–@AQ¯\éq¢=ÿv/·6Z5jzT²\'‡¦\ãá°’.\ÔK\÷«P¿\éû\ZU¼|\Ì\ÈÌa\áz+\Ò!\Ókj{a·P\åùq2»¤œPzH\ò\Ô\É<9\"Î¤™“’‚\ğ\ğ4¸i ”buÅ€@+\ìa>Ş˜Iœ<À ©’È†p\ò\Í\Ùf“Ytüp¡1)?\ê\İW®\áüb\Ä\ò±A\ñ\ğV\ä\Ã\ğŸx«‹wûÑ­‡s+gúi\\zp-‘\0ŒÍ¢’²<±½’\ôŞ§\É&§¦X\ì\ñš\÷ˆ\÷ü\÷\ï&\í›eq..ïŠ²¸¾»\õ\âc±l®nüoøvqoÔ¥Ÿ¿IO_-U\0gm\à\è 2‡\è¸Po»\ëı//œ‘w\Û\Í_]¿Û¬Ûµø¹\ëÛ‡ş\å\ïv\Ë//¾9û»µ\Şx\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001899 00000 n\r\n0000001932 00000 n\r\n0000001963 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<A620A276876705DC6F5F0E57042904A8> <A620A276876705DC6F5F0E57042904A8>]\n/Size 8\n>>\nstartxref\n2060\n%%EOF\n'),(3,4,1,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1549\n/Filter /FlateDecode\n>>\nstream\r\nxœµXk\ÛDı¾¿b>¶\çK«JflPRø\îv\rm³%\É\"Á¯\ç{g\Æv’­XR7q\æq\ç>\Î9sİ¯·7_\rZi­¶?\ßhûÊ©\í›W©PUj{ws\ë6^û\èu¨¼®;\ë|\ê¾:8\ïB[ÇºrjZeB\Ò­­Lm=Y\ïè³¥\õ½oüGh\îµ\Úşv³ıÿnm´5uO6+\ë¬uµ¥\õvc=\õQ\Û\ŞÒ ke\ŞÕ±qm\Şÿ\â»~\èU×¿Q\íÛ¾U\Ûo\ã\Ë4sk5mw–\\\"›8 ‚\ñ\í06\àHŒa™¥ƒœ±\rÏ¤qk\ì@v¬k­–gr–¾y]o£\ÚR®\È\Ì\ÂÄ¿7ı\"\÷\÷“\Ò^\İM\ê\İ\ôé´›>¾?L\êû‡Wu(aº\r\ï\Ô\ğ¡–\Ó\ë\Ø9\í\çŒ+Å™¤S\ÈG7ç½§ú nªC•2¾ŒŒ\ÔU0Á\á\Ó„„sÁR=-Íº°	U\ßÑ¬¦\Êj\Ù\Ä 2\Ú1Ğ¬¥]=R¬2\í\ì\ËVu02F»<[$¼\ğ¾ˆ_Kd{Nº8”\\†ûÁ\×p\ÅÁÁø \Ësr<\Ü\ó´#\Ğ>\n»a7\ï\È\ñr¤$Àvg\à“:\Ø#2X@Z\èÀgUa¬¡Ğ®¦1M9\ZA\äw¤z\r\â[\Ä)¹E0l\Ş-ã¦O\Ì\î\ÑwÇ£•Ü–]\Îm\Z\â\Û\ÆC´4:\Ëum<‡\n\Ğs\àœ§\Ä60<*N3 ©#\Ğ\ë¬{\Ç$®]%A\\BŒ\Ã\Æ\ñ‡ƒªqN\à7 jq\0®QXUI\Æ\×\Æ:;Y\Üœ¤^\Å\ñ¿\ÇÓ¨><¾?\ìŠĞ¬¾ù\ámûî•Š\ãûI}œ\övû\ñ ~œ\Ôt¯¦\ã\é\ñn7\îOm™\ö§±0¯dsMn\0\ó\İ\ï¡\É\à»\ç)Ğ˜ƒÊŒaÀ%>\ÏUAû	¶F+ƒ\ÆŞº/\á,RH\ÌÌ©T%$\rŒŠn\Ş4+|f\\\r˜ƒ_\à\'V\0‚0:¹É¾xÁ\Ğ +—\ê^¢a}\àˆ›fy\Æ\ç†\Ñ\Òh‰\ä2\ã\ãq\÷\Ë~¼{PGš\Ùsş(\İ\á8\îi\ô\ÓH¿°\ë8\ê0?M\',şS>\âaÚ§š©\ñ~.q|™ˆäº¤Cû\Z²ª1\Ş>,\Ğ\Å\"Õ„\öR\ä€\ì,l\Ï»+euN¯\ñi4…¢]\Ñ_\È\ôº$\"]\×\'Ğ‰\ì#î¢‚!ÁY`…\\J{\â\Ç ]\Èe\ê\ózK:\æY!‡\å—(kW©$7û.\Ò\ñ\êÌ¦»%Ùœ¿6\ÛdK‘\×Ù¥,\\\ómvœ‰W\ò\óØ‹\îƒR\ÈHÃ„\ánZ\Ä7²…[(×\ó¸°/…#\ß^b¿8\î\'¸:\Ê,9šL¸¤…ks^±\Ä\ô2Çº\Ô-h0‹\æ\"P“ƒ“\ë¹¼N+*Õ°6\r²²\Ü_]9“!¬¯Ì§\ï½9‰g2.‰ú\ÂC\Ô8“Ù‰fI®Š?n‘\Ï4\0\Ò\æn\Í\×p\ÉWÔµH\é?1\ÍVsDBYM|’r‚k¢83‡²\àŠØ³½e!¥\ì†\È\Ì!\Ä,ÿA7t&7\ó‹\Ñ>qM	<Î£\õ†ao|¤„Šú\Ë}c\ØJLÏ²·J\êº9«Ç™ƒC\Îy\ÉQ¹BS±\ÊrnaXLÈµ^:7\É\Ã	\ö\0¡¬øg\é¹z¹xM\Úe\æY\í\çUVesfg=œ;\é\Ò\õ\"KÄ‹Ä¨§ø¸\à^ÿ|-N\İ [-œ™Ü³B\ó\õp^É˜\ê\åûCª_r†y\'sBUš¸’\ØIZr\Ï\Èû^K\ÙK§¥*¯¯“U“r…\é)\Èk7\óâŠ¸¸“VJ\Ê\Â\å\éqh]Lv‡ˆ+¢a}\éÄ™)9MJƒ\áJ\r\é”<Ô‹.Qtù@-;¸9\ó=\ä\ÖBj¸nŒ„>!1\Ş\ğ}$ıW\Ş¯5\İ	Å\à´O‘&\Â\é³.´\0$¼‹K*\ô\Äø`øÒ±,,n#„Ø\Ğ\æQ\ó~š¾|¹|¿µ\è•\ë*\ê\ÄH¼’´Á\õÌ½€ÿS0½\÷F~[\á¥g\ç\÷\Í\óWZ›—)\ğ›‰\Ä$\÷£\ñy}\àÿ\ò¢[\ò\ã~\÷\Çt8\î\î\Æ;\õ\Ót?ÿ\Z\÷\òb\Óooşb}\ô\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001871 00000 n\r\n0000001904 00000 n\r\n0000001935 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<DE437A980FFDC83E010F3AF3BD962036> <DE437A980FFDC83E010F3AF3BD962036>]\n/Size 8\n>>\nstartxref\n2032\n%%EOF\n'),(4,4,2,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1527\n/Filter /FlateDecode\n>>\nstream\r\nxœµW\Ùn\ÜF|\×WÌ£\n9§6\ä0¢X´\Î;-1±k\å\ìÀùzwu\Ï¹‡ŒH`{M\Î\Ù]]U3üay\ö]_«ºV\Ë\ß\Ïj{\î\Ô\ò\ê\ÌU*T•ZŞŸ½q¾\ö­¯C\åk\İY\çcĞ±upŞ……nu\å<=i\Ze‚©\ÆVFCO\Ö;ú]\Ğø\è\ß\ç\ê\Å?\÷½Zşy¶ü_]¾ı\ñ\\\õ7‹·\í\åm»P\İ5=.\ã­ê¢ºº~w\Ó\Å\Û\×i\ô««\Ë.Ş ƒ\Z77\×WW×¥¯ûuy}^úĞ…—_.»\î*.\ã\Ïe\ÜqKû\ô\ñi\õ0¨›\ñ\ó¸Q\ín\Øm?ŒOw\ê\í\î\ñ¼\Ö:$Tlm[[»\Ê2*6:\İv®v\Î:—P¡\'M£ŒÓ\Úfy¾ŠÀ(„Š\ñMo¤EWÁ‡_\ß\ê\rú‚%\ì,\õºp*B\ÚQoM(\Ö2\ÕÑ•ÅŒz-ÍŠ¨FY•\ñv43¢F–W­ƒ‘6š\åyEª\r\Ïk\ñV\êFk\ç\È\ßX	(…Œ\ğ¡a#‹ƒ—B;Ğ„ûd{„\çiF y”“\ä‚\Ãt¾£ÀË–€7N\Ï;uXˆgA¡\ï\Ù\"m;*…¶|$è£µ\ÜbmO#\ZzR ’r|‘o\á\æ¹\Ó\ä\ç“\æ\éÿ[‘.….³œa~_\Ğo\à?>\'Ìµm<§‚*\Ğs`\ÜS’\â*\÷II\Z• ±3\Î\íº”…K %Z\ê\íŒ*DQ DDm˜¢\×\Îi\Æicû\ÓAe‚„ \ğº- 4S›¦\0D\Ä\ñš	©s%|PJjV\õa\Ølu·{¿~X+b´ú‰~{®\Ú\áı¨\Ç\Õ\İ\Ã\ÓjX«¿v£\Z?ªq³\İ\İ?«\íHS\Æ\Õv(\ê+\È3\Öx\ß\Í9šLPqxmsRY5Lº¤‰\à¹*¨ƒ\ğ?Q—\Ó\è°J_c®%%\æ@:aUbRÏ¬\èfN½¢i\æU>\Äb!£›‹\õ2r\î¦%\öÎ¸™q–{<xn\Øu-µ–L6¬†û\'µ¡\ã¿F\éÖ›aE­ŸzÃ¬\Í8¨\õ¸ù4n1ø³\Ú>=\âa\\¥š©\á\ãT6\ÒùˆºÀQ{\r\ëÔ˜o_I\ìb£j\Â\â\Ø\èÀ\ìln/0¼euv\×øµBš¢	\ÑQë¬z¿$bL!]\é\Äú‘wqÂh	\Ø%\ç\öt\Å1Ig\öCH}\İ\Ï\Úg\Ï:0{\Ìa&\É\Ú=()\ÌØ¥M:\Õ\Ôb\İ6\ã\ño‘\×\ä•Zg\ç¶p*¶)p^Á\ç²ï‡¤€HÃ‚\×a;\ÄG`®;\ã8[½=6|‚\Éú%(h?\Ñ-\ĞVf®Ñ´„K¾Q´6\á\nŠ%¥—>\ö¥\Ø/ ƒ\É4g‰šœœ¡À\ò49­¸T\Ã\Ş\Ô\Ë\Èr~ueO¦8 \Ø?6Ÿ?\÷&l\\€ù\"B\Ô8‹Ù‰g	V%7\ÃÂ³À43\Õ|O¯\áX¯¨k±\Ò³4¯\âX#’ª\ØjÒ“”ZÇ™4”\rWÌ×›R\Ên˜Á”B»G\Ëÿ\Æ$Œ:‹›\õ\Åì€8É¦$\ŞN­ú‚io|K€Šû\Ëycx•6=\Ë\Ü*EX\ë\æ \ö\ó‚Q9B\Ób\å|…a3¡Ğ¢\Ü\Ş;¦\Ö…²\ãÀs\ò\0;\ñ”µKÏ‹® \'U•Y\Ì\ÈN~8\İ8\ä–Æ¬[\"]$E=§Ç™\ö\âË½8\İyÕ¢\éIÉ‘š‡\ÃJ¶©^¹ß§ú¥`Xw\Ò\çaT\å\ò±G®dvK¾3\ò<¦\×\Ü\ö\Òn©\Êû\Ç\É\Ş%\å„\ÒS’§N\æ\Ùqt&\í9)+‡§Ç¦‰tm¢”¨«DZ‹\å&ÎŠH\à4	Ã•\Ò	(7\ò g;³\èø®\ì\Ğ\æ¤\÷¯R\Ãı‹‘\È\'$\Å\Óu’À\â«\ñÔ¥;±¸Æ”i\\}p\í@\0AgqIEh\ï\rW:¶…\Ùi„[\\\ó\è\ò¾¿}=ÿÆµ¸+ëª­“\"\ñ)².²\ö\ÂzŒb\Ü\ònE—š¾9?km.K:\ñ7‰E.\á·RÄ—\İÿ—\İÂw«‡¿\Ç\õ\æ\á~¸W¿\ë\án½ûgXÉ‡M\\}€\Ë\Ü\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001849 00000 n\r\n0000001882 00000 n\r\n0000001913 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<0F8E3A51917350EABDE31EF4A864FA08> <0F8E3A51917350EABDE31EF4A864FA08>]\n/Size 8\n>>\nstartxref\n2010\n%%EOF\n'),(5,4,10,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1524\n/Filter /FlateDecode\n>>\nstream\r\nxœµW\Ùn\Ü6}\÷W\ğ\Ñ)\nW\âjF•¤R£;û\Ğ7\ÅV›)\ìq:K\ä\ë{’\Ò,	j <c\r\×{\Ï=\çúiq\öCW‹º‹\ß\Ïj}a\Äbvf*\áªJ,Ï®Ì¥­­·µ«l-ƒ66:ƒ«±Æµ\Ò\Ë\ÊXx’0J9\éRŒ­”T\Z´5\ğ\İ\Âøh\Û\å\èÅùQ,ş<[|‡\ç\×7o/D7ooü\õoE¸…\ÇE¼!Š\Ù\íı<Ä»7i\ôù\ì:\Ä9v@c;Ÿ\ß\Îf·¥/¼_\Ü^”>\ì\Â\ï®C˜\ÅEü¥Œ;n\ñ/O/«e/\æ\Ã\ça#ü®\ßm?\Ï/\âf\÷|QK™*º\Ö^×¦Ò„ŠFú`jc´1	x’0Ji m’\ç¢ˆ9@PQ¶\é·\È\Ê)g\ğ\Ûv€zƒ}Nvˆ¤q—®¤\r\ôÖ€b\Í3°:²\Ò8£ƒ^\r³\"V£¬Jx˜±FšV­\â6˜eiE¨\r\Í\óø«\Ô\r\ÖÎ‘_i(…Œ\á;*<††i\Ü\ØY.´AšPo\áY˜\á`¤@$¹¤0\rxÙ’°Š\Â\éh§€\ë\ñ4Ò‡©G{zL[\â\Î€Wº\Ñ\î”J\Ó\ÂGr!t„bX\è\×zRŠ+Ì”\Ñ\Åth3\Íşj\Ê üÔŠ\ÉB\à<\Ë(`6\òûR9U+«dN—*\ÛXJk\0ÏPO-˜Õ¸s˜²\â”1¢4\ä\×e 4†O\ğ]SKD‚ÒˆÉ¥\î¨\Í3³,¾:m\İQ*X\Ç!`\0ø‰\â$oa)Y \ÂXID”9¼8R‰kUB>ÿ\Øo¶½x\Ø}X/\×˜,~e\ß]\ß\Ä\ó°zX¾¬úµøk7ˆ\áI›\í\îqÙ¯¶LVÛ¾¨®`N(C\È\÷0\åºk21\\E\áYH\Óç”²ZˆlI\ÎR=°\ÌûDYJ#\à*]se,\é”x4pU™c>%uÄ‡0!n\êe-£:\ìÃ¸P›8¹ÀÜ‚›‹e\öt<r\ê¢%\òÊ¸™°•z,2\\‘\Û`¶\ĞZ29F¼\ß,ÿX\õ/b=+\Â¥[oú´~\ê\á\Î\Ú½X›O\ÃÛ—g|V©f¢\Z\Ëú‘Bg8j+\ÑrPdÄ¶o$‹\ì\"ƒj\\{lp\È\ëlj¯0ºe5\î.\ñ[3iŠ\"Ø·¼=²\èı’°-9˜t!&Ò±\åc\Ş\Å]¢%¢@\î8µ\õ¤3T‘tb<€Ô·\Ì8;Ò\ÚcY/HV\ïA	aÆ6	4:«\É\ãºl\Æ\â§\Ík\ÒJ\Æ\é©-œŠmœ„W\ğù\nÙ‹ç£¤‘†ƒ.‡3È‰P@t\ô\åº“\Õı±qä“‹\×/A¡\ö\İl¥¦\ZMK˜\äEk#®H±¤\ô\ÒG¾»e0š\æ$Q•“\ã£±<MN\Í.Õ7u<²œ\\¡\ìIG\öË¯Ÿx#ˆ6\Î@²|1B¬q³a\Ïb¬J<f‚…% \Ó\ÔX\ó=½ºc½b]‹•ş›¥iC\Z\áT\ÙV“¸œ¨5vœQC\Ùp\Ù\ìi½i!¹\ìŠHŒ)ø=Zş7†Àa\ÔYÜ¤/bê‰’lJ\â~l•—D{e=\0\Ê\î\Ïç¢U|z\æ¹UŠ°–\ÍA=\ì2\æ£r„¦\Ä\Êù\òBf¡E¾µ1vD\'\\)”ÿ\0“\ØAˆ§¬{^u\õ<©ª\ÌbBv\ô\Ã\ñ\ÆÁ\÷3b=Û’\ã[\İ7\ô8\Ñ^|½§{ ­Z4=*9’C\Ó\ñpXIŸ\êeˆû]ª_\n†t\Ç}ª\\>\öÈ•Ìa\É7FšG\ôš\Ú^\Ú-Uyÿ8Ù»¤œPzJ\ò\Ô\É<9\"Î¤=\'%\á\áiq\ÓD:Ÿ(\Å\ê*V\Ø\Ãb¹ƒ“\"8M‚AQ%‘\r\éä»¸““Ytü\0—u\Ô\æ¨w—¯\\\Ãı‹\Ë\Ç%\ÅÃ›t’\Ã\âm\ñÔ¥;±¸aÆ”i\\}p\rH\0FfQIY\Ø\Ş)zŸ4d“\ÓSl·xÍƒ\ËûvøşÍ¤ı\İb\Ş^ˆ·\÷mhg\÷\ïáµ»/®o\âoø\n~}w;q\İ\á+«N\àd\Ù&f±9DÏ…z\İ]\ïy‘-,¸_-ÿÖ›\åcÿ(~\Öı\Ãz\÷¥_\ñ\ËK\\œı\ê»\Õş\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001846 00000 n\r\n0000001879 00000 n\r\n0000001910 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<EE95253D4F0202C92548B6E49680DD66> <EE95253D4F0202C92548B6E49680DD66>]\n/Size 8\n>>\nstartxref\n2007\n%%EOF\n'),(6,4,3,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1567\n/Filter /FlateDecode\n>>\nstream\r\nxœµWYo\ã6~Ï¯\àc·X¤’xY@P@KQ­\Älm>jcm\ê\"±S\Û)\Ğşú\ÎAR\ò‘E´@b\Ë\â5\óC\òS{\õC“‹<\í×«\\]k\Ñ\Ş^\éL\Ø,\í\ê\êFOLnœ\Émf\ò¢V\Úx[ø\Ú\æVm«\Â™6\ğT@/i\ŞA\ßLRÂ“2\Z>+\è\ïMišøZ\ñ_ÿ(\Úß¯\Ú\ï\ñ\ïF\ÕZ\éB5…/2%U\ÏN5\Zf¡\ïÌ•º‚g¥\ZU«Rye5\ĞUœã»ª¾›Î¦\ËvQ\Õó…¨½¸_\Ì\õ®/\Åt\Öú\Ål¾üû\Ö\÷\íüZ,ç·Ÿ\İt>\óKQOš¶Õ­u\ñ\÷Õ¢­\îü¬\ãl\í\ÔÁ×­øT\ÍÜœŸ¦†¶\Õ\"¹\ï\öıV¬z\ñÔ‰Eÿu»{\î\Äl{]X»\0¤*‡„r)‚Ty]¸Z\çœC\nO\ô’ºĞ£	$\0¶\0#@*M\ÙH~SdVZŸ¦\ÊJl³€‘QĞª\í\Äf@“†\Ö(\ÈyR‹`ÃˆZŒ\òHeš•\È\Ò0\Ò#ÁŠfÍ­\äw0\ÊĞŒ@,sø+‘s\Ç\ÈoB\Æ\ğ-©CÃ….l\r«D£Æ¨—\Ç\ğŒ°0R …M(Lmj<-\É\0I\á4´R\ójjuKk:L›”V¡\Æ\\	O‚İ»´¥ˆŒLWHj\Ñ\Õ\ğ)SB˜)£‹\é\Ğzœ9Š\öÍ”)@ø®\é-&\ó(-\É\ZR*YÊ‰\Ìe\Ó%fKC‰ \ğl	\õ\ğS\"‹)KN#JY‚9ü]…b\ÍÁ+\ÕGÑ‰ı«X­7[\ñ\Ğ\í·\ğ\â¥\Û\Ö;\ñ“\È5j¹{\Ü\î[z\ñ²\ë\÷ı\æ\Ğ\'Áÿ\Ö\íxxı²ƒ! 4\ñ\ó|Q-¯…\ë¾\ô\â¹\ß<¬·›n\'şx\í\ï\÷‡\×Õºƒ	`\Ì\Ó%W$L\Ğ\ê±kÑ–‘8›Q\É1€\0ÿ\Ê®µi‚V­!¼!\Öe”%\á\à,McŸJ\ñ(\à]\ÃØ’ƒd\â¸!¾ê‘°B+{o°\r\ãB\ï`äŠ¹‡•\Ë‹av\î9.‘)\ò.e\\\ÔD-(©\Z`¶\ğ6erx·š»\ÕV\ì¡eCøïºİ¾\ÛÀ[ ½#\ö}\'€\æ—ş€ÿ‡\í3>\ô›À™\è\ÚÀc B\èGn\n,	h\09ûV²\èk* ¥­\Îú:w¢´\êW/\ğS±hX>D­#\Ğ\ÏJ\è1%l[‹®\öAt\\’1\ïT¡l%¢@\Õk\\vMA\Ù (\ÒQa\0¤¾]i\\‚³!\È#\åPi„Z  „0}©©wt“\Ãy\ØŒÁÿ*\ÎI39\ê—\à \Õ/\Ä6N\ÆKø¼!\öT“\ÑRˆHI†ÁÊŒ#\n\Ú\r-\Ü!\"\ï„\ãhvw^8\â\Î\Â\ó§ \ĞûAn–’c†)t¨\Ék®(±\à\ô\ÔFu\É7\Ú\0¥˜z\ÇDeL·6\Ä\ò²8W©’jS\Ã=\Ó\ÎR§5I\âÁ\ñv\ö\ö4€˜\Î\0A¨$\Û#D£™5\×,\Æ*Å£GX²*m´-ùÕûyM¥\ô\ßLM³h\ò§\Êe5ø‰\éD¯q\Å<.{šoL$\Ó.IÁ‚;’\åS8Œ<š›üE\ê@?Q’eJ\Ü\ro‹	\É^\Z€r\õ\çıF\Ò,.<\ó\Ø,D˜\å	\'6\ó„Q\ÚB\Ã	\ê\åx¸ b¡y>U1v$\'œ%+ş	<7°“/•vny\×\Ñğ¢«¢Š	Ù¡\'>?‘\ê¹,/‚£\Ş\ò\ã\È{şıµ8œ\Óh\Ö\ä\éÁÉ*4m§LºÀ—&\í7¿ù\Ûªtø8W(v\ó­È‡,¯q\Ù«–·“£C\Ê§‡$/\íÌ£-\âlO:ª¤\ä \Ü<\r.\ZDç‚¤\Ø]) \ğ\n\×0Ÿ\Î\È\äˆ\0N`\Ä$ª!\ì€|V¶\Åh…s?\ÜhL\Ê~·\ñhÁŒ\Ø>68®\ÉÁ>ÿ…\Û\\:\Í\Õ:\î[%\ëÔ‡Lƒ\á\ò“Sh`hQ\Ê\ö\Ä\÷¤û¦²0Ú\è}Àc\Ş3\ó?~\ß=•‹\Ì\åÁ‘x‰‚«½\'\ïY¼.IÏ…{Â¿ûR¢g‡»\à\éuSà¢¥ƒ~£‘\È\ä¾c\ßwü_.¡I!Ÿ7\ë?û\İ~½\êV\â—~\×=\ì^ÿ\î6|±\ñ\í\Õ?‚\Ü\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001889 00000 n\r\n0000001922 00000 n\r\n0000001953 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<EE6B2D8C01FDD8B40803081AD575E906> <EE6B2D8C01FDD8B40803081AD575E906>]\n/Size 8\n>>\nstartxref\n2050\n%%EOF\n'),(7,4,5,_binary '%PDF-1.4\n%\ö\äü\ß\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1509\n/Filter /FlateDecode\n>>\nstream\r\nxœµWkO\ãFıÎ¯˜lµ¢~\ÌK¨’\×—´ \Ä)R¿\âİ¦…„:a¥\ö\×\÷>f\ÆvVEjµK\â\Ì\ó\Şs\Ï93şTŸ}_\Å\"Eıù,–J\Ô7g*&ŠD½:»R—:Ö…M¤ã¤”J[“\Ø\Ò\ÄFie\ò¤H\"¥\á)Q©IŒkƒ±Qš¤¤V\ğ™\Ãx«3]ù\è\Å?\õƒ¨?«¿\Ãÿ\çw\×å…°\åıd*>\Í\ó\å\ôƒ\ë;¿±y)\ò\òv2,\êy^\Ï\æ¡\ën>û\Éµ¸Ÿ\Í^\\\Ï\îBG5·V,fU}ŸÏ­¨f\Ëi™×“Y¿h\Z‹\Û\õ\Ób±\ï\Úv\ï›!a\ËB\Æ*’”°´*)J+%•r	\ÃS£R•(h¤p…\0aú’„„SU)·$‘I\ÂO] \ö	° H\Ê\\š@T\Ğ@1\Ï@\à“H\âŒ\nz%Ì²tX• T0\Ó\"ü’VM\Êm0KÓŠ\0;\Í+\ğW(	¬\í#¿’\Ã7TS\r7’¸±\Ñ\\C… >\Ş\Ã\Ó0\ÃÀ<H\êIa*]B\àaK@§NE;•¸pJ\"3˜U´gi\'¸s.+\0\ÛH\Ü	A/e\ßXŠ+j+\àw\Z’Á,YL…WÃ¬a\â\Û\éRp\ğ]R+&\nA\ó,•ieŠ\ß1ü“>Uªj¦)	\Ä\r!\îZ0ªoe0İ”\ÓÅˆ|\Ğ\ç³;;ù²œ\ÌÄ¢Æ¯¢»W±Z\Ùl\Åc\Ó}\ÙB\ÃK\Ó\í×XµO\"‰\àK|nº¶\ÛR\ËK\×\î\ÚÍ¾\rÿ­\Ù\í\ñøú\ĞÁ ™¸\Í\óÅ…(š‡V<·›\Ç\õv\Ót\â\Ï\×VÀ\ôv·]­X\0¦À:MD\0…`\0R!\Ë!M\æ«f\"r\r\ğ¯\Ø[01µ#ª\ÑBÄ¤t|2\Ä\Z\\¥ŠqnbD!	EE\É0¸$Ÿ4¹¢‚•V¹^\Z•¼\Â>Œ…ƒ#°X\\|\Ø9\ó±h.o\Å#‡\î²!\áR\ÆÙ€NÔ£‘‚)Yf­!“cÄ›Ô¹Ym\Åz6„‡¥\ëv\ÍZ¡\î\r\Õi\×6\Êü\Ò\îq\ğ_b¿}Æ‡v\ãj&š§¾l ¾!.t†#\Ö	úª\0@¾•,Šš\Ü#3ù±û ¨½\ã¼Ã…N”UE¸{‚Ÿ’I\Ã\ô¡\Òú‘KÂº%r0\éJ\ëH\Ç~Œy{2–ˆY\×\ĞsuBn¬±ŒHÒ3\0Rß¶š\"ÀY‘\Òs\ÈÁ\äJÓ–n“’F{5¸n\0›€\Ñø—û5i¥‚\Æ8h\÷±\õ“\ğ>o=2J\n\ÉH0h\Ë8#¡£\0\Ñ\Â\ãÁ×p¬^‡?Vxıj\ß\Ñ\ÍÀV\éP£n	\å|#h­\Ç)\æ”úÈ—l•£Ša´O4\õ\É\ñ¹†X&§d—\ÊÈ›*–2\ìIG\Æg\Ù\ÛGRb¸\08¢,_Œk\ìÅ¬Ø³«\Z`¡IÈ´Á¹8Ò«9\Ö+\Ö5X\é¿YšVQ¤N•m\Õ\é‰Ë‰Zc\Ç\é5\ä\r—Í\Ö’Ë)‚>…bD\Ëÿ\Æ8ŒØ‹›\ôE\ì@=Q’YH¼\è[“K¢}ª\0”İŸÏ›”V)\Ü3Ï\\„q’\Ô\ã À\Êc0\nG¨»>P\ö·2\Íò•Š±#:\ázH!\ïø\ğœ<ÀB<e\í\Ü\ó®{\áIUy²½\ö7¾@\ëÙ–@NQo\éq =û~/v5Z5hºW²%‡¦\ãá°’…«—\"\îW®~.\Ò\÷i4ªpù‘Ë™\Ã\Â\õ–¤C¦\×\Ğ\ö\Ün®\Ê\ã\ãdtI9¡t—ä©“ypDI#\'%\á\á©qSGº\ÂQŠ\Õ­°‡\ÙpI&E8p2CJ•D6¸/\Ë&\ìpÌ¢\ã‡+…I\Ù^\ï\Æ_-¸†\ã‹\Ë\Ç8\Å\Ã¬“\Ã\âU.\\\ç{·\ö\çV\Æ<µ.S\'¸ø\àZ\"šE%eyb{•\ÒË\"[œF˜b¾\Çk\Ş3\Ş\ó?~´\ß\Â{\ñ…øq™—ù\Í\òÎŠ\Û|^O¦\öWQZ1Y\ÌnJÛ‹\î\ğ}R:p¼lG½XH\ÈbÁ…z\ß]\ïy\Ë,Xn\Ö_\Ûn·^5+\ñK\Û5\İ\ë\ßÍ†_^l}\ö\Ä¿b\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001831 00000 n\r\n0000001864 00000 n\r\n0000001895 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<8D2577174E540BE702874BEE22A09F99> <8D2577174E540BE702874BEE22A09F99>]\n/Size 8\n>>\nstartxref\n1992\n%%EOF\n');
/*!40000 ALTER TABLE `oficio_asignacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizacion_vinculada`
--

DROP TABLE IF EXISTS `organizacion_vinculada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizacion_vinculada` (
  `ID_Org_Vinculada` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `sector` enum('PUBLICO','PRIVADO','SOCIAL') NOT NULL,
  `correo` varchar(50) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Org_Vinculada`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizacion_vinculada`
--

LOCK TABLES `organizacion_vinculada` WRITE;
/*!40000 ALTER TABLE `organizacion_vinculada` DISABLE KEYS */;
INSERT INTO `organizacion_vinculada` VALUES (1,'Departamento de TrÃ¡nsito de Coatzacoalcos','PUBLICO','coatzacoalcostransito@mexico.gov.mx','2274501988','Calle 16 de Septiembre No.27','Coatzacoalcos','Veracruz'),(2,'MiddleTek','PRIVADO','middletekBusiness@middletek.com','2190398122','Colonia Reyes Cuauthemoc Num.122','Monterrey','Nuevo Leon'),(3,'Departamento de TIC del Banco del Bienestar','PUBLICO','bancobienestar@mexico.gov.mx','2298760211','Paseo de la Reforma No.274','Ciudad de MÃ©xico','MÃ©xico'),(4,'Strongware Soluciones SA','PRIVADO','strongwarecontacto@strongware.com','2209750062','Col. NiÃ±os Heroes Calle Juan Escutia No.14','Reynosa','Tamaulipas'),(5,'Free Software Foundation','SOCIAL','fsfprojectadmin@fsf.org','6175425942','31 Milk Street','Boston','Massachusetts'),(6,'SaipanCo','PUBLICO','saipanCo@corp.com','2283452765','Calle 5 Av. JuÃ¡rez','Saipan','Veracruz'),(7,'Satou System','SOCIAL','pruebas@gmail.com','2282141329','Av. MÃ©xico No. 10','Banderilla','Veracruz');
/*!40000 ALTER TABLE `organizacion_vinculada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodo`
--

DROP TABLE IF EXISTS `periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodo` (
  `ID_Periodo` int NOT NULL AUTO_INCREMENT,
  `abreviatura` varchar(20) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`ID_Periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodo`
--

LOCK TABLES `periodo` WRITE;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` VALUES (1,'AGO2023-ENE2024','2023-08-21','2024-01-31'),(2,'FEB2024-JUL2024','2024-02-07','2024-07-30'),(3,'AGO2024-ENE2025','2024-08-21','2025-01-31'),(4,'FEB2025-JUL2025','2025-02-02','2025-07-30'),(5,'AGO2025-ENE2026','2025-08-21','2026-01-31');
/*!40000 ALTER TABLE `periodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preferencia`
--

DROP TABLE IF EXISTS `preferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferencia` (
  `num_preferencia` int NOT NULL,
  `ID_Proyecto` int NOT NULL,
  `ID_Estudiante` int NOT NULL,
  KEY `fk_Preferencia_Proyecto1_idx` (`ID_Proyecto`),
  KEY `fk_Preferencia_Estudiante1_idx` (`ID_Estudiante`),
  CONSTRAINT `fk_Preferencia_Estudiante1` FOREIGN KEY (`ID_Estudiante`) REFERENCES `estudiante` (`ID_Estudiante`),
  CONSTRAINT `fk_Preferencia_Proyecto1` FOREIGN KEY (`ID_Proyecto`) REFERENCES `proyecto` (`ID_Proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferencia`
--

LOCK TABLES `preferencia` WRITE;
/*!40000 ALTER TABLE `preferencia` DISABLE KEYS */;
INSERT INTO `preferencia` VALUES (1,4,4),(2,5,4),(1,5,5),(2,4,5),(1,3,2),(1,9,6),(2,4,6),(3,10,6),(1,4,7),(2,8,7),(3,10,7),(1,9,8),(2,10,8),(3,8,8),(1,8,9),(2,10,9),(3,4,9),(1,10,10),(2,8,10),(3,9,10);
/*!40000 ALTER TABLE `preferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `ID_Profesor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `num_personal` int NOT NULL,
  `ID_Usuario` int DEFAULT NULL,
  PRIMARY KEY (`ID_Profesor`),
  KEY `fk_Profesor_Usuario1_idx` (`ID_Usuario`),
  CONSTRAINT `fk_Profesor_Usuario1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (1,'Lic. Ramiro Ramirez Rodriguez',99345,NULL),(2,'Mtra. Ana Maria Lopez',34213,NULL),(3,'Dr. Santiago Sanchez de JesÃºs',43722,NULL),(4,'Lic. Diana Sarahi Dominguez',53291,4),(5,'Mtro. Fernando Hernnandez Ezequiel',48731,5),(6,'Mtro. Luis Fernando Salazar',65431,11);
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `ID_Proyecto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `objetivo_general` varchar(100) NOT NULL,
  `metodologia` varchar(100) NOT NULL,
  `max_participantes` int NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `ID_Org_Vinculada` int NOT NULL,
  `ID_Responsable` int NOT NULL,
  PRIMARY KEY (`ID_Proyecto`,`ID_Org_Vinculada`,`ID_Responsable`),
  KEY `fk_Proyecto_Organizacion_Vinculada1_idx` (`ID_Org_Vinculada`),
  KEY `fk_Proyecto_Responsable_Tecnico1_idx` (`ID_Responsable`),
  CONSTRAINT `fk_Proyecto_Organizacion_Vinculada1` FOREIGN KEY (`ID_Org_Vinculada`) REFERENCES `organizacion_vinculada` (`ID_Org_Vinculada`),
  CONSTRAINT `fk_Proyecto_Responsable_Tecnico1` FOREIGN KEY (`ID_Responsable`) REFERENCES `responsable_tecnico` (`ID_Responsable`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` VALUES (1,'Sistema de Control de TrÃ¡nsito','Participar en la elaboraciÃ³n de un sistema de control de trÃ¡nsito para el municipio de Coatzacoalcos','ICONIX',1,'2024-02-10','2024-05-24',1,1),(2,'Sistema de AtenciÃ³n al Cliente','Desarrollar un sistema para la atenciÃ³n al cliente en lÃ­nea','SCRUM',2,'2023-02-19','2023-05-31',2,2),(3,'Sistema de Nomina','Desarrollar un sistema para el control de NÃ³minas del Banco del Bienestar','ICONIX',1,'2024-08-15','2024-11-30',3,3),(4,'Sistema de Control Hidroponico','Desarrollar un sistema para el monitoreo de laboratorios hidropÃ³nicos','Kanban',3,'2025-02-18','2025-07-09',4,4),(5,'Open Audio Studio','Participar en el desarrollo de un modulo para un editor de audio libre','Scrum',1,'2025-02-20','2025-07-18',5,5),(8,'Punto de Venta Veterinaria','Desarrollar un sistema de punto de venta para una veterinaria','XP',1,'2025-02-08','2025-06-28',2,2),(9,'Programa de Monitoreo Industrial','Participar en el desarollo de un sistema de superivison de maquinaria','ICONIX',1,'2025-02-11','2025-06-29',4,4),(10,'Sistema de AtenciÃ³n Hotelera','Desarrollar un sistema para servicio al huesped','Kanban',1,'2025-02-02','2025-06-30',2,2),(11,'Desarrollo de E-comerce','Realizar la tienda oficial de la compaÃ±ia','XP',2,'2025-02-20','2025-06-30',7,7),(12,'Prueba de Registro','Demostrar el caso de uso registrar proyecto','ICONIX',2,'2025-07-01','2025-07-01',2,2),(13,'Proyecto Actualizado','Demostrar la actualizacion de un Proyecto','Scrum',2,'2025-02-12','2025-06-30',4,4);
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_mensual`
--

DROP TABLE IF EXISTS `reporte_mensual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_mensual` (
  `ID_Reporte_Mensual` int NOT NULL AUTO_INCREMENT,
  `mes` enum('Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic') NOT NULL,
  `horas_reportadas` int NOT NULL,
  `estado` enum('Pendiente','Entregado','Aceptado','Rechazado') NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `reporte` longblob,
  `ID_Entrega_Reporte` int NOT NULL,
  PRIMARY KEY (`ID_Reporte_Mensual`,`ID_Entrega_Reporte`),
  KEY `fk_Reporte_Mensual_Entrega_Reporte1_idx` (`ID_Entrega_Reporte`),
  CONSTRAINT `fk_Reporte_Mensual_Entrega_Reporte1` FOREIGN KEY (`ID_Entrega_Reporte`) REFERENCES `entrega_reporte` (`ID_Entrega_Reporte`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_mensual`
--

LOCK TABLES `reporte_mensual` WRITE;
/*!40000 ALTER TABLE `reporte_mensual` DISABLE KEYS */;
INSERT INTO `reporte_mensual` VALUES (1,'Feb',90,'Aceptado','Observaciones...',NULL,1),(2,'Mar',110,'Aceptado','Observaciones...',NULL,2),(3,'Abr',100,'Aceptado','Observaciones...',NULL,3),(4,'May',120,'Aceptado','Observaciones...',NULL,4),(5,'Ago',100,'Aceptado','Observaciones...',NULL,5),(6,'Sep',110,'Aceptado','Observaciones...',NULL,6),(7,'Oct',115,'Aceptado','Observaciones...',NULL,7),(8,'Nov',95,'Aceptado','Observaciones...',NULL,8),(9,'Jun',140,'Aceptado','Me retracto, buen trabajo',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nxœO»j1\ìú‡)\íÀİ­V\'\Ë!\ğ=lrE\ğA!…\ç*Nüÿ•\"I•-vw˜\ÙÇ ÚŸ3b¬†\ö¾U‡y\Â\âx)†—eJhºZQI9‚aV’}`|µz¾Ã¬U3jUm\r„ßµ2\"\"°\ã\Ò{x\neÀx\Íno\ÓEbºA\ó\rwZ½F\"\æT\ØH\Ænˆúu\òÒ®6\rÑ¶–Ê‚]¦“‹d» k2\\g:u4)/p¢\â\æª|\Ãø U/?>i\õ_3ü×Œu¡dû\Ã\Ì\Õ\Â\í\ñ–¿ Z|ÿEW\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250622133747-06\'00\') /ModDate(D:20250622133747-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 303>>\r\nstream\r\nxœ]‘\Ëj\Ã0E\÷ú\n-\ÓE°\åWZ0†4®Á‹>¨\Óp¤q*¨e!+ÿ}¥‘“–$8Ì½š\ËLth\ëVIK£3\ñ,¤\æ\éb8\Ğœ¥\",¡Br»¾|\ì5‰œ¹[fc«†‰”%>]q¶f¡›½˜N\ğ@¢w#ÀHu¦›¯Cç¸»hı#(KcRUTÀ\à>z\í\õ[?Ğ¶m…«K»l\çOq\\4\Ğ™…0|0ëƒ\é\ÕH»SÑ²q§\" \Ä]½®\ÓÀ¿{\ã\ÕI\â\Ôqœe\Òc \é%P‘\"5Y ¬±d¥} \ç@\ì¹şÎ®½®\ÑXÊ¼Œ¥¡gQ¯\êP\Ïï¢±td\r¶\Ès¤]ŒT¬”\n\ÊFK\ë\'¤$şÆ\Âo\ì6g~1Æ×Š³\õS•\nn›×“\ö.•g t\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8024/Length1 21328>>\r\nstream\r\nxœ\í|\rx×•\è¹3#Y¶e#0?4b°È¶À\ÆÛ„Ì¯±\rX‚\Ç\Ò\Ø\Ö’lc‰Û”Àª\rä…†¶4)!Ù„4iš1ùƒ\ì6Mš¦û\Ş6$Mw\ÛfS6Ù¦ù¶/M»m_7kÏ½3’e\Ç\É\î—ı\Ò\ì\ÛeFs\æ\Şs\Ï=ÿ\÷\Ü!\0¦ À½¥\İU¹ş_\Ï\Z\È~\Ävµw¬\îx\å\ò\Ë)€\Öu\Ø?\è\r\ÉÑ’\åS\00ı(\ö\Ïy¢ı\î\é\ß¸\æ{\Ø¶\'\Ú\Ú\ñ\Ù)€’•\È\ô–\Ş\àP\Ï\è+¿º`\á\í\0¹m~E\ö-¸\÷§\ö2^5~D˜/<ˆ\ò–a?”\Ø}Qşl\ìÿÀT5\ñÊ¯,ş¡`\é\0y–¼?j\nMù\ïDz1¤$\äšû\ö·lYƒ8.,‡”\é}Sÿ ş\÷8¿<\Z‰\'R§¡\ÇPúhL‰F§¦”>ÀMj;\Ç\ÏÿF\Í\ã{¦¬üä›€¯şeÿ»\ôşş\Ê\ê\Ë\ä\Ê\Å\Ü~\Ó4\ì\Z\íÀy9·\\ù&\ê\ä¸Lş\ô;‡\ñ‡\ğ\n¥1\ä@úu\n\ğ8\Ó.B•\Ü8\å\ì„ƒ\äv0€\ÉP%\\\Ä)§´;wz¸Ÿ\á=‚\Ü\çÓ¼7µ‹\"<W.k:˜¦qU\"\ÓtŒ\É\Ğ@-µx\nL\ô‚O\ğ0u2¼Ÿÿ\ß\é0¶ı\÷·\ñ\ê\ñ\Ñ¡\n\öNŠ?øø\å“\ãÿ9\È[©7\è5\Ù7NN†7ş\0\Î8\óa|…½>¿‡\Æt\áùp½&;¸“X™\'\ò\Ü_øOª\õ?\â\à#\ĞÎŸ€\öOZ«\Ç\Õ\ã\êq\õ¸z\\=®ÿ³r\Ïœ–\ë„G>6E>\æƒû\ÜúI\ëp\õ¸züù\ò‹O@(ıv‘~\Ë7\r!aw¾‚\÷9`AŒ\æ\Ãjh‚M \àob\ĞÁ\Ó\ğ·<•ú\ßjXƒ£^\r\âh\"{4\õ,\ãˆø%Ú—\ï¥V¾r\æ f~‰x9\Æ\âÿC˜ŠrÂ¯\àmø=q’¥¤’Ô‘mD!ø\Ö\í^ÿ¥/~\á\ä‘[\æ–Ojø\æ›¼\ñÀ\ĞşÁşD<¶/\Z	‡‚}{ş\Ş\Å\çí–»\öÜ°ûú];=;¶o\ëh\ßÚºe\ó¦Ö·¬[Û¼\Ğf\É\Ë-##ùyR£’W^#yù\Ø\Ì//#ª±Q\ÍaHu‹ST\İ[;\í\Ú:›\ÖX\ívU²«nU(m¢—\ìKz\Ód³p.²\Ø\Ğ.mØº³SlJv±A\ÄtŒ\ëi\ã+2czK\å\Z;:\Õf\'\ö²úkY?\Ó]7a¸%=,‰*´&“¾\àKï¶\Ö04~Öƒ–x$µ\Û)Ù¥NiGL`¶wt5bËœnq-r\Ï[ /\ï\é<\Ñ[;;U±«Ç³©+UÙ§ı<TKûµv—*zEQ5–Jİ­I»Jº$«\Şo\ëDÙš´Kv\Ñ\ã9Ÿzn¥–\ìÈ‹ƒ†‰\İ:\â&G\Ûwv^°`6\í\è<\Ç®±«Á3²\0\Ç:/`‚¸–£XŠ¤‘v`ÁÈœ\ãLŒ\ŞzÁ\r0\ÌF†`}/ZÁp¦4€\÷<§\á,š \ä\Æ\Õ\à=/h#\î4µ€8“†Ö¨\ê\Ô&±Ğ‘§Ãµ\Ãµ½„‘q\ç\Ü&w®\Û\ÌpŠ:‡˜§‘6—ÀcfR@¬#È³¡Ï“\á‘\\·\õ\ãÔ¦S#%\Å\rgp¨9%\Ëb„\ò4Ã·Y°mg\çcf@ş\"E=\ÊËšF¸\ÍNi,­·vb\ôšF\Èfg¦6\í\ò¥M\"¦µ\ênï¤´]V\Ìy\Ì\î5\åe4»\ÄNI±J‘iÓ’Ñ¦‹¥qC²s%Øˆltt9“Z\Ê\ÑD“,u˜¦|i‹Wj\îB	—\r~Z\å\İ.v©\İ]NlŠ–\æd3\Í\n™RC\ÉÇ—¡”¬‚U\è7£YÍ“”5_jÈŒ\\\×i#F:’#5¨¤D\óz“\Ô$\Î$½R7f »µ³\×\Úã‘‘·\ê–dU\Z¬#4\àz™IĞ¤¦\Ø\ìD\Û6`nq¶\î\ÂEJ!&“k\Ä·\à½2\í¯±\ãºO\êCÒš5¬MbRu\Ë\Ş.¤h\ò0b\\‰ˆl’dÑ‡^Fs\Ñs\í6w\î¤s:vv&\Í>\É\'¡‡\İî¤Œf[E¯Çš\ôx™\Çq>ª\åe†±\ê¤\'®ùRo‚\ó\"twI\İ\Z‚®Î‰¸Ş‰ˆ¤\Ê\ÆI\ë©8v\'\ì\\/5ù‚^²O\å1\ã\ì¢Ï£¥´²º\ñD$‹HÄ˜2\æIK}ºG\ôv\ğ“T{\Çwı™n3½º\ĞkZ®¨‚ƒf^§]\İkUƒg†DV‡»Å¤h‘\ê$\n\Ø\äµ\ô\êR\r\Ø\öÊ´8i\î!b=\"\Ä\În\Ìed\ØÜ•LgNIj\Ø9%–TÒ¢¹Rj:\Ü*vyÄ®.\Ä\â\ê±[EÕ€w±G¦\ÉE\Ën«fO+\Ö~¼\É\ÉvœtY\Õ\ÜzdE²cµV\é¢Õ¼OuP;h\ïTÁšLJI• Š¥\ÍHŒ\ìª\Ñ\ÑBoø‰:%YÁ Ry¢¬°¹Í¨.\ó\åfm’\ì$\áJ™/\ÑqX-º)\ğ&1\Õİ¸\Ú¥E\É\â¤X›Äªµ®\à\ğn\ï\ÂmA´ˆ\Í\"µŒ™L\ĞB{d¤\æ–RBœ\Ï>5\äÙS:†aŸˆS#61®¨Y[§Úš&\Éal\ìsªÜŒ8H\'mX?(\ê<Ciº×Ye¥³E•\ë\è\Ô\Ã\Ã\æ·Ğ©\ÖtÀ´iˆae—n‹\ö´¾ùš¾šP#û˜\Ù\'·T5•b UuĞ†s¨9cI€mTZ›\Ã3u5°¢D}„Ò¥w„R…Ù¤m‡\"-Ÿø  K\ô²O=ÛŠ5²K¢—\ÇCÅ›˜ :ƒ±NjŒ©»Œtp2Wè’´O>ı´0²\Ñy\ì“\Ãt¦cšI†\ñ×½w\Ğ4\Ï\Ù\õƒ\æµ\òˆ¾*\õu§XU¿\Ç\é\Óf\õ\n.bE\Å\Ê\í\İÊ6v\áj\ì9X\Ç\Ğ|\\U¢\Ú\î\ÄM„\ÙvD\ó\êz­:Ğ¬$\Í4c\é\r(¤u„À¥%­S9\ìfZ\Ò9ˆIZAo¹ÒŠ\ä`µ§\Å\ÈR`\ÆBŸ\ôvù´\Z½+¬+é£‘‘:—\Åv€–¦NƒU\ğ°”q¨ƒN=‹58\àÌŒ\Ò5™“\ö¤‰%3ƒ\ÆnP\Ë\r‡œ¦Ig%Mÿ1a&=šj.£\Õ\ÈaúpQ¼ \õZ¸\Ös\Z\ç\õZ@¬Ã›L\Ò\Ò6²»®P³£\ñÅ¨Z-*Y«k‰¾9ˆª´R\Ñ&†a]\\n9T-l¥ù8`A\Ú\ç´\Ô\Î\ÇAj\óœU£\Â\Ï|\Øp¦©5\' \Şy¥Z\ë\Ãúl-;l5Ó«Išé¥¯¤|}•š\'T}½\Ó\Ü\ñƒR†\İ\è¥G\Ú!f|¬”\è-\è®:\æOªŠıd\İ\Éq\èJÀ•\Ö%“ù\éúO\Ëÿ|\0\öp	\äD„zã±.˜|\Ä4[À\Ğz”2wŠÔ—C^£š\ßHŸ_\èŞ”K \ã{\è½\æ°Ç‰,\Ç0]Š\ÙØ™\Ô\÷9\é’q¦\ç¦ı\ÖÃ–´>w¶£\ób©§^ ;‰J\ğnp\Ø\ée¥®c\ÒhGœúƒ\î!\Z\İO3vŸvŠb\0Ÿ³\Z	>m\áF [•H©MV\ä’øÀeV‡\Øk\ÌL|–j£O\Çø YD²Vj/C’ş{€PÚ¹\ÒZ\ëÁ\÷Š\ó©·\æx´R\Å\á&WGR-E8”‹\ñEC=\ÌÜ«I‡»¸Ñ¡SQ\ã\â\Ô\è¨\öf.¹¡@\ß\È\òVX\ó\è[^ú\ë‹\Î\é|¬R\êi¿ºB\İ.\r\á\ÃB£¤Š\â\õX¹v\'™\Ä\í4)\Ñ7©\í\Z¤C¤l}2 O1:­u¾£u\Íshº\É\çSÍ¡¯Ki7¦¥\ÅP\Zm$\Ó\âT\ï¤\Òh–‘]Z®á‡©?R’&_p\èB“\×\'w\âû¡]K\ëz`·p‡q@M¾H5wjÏ’”í†¥)\ÛnW\Ìv½\ë„m—+e\ÛY‘²y*.\Ú:\ËR¶\å)\Û\ö\ò‹¶mÎ”­c\Ñz[û¢”­mqÊ¶u\ñÃ¶\ÖE¢m\Ë\Â&\Û\æ…\Û6-L\Ù6^“²mp¤l\ëN[Ë‚^Ûºmk¤lÍ¥)[S\éÃ¶5R\Ê\Ö8?ek°_´­¶§lnûÃ¶\ëÄ‹¶Ub\Êv­xÂ¶Rt\Ù\ê\ç\Ålu\óR¶Z[Ê¶\Â6l[>7f«™›²UÏ½h[6ç¢­jN\ÊV9\ça\Û\Ò%1[EÙµ¶\ò²˜m\ñ¢l¥(kÁl\ë¬\ë¥ùn\Û|~\ö¬\ë\í³¯µ‰+±a›\×k›·hf\É\õsg¤lsJR6k\õ¬º]3kJ\êv\Ív·\Ò\öÚ>«¾Ä¿sjm\ñ¶¢ZË¶b\ÅSPk\Şf¨\å¶	x™=Sj\n·\å\×\æmË©5n+\ô\äyŒ\ğ\äÖš¶\ñ8j\òp\ğn·\\ ·C‡s\ÃùœT\Û\ÕÔºK%G\Õ\Òv\n\ñµA5Ua\Û\Î]#„\ó¾\í6˜Û°A½½½\ó\Ø\Ä\'I®qk\çˆÀ\ó4€œN\'\è\'k\ê}§“d€ı€Skh\ã:¹\Ş\ÎtœiR?nd&\Z\è	Å©¥\Ş\ä\rE\0©·\Ó\×\è©\Ôÿ5Ì€b­\áS\Âs|x\Ò\öˆ\Â\0´ƒı„^¤\èC‡½\ğa\'Ä )z\áF¤¾ü8c\0\á>\ìº ‚œn„M8¿“q‘2ˆ£\Èı\ãD\éÛ°À\Ñ[\ç6\ä\éCl¶\ÂØû\ğÑ~\ó\ô‚a=\ğ0¦B9¸Ü³\Ïg_cX \äM\ä	K\Å\ÜS§.¦\Z_iùNeQgQ\ñŒ\Ú%K\÷Ù‹J\ç;ª—\ÕTU–LŸf4Ø‹\ì\ÄQ³¼¦¦z™Cšoœ.¥GrŒ\Æş…\ÑY–,Y° ²rt5¿\ê\ò·ˆ\"\Ô\×\×Õ´m\ï\Ø½\÷SŸşrk\ã\òù‚aı»O¾\æZ°ÀE¯»„o]şc[_y\ÙÚšú-­‡\ìk\õ-sn¨¦\ß\á™\ğ9şQŒ@\ä\Õ]\'˜ŒF@]¦,\êX\ëª*B-ã¤ŠH¼Ÿj\çM\äOÏ\ß>=|\åû·>Eş\ö\rCÃ»Ï¡\Ñ#œ…»p\Çf\Ï\ô[Ab^v\à\õ“\\>!dÿvp.£RU\0C!JÍƒ\é`yj:\Ê\Ë\×\åU¢¨\"{¥P<}\Z\'H¥U•\Ì\r	·\Ó~@\ßu\÷è¿?ú›·F~¹/ş\æ\×\ß24œış4úı¯|a\ß[#\ê›1”‰¼…|\ä³\Üfƒ\É²\ÏM³§\ö0\Ó\íú¥\ò»®x¸}Wsg\r\r\'G\Û??\ê<	\Z\Ã\ä3lnŸ[À›\ÍF0\"/S†Wq­‹F0^„¾!UE’~W_ ¯µ?;²jtùÀ\è’U††\Ëo\ò³\Ş}Fø\Ú\å\÷x\Ã{”û\Ş\ÔoøÿÃ¿\ó¨\×f\Ì‹)\'6\ò5\ÖÅµµ.×’¥M\ó41hüKfH–\ÓJJ\Ğ+Ë«\n9®ü3/\Æ\÷}\÷È¾\'‚üıÆƒ}\Ç>·\ê¦ún\å\ï\çCŠ\"¯=ø\à¥}\ë\ïŒ\İ|^\í¿oG¤o\à\î\Í\Ô\÷{So\ó?§kl0\×m)Ì‹@lv>JŸj\Ñ\ÄWÒsœ\ôEh\Ş5F\ã5(¹(­y{\ğ\ë{”\ó‡ü§\\g¿’»\ì/7\õ+[tX9|\ä\æ\â\Ø\ëgø‡}»6s\æwŸ9¶\Ö\ó\ÊZ2\Ø\Ö\÷Ì£O<£k\ğ\"\Ú>\ì¨A¡µ¦ “©i\ó1JÅµU\ã4 ùoŸ\Ç\é¦;S‚«9ı\İ\î=ÏŸü›\ä¸+\ëIıp zš\ï{|T\æ¦\ñG‡|¶ø\ğ?¿\ó\õ\áw.MY”»\çtWÀ\Û{\çV\Îs\ô\ö\ãÀ¥\Ş=Ev\Öb¦Ì€©\î\Übs1F ©\ğ&bc5J«FË§¥©Y+t³¥\å\ì‘S]4Huu£§6mJ\Şû\Ó§ÿ¼|\ñ\â\å\ô\Â3ş\ëø—\á“Y¬\Ç3Ö™e1Á\ì 	ø[Œ‘g\Z –yúL™:„N,©ªšN.\ŞT\ñ€\ËS¾\á6¯s™\ì\ê:Š\Ş=`\\\Éÿ¦A)H\î\ây³\ívoÌ‰c¬4?_\ãTT…u¨ol-T\Í\Ğ<Œ	¼Œ¹5K’ŞºF:s\ÑùÀÁ{=8wsK\ï1§°i\î\æuşc³\êFÉ¿t²>\ğ\ÌCW>\Ç]¿6|·ş\ÊfÖ\ë¸\Ã¡Vü+L«nsZ]ª\Ë\èb\Ë¼\å;\Î\Î\Û\Ôú|9ô‡³iı\0ü%ºR±š\Ì\ÄD²¤iü\Â\Ø\Ñ\Ö*\Ê|#[KÜ’\ã/\ö\õ½xü—#‘—\ï¯X1\ÜXSs£e\èÒ—O¿~\àÀë§¿|i\è\ğ³{ƒ\É\òCÁ½g\÷P™gFO	S1‡\õU4µ¨0?6K7‹\ÅÙ©­£%K\Û\Óv1\ñ\Ò|\Ç5E¤R¯\í9E%%g\î5,»?´Ÿ®¤ƒş»\\d\Ú\á#7\è;±h\á\Ñ\ÑS†e§7w\ïû\Å\Ùû/\Å\Û×‘W¿9\ò\Ø3±£G7\î\Ñ|\Ê\å\n…0İŸ›§\Ïx´j:µ}y·q\Ñı\Óf´„\ÛDş¥6\ö|\É\ÑXv…U#9\íÁ\èXİ…\Æ\Â\ÂüÜ½9ù\ÆX±ŸJgUQU:ù¤\êª\êª\é\ÈTO\Â_\Ü\äº\ï¾\Şy\Ç\åÙ‹‰È™¼\öÚ‘+—w\ÉG(\ç/¤~\Ëÿ×€\÷¼\Ø\Ù\æe\êŒVe´ŒfeM¯3\ä\Ç_=ùà¼-\áÏ—?x\Æ\àzx\Ê_\ß\Ï¼\ò\åİ®•Ü¹Ë•\'\ëúhÚ¹r\î=C\ÌF¡@œ;\×nšbš\É\Ï\óTpU}»rFmQU%\Õ}µ\Ë\Çmª4\×\ôªV\ÍÒ¬oØ·æ–·\ï½a\İÆO\ßq|\Ûm9\Ënsµ\Şdÿ\î£-\\ù²Ş}}¹šk\ÖnI\ŞX\\ù¡k\×\ì\Ûr\İmü†­u\ršFüj\Ôh\n\êTø„\Å&Ô„f\â\ê\÷g¢ˆT\ğ·cx<\ÄÚ½û¡CJYwG¿\ÏÇ•Ë\Z~¢K~\â\æC\ËC\÷µ\r¯¿\ç\à\Ğ=\Ô\öGR$c\È\Å=«X,yB ¯˜FŸE«\İÁ1¿r9|V\íºb™\ñ\èŒ\"×Š––5k×’»¤\ôİ½OŒş4>\êi©®in®©n¡üo\åƒ\\„ñŸŠ–\ä	°·PH[‚†`ĞŠœi‘·\ÌS\ÎŒn6[î’\Ï\÷¨{w\ï\îûZwú„ü\Â\ğ$\ï5>OJyı9†\õ\Ô*ù\Ös£)Ã“¤`\ô_\Ø?\åí£p\ê?yş\ï¬\ó\×\î“X¯Ygg\Öù¥¬\óÕ\÷\ä\n¸\ÅYçº¬\ó\÷Ü„\ó½r\ò×²³û\Ï\ã™\ó™ÿz§#¬¼z^=¯WÏ\å~¬\çW\ÏO\äü\êŸ\÷¤¿\ò\"/±ß˜\Ñ\ï\ÚV\0\èm\ìı\×h9ü>½\Ígá…¬¶ŠøızÛ˜…Ï\ÚL»€|›ÿ½]N\Ã&½mÉ¢/\Z“E0\Zt\Ä\0\ÃMz;7‹¦Ì†[\ô\öJ¤?N1\'\ä¢QÃz›@Ù ·9(4\êm>/dµ\r0\ß|Xo³\ğ9Ë´MPl¸Oo\ç\Â\óY½\æ\ç\õ¶–\Ì\Ğ\ÛüÑ‚µz»¶[^\ÖÛ–,şEcº¡\í\æ¢R½m€¼¢¥z;7‹¦f\Õ\ë\í•H\ßşU±rI\å2qSÀ‹\Ä#=	±1‹Fbr\"	Wˆ«ƒA±-\Ğ\ëO\Ä\Å6%®\Ä_…\Ø\áW\Äù}J,<_L\È\İAEŒ\ôˆ	 .\öD\Â	qP‹>e@	F¢ŠO„Å¨Kˆı\ñ@¸W”\Åx¢\ß7$v‰«Ã¾\Ø1±¹\ßë‹‘0\ÎWÄ˜Tä°—1¤üé”¨ˆ\ÅÅ…şD\"\Z¯s¹z	w…7r\É\ÈA)\ï¡\\:u9£vu#İ®O(1\×Æ–Æ¦\Í\íM!ß¢\n´-:£\æ \ÑKk³u¨[•X(£\Ù\"š\âWb\nj\Ù“\Ã	\ÅW&\ö\Ä¦–\×/\Çz•21\å\ğUbqœ\éNÈ°f¡ed<B=:(\Ç$\ö‰r<\ñd\ä\'ú\"\ŞşN07‹= ‚6R\Ìo\×g\Ì_Ä„ø9HH\Ç\ÒC\â :!ÒŸ@‡\Å±€—\ò(C\"o°\ßGuH¡€.¹W‹#2í£T\Ï21\ñz\è]afEû»ƒ¸¿L\ô(\ë\îş\"\ã\éU\Ât\Ú\áŠ\ÄÄ¸‚‰¨7³uL;FC¥D©Cº‹˜\ÜA$4\Şš4ıº¸_as|t“¸W\ñ&(†’\÷D‚Á\È 5\Í	ûÔ¢xKC¹;2 0S´°†#	\ÔTÓ€ú?:T}(\î—Q\õnE\÷—–¢r–51*=À¸\Ğ\õ¸˜¸‰VV¬&\"qª¿,&b²O	É±¾4\Ñ\Øb\êEú£,o\"¡¨FmJoPmG·Pµ*+–,­\ßRUS=6)\Ş¨]O¢\'\Ò/†\ä!\Zµ¬e†®\ñ\Æ™\Æc\r\ÊCšã£±\0¢Ÿ˜^˜rzh\Òa>S\í\ôXŠ¸:B\Ì^½Ñ£\å\Åûlˆ\Æ\"¾~o£‚\ë\ç–\Ñ9i\è¼AÀ\ëŸP\0\Ò\Î\Ó>‰‹D%Ô­ø²È‘Ã‡i\Ë\ÈYZge{|\\\ô2¼\ê™PJB	\Ñ* T_d0ŒÈ¾\ñŞ“5W)1jNE!\ìODq\İ`\õ¢™‚4~%\ïQ,‰¸\ì5r\Zšc±ˆ?\Ğ@+\ÒU\n—w¼\"”\ö «V‰¡h«I\Ô?\äÂ¤\íO\ìPh\Â\îøş-Q\ÌLÌµ\öÀ¥%!c|\à« B%,Ák¶6A\0¼ƒ\Ä\ñ\ê\â\Z±ƒ(ƒ2b\Ø\nCû!wO\Ú\×~‹³‚w©úe*xŸ}l$Œ-\ée\èFt„J£?\ò¢\\z˜*©(Æ‡t”cG¢Œ³ˆ´a„Q¤ˆ1\Ú~¤¤¸^l\Ëx\ÅÛ”C\Ø\îfp5úú-l7\ã˜%Æ™ü°.Ÿjcr¨<\ñ\Ş,\r\Óú§¥P\Ù\ÄP™ˆ‹C¸\ğ\ì\Å1Ê³¥W Ÿ„+\ë:(P<\Ó:¸&\ğ.\Ï\â\íb~Š t!™\ÙEi]°Z0BM°\ÚV\à¨1Ÿ72?\r!U::Z¤—B\íú\ÎkeœC,q=Ú¢?St_\ö²Œ3]|PÆ¢FGÇ¼E¹\Ò\Ø\ô\"®Œù7\Â\"f\ó£Œ[\\—@­K0‹\Ã\ãb\è\Õ\íx¤st\ÉPt\Î>v³Q/RÊº~4ƒ(¦mS˜\Öc\ÙL5°ˆkqLd\òµ}‚Œù\è\İ1KhN\Êl\r\Æ\å\Ï\ÄY4‹µLˆ ü„a4Š1¶\â\Òz”éœ¼È³Ÿı´æ‡‰³ƒ\Ø1\\¶\rcÙ›½5MûÙš,\Ë\ò\'m‡°M¥\ôdúJV´¢,oƒ\Ì\Û~†ñ±¶¦u7\ÓE£Œg(½Ì·iYZ<\\¬vˆ«UM‡€\îï±¸Næ»²¬¸j¶D3š˜Ec\ö2o…>4&\éJÓ¯¯º8£“\ãcr³q/Rx™\\&ÍÖ« [£ƒ™¨y™N>¦g@×¯.«\Z\Ò\êa5m,*Ù«5Œ¸„\î\Ól¤\ó\Ì\Ù+uü¬8[š×»u«\Ç\ò+»Š\Ê›X\Æ\ö8Ë·0\ã®e½¶+ŒY\÷\ïÅ²\ëN”y.\ñ¿\Ì\èi%¡ú„e\ßû8M¶3\õ²~?r«74\æQ¦¥fAÛz\ÙE(\ç\íz¶¤½U‰´&\Ö\Ã¨‚\Z¨FúNC¥Ê¬¢+z~¥\ë»V\İ\ÙYÁ\"0^·±ZŸÀ˜R/iµ2Š†›\Ş\İ\âz=Ï–\ñş”{<\Ãs2OÄ™¢lj1MK \İÃ¼$2IC™Z0ùn«eµ—EKÎ¬om\İG™‡Æ­\È(\ËXm®W\ç¢\è}yB–&2•X\Û?Ò±_7D}oe\å\ßxLÏ¸z\ö\ï\çI”\õ}l—K\èkY{>\Ñ\ä–e\äL´@[ƒzü\à³\ô\ÊÄ•5™\ï\éœ k-DúEx§9ß©;\ï\ç®\é\ğQ};\Æ}l7™|\ï™Ì‚\ì}m¼^\õY9@-\ÑlI0y\ég\Å\ÛS‡\ôJ:\È,°uşa¹\'\Ë*…\Å%¢Ã„ş\"\ê;aT\ßµg\Ãt\Í\Óøø\Ùnı\ĞÕb\ÃzdÆ¸§WHº\Î\Òü\ñ³=/ û¹\â}\Ïz\Ú\ÓEü#\Õm\' ¶\ì@\î\é`¶|L«-¬jR®Z\İm\Ç\ö¤laY[?ù\Ûk©»\èß’›\ô úş;¾;\ô\émŸ/\î\Åû\ñªkmú\×Şª\éKLG$\Ä\×\àe\Ëj+–Ô‹ı=‘ÊDXU±”v{ƒCQ|c »N¬©À³^\Å\é¬ \Å,©¨­XQO\ß\\\Økvo€~—0 /¤ubµ×»t‰·Ú»QN„\Ë\ÄÆ¡X°L\\S”¾2q P®a»{ËµxLo\ô\÷±\ÆGš\Ä<@À\Ä~½7ÁeÀE¢\ñ¤`ß“ˆ\0d_•ˆ¸\0¾\"‘•\èU\ÌÁMb%ûŸ¯¡ß\ä\Ï:\öı#¡8r;²\áu\É\àµy\Ö_¨€k\Ãvbf³ÿ\ÛJ3·\è\÷Œu¸´¬Â“€\Ë]@¿[†ÿ…\ğ<Œ\ğ\ëp\á_ı±\ïÀ\ïş\õ%$\å’O\Ì\É\"„N²\áV\âE¨Co&I„Ÿ#_Gø(9‡º=I\Ä\öy\ò4\Âoo |–ü-\Â\éw¯\ä{\ä‡L~‚\ğU\ò*\ÂK\ä\Â\×\É/ş t\ò{\òG„\") \Ï\å \Ì\å\òÒ¿]\ÈssÚ¸\ÅË¸\n„\Õ\\-Â•Üµ¹M·r[¶s·s;z¸»8\ô\ç\ã\ö\"q!„Q.ŠpFx+w+\Âc\Ü¿\Äİƒ\ğ^\îk\åF>\Î=\ğ)\î)„Osh\÷M\îY„\ß\á\Ğ.\î{Üş„û;„?\å~Š\ğ\ç\Ü\Ïş\÷\Z\ÂK\ÚÈ½Áı\Z\áo¸wşCK¹?r—r£@x4a>\çùB„Ş‚°˜/FXÂ— œ\É\ÏD8Ÿ‡p>_p	¿¡›_°‘o\"¬0\ÖB“Ğ„\ğ\á„§…\Ó\Î/<&<\í\'…¿\Ç\öÏ„ŸaûM\áW\ß6X.\ó\ì;j`ÿ?º’ı½\Æs\Â\Âw„¿Áü\âq\Ş\Ó\0\Â_ÏƒAø.\ò( 9(ü•\ğ\íªAZø\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  34[ 686]  40[ 556]  232[ 525]  244[ 527]  292[ 239]  299[ 260]  305[ 853 551]  314[ 552]  341[ 561]  357[ 323]  362[ 559]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-22T13:37:47-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-22T13:37:47-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:DocumentID><xmpMM:InstanceID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Filter/FlateDecode/Length 108>>\r\nstream\r\nxœ-Ì½@@\àw\"‰\Ñ#Ö‚H\Úa” ×‚‘P‡D*8gŸ\r\ö›\Ùİ·@(\ïU\è9\ğ±’[P`J²M°=\áĞ\ä \ÌE\Ü\Å \Ã\Ïšb‰#Šü—Q\È%§\Ä\ÓA\È.¡š…º!\Ğ\îÀØ”\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003030 00000 n\r\n0000011144 00000 n\r\n0000011310 00000 n\r\n0000011337 00000 n\r\n0000014518 00000 n\r\n0000014563 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] >>\r\nstartxref\r\n14872\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Prev 14872/XRefStm 14563>>\r\nstartxref\r\n15629\r\n%%EOF',27),(10,'Jun',117,'Aceptado','Buen trabajo',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nxœOMk\Ã0½üŞ±-4‘\ì8®!\Z§-\Ëa4°ÁØ¡‡.§†~ü˜\Ò\ì\Ğ\í4$¤\÷¤‡|>¨ª¼MO\r(9=f\ÇÛ²}ŸÇˆºI¸hEØ€PJ\öÁ\àz\Ô\êmA«º\Ó*\ß2è¾´b!\Æù¬\ğ²€\î$œİ	ıM¢ŸZşiwZ}TD+—V\ê¶ vØ®¥®bQ—\î>¶M *y¢X#pŠ~„\×1ˆ05Ä¦Y£\È:ŠŸèµ\ÚÈ‹¯Zı×‹ù\ëÅº\"+ìƒ—»ƒ\é\ïæ¿`\Ó&|ù\óEr\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nxœ]\Ñ\Íj\Ã0\0à»Ÿ\Â\Ç\îP\âüµ„@—¬\Ã~X¶Hm¥3,q\ÜC\Ş~¶T:˜!I¶%\'M\×vF{¼»Y\ö\àù¨r°\ÌW\'Ÿ\á¢\rKWZú›\ğ/§Á²$\÷\ë\âa\ê\Ì8³ª\â\ÉG.Ş­|sT\óX\ò\æ8m.|\ó\Õ\ôÁı\Õ\Ú˜Àx.X]sc\Ø\èe°¯\Ã<Á²m§B\\ûujş2>W<C§t9+X\ì Á\r\æ¬aÕ¼:…U30\ê_<-¨\ì<\Ê\ïÁ\Å\ô]\ZÒ…(\Ú:\ê°G•ªiQ!%\êTÊ¨4{\"5¨<#=“¤ª,Q{A:2RC\ÊQ»[fA¢]\öx^^\nTw\É\ÛGT&°\É[7±\İø*\÷YÊ«saŒøt8¿89m\àşºv¶±*~¿g“	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nxœ\í|xÕ™\è93£‡eÙ–±C\äD#\Ë6	\ò+~%¶CP\ìØ\í<\ÛI¤8ÁKcK¶^Ivœ†lHP\á\Ş\Ğh!-”\"\óLØ–Gy\ì×–@w\÷n»}\0M\é\İ\Ş\î\×ei·\åvib\İÿœÉ²1”-”\ì½_\æhş9\ç?ÿù\ß\çŸù0B(\0‡l[z+«;ÿ\ó”\Z!¼°ƒ½}\ëúşşüq„z\î„\ñ§O\î¨ş\àf„ıÆ§\ãa\Şü¥E¯\"´\Ü\ã†ƒ#¾_\È2 ”ÿ\r`zx\Ä;9Œªµ­€\é\ôZ·(¸Šø\Ã\İ08g½ú\óo¼Z»}\á½\ã›\r50şg„\ò\n½§°eoOBµ0¯3ø„½A­/\ë}˜·=\ï\ÃBıW\ö\ö\"´\õVÀ1~Á\'.\Z\ËıO„Ö®G(·<…\ã\'Q5Ì‡	}PƒÁ#\ñ\\„J\'“…ˆ\ís|\Ûm\Ïd­ùJU\áx\ó«‘\È\õ\î\êº\óø\ÂÙ´ˆ6†j\Ä ù€uš\ÃJ\Ï\ã?ş\æ\Ñ\ÜC¥!4\0W‚_³+\r¨%7f†Fw\0ßŒTH«ª\á\ÎÂ’»\å+s\r3?…k:\ârp<b\Â<›à½©—\ç\Ñ(\ã\ÂyYmS\Ã#|’Ì±¯«š‰¥ˆe_>ƒ´\äD—‹r¨{P\ìb\ë°\ĞÁıø¿§^û\àlh\ô¢\ëp`a¸U_·¿\ÖÁ,B·\Ô\çA\÷\ÜZn\ô\ó\ówpV\æÑ¹z±\ï \á?·¹*\ó|{\ÑŸ‰rÅƒ;t\ñs\r ^\ö\ê½\Øz\\:.—KÇ¥\ãÿ\ïƒkƒw¬‹t0\Ï \ã\'¢{\Ù>	\İ\'µ\èş\õ\É=&?KºO{\\,}\ğ}Ÿœ–±£G?KÙŸ\çÁü]±u¸t\\:>¿ÿübk\ğ\×: ÆŸù&“|£˜\Ó+‡¾\n\×e\È\0˜LT„V¢uh\êA‘Q=ŒE/\ò\×\Æ\ãˆ|\Ã8;\ï‚y?’`şLb5\Å_\0u0ƒ\Ğ\óD.\Ö!_\÷N#H[–¢\ÎbzR\ô`\Ìş’\ËE\ï¢\ß\ãjÜˆ·a;Ş…E<Ê¾‚Ÿ²u\Şu\ç·½ş\È\ß¾\îÚ©k<°\ß\äŞ‰\ñH8$\í	ü>\ïØ¨\Ç=2,ºœC\Â\àÀÕ»w\õ\ït\Øwl\ß\Ö×»µ{\Ë\æM»:;6´·-7tiex:]\×biu\åehZ—\İ\ô\ò2S·\Ä4\Ûb\åc¶­vsW½u½\Ñlv-\æ˜-Æ•´’SpE‰	°€U°Xt\õZº¶\î´\ó­\ÑA:	˜¾9#y~urN\éÅ˜–>{¬\Í\n£”q;\'‡\æMw$¦-|uG£®iÄ–\0\ŞfœÆ´£jù‚,qXbCV‹\ÙbvZ‹\ô\æ¾Á\è\é=Ì·Gş´\rÁ\é\Üa9•\ŞN{Œvl\0jÄ”\Ä\è§\÷4ª³\ì•ûƒ1\Ş\É\ó1u‰e¨\Û5\Ç\ğ Å¨Œ{\ì\à1,£f‹™w8N\Ç_,$\Ô3\ğbP\ó´\Û:m\Ã\Çzw\Ú\Ï \õ\Ùg0\Ó2\Ø\ì˜.†9ûH\n\Å2KdÀ“\ê\Â™\Ç-¥7±!4Eg9Š c\'XAq\Ú#\çiF\ÆdA¥T\rv„\ó4\'\Ï\Ø\Ô\à´2nJ¦^®Pka\Æ@fE\ì:)\à%ˆŒM§²imi6=“Á@,\êqÀ<´i=¡\Ç\Ø8\r<{(ú4šN³\ÏPN=\n\åP\ÜTš²F O6|Û¬\ÛvÚŸ\Ğ#\àO!P4“£¼¬uš\ÙlµÌ¦\õV;D¯u\Zo¶Bj“![\Ò\ÊCZ\Çl½vB;h„œ‡\ì^_^F²‹·[D£\Å1—\r¶N-]\ÑHd\È5š`Ó‚ºt\Ğ\Z•S$š\Å\ĞiÊ–t8-mƒ@bmŸ@9·óƒ±¡A+tyC[´d…@¨Qş4Ã–Lc®¯EkÁoj}Lg›c\é–\æ\ä\ÌU\è*yFMf4–\æÎ—½\Şji\å{¢N\Ëd ­\Û>bvÀ;f³1\Î\Òlœ\æP3\ì—\ÅLjF›­`[\ä\àkw?lR\â>\Z]\ÏOÛ¸RÁ)\ñz3\ìû¨2eY¿Ş‘²¢•\Æl‚s(Z”v\" [-\ï/ƒ¹\à¹^tw\î$kúvÚ£z—\Åe\ÛlQ\Ì6\òN‡1\êpR\ÃzP\r•—©f«“Rœ²\çKœ\Ã\0N\óhh\Ğ2$#\Èîœ™ªTœ¥“ˆ£WL¯\ÑNK«(\È)¸b,dœ™w9\ä”Aİ´n|$N!\â!¦”y\ÔĞ”aeøDc#s‡\îä°œƒ\àµ\n9Wb\\)\É<»96jŒy\Ö$‰›\Zâ£¼Á\Òh!€.n\'\ç`L)§@Š“š\ä :ÁÛ‡ —a\Û`4‘q°Œ+MJŠù­sXBI\Å} š)!\æÄ¦ºùA?8X\Ø=f#SÁ•Hr‘²\Û-\Û\Ó\rµ.B´\Ö\"²Œ1\r\Ü†\Ñb†j#›V\ö>Ñ‘\íP¯=†ŒÑ¨%\ZÃ bIûÒ˜º´ƒ\\\à´Z‚H\ä\ñ‚H×¶º\Ô;„›±\Õbv\0	SB}	ƒj1D€3\n\Ù\Û\r»MU’Í‰\ò\rQ¨Z»¡\àr¥\Î\íƒp[\à\r|OC-@&\'t‘É„i%„\Ö\ÓOi\ÌgŞ­)™\Å\ĞOÀ*k)WĞ¬\Ç\ëNh\è:{¬1¦`5L\ãq\ÔŠ8OU\Ò\îµAV\Éj>\Æ\ôÙ•\ğ\Ğ\õd©10y`h\Ù%·EsB\ßtY_Y¨š~\ô\ô“VÓ–@ c\è Okˆ9³I\0}PZ^\ÃRue ¢xe†\Z2¨¸‘\Ú$\ßyR>\áAA°\Óx:şB7\Ô\ÈA9\"^K‘”uTfLÜ¥&“¹B‘$\ÒÉ§ƒšŠ\ÖÑ†\êL\æd“Ts¯x\ï<É3+\Éb\åQeW*ûN4\Æ\Ü«K^¥V*8*·s+}\Ú\è‡\İ`1k ù°«øX¯n\"Ô¶£²W;\å\ê@²·YP\ä\ÒAù(†,0¶–eCŒa²gyœAXkYM.i–\Õ\Ó\Ö@µ\'\ÅÈ¡‡Buº\ä5x­6®!Fj\Z\è4\Z\ÛqRšú\ì*#\ç )S\Z›°*Y,\Ãqkr~‚\ìIMÂ“Z2MNª(»	97J8n\Õ.¸*ªıdÂ´J4citT£R\íÇ‹b\å\0u\Ê\á\êddÎr\0l©3\Z%¥mzw&Ù¡ú\ÒlÀ\ç€j\r dƒ¢%ø\æ\0¨\ÒMDk)†a»iˆ:r\ØJ\Òa\Â\0´/Ê©“\Ğ\æE£LŸ3\ğ°?nMP\ËN\0½u%r+\Ó\Êj9;\'¬èµ‘sH\ÚÈ©\ì¤te—\ê\çU}…½Ó´¹“–$3r£·$9’\Ñ4\Ö\Ã30gT\ÄR\Ş\0\îj¤ş,UamœÆšR…@E˜’\Æh4=QÿIù‡w%¢—\Èˆ„x@¬3\Ñ\Î\ÇfP´\åŒ\ä• •\í k‰¥·\çroJ#	P\ñ=øŠRs\è\ãDŠc(Šl\ÅT\ìb\â{M¢$¬‰µ	¿\r\Ó-­¬‡\í³,\ñ\Ô+\äN\ÃpU•š\Éi$®£\ÒH¬Êƒ\îA\İ\ë(»\ë¬<\ï\ç¬O[p£\ô[O¨µ¥´\ÈE\á\Ç#´\Ñ×˜\Å\ğ,\ÕC\á\rÀb\à\ñ\Z´F~²(\ïp\àJ\ìkŒ\rx¯8ÿu¡C.U\Ü\ä\á\ì‹\ò¼!¦¢|¼hÄP\÷*sŠƒ»¸ºT¡\"\Í)\Ó\í\õL´«œ@\Ş\Èt«:\ò–—xÁº\Óúq\Ó<YU*6`\Ùk&®ˆm·L\Â\ÃB‹%\Æ\ó» $²½\Ğ\Â\í4j!oR\Û\í2$S¸¬<§…\ÖX\ïh³C}!I7\átü‰Bòº””¶?!Mi¤Mˆ‹9”F²\÷Ë¹ªşt=²\È\ò¹REhtWt\'¼šcK‰`Ef:(\Ğ\äN¢	²\Åªâ¦«W\ÆM»+%Ó®\Ê¦şÊ¸igE\Ü\ä¨8k²—\ÅM;\Ê\ã¦\í\ågMÛ¬qSßŠNSïŠ¸©çŠ¸i\ë˜ºW\ğ¦-\Ë[M›—?bÚ´<n\Úxy\Ü\ÔU\Z7u–ZM\Å#¦\r\ÅgM\í\ÅqS[I\Ü\ÔZ\òˆi½%nj)Š›š\ÍgM\ë\Ìq“\Íüˆ\é*ş¬i-7]ÉŸ0­\á+MM\Ë$Sã²¸©Á7­6M™V-•L\õKã¦º¥gMµ…gM5…qSu\á#¦•U’©¢\ìJSy™dºb\ÅÕ¦U¼\Äx\Ù.K‘\ÍT\Ä.¹l—yÉ•&~\rtL\ËFL\ËV,\Îßµ´ n*Ì›Œu—5\ö/®\Ïo\ì_b\ë&ı\Ò_tYS¾{gnCÎ¶\ìÃ¶‡Á‘Ñ ß¦j`¶qp\êY\õ™\Û\Òt\Û4\r\êm™C\í@´\í6fµ\Æa@¬Í¦\Âg\ğÍ¨\Ï\ÚuZ\ï\éŠi»ûcøX¬¤—@xmˆ©\ÅĞ¶ı\öiŒor¹\ñF´´¹+vs¯ıqA$™–­\öi½\ÉÑŒ¬\Èjµ\"¥Ñ®2¶ZqJCp’²\Êy^!WúÉ5Aª\à\ç\Ì,Fªf\ÒPNüŸ\â¿bƒ²Š¿›8g\îÿ›ª\0\å\Èct\0]‹|\Ğ&\Z\é\ïCA4z‘ˆ\"È‹F€b`¢!\íD\êŠ´¨¯GnX1pŒÿ\r¢\0pÚ6Áz;\å \0¥fÇûAÊ‰\Ğ\÷À\È³‡\ç6\à\é¬„¶¢h7P\ìG\ò­\Ó+ªNÄ¢,”‹\ÊQ¥m\Éü’\ËUÅœ.Ï£\ã†Š¥Å¹¹˜‘V\ã«\r¯Vg\×\0°f\ç4T­Ü“m\Î.)*­«­¯©\Î_”§V™³Í¸´~U}}]m©¥H½È’˜Ñ¨\Õ\Z\ö•™ËŠ«ªŠ‹««gÖ±k\Ï‹\\SSc}\Ï\ö¾\à\×^wOwËª\"N\ÕùÁ\ÓoWW’\ó^\î;\ç\ß\ï+/k¯o\Úb\ï>x\ìÀX·«\Ö\ÚUG¾\Ç\Ó\Âsüc\r\Ò!£-C\Çi\ÕjºrTYĞ±¡²&´\á\Zla\Íl®™\Õ\â?>‡û\ìÔ…¸şü½_ªš?xO\Îe\Ì5\îØ”£ú%u)ùf«¹7J\á‰úi&c¼w;²Ö’\ßŒ!¤º¤f!“\ÍÀ¦e°z½\Z©A¬V[\ÓPI¼\Ê¹¸&Û¢\\c¯\à·;\ğ_˜^;³j|¦j­ªùü¯\Ø\Ë>xû\Æù?±ª?\õ›€;wp\ÏG<Zj\ËL+(X´\ñÀ=+\É¬Ê¡\Ü\Í\ÕùÔµË˜‚\\[ÁX\ÌÙ€“}o\á‘\ç¥\ãÑC\ë\ÛOo\Ê[µk\Ó\ÌË¸ºsoû‘kf¾«j\îü\ò¡©\'ù\ô\×\Ì<†\ëz#W^x•ùÁ\êÑ®=‡@‹\Ñø»\ì\×Ù·\Ñ2´™m\ÙKt’\Öb\ÉBú<d*D\éDªICvµjekQ)I\âU³A‡¨/ce[.W«/¯®_UÇ©\å\å\ã{û¾\ĞûU\\\ö\İbô‘§\"]7øl\÷jZ¦;]\÷\ÕÏ¼ÿ«\İ9¶ƒ»[É¬?¸{Ø¿\÷\Ö\õ…G<\"·v\õO]½\áU\öê±Šn?#û™ÀC†L”¤%\éZ”kHªVmÕ‹d`AvMR™\ìRª%\è\ó\î\Ä7\Ä\Ó\İwWúrZ\íW7\İT¶\âˆx\ä\è59\Ò;§zkOÿfFÿÁs7µ;n\Û\ñD\Ï\Øs=\õœ¢Ák\à%\ÈLbd\ÌGYDY>QNC\Í\rH \ÌË˜\ZP &“ÁfªS\òûC/\İşw¿`˜¸i\Ê<\Ä>Èºœ˜<\ö\Ø\ä¾/\äù_\Ço{g\ê½sY+\ÒNzœ#·me\Çn>™x;¤\ãoÁz”ù´\nI:¤£Ò«V\nD,Xœ—_S³Ÿ™8T\ñP¥£¼\ëF\'§9ûÁ\Úûa\çÿ=û3”‡\nlz«\ÖHX-¥+À4{d\Í!k©ºš\ìû\ïS—\í\ğ}·œZ¶©\Ãwk9ûú\íMo?r\á‹Ì®vÿUÎ¦›\õ\Ï{bÏ‘‚\Ï,\Ç™\ã\â’°„=‰I>Suüµ±±×\ß\òF \ğ\Æ-Ş©Õ«§¼ı\õ\õû\r“\ç\î9ùÎ¾}ïœ¼\ç\Üä‘S£Ş‡\áa\ï\è©\"\óş™»¹\\ˆ‰’¹Ù™\é\ÒeŠY(“\Ô.9/ªV\ö&\ì¢\â-E¥—g\ãj¥^i²\ó\ó\ï@Uû o/ÉŒ\î{+qŞ‘£‡\öX±ü\Ø\ÌİªÚ“›‡\öüüÔƒ\çB½f²\ñ›\ÏO?\ñœ´q\æ\Ø\ÆÙ§\Ì1\ö\'(-²¥§%„\ë\áI\Ö,\"¶‚/¿¤^qK$¯ \Ã\ßÃ³¯?´qø®Ò–²}¤\ÆC†kª\Ğ2[N™^µ|Yn±™k¤´„+in-ª`\êj \ÎÔ‚\ËaP»–¡{\ÏR«dy~Œ\ò \å>\è9¼\êşG\ö¾(İ»y•\óúÍ›¬y\à€cg°z\Üå»µ«\ÉscN\ñ\ækvJ»;ú6´™\í¾\Şu\Îfs\ñÆ½}\î\í¶\õ—\×[/Ù°Ç¾1\Ğ^D´\äÁ\Ş~\îQ\È!£-S™™6ªIWK9JU[k²k\Éh©«©«Y¦+Iù/\ã‡*¿\ò•‡\Ş{¯\Ò1\n‰\Éè¾ı\ö\Ñ\çû…£„\ó\ñß²?b_W²S\'eqÀV—\Ü\İ\òŞ–3œ˜¾J\Ù\İø‡_¿ık\Ëú¶øo-ÿ\Úıª\ÊG²¾\õ s\à\Â=\Í\î\Æş5\Ì\ã\ç«oo“\ó\ó\ß\Ø7Ù·h®”\Ø\ò²t’^-,¡5$?7YE ¶Q0¯’\Ô-TIş}\ò±İ®gú\îª •\äÁ-¾›­ËŠ‡o˜\Ê\İ\ó\ó‡Nı<´³\ë¶\ó\Õ\'ºúy:\ñ\ä\ñ\Å\Ø\ß\"š\ô2\åÌŸT}¨•B\Öf\ğK—šµY\Ú\Å\ì¤\ÏE•5/W@…­&^\\§h°jÎ5?¥\Ä\Ò\íƒ;›\÷¬?ü\îWo\Ø8|\â\é\ã;o»QS{ce\÷!\ó\÷\ë`\ÊkG6-g\êw¬o\ß\İ_\ò\\ø?¾+\×\ï\ÙrÕl\×\Ö\ÆfY#vh”:e>e\Ğ\"O4!;wİ‡w®²q‰\à—¥‡‡¤\ñ‡w\ï~xü X6\Ôq¹˜r\áÉƒSO\r\nO]s\ğIa\ò¾É©\ÎûL\ŞGbü8à»ªeP½\nl\é*µZ§\×KX\Ç)wnš9Ù™Œ¦n-³ª&›Ybt\ë\ë=\î3\İ\Ãm(i­\×9³s°\ìƒ_\0#0û\r\å³È¦>X—|Z©\Ç\Û\ò·…\Ú\Û\÷\r,¹#\Ée œr·T†gÿ¥.œJ…\Ó[7Á¶¬\Â%ly \Ğq­\Óx\'¯ÙsR\ß\Ö\ÅùrxzP,R«\Ùn\òc?\ò%\Ì[ÀsV³ù<g\í«^<pİ–\Í7Œ\ŞÁ\Ä\Í\Í5z…+p™V\ç\Ø|\Ğ,\çª\ZMC•Öššùj9\nƒ}\õımùû™©I@_¶z\éù%O5“L>§*°;\È\ß~\ÌL3>‡\í2f¦™`\Ø\Ä\çÔ¿–1 3ƒ¿»K\ZZ„rmi\È`\Ğq]QŸŠ\î-e\èd4l\Ê\àCÁcÙ•«;:V×··\ã/…q\É	\ò„ub\æ\'¡GG]}[[}]\Éı\ëY/ üs!\Ót\Z\Í\ä™‰Õ‚\Ü1“=ük}\Öı™3›\õ†²\ÒY\ï@lt\÷\î±o%®ãŸ«f\ê—\àiV\÷Â£¼¼rk`\æ;/\Î\ÄUOãŒ™ÿ\0\ÉgÀ\Â\ÍB)A0×™1ª%\×m\İzÃˆé™j\æ{\\Wq[½şÌ®A\ë¿¸\õV\òÀ<€¡»ÿŸn\ßı\ì\Z\Öÿ7j;?u»\'¥½ı¹¶©±\Îk\â_\ÔN\Ñ\öš\ÜXÓ‡\Ú\Æd\Ûÿ™·>m\ãÒ¸µ—Ú¥v©ı\ÛĞ§jGh§h-\Ğşa\ö´\óÿ\õ¦Z\è\ÈüTm\í_µ\\j¥\íÿ\\ù{\îRü:ı=B\ò]\êjú\ÜO\é©`$\÷¤a\÷(}6Ï¥\ôU(›İ«\ô\Õ)x\rjH\ö3\ğ\Ë\ì\rJ?YU›”¾!…>{V\æZ¥\ğ\Ä*¤RRúi)4MH¯:¬\ô\×\0ıq\ò[‘\\\Z(Tİ¦\ô1\Ò\éUJŸA™ú	¥Ï¦à¹”¾\n\é(}u\n^ƒ¤d_‹rT_Qúi¨PJé§£>ıKJ_ª2\n”~{,£]\ég¢\í†7”¾!…\ö¬n`»>»Dé«.{¥\ÒOK¡iB‹³›”ş\Z \ïı:_]U]\Ëo\ò8¥@(0\æ[R0 	aOÀ_Á¯\ózùÏˆ;\â{Ä(‹®\n¾\Ï-\òEc¢\ä/\â\ÃÂW\ä\Ã|\Ø\í	\ñ\Ã˜ŸB¼K½ \è\â=~>(Ha>\òøGx…#®I~h’_\çwI7\ñm§;\Äü°^\ä%\Ñ+~\'eHø“%AÁ#…ø\å\îp8j¬¬\ñ„İ‘¡\ngÀW)\0±|˜p¨T¨\Ë)u\å70T\éBaQª\Ü\Ø\ÑÒº¹·µ\Â\çZQ¶\'%b½²!U‡\n¾[”|P\Ì\æÁ·(‰ \åˆ$øÃ¢«Œ–Dª–\Ó-H#b\ğ‚’ŠR†Â‚\Ç/[\èIN’\Ä.^…N\0üxWÀ\ñ‰ş0u3?\ì\ñŠ`#\ñAQ¯²¢h\â/q\"™KL\ñ\à„@$…%“\ğ(\"§7\â\":$¦½ŸG‘@\İ+\Ç˜FB`Ñ³Œ\÷\\ar©YÁÈ\×r—\ñ.a=	2DN\ÑOV•‰‰ÀÁzS[gµ£4DJ84¬¸ˆÊp|s-!IĞ…\Ü\"]\ã\n€Ë¨\ÄQ\Ñ&B>\ğz\Ä4gÀ\ï\ò‹B4\r…¡À¸HM‘\Ã\ê„ASY\âÿ\àlP•©[\0Õ‡D\Å_rŠ\n)\ÖHDz(q\÷€\ëa+Pq\ó­¬XBDK‚K\ô	\ÒX‚hv3HH\æMÀü  ¢G‰xi;¸…¨U]Qµ²iKM}\İ\ì¢P$\ôz@3²Ÿ*xG \Âû„Iµ”m®qJ¢@\â±\nz…I\Ù\ñA\É³\à§0¤¤œ’t\ÏD;%–<\ìµW\é\Ëy\ñ!‚RÀq†!*°ÿamY“\0Î›p{œ\îy \á\ÜY\í~\ï$¿Ü³‚}C¢+…8|œ¶”œ¦uJ¶‡\æD/É«‰z`¹¤„E©b’¤º~o@p\Í\õ »J”ˆ90Â¾\êE2hÜ¢78×£Pa\Û\Ë\ä$ $Ç¤€\Û3\ä+U\n¶w¨Â—\ğ ­V\á\É`\0ªI\Ğ=Y	I	\ïI\Â\î\ğ¸\Â\î-A\ÈLÈµ^\Ï>±#,@|\Ğ\×ªQœµ\ĞÛ„<È‰$@!8‡Qp-Ğ“PB0\èùQÌ¬C^h<\ê\Ür\Ã\\ˆD¸Š@=\ĞE)û`V„k\Z£3~\è\ñ@/ !\à@fˆ4‚q/\Âe˜J!\ò\'€Š`\\@7Nÿh \0\Ú\Î<\ĞúB¢´ $¸\èp†\0\ÊI\èQ¸f]@ık\è·Áœ$†¨|¿\"Ÿh#Q9D\0xgŠ†	ıRˆl`\å\ÔaÀ…P#ª„6s„g¤W\0Ÿ\0\òVPtQ9\ğL\èP9wy\n\ïJ\ê§\0ÀJ\à P»m%Úˆ: B­h3\êX³.´‚ú¼…úi¨Ñ‘#½5|¤Èºn\Ê\ÙG\ãR¢\Í+Qq\Ó9Q\ñ\å\Í?\ÕÅ…\Êh\Ô\Èì¬·W›À•Qÿhdüt}r)ˆuaj±NŠÎ‘DNP¢\Â\ÙE¯!:\ëJAÑdÁDÀ6‘j=›\ÍDs¸\Çp2_{\ç\É(\ï\ÎZBrR {À3\'\æ¯\"Y,gB\0ä‡•#Q”\èK\èQ¦pr\Ïı\Ù\óW{aì£¸Tf³7u?ÊšF\è,K\ñ\'\éû O¤\'\ÇbJ´‚4o½\Ô\ÛnŠqÑ¾¬\õ\ÕE¦%)Ô·	Yr<*i\í\à)V®²\Åß³q]\Èwe)q•m	&34</‹fí \Ş\ò}lL•&¢\ìº¥œ•ã¢pµq(œT®L“\àNê•—\îÑ‰dÔœT\'\ÕÓ£\è×˜R\rI\õĞš6•\Ô\İ\ê\\X\ñiªù?\ë‡Ô:wUˆ\î@\Ù\ëCŠÕ³ù•ZE…ˆ”´=D\ó\ÍO¹\ËY/\ßf­ûs±¬€º¤%ı/Pz‰şÁ—H«›•p>§…\îL#t³\õ†\Ä<Hµ”-¨ \÷£ú‹@„\óv%[Şª\nR›\ĞTƒ\êQ\èV\î4Dª@+º¨\äW¢¾\Ë\Õ}‚¶\n\Z¹º\Í\Öú0Ä”xI®•A\à0	\Ø\Ä\İ-¤\Ô\óT^A¸‡’<\òDˆz!Hw Ó„R\Ñ\ÔK<•4™¬\ßm\å¬v\Òh	\Éı-\ïû \õ\á\äœ¤+¯u*\\De,\Ì\Ë\Òp²\Ë\÷Dl\ç\Ö\r^¹·ùR\òo.fxN=û\óy¤c½Ë…•½,?Ÿ\ÈrË’r\æ[ \ïŒ	%\î\ğY\â	eş\ÎZ\È\÷d—\ö–ı\n¸’œJÖs—uøK};\Ë}\ön²\ğ½g!R\ïks\õjJ\Éb‰lK˜\ÊK<+J\ô:©T\Ò	jy€\î\ó\Ë=aNV‰4.†•\'^¹•û¡ül˜¨y2·\ò¦—£\òS¬_‰\Ì,\÷\ÄI\ÔY’?nz\Ï\ó(~®øĞ³ütú‹\ê|\' ¶\ì\0\î‰;Àè¹¨V[h\Õ$\\\åº\Ûı}@\ÙA+²¼P\òù\Å\ï%ÿ›pÁ+W\ò\Ù!×¥\ô].¯®\äÿ1Ö…\ä>ù\ïu\ä%¦/\ğ\ÂkpmEmCEUT‡ùšŠ•d8\âºC=C|}´&\Ş\"«¼SU\ÑP±º‰¼¹\Ğ\×\ìù.a\ÜC^Hù:§se•³Î¹Qû\Ëø–I\É[Æ·K¢8VÆ{\Êe\ì\ĞH¹<’”NdŒvş¢E\Ôi\éog\æQX‹˜@0´7!4\ïI˜Cx^•°\n1xE\ÂkÀ«ZT7‰5\ô¯›L¾;C(ı²»\ÉO¸\éÿ\\¾XKp¦2J\ç¢}–\ö‘‚Ï”À\ô@0K\à$¿¡‚a‘\ïaka´\Zù½	À~D¾[œBÿ\à	\ôÀo¢3\0ÿ½\ğ=\ô;€¿}1Ö€ŒÓ±`&^ĞŠ·\0ÜŠ\0E|\à58\n\ğ‹ø›\0ÃƒnOã§¡\Z?\ğ\Ûø\Û\0_À\ßø\Zù\îÿ\0ÿO€?\Ä?ø&~\à9|\à;ø_\0şƒtü{ü>À?\â8\Â\Ëh\0¦1\é\03\Éÿ\Âdr˜¥\0M\Ì\0Ë˜\n€uLÀ5Ì•\0[˜M\0·2[\ö2}\0·3;\0:˜\0\ğ\ãbFúÀ 8ÁL¼¹\àM\Ì-\0\ïb\îø\0\ó\r€1\Ó\0Ÿdø\óÀg°‹yy\à«\Ø\Åü€ù\'€?bş\àO˜Ÿ\0ü\ó3€o1o<Ç€\Ì/™\ß\0üw\æ=€¿cÀR\æ}\æ<ÀfaL¨aÁ\çl&›	\ĞÀ\Z\0\æ°9\0\ó\Ù|€‹\Ù\Å\0—±\Ë\0±\å\0«\Ø*€6vÀ¶a\òs%€­\\+À«¹«\äN|”{±\Ü\ÜS\Ğšû1\ô\Êıú¿\âş7ÀwU*š\Ë,ı\ZÑ¿u¯¦ÿÿ\óq\î\îU\î\ï ¿XX\÷,BÜ·¸—Šû>\ğ\È 9\Èı-\÷\òÿš\ó©¿\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nxœ-\Ì\Í@@à·¿\'c\ô@\npÕ€vĞ‚»\Ü\èAªPÁZyr\È7“\äˆ‚Š½\0>6r\êLEV²v º‰„9\Ï]2:ş,¡‰!–8¢\È\éc.=%B~	MO‚\Ğ\ÖB·\0/\İg\Å\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',28),(11,'Jun',7,'Aceptado','actividades correctas',_binary '%PDF-1.7\r\n%µµµµ\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nxœOMk\Ã0½üŞ±-4‘\ì8®!\Z§-\Ëa4°ÁØ¡‡.§†~ü˜\Ò\ì\Ğ\í4$¤\÷¤‡|>¨ª¼MO\r(9=f\ÇÛ²}ŸÇˆºI¸hEØ€PJ\öÁ\àz\Ô\êmA«º\Ó*\ß2è¾´b!\Æù¬\ğ²€\î$œİ	ıM¢ŸZşiwZ}TD+—V\ê¶ vØ®¥®bQ—\î>¶M *y¢X#pŠ~„\×1ˆ05Ä¦Y£\È:ŠŸèµ\ÚÈ‹¯Zı×‹ù\ëÅº\"+ìƒ—»ƒ\é\ïæ¿`\Ó&|ù\óEr\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(şÿ\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\á\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(şÿ\0M\0i\0c\0r\0o\0s\0o\0f\0t\0®\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nxœmQÛŠ\Â@}_\ğ\ò\éx[\Ä.b)­°\â\ÃX³m±‘q\nú\÷›l»k\öa†œ\ä\ä\ÌÉ¤@\0j\n#j*\à3f\Ì\ç†c.M`8@_Áp:\Ù#ac‚7\ÂÄ»:\õ\ë’*\Ü!8F„3Ÿ\÷Şš–QÛ²²i]‘\ñÿu\ö\ÅJ|‚¶«\Ã88¢\ØZ±-i¯o\âQ\ô\"\íXKªbW2,\Ó\ØÕ~GOP­ô†µŒ\õ„¡\\ksyS\Ï\ö	¥·¤/\äšXz~\ãS†’\\‹CI,+h_X\Ób\ç‹/\ÍÁú´\îz¶\öúš^2\÷œÈ‹I{:\ÛÁËœ\ï^º´Y\'‘”Å…:\Ü\æ¦eNW¸)²\Ú\ñ(…/	·\n—¶’W&\Í-OpÓ¦ı‡°®\î¼1\Ùn\÷\çC]\Ñı\ØÀ\×Zzo\ß\Ï/¬\Ü\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nxœ]\Ñ\Íj\Ã0\0à»Ÿ\Â\Ç\îP\âüµ„@—¬\Ã~X¶Hm¥3,q\ÜC\Ş~¶T:˜!I¶%\'M\×vF{¼»Y\ö\àù¨r°\ÌW\'Ÿ\á¢\rKWZú›\ğ/§Á²$\÷\ë\âa\ê\Ì8³ª\â\ÉG.Ş­|sT\óX\ò\æ8m.|\ó\Õ\ôÁı\Õ\Ú˜Àx.X]sc\Ø\èe°¯\Ã<Á²m§B\\ûujş2>W<C§t9+X\ì Á\r\æ¬aÕ¼:…U30\ê_<-¨\ì<\Ê\ïÁ\Å\ô]\ZÒ…(\Ú:\ê°G•ªiQ!%\êTÊ¨4{\"5¨<#=“¤ª,Q{A:2RC\ÊQ»[fA¢]\öx^^\nTw\É\ÛGT&°\É[7±\İø*\÷YÊ«saŒøt8¿89m\àşºv¶±*~¿g“	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nxœ\í|xÕ™\è93£‡eÙ–±C\äD#\Ë6	\ò+~%¶CP\ìØ\í<\ÛI¤8ÁKcK¶^Ivœ†lHP\á\Ş\Ğh!-”\"\óLØ–Gy\ì×–@w\÷n»}\0M\é\İ\Ş\î\×ei·\åvib\İÿœÉ²1”-”\ì½_\æhş9\ç?ÿù\ß\çŸù0B(\0‡l[z+«;ÿ\ó”\Z!¼°ƒ½}\ëúşşüq„z\î„\ñ§O\î¨ş\àf„ıÆ§\ãa\Şü¥E¯\"´\Ü\ã†ƒ#¾_\È2 ”ÿ\r`zx\Ä;9Œªµ­€\é\ôZ·(¸Šø\Ã\İ08g½ú\óo¼Z»}\á½\ã›\r50şg„\ò\n½§°eoOBµ0¯3ø„½A­/\ë}˜·=\ï\ÃBıW\ö\ö\"´\õVÀ1~Á\'.\Z\ËıO„Ö®G(·<…\ã\'Q5Ì‡	}PƒÁ#\ñ\\„J\'“…ˆ\ís|\Ûm\Ïd­ùJU\áx\ó«‘\È\õ\î\êº\óø\ÂÙ´ˆ6†j\Ä ù€uš\ÃJ\Ï\ã?ş\æ\Ñ\ÜC¥!4\0W‚_³+\r¨%7f†Fw\0ßŒTH«ª\á\ÎÂ’»\å+s\r3?…k:\ârp<b\Â<›à½©—\ç\Ñ(\ã\ÂyYmS\Ã#|’Ì±¯«š‰¥ˆe_>ƒ´\äD—‹r¨{P\ìb\ë°\ĞÁıø¿§^û\àlh\ô¢\ëp`a¸U_·¿\ÖÁ,B·\Ô\çA\÷\ÜZn\ô\ó\ówpV\æÑ¹z±\ï \á?·¹*\ó|{\ÑŸ‰rÅƒ;t\ñs\r ^\ö\ê½\Øz\\:.—KÇ¥\ãÿ\ïƒkƒw¬‹t0\Ï \ã\'¢{\Ù>	\İ\'µ\èş\õ\É=&?KºO{\\,}\ğ}Ÿœ–±£G?KÙŸ\çÁü]±u¸t\\:>¿ÿübk\ğ\×: ÆŸù&“|£˜\Ó+‡¾\n\×e\È\0˜LT„V¢uh\êA‘Q=ŒE/\ò\×\Æ\ãˆ|\Ã8;\ï‚y?’`şLb5\Å_\0u0ƒ\Ğ\óD.\Ö!_\÷N#H[–¢\ÎbzR\ô`\Ìş’\ËE\ï¢\ß\ãjÜˆ·a;Ş…E<Ê¾‚Ÿ²u\Şu\ç·½ş\È\ß¾\îÚ©k<°\ß\äŞ‰\ñH8$\í	ü>\ïØ¨\Ç=2,ºœC\Â\àÀÕ»w\õ\ït\Øwl\ß\Ö×»µ{\Ë\æM»:;6´·-7tiex:]\×biu\åehZ—\İ\ô\ò2S·\Ä4\Ûb\åc¶­vsW½u½\Ñlv-\æ˜-Æ•´’SpE‰	°€U°Xt\õZº¶\î´\ó­\ÑA:	˜¾9#y~urN\éÅ˜–>{¬\Í\n£”q;\'‡\æMw$¦-|uG£®iÄ–\0\ŞfœÆ´£jù‚,qXbCV‹\ÙbvZ‹\ô\æ¾Á\è\é=Ì·Gş´\rÁ\é\Üa9•\ŞN{Œvl\0jÄ”\Ä\è§\÷4ª³\ì•ûƒ1\Ş\É\ó1u‰e¨\Û5\Ç\ğ Å¨Œ{\ì\à1,£f‹™w8N\Ç_,$\Ô3\ğbP\ó´\Û:m\Ã\Çzw\Ú\Ï \õ\Ùg0\Ó2\Ø\ì˜.†9ûH\n\Å2KdÀ“\ê\Â™\Ç-¥7±!4Eg9Š c\'XAq\Ú#\çiF\ÆdA¥T\rv„\ó4\'\Ï\Ø\Ô\à´2nJ¦^®Pka\Æ@fE\ì:)\à%ˆŒM§²imi6=“Á@,\êqÀ<´i=¡\Ç\Ø8\r<{(ú4šN³\ÏPN=\n\åP\ÜTš²F O6|Û¬\ÛvÚŸ\Ğ#\àO!P4“£¼¬uš\ÙlµÌ¦\õV;D¯u\Zo¶Bj“![\Ò\ÊCZ\Çl½vB;h„œ‡\ì^_^F²‹·[D£\Å1—\r¶N-]\ÑHd\È5š`Ó‚ºt\Ğ\Z•S$š\Å\ĞiÊ–t8-mƒ@bmŸ@9·óƒ±¡A+tyC[´d…@¨Qş4Ã–Lc®¯EkÁoj}Lg›c\é–\æ\ä\ÌU\è*yFMf4–\æÎ—½\Şji\å{¢N\Ëd ­\Û>bvÀ;f³1\Î\Òlœ\æP3\ì—\ÅLjF›­`[\ä\àkw?lR\â>\Z]\ÏOÛ¸RÁ)\ñz3\ìû¨2eY¿Ş‘²¢•\Æl‚s(Z”v\" [-\ï/ƒ¹\à¹^tw\î$kúvÚ£z—\Åe\ÛlQ\Ì6\òN‡1\êpR\ÃzP\r•—©f«“Rœ²\çKœ\Ã\0N\óhh\Ğ2$#\Èîœ™ªTœ¥“ˆ£WL¯\ÑNK«(\È)¸b,dœ™w9\ä”Aİ´n|$N!\â!¦”y\ÔĞ”aeøDc#s‡\îä°œƒ\àµ\n9Wb\\)\É<»96jŒy\Ö$‰›\Zâ£¼Á\Òh!€.n\'\ç`L)§@Š“š\ä :ÁÛ‡ —a\Û`4‘q°Œ+MJŠù­sXBI\Å} š)!\æÄ¦ºùA?8X\Ø=f#SÁ•Hr‘²\Û-\Û\Ó\rµ.B´\Ö\"²Œ1\r\Ü†\Ñb†j#›V\ö>Ñ‘\íP¯=†ŒÑ¨%\ZÃ bIûÒ˜º´ƒ\\\à´Z‚H\ä\ñ‚H×¶º\Ô;„›±\Õbv\0	SB}	ƒj1D€3\n\Ù\Û\r»MU’Í‰\ò\rQ¨Z»¡\àr¥\Î\íƒp[\à\r|OC-@&\'t‘É„i%„\Ö\ÓOi\ÌgŞ­)™\Å\ĞOÀ*k)WĞ¬\Ç\ëNh\è:{¬1¦`5L\ãq\ÔŠ8OU\Ò\îµAV\Éj>\Æ\ôÙ•\ğ\Ğ\õd©10y`h\Ù%·EsB\ßtY_Y¨š~\ô\ô“VÓ–@ c\è Okˆ9³I\0}PZ^\ÃRue ¢xe†\Z2¨¸‘\Ú$\ßyR>\áAA°\Óx:şB7\Ô\ÈA9\"^K‘”uTfLÜ¥&“¹B‘$\ÒÉ§ƒšŠ\ÖÑ†\êL\æd“Ts¯x\ï<É3+\Éb\åQeW*ûN4\Æ\Ü«K^¥V*8*·s+}\Ú\è‡\İ`1k ù°«øX¯n\"Ô¶£²W;\å\ê@²·YP\ä\ÒAù(†,0¶–eCŒa²gyœAXkYM.i–\Õ\Ó\Ö@µ\'\ÅÈ¡‡Buº\ä5x­6®!Fj\Z\è4\Z\ÛqRšú\ì*#\ç )S\Z›°*Y,\Ãqkr~‚\ìIMÂ“Z2MNª(»	97J8n\Õ.¸*ªıdÂ´J4citT£R\íÇ‹b\å\0u\Ê\á\êddÎr\0l©3\Z%¥mzw&Ù¡ú\ÒlÀ\ç€j\r dƒ¢%ø\æ\0¨\ÒMDk)†a»iˆ:r\ØJ\Òa\Â\0´/Ê©“\Ğ\æE£LŸ3\ğ°?nMP\ËN\0½u%r+\Ó\Êj9;\'¬èµ‘sH\ÚÈ©\ì¤te—\ê\çU}…½Ó´¹“–$3r£·$9’\Ñ4\Ö\Ã30gT\ÄR\Ş\0\îj¤ş,UamœÆšR…@E˜’\Æh4=QÿIù‡w%¢—\Èˆ„x@¬3\Ñ\Î\ÇfP´\åŒ\ä• •\í k‰¥·\çroJ#	P\ñ=øŠRs\è\ãDŠc(Šl\ÅT\ìb\â{M¢$¬‰µ	¿\r\Ó-­¬‡\í³,\ñ\Ô+\äN\ÃpU•š\Éi$®£\ÒH¬Êƒ\îA\İ\ë(»\ë¬<\ï\ç¬O[p£\ô[O¨µ¥´\ÈE\á\Ç#´\Ñ×˜\Å\ğ,\ÕC\á\rÀb\à\ñ\Z´F~²(\ïp\àJ\ìkŒ\rx¯8ÿu¡C.U\Ü\ä\á\ì‹\ò¼!¦¢|¼hÄP\÷*sŠƒ»¸ºT¡\"\Í)\Ó\í\õL´«œ@\Ş\Èt«:\ò–—xÁº\Óúq\Ó<YU*6`\Ùk&®ˆm·L\Â\ÃB‹%\Æ\ó» $²½\Ğ\Â\í4j!oR\Û\í2$S¸¬<§…\ÖX\ïh³C}!I7\átü‰Bòº””¶?!Mi¤Mˆ‹9”F²\÷Ë¹ªşt=²\È\ò¹REhtWt\'¼šcK‰`Ef:(\Ğ\äN¢	²\Åªâ¦«W\ÆM»+%Ó®\Ê¦şÊ¸igE\Ü\ä¨8k²—\ÅM;\Ê\ã¦\í\ågMÛ¬qSßŠNSïŠ¸©çŠ¸i\ë˜ºW\ğ¦-\Ë[M›—?bÚ´<n\Úxy\Ü\ÔU\Z7u–ZM\Å#¦\r\ÅgM\í\ÅqS[I\Ü\ÔZ\òˆi½%nj)Š›š\ÍgM\ë\Ìq“\Íüˆ\é*ş¬i-7]ÉŸ0­\á+MM\Ë$Sã²¸©Á7­6M™V-•L\õKã¦º¥gMµ…gM5…qSu\á#¦•U’©¢\ìJSy™dºb\ÅÕ¦U¼\Äx\Ù.K‘\ÍT\Ä.¹l—yÉ•&~\rtL\ËFL\ËV,\Îßµ´ n*Ì›Œu—5\ö/®\Ïo\ì_b\ë&ı\Ò_tYS¾{gnCÎ¶\ìÃ¶‡Á‘Ñ ß¦j`¶qp\êY\õ™\Û\Òt\Û4\r\êm™C\í@´\í6fµ\Æa@¬Í¦\Âg\ğÍ¨\Ï\ÚuZ\ï\éŠi»ûcøX¬¤—@xmˆ©\ÅĞ¶ı\öiŒor¹\ñF´´¹+vs¯ıqA$™–­\öi½\ÉÑŒ¬\Èjµ\"¥Ñ®2¶ZqJCp’²\Êy^!WúÉ5Aª\à\ç\Ì,Fªf\ÒPNüŸ\â¿bƒ²Š¿›8g\îÿ›ª\0\å\Èct\0]‹|\Ğ&\Z\é\ïCA4z‘ˆ\"È‹F€b`¢!\íD\êŠ´¨¯GnX1pŒÿ\r¢\0pÚ6Áz;\å \0¥fÇûAÊ‰\Ğ\÷À\È³‡\ç6\à\é¬„¶¢h7P\ìG\ò­\Ó+ªNÄ¢,”‹\ÊQ¥m\Éü’\ËUÅœ.Ï£\ã†Š¥Å¹¹˜‘V\ã«\r¯Vg\×\0°f\ç4T­Ü“m\Î.)*­«­¯©\Î_”§V™³Í¸´~U}}]m©¥H½È’˜Ñ¨\Õ\Z\ö•™ËŠ«ªŠ‹««gÖ±k\Ï‹\\SSc}\Ï\ö¾\à\×^wOwËª\"N\ÕùÁ\ÓoWW’\ó^\î;\ç\ß\ï+/k¯o\Úb\ï>x\ìÀX·«\Ö\ÚUG¾\Ç\Ó\Âsüc\r\Ò!£-C\Çi\ÕjºrTYĞ±¡²&´\á\Zla\Íl®™\Õ\â?>‡û\ìÔ…¸şü½_ªš?xO\Îe\Ì5\îØ”£ú%u)ùf«¹7J\á‰úi&c¼w;²Ö’\ßŒ!¤º¤f!“\ÍÀ¦e°z½\Z©A¬V[\ÓPI¼\Ê¹¸&Û¢\\c¯\à·;\ğ_˜^;³j|¦j­ªùü¯\Ø\Ë>xû\Æù?±ª?\õ›€;wp\ÏG<Zj\ËL+(X´\ñÀ=+\É¬Ê¡\Ü\Í\ÕùÔµË˜‚\\[ÁX\ÌÙ€“}o\á‘\ç¥\ãÑC\ë\ÛOo\Ê[µk\Ó\ÌË¸ºsoû‘kf¾«j\îü\ò¡©\'ù\ô\×\Ì<†\ëz#W^x•ùÁ\êÑ®=‡@‹\Ñø»\ì\×Ù·\Ñ2´™m\ÙKt’\Öb\ÉBú<d*D\éDªICvµjekQ)I\âU³A‡¨/ce[.W«/¯®_UÇ©\å\å\ã{û¾\ĞûU\\\ö\İbô‘§\"]7øl\÷jZ¦;]\÷\ÕÏ¼ÿ«\İ9¶ƒ»[É¬?¸{Ø¿\÷\Ö\õ…G<\"·v\õO]½\áU\öê±Šn?#û™ÀC†L”¤%\éZ”kHªVmÕ‹d`AvMR™\ìRª%\è\ó\î\Ä7\Ä\Ó\İwWúrZ\íW7\İT¶\âˆx\ä\è59\Ò;§zkOÿfFÿÁs7µ;n\Û\ñD\Ï\Øs=\õœ¢Ák\à%\ÈLbd\ÌGYDY>QNC\Í\rH \ÌË˜\ZP &“ÁfªS\òûC/\İşw¿`˜¸i\Ê<\Ä>Èºœ˜<\ö\Ø\ä¾/\äù_\Ço{g\ê½sY+\ÒNzœ#·me\Çn>™x;¤\ãoÁz”ù´\nI:¤£Ò«V\nD,Xœ—_S³Ÿ™8T\ñP¥£¼\ëF\'§9ûÁ\Úûa\çÿ=û3”‡\nlz«\ÖHX-¥+À4{d\Í!k©ºš\ìû\ïS—\í\ğ}·œZ¶©\Ãwk9ûú\íMo?r\á‹Ì®vÿUÎ¦›\õ\Ï{bÏ‘‚\Ï,\Ç™\ã\â’°„=‰I>Suüµ±±×\ß\òF \ğ\Æ-Ş©Õ«§¼ı\õ\õû\r“\ç\î9ùÎ¾}ïœ¼\ç\Üä‘S£Ş‡\áa\ï\è©\"\óş™»¹\\ˆ‰’¹Ù™\é\ÒeŠY(“\Ô.9/ªV\ö&\ì¢\â-E¥—g\ãj¥^i²\ó\ó\ï@Uû o/ÉŒ\î{+qŞ‘£‡\öX±ü\Ø\ÌİªÚ“›‡\öüüÔƒ\çB½f²\ñ›\ÏO?\ñœ´q\æ\Ø\ÆÙ§\Ì1\ö\'(-²¥§%„\ë\áI\Ö,\"¶‚/¿¤^qK$¯ \Ã\ßÃ³¯?´qø®Ò–²}¤\ÆC†kª\Ğ2[N™^µ|Yn±™k¤´„+in-ª`\êj \ÎÔ‚\ËaP»–¡{\ÏR«dy~Œ\ò \å>\è9¼\êşG\ö¾(İ»y•\óúÍ›¬y\à€cg°z\Üå»µ«\ÉscN\ñ\ækvJ»;ú6´™\í¾\Şu\Îfs\ñÆ½}\î\í¶\õ—\×[/Ù°Ç¾1\Ğ^D´\äÁ\Ş~\îQ\È!£-S™™6ªIWK9JU[k²k\Éh©«©«Y¦+Iù/\ã‡*¿\ò•‡\Ş{¯\Ò1\n‰\Éè¾ı\ö\Ñ\çû…£„\ó\ñß²?b_W²S\'eqÀV—\Ü\İ\òŞ–3œ˜¾J\Ù\İø‡_¿ık\Ëú¶øo-ÿ\Úıª\ÊG²¾\õ s\à\Â=\Í\î\Æş5\Ì\ã\ç«oo“\ó\ó\ß\Ø7Ù·h®”\Ø\ò²t’^-,¡5$?7YE ¶Q0¯’\Ô-TIş}\ò±İ®gú\îª •\äÁ-¾›­ËŠ‡o˜\Ê\İ\ó\ó‡Nı<´³\ë¶\ó\Õ\'ºúy:\ñ\ä\ñ\Å\Ø\ß\"š\ô2\åÌŸT}¨•B\Öf\ğK—šµY\Ú\Å\ì¤\ÏE•5/W@…­&^\\§h°jÎ5?¥\Ä\Ò\íƒ;›\÷¬?ü\îWo\Ø8|\â\é\ã;o»QS{ce\÷!\ó\÷\ë`\ÊkG6-g\êw¬o\ß\İ_\ò\\ø?¾+\×\ï\ÙrÕl\×\Ö\ÆfY#vh”:e>e\Ğ\"O4!;wİ‡w®²q‰\à—¥‡‡¤\ñ‡w\ï~xü X6\Ôq¹˜r\áÉƒSO\r\nO]s\ğIa\ò¾É©\ÎûL\ŞGbü8à»ªeP½\nl\é*µZ§\×KX\Ç)wnš9Ù™Œ¦n-³ª&›Ybt\ë\ë=\î3\İ\Ãm(i­\×9³s°\ìƒ_\0#0û\r\å³È¦>X—|Z©\Ç\Û\ò·…\Ú\Û\÷\r,¹#\Ée œr·T†gÿ¥.œJ…\Ó[7Á¶¬\Â%ly \Ğq­\Óx\'¯ÙsR\ß\Ö\ÅùrxzP,R«\Ùn\òc?\ò%\Ì[ÀsV³ù<g\í«^<pİ–\Í7Œ\ŞÁ\Ä\Í\Í5z…+p™V\ç\Ø|\Ğ,\çª\ZMC•Öššùj9\nƒ}\õımùû™©I@_¶z\éù%O5“L>§*°;\È\ß~\ÌL3>‡\í2f¦™`\Ø\Ä\çÔ¿–1 3ƒ¿»K\ZZ„rmi\È`\Ğq]QŸŠ\î-e\èd4l\Ê\àCÁcÙ•«;:V×··\ã/…q\É	\ò„ub\æ\'¡GG]}[[}]\Éı\ëY/ üs!\Ót\Z\Í\ä™‰Õ‚\Ü1“=ük}\Öı™3›\õ†²\ÒY\ï@lt\÷\î±o%®ãŸ«f\ê—\àiV\÷Â£¼¼rk`\æ;/\Î\ÄUOãŒ™ÿ\0\ÉgÀ\Â\ÍB)A0×™1ª%\×m\İzÃˆé™j\æ{\\Wq[½şÌ®A\ë¿¸\õV\òÀ<€¡»ÿŸn\ßı\ì\Z\Öÿ7j;?u»\'¥½ı¹¶©±\Îk\â_\ÔN\Ñ\öš\ÜXÓ‡\Ú\Æd\Ûÿ™·>m\ãÒ¸µ—Ú¥v©ı\ÛĞ§jGh§h-\Ğşa\ö´\óÿ\õ¦Z\è\ÈüTm\í_µ\\j¥\íÿ\\ù{\îRü:ı=B\ò]\êjú\ÜO\é©`$\÷¤a\÷(}6Ï¥\ôU(›İ«\ô\Õ)x\rjH\ö3\ğ\Ë\ì\rJ?YU›”¾!…>{V\æZ¥\ğ\Ä*¤RRúi)4MH¯:¬\ô\×\0ıq\ò[‘\\\Z(Tİ¦\ô1\Ò\éUJŸA™ú	¥Ï¦à¹”¾\n\é(}u\n^ƒ¤d_‹rT_Qúi¨PJé§£>ıKJ_ª2\n”~{,£]\ég¢\í†7”¾!…\ö¬n`»>»Dé«.{¥\ÒOK¡iB‹³›”ş\Z \ïı:_]U]\Ëo\ò8¥@(0\æ[R0 	aOÀ_Á¯\ózùÏˆ;\â{Ä(‹®\n¾\Ï-\òEc¢\ä/\â\ÃÂW\ä\Ã|\Ø\í	\ñ\Ã˜ŸB¼K½ \è\â=~>(Ha>\òøGx…#®I~h’_\çwI7\ñm§;\Äü°^\ä%\Ñ+~\'eHø“%AÁ#…ø\å\îp8j¬¬\ñ„İ‘¡\ngÀW)\0±|˜p¨T¨\Ë)u\å70T\éBaQª\Ü\Ø\ÑÒº¹·µ\Â\çZQ¶\'%b½²!U‡\n¾[”|P\Ì\æÁ·(‰ \åˆ$øÃ¢«Œ–Dª–\Ó-H#b\ğ‚’ŠR†Â‚\Ç/[\èIN’\Ä.^…N\0üxWÀ\ñ‰ş0u3?\ì\ñŠ`#\ñAQ¯²¢h\â/q\"™KL\ñ\à„@$…%“\ğ(\"§7\â\":$¦½ŸG‘@\İ+\Ç˜FB`Ñ³Œ\÷\\ar©YÁÈ\×r—\ñ.a=	2DN\ÑOV•‰‰ÀÁzS[gµ£4DJ84¬¸ˆÊp|s-!IĞ…\Ü\"]\ã\n€Ë¨\ÄQ\Ñ&B>\ğz\Ä4gÀ\ï\ò‹B4\r…¡À¸HM‘\Ã\ê„ASY\âÿ\àlP•©[\0Õ‡D\Å_rŠ\n)\ÖHDz(q\÷€\ëa+Pq\ó­¬XBDK‚K\ô	\ÒX‚hv3HH\æMÀü  ¢G‰xi;¸…¨U]Qµ²iKM}\İ\ì¢P$\ôz@3²Ÿ*xG \Âû„Iµ”m®qJ¢@\â±\nz…I\Ù\ñA\É³\à§0¤¤œ’t\ÏD;%–<\ìµW\é\Ëy\ñ!‚RÀq†!*°ÿamY“\0Î›p{œ\îy \á\ÜY\í~\ï$¿Ü³‚}C¢+…8|œ¶”œ¦uJ¶‡\æD/É«‰z`¹¤„E©b’¤º~o@p\Í\õ »J”ˆ90Â¾\êE2hÜ¢78×£Pa\Û\Ë\ä$ $Ç¤€\Û3\ä+U\n¶w¨Â—\ğ ­V\á\É`\0ªI\Ğ=Y	I	\ïI\Â\î\ğ¸\Â\î-A\ÈLÈµ^\Ï>±#,@|\Ğ\×ªQœµ\ĞÛ„<È‰$@!8‡Qp-Ğ“PB0\èùQÌ¬C^h<\ê\Ür\Ã\\ˆD¸Š@=\ĞE)û`V„k\Z£3~\è\ñ@/ !\à@fˆ4‚q/\Âe˜J!\ò\'€Š`\\@7Nÿh \0\Ú\Î<\ĞúB¢´ $¸\èp†\0\ÊI\èQ¸f]@ık\è·Áœ$†¨|¿\"Ÿh#Q9D\0xgŠ†	ıRˆl`\å\ÔaÀ…P#ª„6s„g¤W\0Ÿ\0\òVPtQ9\ğL\èP9wy\n\ïJ\ê§\0ÀJ\à P»m%Úˆ: B­h3\êX³.´‚ú¼…úi¨Ñ‘#½5|¤Èºn\Ê\ÙG\ãR¢\Í+Qq\Ó9Q\ñ\å\Í?\ÕÅ…\Êh\Ô\Èì¬·W›À•Qÿhdüt}r)ˆuaj±NŠÎ‘DNP¢\Â\ÙE¯!:\ëJAÑdÁDÀ6‘j=›\ÍDs¸\Çp2_{\ç\É(\ï\ÎZBrR {À3\'\æ¯\"Y,gB\0ä‡•#Q”\èK\èQ¦pr\Ïı\Ù\óW{aì£¸Tf³7u?ÊšF\è,K\ñ\'\éû O¤\'\ÇbJ´‚4o½\Ô\ÛnŠqÑ¾¬\õ\ÕE¦%)Ô·	Yr<*i\í\à)V®²\Åß³q]\Èwe)q•m	&34</‹fí \Ş\ò}lL•&¢\ìº¥œ•ã¢pµq(œT®L“\àNê•—\îÑ‰dÔœT\'\ÕÓ£\è×˜R\rI\õĞš6•\Ô\İ\ê\\X\ñiªù?\ë‡Ô:wUˆ\î@\Ù\ëCŠÕ³ù•ZE…ˆ”´=D\ó\ÍO¹\ËY/\ßf­ûs±¬€º¤%ı/Pz‰şÁ—H«›•p>§…\îL#t³\õ†\Ä<Hµ”-¨ \÷£ú‹@„\óv%[Şª\nR›\ĞTƒ\êQ\èV\î4Dª@+º¨\äW¢¾\Ë\Õ}‚¶\n\Z¹º\Í\Öú0Ä”xI®•A\à0	\Ø\Ä\İ-¤\Ô\óT^A¸‡’<\òDˆz!Hw Ó„R\Ñ\ÔK<•4™¬\ßm\å¬v\Òh	\Éı-\ïû \õ\á\äœ¤+¯u*\\De,\Ì\Ë\Òp²\Ë\÷Dl\ç\Ö\r^¹·ùR\òo.fxN=û\óy¤c½Ë…•½,?Ÿ\ÈrË’r\æ[ \ïŒ	%\î\ğY\â	eş\ÎZ\È\÷d—\ö–ı\n¸’œJÖs—uøK};\Ë}\ön²\ğ½g!R\ïks\õjJ\Éb‰lK˜\ÊK<+J\ô:©T\Ò	jy€\î\ó\Ë=aNV‰4.†•\'^¹•û¡ül˜¨y2·\ò¦—£\òS¬_‰\Ì,\÷\ÄI\ÔY’?nz\Ï\ó(~®øĞ³ütú‹\ê|\' ¶\ì\0\î‰;Àè¹¨V[h\Õ$\\\åº\Ûı}@\ÙA+²¼P\òù\Å\ï%ÿ›pÁ+W\ò\Ù!×¥\ô].¯®\äÿ1Ö…\ä>ù\ïu\ä%¦/\ğ\ÂkpmEmCEUT‡ùšŠ•d8\âºC=C|}´&\Ş\"«¼SU\ÑP±º‰¼¹\Ğ\×\ìù.a\ÜC^Hù:§se•³Î¹Qû\Ëø–I\É[Æ·K¢8VÆ{\Êe\ì\ĞH¹<’”NdŒvş¢E\Ôi\éog\æQX‹˜@0´7!4\ïI˜Cx^•°\n1xE\ÂkÀ«ZT7‰5\ô¯›L¾;C(ı²»\ÉO¸\éÿ\\¾XKp¦2J\ç¢}–\ö‘‚Ï”À\ô@0K\à$¿¡‚a‘\ïaka´\Zù½	À~D¾[œBÿ\à	\ôÀo¢3\0ÿ½\ğ=\ô;€¿}1Ö€ŒÓ±`&^ĞŠ·\0ÜŠ\0E|\à58\n\ğ‹ø›\0ÃƒnOã§¡\Z?\ğ\Ûø\Û\0_À\ßø\Zù\îÿ\0ÿO€?\Ä?ø&~\à9|\à;ø_\0şƒtü{ü>À?\â8\Â\Ëh\0¦1\é\03\Éÿ\Âdr˜¥\0M\Ì\0Ë˜\n€uLÀ5Ì•\0[˜M\0·2[\ö2}\0·3;\0:˜\0\ğ\ãbFúÀ 8ÁL¼¹\àM\Ì-\0\ïb\îø\0\ó\r€1\Ó\0Ÿdø\óÀg°‹yy\à«\Ø\Åü€ù\'€?bş\àO˜Ÿ\0ü\ó3€o1o<Ç€\Ì/™\ß\0üw\æ=€¿cÀR\æ}\æ<ÀfaL¨aÁ\çl&›	\ĞÀ\Z\0\æ°9\0\ó\Ù|€‹\Ù\Å\0—±\Ë\0±\å\0«\Ø*€6vÀ¶a\òs%€­\\+À«¹«\äN|”{±\Ü\ÜS\Ğšû1\ô\Êıú¿\âş7ÀwU*š\Ë,ı\ZÑ¿u¯¦ÿÿ\óq\î\îU\î\ï ¿XX\÷,BÜ·¸—Šû>\ğ\È 9\Èı-\÷\òÿš\ó©¿\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>MicrosoftÂ® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel HernÃ¡ndez Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>MicrosoftÂ® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nxœ-\Ì\Í@@à·¿\'c\ô@\npÕ€vĞ‚»\Ü\èAªPÁZyr\È7“\äˆ‚Š½\0>6r\êLEV²v º‰„9\Ï]2:ş,¡‰!–8¢\È\éc.=%B~	MO‚\Ğ\ÖB·\0/\İg\Å\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',40);
/*!40000 ALTER TABLE `reporte_mensual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable_tecnico`
--

DROP TABLE IF EXISTS `responsable_tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsable_tecnico` (
  `ID_Responsable` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `departamento` varchar(100) NOT NULL,
  `puesto` varchar(100) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `ID_Org_Vinculada` int NOT NULL,
  PRIMARY KEY (`ID_Responsable`,`ID_Org_Vinculada`),
  KEY `fk_Responsable_Tecnico_Organizacion_Vinculada1_idx` (`ID_Org_Vinculada`),
  CONSTRAINT `fk_Responsable_Tecnico_Organizacion_Vinculada1` FOREIGN KEY (`ID_Org_Vinculada`) REFERENCES `organizacion_vinculada` (`ID_Org_Vinculada`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable_tecnico`
--

LOCK TABLES `responsable_tecnico` WRITE;
/*!40000 ALTER TABLE `responsable_tecnico` DISABLE KEYS */;
INSERT INTO `responsable_tecnico` VALUES (1,'Lic. Pedro HernÃ¡ndez PerÃ©z','Area TIC del Dpto. de TrÃ¡nsito de Coatzacoalcos','Jefe del Area TIC','pperezhernandez@gov.veracruz.mx',1),(2,'Ing. Francisca Dorantes de Lourdes','Dpto. de Desarollo de MiddleTek','Lider de Desarrollo','lourdesdf@middletek.com',2),(3,'Mtro. Carlos LopÃ©z Dominguez','Dpto. Soluciones Digitales','Administrador de Proyectos Internos','cldominguez@gov.cdmx.mx',3),(4,'Lic. Victoria SanchÃ©z de la Cruz','Dpto. de Desarrollo de Strongware','Gestora de Proyectos','victoriacruz@strongware.com',4),(5,'Phd. Edwin Braun','Project Workshop','Lead Administrator','edbraun@fsk.internal.org',5),(6,'Satou Sakura','IT','Jefe de I+D','sakurasatou@employess.saipan.com',6),(7,'seth marquez rodriguez','Sistemas','Director','cuentadesoportea@gmail.com',7);
/*!40000 ALTER TABLE `responsable_tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rubrica_presentacion`
--

DROP TABLE IF EXISTS `rubrica_presentacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rubrica_presentacion` (
  `ID_Presentacion` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL,
  `criterio1` float DEFAULT NULL,
  `criterio2` float DEFAULT NULL,
  `criterio3` float DEFAULT NULL,
  `criterio4` float DEFAULT NULL,
  `criterio5` float DEFAULT NULL,
  `calificacion` float DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `ID_Estudiante` int NOT NULL,
  `ID_Periodo` int NOT NULL,
  `ID_Profesor` int NOT NULL,
  PRIMARY KEY (`ID_Presentacion`,`ID_Estudiante`,`ID_Periodo`,`ID_Profesor`),
  KEY `fk_Rubrica_Presentacion_Expediente1_idx` (`ID_Estudiante`,`ID_Periodo`),
  KEY `fk_Rubrica_Presentacion_Profesor1_idx` (`ID_Profesor`),
  CONSTRAINT `fk_Rubrica_Presentacion_Expediente1` FOREIGN KEY (`ID_Estudiante`, `ID_Periodo`) REFERENCES `expediente` (`ID_Estudiante`, `ID_Periodo`),
  CONSTRAINT `fk_Rubrica_Presentacion_Profesor1` FOREIGN KEY (`ID_Profesor`) REFERENCES `profesor` (`ID_Profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rubrica_presentacion`
--

LOCK TABLES `rubrica_presentacion` WRITE;
/*!40000 ALTER TABLE `rubrica_presentacion` DISABLE KEYS */;
INSERT INTO `rubrica_presentacion` VALUES (1,'2023-09-30 14:40:25',8.5,8,8.5,8.5,8.5,8.4,'Observaciones...',1,1,3),(2,'2023-11-30 15:24:12',9,9,9.5,8.5,9,9,'Observaciones...',1,1,3),(4,'2024-04-30 13:55:32',7.5,7,8,7.5,7.5,7.5,'Observaciones...',2,2,1),(5,'2024-06-05 17:12:07',8,8,8.5,7.5,8,8,'Observaciones...',2,2,4),(6,'2024-09-30 14:13:45',9.5,9.5,10,9.5,9.5,9.6,'Observaciones...',3,3,5),(7,'2024-11-30 13:52:02',9.5,9,9.5,9.5,9.5,9.4,'Observaciones...',3,3,5),(36,'2025-06-23 20:46:21',8,9,8,9,8,8.4,'hola 123',4,4,6),(37,'2025-06-23 20:48:05',8,9,8,8,9,8.4,'observaciones...',5,4,6),(38,'2025-06-25 01:41:22',10,8.5,7,6.5,6,7.6,'Se guarda calificaciÃ³n final.',7,4,6);
/*!40000 ALTER TABLE `rubrica_presentacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `ID_Usuario` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varbinary(255) NOT NULL,
  `tipo_usuario` enum('COORDINADOR','ESTUDIANTE','PROFESOR') NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'jangel@uv.mx',_binary '7\ó£˜8ú¢\ô\é\r\nıƒ´','COORDINADOR',1),(2,'zs19834121@estudiantes.ux.mx',_binary 'N\æ¸;ß¯\0œ\È\á¸À|H|','ESTUDIANTE',0),(3,'zs20432114@estudiantes.ux.mx',_binary '3=†z}¨3\ëq\êe¢pi','ESTUDIANTE',1),(4,'dsarahi@uv.mx',_binary '¢£\n\ì¬U0\è\Ù¤c”´\Ì','PROFESOR',1),(5,'hfernando@uv.mx',_binary ')\ÌhY£V\áş¶…ş¹S\ô\"','PROFESOR',1),(9,'ana_coordinador',_binary 'XD	.\ÆU Xpq„Œ','COORDINADOR',1),(10,'juan_estudiante',_binary '?Œ\È\ë\å­İµ\\(+.£*·','ESTUDIANTE',1),(11,'luis_profesor',_binary 'P-û»‹v0\áK\Ç?\Ú!_','PROFESOR',1),(12,'zS22087162',_binary 'I@+\åÓ•ÛšÂ“2§6','ESTUDIANTE',1),(13,'ester',_binary '¡”…\Úb\è\İ.t\ğ{¬','ESTUDIANTE',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_asignaciones_lugares`
--

DROP TABLE IF EXISTS `vista_asignaciones_lugares`;
/*!50001 DROP VIEW IF EXISTS `vista_asignaciones_lugares`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_asignaciones_lugares` AS SELECT 
 1 AS `ID_Proyecto`,
 1 AS `num_asignaciones`,
 1 AS `max_participantes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_entrega_reportes`
--

DROP TABLE IF EXISTS `vista_entrega_reportes`;
/*!50001 DROP VIEW IF EXISTS `vista_entrega_reportes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_entrega_reportes` AS SELECT 
 1 AS `ID_Entrega_Reporte`,
 1 AS `num_reporte`,
 1 AS `fecha_apertura`,
 1 AS `fecha_limite`,
 1 AS `fecha_entrega`,
 1 AS `ID_Reporte_Mensual`,
 1 AS `mes`,
 1 AS `horas_reportadas`,
 1 AS `estado`,
 1 AS `observaciones`,
 1 AS `ID_Estudiante`,
 1 AS `ID_Periodo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_estudiante_proyecto_ov_responsable`
--

DROP TABLE IF EXISTS `vista_estudiante_proyecto_ov_responsable`;
/*!50001 DROP VIEW IF EXISTS `vista_estudiante_proyecto_ov_responsable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_estudiante_proyecto_ov_responsable` AS SELECT 
 1 AS `ID_Estudiante`,
 1 AS `nombre_estudiante`,
 1 AS `matricula`,
 1 AS `ID_Org_Vinculada`,
 1 AS `nombre_organizacion`,
 1 AS `direccion`,
 1 AS `ID_Proyecto`,
 1 AS `nombre_proyecto`,
 1 AS `fecha_inicio`,
 1 AS `ID_Responsable`,
 1 AS `nombre_responsable`,
 1 AS `puesto_responsable`,
 1 AS `departamento_responsable`,
 1 AS `ID_Periodo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_estudiantes_asignados`
--

DROP TABLE IF EXISTS `vista_estudiantes_asignados`;
/*!50001 DROP VIEW IF EXISTS `vista_estudiantes_asignados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_estudiantes_asignados` AS SELECT 
 1 AS `ID_Estudiante`,
 1 AS `estudiante`,
 1 AS `semestre`,
 1 AS `promedio`,
 1 AS `ID_Proyecto`,
 1 AS `proyecto`,
 1 AS `max_participantes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_lugares_disponibles`
--

DROP TABLE IF EXISTS `vista_lugares_disponibles`;
/*!50001 DROP VIEW IF EXISTS `vista_lugares_disponibles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_lugares_disponibles` AS SELECT 
 1 AS `ID_Proyecto`,
 1 AS `lugares_disponibles`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_proyectos_sin_asignaciones`
--

DROP TABLE IF EXISTS `vista_proyectos_sin_asignaciones`;
/*!50001 DROP VIEW IF EXISTS `vista_proyectos_sin_asignaciones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_proyectos_sin_asignaciones` AS SELECT 
 1 AS `ID_Proyecto`,
 1 AS `num_asignaciones`,
 1 AS `max_participantes`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'practicasprofesionales'
--
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_proyecto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_proyecto`(
    IN ID_Proyecto_in INT,
    IN nombre_in VARCHAR(100),
    IN objetivo_general_in VARCHAR(100),
    IN metodologia_in VARCHAR(100),
    IN max_participantes_in INT,
    IN fecha_inicio_in DATE,
    IN fecha_fin_in DATE,
    IN ID_Org_Vinculada_in INT,
    IN ID_Responsable_in INT
)
    SQL SECURITY INVOKER
BEGIN
    UPDATE proyecto SET
    nombre = nombre_in,
    objetivo_general = objetivo_general_in,
    metodologia = metodologia_in,
    max_participantes = max_participantes_in,
    fecha_inicio = fecha_inicio_in,
    fecha_fin = fecha_fin_in,
    ID_Org_Vinculada = ID_Org_Vinculada_in,
    ID_Responsable = ID_Responsable_in
    WHERE ID_Proyecto = ID_Proyecto_in;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `asignar_proyecto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_proyecto`(
    IN ID_Proyecto_in INT,
    IN ID_Estudiante_in INT,
    OUT exito BOOLEAN
)
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_ID_Periodo INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    SET exito = false;
    
    -- Realizar la asignacion
    UPDATE Estudiante SET ID_Proyecto = ID_Proyecto_in WHERE ID_Estudiante = ID_Estudiante_in;

    -- Obtener el ID del Periodo Actual
    SELECT ID_Periodo
    INTO v_ID_Periodo
    FROM Periodo
    WHERE NOW() BETWEEN fecha_inicio AND fecha_fin;

    -- Cancelar si el periodo es NULL
    IF v_ID_Periodo IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "No se encontro un periodo activo";
    END IF;

    -- Crear el Expediente del Estudiante
    INSERT INTO expediente
    (
        ID_Estudiante, ID_Periodo, estado, horas_acumuladas
    )
    VALUES
    (
        ID_Estudiante_in, v_ID_Periodo, 'Activo', 0
    );
    
    -- Crear las entregas iniciales
    INSERT INTO entrega_doc_inicial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas parciales
    INSERT INTO entrega_doc_parcial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas finales
    INSERT INTO entrega_doc_final
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas de reportes
    -- Reporte 1
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        1, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 2
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        2, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 3
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        3, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 4
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        4, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Terminado
    SET exito = true;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `autenticar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autenticar_usuario`(
    IN username_in VARCHAR(45),
    IN password_in VARCHAR(45)
)
    SQL SECURITY INVOKER
BEGIN
    SELECT ID_Usuario, username, password, tipo_usuario, activo FROM usuario
    WHERE 
        username_in = username
        AND 
        password_in = AES_DECRYPT(password, '3sk0lAr?p4S5', '', 'hkdf')
        AND
        activo = 1; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultar_proyectos_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_proyectos_disponibles`()
    SQL SECURITY INVOKER
BEGIN
    SELECT p.ID_Proyecto, p.nombre, p.max_participantes, p.fecha_inicio, p.fecha_fin, vlp.lugares_disponibles FROM Proyecto p
    JOIN vista_lugares_disponibles vlp
    ON p.ID_Proyecto = vlp.ID_Proyecto
    WHERE (NOW() BETWEEN fecha_inicio AND fecha_fin) AND lugares_disponibles > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_entrega_doc_final` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_entrega_doc_final`(
    IN fecha_apertura_in DATETIME,
    IN fecha_limite_in DATETIME,
    IN ID_Estudiante_IN INT,
    IN ID_Periodo_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO entrega_doc_final
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        fecha_apertura_in, fecha_limite_in, ID_Estudiante_in, ID_Periodo_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_entrega_doc_inicial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_entrega_doc_inicial`(
    IN fecha_apertura_in DATETIME,
    IN fecha_limite_in DATETIME,
    IN ID_Estudiante_IN INT,
    IN ID_Periodo_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO entrega_doc_inicial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        fecha_apertura_in, fecha_limite_in, ID_Estudiante_in, ID_Periodo_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_entrega_doc_parcial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_entrega_doc_parcial`(
    IN fecha_apertura_in DATETIME,
    IN fecha_limite_in DATETIME,
    IN ID_Estudiante_IN INT,
    IN ID_Periodo_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO entrega_doc_parcial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        fecha_apertura_in, fecha_limite_in, ID_Estudiante_in, ID_Periodo_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_entrega_reporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_entrega_reporte`(
    IN num_reporte_in INT,
    IN fecha_apertura_in DATETIME,
    IN fecha_limite_in DATETIME,
    IN fecha_entrega_in DATETIME,
    IN ID_Estudiante_in INT,
    IN ID_Periodo_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite,
        fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
        num_reporte_in, fecha_apertura_in, fecha_limite_in,
        fecha_entrega_in, ID_Estudiante_in, ID_Periodo_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_expediente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_expediente`(
    IN ID_Estudiante_in INT,
    IN ID_Periodo_in INT,
    IN estado_in VARCHAR(20),
    IN horas_acumuladas_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO expediente
    (
        ID_Estudiante, ID_Periodo, estado, horas_acumuladas
    )
    VALUES
    (
        ID_Estudiante_in, ID_Periodo_in, estado_in, horas_acumuladas_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_doc_final` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_doc_final`(
    IN fecha_entrega_in DATETIME,
    IN tipo_in VARCHAR(25),
    IN estado_in VARCHAR(20),
    IN documento_in LONGBLOB,
    IN ID_Entrega_Doc_Final_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO documento_final
    (
        fecha_entrega, tipo, estado, documento, ID_Entrega_Doc_Final
    )
    VALUES
    (
        fecha_entrega_in, tipo_in, estado_in, documento_in, ID_Entrega_Doc_Final_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_doc_inicial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_doc_inicial`(
    IN fecha_entrega_in DATETIME,
    IN tipo_in VARCHAR(25),
    IN estado_in VARCHAR(20),
    IN documento_in LONGBLOB,
    IN ID_Entrega_Doc_Inicial_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO documento_inicial
    (
        fecha_entrega, tipo, estado, documento, ID_Entrega_Doc_Inicial
    )
    VALUES
    (
        fecha_entrega_in, tipo_in, estado_in, documento_in, ID_Entrega_Doc_Inicial_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_doc_parcial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_doc_parcial`(
    IN fecha_entrega_in DATETIME,
    IN tipo_in VARCHAR(25),
    IN estado_in VARCHAR(20),
    IN documento_in LONGBLOB,
    IN ID_Entrega_Doc_Parcial_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO documento_parcial
    (
        fecha_entrega, tipo, estado, documento, ID_Entrega_Doc_Parcial
    )
    VALUES
    (
        fecha_entrega_in, tipo_in, estado_in, documento_in, ID_Entrega_Doc_Parcial_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_EE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_EE`(
    IN nrc_in INT,
    IN nombre_in VARCHAR(100),
    IN ID_PERIODO_in INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO experiencia_educativa
    (
        nrc, nombre, ID_PERIODO
    )
    VALUES
    (
        nrc_in, nombre_in, ID_PERIODO_in
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_estudiante`(
    IN matricula_in VARCHAR(9),
    IN nombre_in VARCHAR(100),
    IN genero_in VARCHAR(1),
    IN correo_in VARCHAR(50),
    IN telefono_in VARCHAR(10),
    IN semestre_in INT,
    IN promedio_in FLOAT,
    IN habla_idioma_indigena_in TINYINT(1),
    IN ID_Proyecto_in INT,
    IN ID_Usuario_in INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO estudiante
    (
        matricula, nombre, genero, correo, telefono, semestre, promedio,
        habla_idioma_indigena, ID_Proyecto, ID_Usuario
    )
    VALUES
    (
        matricula_in, nombre_in, genero_in, correo_in, telefono_in, semestre_in, promedio_in,
        habla_idioma_indigena_in, ID_Proyecto_in, ID_Usuario_in
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_periodo`(
    IN abreviatura_in VARCHAR(20),
    IN fecha_inicio_in DATE,
    IN fecha_fin_in DATE
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO periodo
    (
        abreviatura, fecha_inicio, fecha_fin
    )
    VALUES
    (
        abreviatura_in, fecha_inicio_in, fecha_fin_in
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_preferencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_preferencia`(
    IN num_preferencia_in INT,
    IN ID_Proyecto_in INT,
    IN ID_Estudiante_in INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO preferencia
    (
        num_preferencia, ID_Proyecto, ID_Estudiante
    )
    VALUES
    (
        num_preferencia_in, ID_Proyecto_in, ID_Estudiante_in
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_proyecto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_proyecto`(
    IN nombre_in VARCHAR(100),
    IN objetivo_general_in VARCHAR(100),
    IN metodologia_in VARCHAR(100),
    IN max_participantes_in INT,
    IN fecha_inicio_in DATE,
    IN fecha_fin_in DATE,
    IN ID_Org_Vinculada_in INT,
    IN ID_Responsable_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO proyecto
    (
        nombre, objetivo_general, metodologia, max_participantes,
        fecha_inicio, fecha_fin, ID_Org_Vinculada, ID_Responsable
    )
    VALUES
    (
        nombre_in, objetivo_general_in, metodologia_in, max_participantes_in,
        fecha_inicio_in, fecha_fin_in, ID_Org_Vinculada_in, ID_Responsable_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_reporte_mensual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_reporte_mensual`(
    IN mes_in VARCHAR(3),
    IN horas_reportadas_in INT,
    IN estado_in VARCHAR(20),
    IN observaciones_in VARCHAR(500),
    IN reporte_in LONGBLOB,
    IN ID_Entrega_Reporte_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO reporte_mensual
    (
        mes, horas_reportadas, estado, observaciones, reporte, ID_Entrega_Reporte
    )
    VALUES
    (
        mes_in, horas_reportadas_in, estado_in, observaciones_in, reporte_in, ID_Entrega_Reporte_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_rubrica_presentacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_rubrica_presentacion`(
    IN fecha_hora_in DATETIME,
    IN calificacion_in FLOAT,
    IN observaciones_in VARCHAR(500),
    IN ID_Estudiante_in INT,
    IN ID_Periodo_in INT,
    IN ID_Profesor_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO rubrica_presentacion
    (
        fecha_hora, calificacion, observaciones,
        ID_Estudiante, ID_Periodo, ID_Profesor
    )
    VALUES
    (
        fecha_hora_in, calificacion_in, observaciones_in,
        ID_Estudiante_in, ID_Periodo_in, ID_Profesor_in
    );
    SET ID_generado_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_usuario`(
    IN username_in VARCHAR(45),
    IN password_in VARCHAR(45),
    IN tipo_usuario_in VARCHAR(20),
    IN activo_in TINYINT
)
    SQL SECURITY INVOKER
BEGIN
    INSERT INTO usuario
    (
        username, password, tipo_usuario, activo
    )
    VALUES
    (
        username_in,
        AES_ENCRYPT(password_in, '3sk0lAr?p4S5', '', 'hkdf'),
        tipo_usuario_in,
        activo_in
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_asignaciones_lugares`
--

/*!50001 DROP VIEW IF EXISTS `vista_asignaciones_lugares`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_asignaciones_lugares` AS select `vista_estudiantes_asignados`.`ID_Proyecto` AS `ID_Proyecto`,count(`vista_estudiantes_asignados`.`ID_Proyecto`) AS `num_asignaciones`,`vista_estudiantes_asignados`.`max_participantes` AS `max_participantes` from `vista_estudiantes_asignados` group by `vista_estudiantes_asignados`.`ID_Proyecto`,`vista_estudiantes_asignados`.`max_participantes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_entrega_reportes`
--

/*!50001 DROP VIEW IF EXISTS `vista_entrega_reportes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_entrega_reportes` AS select `e`.`ID_Entrega_Reporte` AS `ID_Entrega_Reporte`,`e`.`num_reporte` AS `num_reporte`,`e`.`fecha_apertura` AS `fecha_apertura`,`e`.`fecha_limite` AS `fecha_limite`,`e`.`fecha_entrega` AS `fecha_entrega`,`r`.`ID_Reporte_Mensual` AS `ID_Reporte_Mensual`,`r`.`mes` AS `mes`,`r`.`horas_reportadas` AS `horas_reportadas`,`r`.`estado` AS `estado`,`r`.`observaciones` AS `observaciones`,`e`.`ID_Estudiante` AS `ID_Estudiante`,`e`.`ID_Periodo` AS `ID_Periodo` from (`entrega_reporte` `e` join `reporte_mensual` `r` on((`e`.`ID_Entrega_Reporte` = `r`.`ID_Entrega_Reporte`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_estudiante_proyecto_ov_responsable`
--

/*!50001 DROP VIEW IF EXISTS `vista_estudiante_proyecto_ov_responsable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_estudiante_proyecto_ov_responsable` AS select `e`.`ID_Estudiante` AS `ID_Estudiante`,`e`.`nombre` AS `nombre_estudiante`,`e`.`matricula` AS `matricula`,`o`.`ID_Org_Vinculada` AS `ID_Org_Vinculada`,`o`.`nombre` AS `nombre_organizacion`,`o`.`direccion` AS `direccion`,`p`.`ID_Proyecto` AS `ID_Proyecto`,`p`.`nombre` AS `nombre_proyecto`,`p`.`fecha_inicio` AS `fecha_inicio`,`r`.`ID_Responsable` AS `ID_Responsable`,`r`.`nombre` AS `nombre_responsable`,`r`.`puesto` AS `puesto_responsable`,`r`.`departamento` AS `departamento_responsable`,`ex`.`ID_Periodo` AS `ID_Periodo` from ((((`estudiante` `e` join `proyecto` `p` on((`e`.`ID_Proyecto` = `p`.`ID_Proyecto`))) join `organizacion_vinculada` `o` on((`p`.`ID_Org_Vinculada` = `o`.`ID_Org_Vinculada`))) join `responsable_tecnico` `r` on((`p`.`ID_Responsable` = `r`.`ID_Responsable`))) join `expediente` `ex` on((`e`.`ID_Estudiante` = `ex`.`ID_Estudiante`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_estudiantes_asignados`
--

/*!50001 DROP VIEW IF EXISTS `vista_estudiantes_asignados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_estudiantes_asignados` AS select `e`.`ID_Estudiante` AS `ID_Estudiante`,`e`.`nombre` AS `estudiante`,`e`.`semestre` AS `semestre`,`e`.`promedio` AS `promedio`,`p`.`ID_Proyecto` AS `ID_Proyecto`,`p`.`nombre` AS `proyecto`,`p`.`max_participantes` AS `max_participantes` from (`estudiante` `e` join `proyecto` `p` on((`e`.`ID_Proyecto` = `p`.`ID_Proyecto`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_lugares_disponibles`
--

/*!50001 DROP VIEW IF EXISTS `vista_lugares_disponibles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_lugares_disponibles` AS select `vista_asignaciones_lugares`.`ID_Proyecto` AS `ID_Proyecto`,(`vista_asignaciones_lugares`.`max_participantes` - `vista_asignaciones_lugares`.`num_asignaciones`) AS `lugares_disponibles` from `vista_asignaciones_lugares` union select `vista_proyectos_sin_asignaciones`.`ID_Proyecto` AS `ID_Proyecto`,(`vista_proyectos_sin_asignaciones`.`max_participantes` - `vista_proyectos_sin_asignaciones`.`num_asignaciones`) AS `lugares_disponibles` from `vista_proyectos_sin_asignaciones` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_proyectos_sin_asignaciones`
--

/*!50001 DROP VIEW IF EXISTS `vista_proyectos_sin_asignaciones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_proyectos_sin_asignaciones` AS select `p`.`ID_Proyecto` AS `ID_Proyecto`,(`p`.`max_participantes` - `p`.`max_participantes`) AS `num_asignaciones`,`p`.`max_participantes` AS `max_participantes` from (`proyecto` `p` left join `estudiante` `e` on((`p`.`ID_Proyecto` = `e`.`ID_Proyecto`))) where (`e`.`ID_Proyecto` is null) */;
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

-- Dump completed on 2025-07-02 17:55:26
