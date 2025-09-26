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
INSERT INTO `coordinador` VALUES (1,43211,'Dr. Miguel Dominguez Carrera','Coordinador de Servicio Social',1,NULL),(2,40812,'Dra. Maria Fernanda Ortiz','Coordinadora de Servicio Social',2,NULL),(3,43722,'Mtro. Santiago Sanchez de Jesús','Coordinador de Servicio Social',3,NULL),(4,44642,'Mtra. Guadalupe Martinez de Isolde','Coordinadora de Servicio Social',5,9),(5,45721,'Dr. Angel Juan Sanchez Garcia','Coordinador de Servicio Social',4,1);
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
INSERT INTO `documento_inicial` VALUES (1,'2023-08-15 13:22:53','CartaAceptacion','Aceptado',NULL,1),(2,'2023-08-15 13:22:53','Cronograma','Aceptado',NULL,1),(3,'2023-08-15 13:22:53','OficioAsignacion','Aceptado',NULL,1),(4,'2023-08-15 13:22:53','HorarioUV','Aceptado',NULL,1),(5,'2023-08-15 13:22:53','ConstanciaSeguro','Aceptado',NULL,1),(6,'2025-06-22 13:38:00','CartaAceptacion','Aceptado',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nx��O�j1\���)\��ݭV\'\�!\�=lrE\�A!�\�*N�����\"I�-vw�\�Ǡڟ3b��\��U��y\�\�x)��eJh�ZQI9�aV�}`|�z�ìU3jUm\r�ߵ2\"\"�\�\�{x\ne�x\�no\�Eb�A\�\rwZ�F\"\�T\�H\�n��u\�Ү6\rѶ�ʂ]���d� k2\\g:u�4)/p�\�\�|\���U/?>i\�_3�׌u�d�\�\�\�\�\�\�����Z|�EW\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250622133747-06\'00\') /ModDate(D:20250622133747-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 303>>\r\nstream\r\nx�]�\�j\�0E\��\n-\�E�\�WZ0�4���>�\�p�q*�e!+�}����$8̽�\�Lth\�VIK�3\�,�\�\�b8\���\",�Br��|\�5���[fc����%�>]q�f����N\�@�w#�Hu���C縻h�#(KcRUT�\�>z\�\�[?�жm��K�l�\�Oq\\4\���0|0랃\�\�H�SѲq�\"�\�]��\���{\�\�I\�\�q�e\�c�\�%P�\"5Y ��d�}�\�@\��ή��\�Xʼ���gQ�\�P\�td\r�\�s�]�T��\n\�FK\�\'�$�Ə\�o\�6g~1ƍ׊�\�S�\nn�ד\�.�g�t\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8024/Length1 21328>>\r\nstream\r\nx�\�|\rxו\�3#Y�e#0?4b�ȶ�\�ۄ̯�\rX�\�\�\�\��lc�۔��\r䅆�4)!ل4i�1��\�6M���\�6$Mw\�fS6٦��/M�m_7kϽ3�e\�\�\��\�\�\�eFs\�\�s\�=�\�\�!\0� ���\�U��_\�\Z\�~\�v�w�\�x\�\�\�)�\�u\�?\�\r\�ђ\�S\00�(\�\�y��\�\�\��\�{\��\'\�\�\�\�)���\�\��\�\�P\�\�+��`\�\�\0�m~E\�-�\���\�2^5~D�/<�\�a�?�\�}Q�l\���T5\�ʯ,��`\�\0y���?j\nM�\�Dz1�$\��\��lY�8.,��\�}S���\�8�<\Z�\'R��\�P�hL�F���>�Mj;\�\��F\�\�{���䛀��e��\����\�\�\�\�\�\�\�~\�4\�\Z�\��y9�\\�&\�\�L�\�;�\�\�\n�1\�@�u\n\�8\�.B�\�8\�\���\�v0�\�P%\\\�)��;wz��\�=��\�\�Ӽ7��\"<W.k:��qU\"�\�t�\�\�@-��x\nL\�O\�0u2���\�\�0��\��\�\�\�\��\n\�N�?��\�\��9\�[�7\�5\�7NN�7�\0\�8\�a|��>��\�t\��p�&;��X�\'\�\�_�O�\�?\�\�#\�Ο�\�OZ��\�\�\�\�q\��z\\=���r\���\�G>6E>\��\��I\�p\��z��\�O@(�v�~\�7\r!aw��\�9`A�\�\�jh�M�\�ob\��\�\��<���\�jX��^\r\�h\"{4\�,\���%ڗ\�V���r\� f�~�x9\�\���C��r¯\�m�=q����ԑmD!�\�\�^��/~\�\�[\�Oj�\��\��\�����D<�/\Z	��}{�\�\�\�햻\�ܰ��];=�;�o\�h\�ںe\�ַ�[ۼ\�f\�\�-##�y�R��W^#y�\�\�//#��Q\�aHu�ST\�[;\�\�:�\�X\�v�U��nU(m��\�Kz\�d��p.�\�\�.mغ�SlJv�A\�t�\�i\�+2czK\�\Z;:\�f\'\���kY?\�]7a�%=,�*�&��\�Kﶎ\�04~փ�x$�\�)٥NiGL`�wt5b˜nq-r\�[�/\�\�<\�[;;U��ǳ��+U٧�<TK��v�*zEQ5�Jݭ�I�J�$�\�o\�D�ٚ�Kv\�\�9�zn��\�ȋ���\�:\�&G\�wv^�`6\�\�<\�����3�\0\�:/`����X���v`�Ȝ\�L�\�z�\r0\�F�`}/Z�p�4��\�<�\�,� \�\�\�\�=/h#\�4��8��֨\�\�&�Б��õ\�����q\�\�&w�\�\�p�:����6��cfR@�#ȳ��ϓ\�\\�\�\�ԦS#%\�\rgp�9%\�b�\�4÷�Y�mg\�cf@�\"E=\�˚F�\�Ni,��vb\��F\�fg�6\�\�M\"��\�n老]V\�y\�\�5\�e4�\�NI�J��iӒѦ��qC�s�%؈ltt9�Z\�\�D�,u��|i�Wj\�B	�\r~Z\�\�.v�\�]Nl��\�d3\�\n�RC\�Ǘ�����U\�7�Y͓�5_jȌ\\\�i#F:�#5��D\�z�\�$\�$�R7f����\�\�㑑�\�dU�\Z�#4\�z�IФ�\�\�D\�6`nq�\�\�EJ�!&�k\��\���2\�\�O\�CҚ5��MbRu\�\�.�h\�0b\\��l�dч^Fs\�s\�6w\�s:vv&\�>\�\'��\�f[E�ǚ\�x�\�q>�\�e��\�\'���Ro�\�\"twI\�\Z��Ή�މ��\�\�I\�8v\'\�\\/5���^�O\�1\�\�ϣ����\�D$�HĘ2\�IK}�G\�v\�T{\�w��n3��\�kZ����f^�]\�kU�g�DV��Ťh�\�$\n\�\�\�\�R\r\�\�ʴ8i\�!b=\"\�\�n\�ed\�ܕLgNIj\�9�%�Tҁ��Rj�:\�*vyĮ.\�\�\�[EՀw�G�\�E\�n�fO+\�~�\�\�v�tY\�\�zdE�c�V\�ռOuP;h\�T��LJI����\�H�\��\�\�Bo��:%Y� Ry����ͨ.\�\�fm�\�$\�J�/\�qX-�)\�&1\�ݸ\��E\�\�X�Ī��\�\�n\�\�mA��\�\"���L�\�B{d�\�RB�\�>5\�ٝS:�a��S#61��Y[�ښ&\�al\�s�܌8H�\'mX?(\�<Ci�׍Ye��E�\�\�\�\�\�\�Щ\�t��i�ae�n�\�������P#��\�\'�T5�b�UuІs�9cI�mTZ�\�3u5���D}�ҥw�R�٤m�\"-��� K\���O=ۊ5�K��\�Cś� :��Nj����tp2W蒴O>��0�\�y\�\�t�c�I�\�׽w\�4\�\�\��\��\�*\�u�XU�\�\�\�f\�\n.bE\�\�\�\�ʞ6v\�j�\�9X\�\�|\\U�\�\�\�M�\�vD\�\�z�:Ь$\�4c\�\r(�u���%�S9\�fZ\�9�IZAo�Ҋ�\�`��\�\�R`\�B�\�v���\Z�+�+飑�:�\�v����N�U\�q��N=�58\�̌\�5��\����%3�\�nP\�\r���Ig%M�1a&=�j.�\�\�a�pQ��\�Z�\�s\Z\�\�Z�@�ÛL\�\�6����P��\�ŨZ-*Y�k��9���R\�&�a]\\n9T-l��8`A\�\�\�\�\�Aj\�U�\�\�|\�p��5\'�\�y�Z�\�\��l-;�l5ӫI�饯�|}��\'T}��\�\�\�R�\�\�G\�!f|��\�-\�:\�O���d\�\�q\�J��\�%��\��O\��|\0\�p	�\�D�zぱ.�|\�4[�\�z�2w�ԗC^��\�H�_\�ޔK�\�{\��\�ǉ,\�0]�\�ؙ\�\�9\�q�\��\�Ö�>w��\�b��^�;�J\�np\�\�e��c\�h�G���\�!\Z\�O3v�v�b\0��\Z	>m\�F�[�H�MV\����eV�\�k\�L|�j�O\�� YD�Vj/C����{�Pڹ\�Z\��\��\�\�x�R\�\�&�WGR-E8��\�EC=\�ܫ�I���ѡSQ\�\�\�\�\�f.���@\�\�\�VX\�\�[^�\�\�\�|�R\�i���B\�.\r\�\�B���\�\�X�v�\'�\�\�4)\�7�\�\Z�C�l}2�O1:�u���u\�sh�\�\�S�͡�Ki7��\�P\Zm$\�\�T\�\�h��]Z�ᇩ?R�&_p\�B�\�\'w\���]�K\�z`�p��q@M�H5wjϒ�톥)\�nW\�v�\�m�+e\�Y��y*.\�:\�R�\�)\�\�\�mΔ�c\�z[����mqʶu\�ö\�E�m\�\�&\�\�\�6-L\�6^��mp�l\�N[˂^ۺmk�lͥ)[S\�ö5R\�\�8?ek�_����ln�ö\�ċ�Ub\�v�x¶Rt\�\�\�\�lu\�R�Z[ʶ\�6l[>7f����UϽh[6碭jN\�V9\�a\�\�%1[Eٵ�\�m\�l�(k�l\�\��n\�|~\��\�\���+�a�\�k��hf\�\�sg�lsJR6k\���]3kJ\�v\�v�\�\�ڞ>��Ŀsjm\�Z˶b�\�SPk\�f�\�	x�=Sj\n�\�\�\�m˩5n+\�\�y�\�\�֚�\�8j\�p\�n��\\ �C�s\���T\�\�ԺK%G\�\�v\n\�A5Ua\�\�]�#�\��\�6�۰A���\�\�\�\'I�qk\��\�4��N\'\�\'k\�}��d����Skh\�:�\�\�t�iR?nd&\Z\�	ũ�\�\�\rE\0��\�\�\�\��5̀b�\�S\�s|x\�\��\�\0����^�\�C��\��a\'Ġ)z\�F���8c\0\�>\�� ��n�M8��q��2��\��\�D\�۰�\�[�\�6\�\�Cl�\�؍�\�с~\�\�a=\�0�B9�ܳ\�g_cX \�M\�	K\�\�S�.�\Z_i�NeQgQ\�\�%K\�ًJ\�;��\�TU�L�f4؋\�\�Q����z�C�o�.�Gr�\���\�Y�,Y���rt5�\�\�\"\�\�\�մm\�\��\�S��rk\�\���a��O�\�Z��E���o]�c[_y\�ښ�-����\�k\�-sn��\�\�\�9�Q�@\�\�]�\'��F@]�,\�X\�*B-㤊H���j\�M\�Oϐ\�>=|\���>E�\�\rCûϐ�\�#���p\�f�\�\�[Ab^v\�\��\\>!d�vp.�RU\0C!J̓\�`yj:\�\�\�\�U��\"{�P<}\Z\'H�U�\�\r	�\�~@\�u\�菿?���F~�/�\�\�\�24���4���|a\�[#\�1����|\��\�f�\��\�M��\�0\�\���\�x�}W�sg\r\r\'G\�??\�<	\Z\�\�3ln�[��\�F0\"/S�Wq��F0^��!UE�~W_ ���?;�jt��\�U��\�o\�\�}F�\�\�\�x\�{��\�\�o��ÿ\�\�f\��)\'6\�5\�ŵ�.ג�M\�41h�KfH�\�JJ\�+˫\n9��3/\�\�}\�Ⱦ\'���ƃ}\�>�\��n\�\�\�C�\"�=�\�}\�\�\�|^\�oG�o\�\�\�\�\�{So\�?�kl0\�m)̋@lv>J�j\�\�Wҏs�\�Eh\�5F\�5(�(�y{\�\�{�\���\\g���\�/7\�+[tX9|\�\�\�\�\�g��}�6s\�w�9�\�\�\�Z2\�\�\�̣O<�k\�\"\�>\�A������i\�1JŵU\�4��o�\�\�;S��9�\�\�=ϟ��\�+\�I�p z�\�{|T\�\�G�|��\�?�\�\�\�w.MY��\�tW�\�{\�V\�s\�\�\���\�=Ev\�b�̀�\�\�bs�1F���\�&bc5J�F˧��Y+t���\�\�S]4Huu���6mJ\��\����|\�\�\�\�\�3�\����\�Y�\�3֙e1�\�	�[��g\Z �y�L�:�N,���N.\�T\�\�S�\�6��s�\�\�:�\�=`\\\���A)H\�\�y�\�vỏc�4?_\�TT�u�ol-T\�\�<�	���5K�޺F:s�\����{�=8wsK\�1��i\�\�u�c�\�Fɿt�>\�\�CW>\�]�6|���\�f֐\��\���V�+L�nsZ]�\�\�b\��\�;\�\�\�\��|9􍇳i��\0�%�R��\�\�D��i�\�\�\�\�*\�|#[Kܒ\�/\�\��x���#��\��X1\�XSs�e\�җO�~\��맿|i\�\�{�\�\�C��g\�P�gFO	S1�\�U4��0?6K7�\�٩��%K\�\�v1\�\�|\�5E�R�\�9E%%g\�5,�?�������\\d\�\�#7\�;�h\�\�\�S�e�7w\��\�\��/\�\�׍�W�9\�\�3���G7\�\�|\�\�\n�0ݝ����\�x�j:�}y�q\��\�f��\�D��6\�|\�\�Xv�U#9\��\�X݅\�\�\��ܽ9�\�X��JgUQU:��\�\�\�\�TO\�_\�\�\�\�y\�\�ً�ș��\�ڑ+�w\�G(\�/�~\��׀\��\�\�\�e\�Ve��feM�3\�\�_=�༎-\�ϗ?x\�\�zx\�_\�\��\�\�ݮ�ܹ˕\'\��hڹr\�=C\�F�@�;\�n�b�\�\�\�TpU}�rFmQU%\�}��\�\�m�4\�\��V\�ҁ�oط斷\�a\�ƞO\�q|\�m9\�ns�\�d�\�-\\��ލ}}��k\�nI\�X\\��k\�\�\�r\�m���u\r�F�j\�h\n\�T��\��&Ԅf\�\�\�g���T\�cx<\�ڽ���CJYwG�\�Ǖˏ\Z~�K~\�\�C�\�C\��\r��\�\�\�=\�\�GR$c�\�\�=�X,yB ��F�E�\��1�r9|V\�b�\�\�\"׊��5kג��\�ݽO��4>\�i��in��n��o\�\\�񟊖\�	��PH[��`Њ�i��\�S\��n6[\�\��{w\�\��Zw���\�\�$\�5>�OJy��9�\�\�*�\�s�)Ó�`\�_\�?\�큣p\�?y�\�\�\�\�X��Ygg\����\�Տ\�\�\n�\�Y纬\�\�܄\�r\�ײ��\�\�\��z��#��z^=��WϏ\�~�\�W\�O\��\�\���\�\"/�ߘ\�\�\�V\0\�m\��\�h9�>�\�gᅬ����zۘ�ρ\�L��|���]N\�&�mɢ/\Z�E0\Zt�\�\0\�Mz;7��̆[\�\�J�?N1\'\�QÝz�@�٠�9(4\�m>/d�\r0\�|Xo�\�9˴MPl�Oo\�\�\�Y��\�\�\���\�\�\��т�z��[^\�ۖ,�Ec��\�\�R�m����z;7��f\�\�\�H\��U�rI\�2qS��\�#=	�1�Fbr\"	W���A�-\�\�O\�\�6%�\�_�\�\�W\��}J,<_L\�\�AE�\�	 .\�D\�	qP��>e@	F��O�ŨK��\�@�W�\�x�\�7$v��þ\�1��\�돋�0\�WĘT䰗1��锨�\�Ņ�D\"\Z�s�z	w�7r\�\�A)\�\\:u9�vu#ݮ�O(1\�ƖƦ\�\�M!ߢ\n�-:�\�\�Kk�u�[�X(��\�\"�\�Wb\nj\��\�	\�W&\�\���\�/\�z�21\�\�Ubq�\�Nȁ�f�ed<B=:(\�$\��r<\�d\�\'�\"\���N07�=���6R\�o\�g\�_Ą�9H�H\�\�C\� :!ҟ@�\����\�(C\"o�\�GuH��.��W�#2폣T\�21\�z\�]afE������L\�(\�\��\"\�\�U\�t\�\�\�ĸ����7�uL;FC�D�C���\�A$4\��4���_as|t��W\�&(��\�D��\� 5\�	�ԢxKC�;2�0S���#	\�TӀ�?:T}(\�Q\�nE\����r�51*=���\�\�����VV��&\"q��,&b�O	ɱ�4\�\�b\�E��,o\"��FmJoP�mG�P�*+�,�\�RUS=6)\���]O�\'\�/�\�!\Z��e��\�\��\�c\r\�C�㣱\0����^�rzh\�a>S\�\�X��:B\�^�ѣ\�\��l�\�\"�~o��\�\�\�9i\�A�\�P\0\�\�\�>��D%ԭ��ȑÇi\�\�YZge{|\\\�2�\�PJB	\�*�T_d0�Ⱦ\�ޓ5W)1jNE!\�ODq\�`\����4~%\�Q,��\�5r\Z�c��?\�@�+\�U\n�w�\"�\� �V��h�I\�?\�¤\�O\�Ph\�\���-Q\�L̵\���%!c|\� B%,�k�6A\0��\�\�\�\�\Z��(�2b\�\nC�!wO\�\�~����w��e�*x�}l$�-\�e\�Ft�J�?\�\\z�*�(Ƈt�cG�����a�Q��1\�~���^l\�x\�ۏ�C\�\�fp5����-l7\�%ƙ��.�jcr�<\�\�,\r\����P\�\�P���C�\�\�\�1ʳ�W ��+\�:(P�<\�:�&\�.\�\�\�b~� t!�\�Ei]�Z0BM�\�V\�1�72?\r!U::Z��B\���\�ke�C,q=ڢ?St_\���3]|PƢFGǼE�\�\�\�\"���7\�\"f\�[\\�@�K0�\�\�b\�\�\�x��st�\�Pt\�>v��Q/Rʺ~4�(�mS�\�c\�L5��kqLd\�}���\�\�1KhN\�l\r\�\�\�\�Y4��L�����a4�1�\�\�z�霼ȳ���應��\�1\\�\rcٛ�5M�ٚ,\�\�\'m��M�\�d�JV��,o�\�\�~�񱶦u7\�E��g(�̷iYZ<\\�v��UM��\�ﱸN滲��j�D3���Ec\�2o�>4&\�Jӯ��8��\�c�r�q/Rx�\\�&֫͝ [����y�N>�g@ׯ.�\Z\�\�a5m,*٫5���\�\�l�\�\�\�+u��8[��׻u�\�\�+��\��X\�\�8˷0\�e��+�Y\�\�Ų\�N�y.�\�\�\�i%���e\��8M�3\��~?r�74\�Q��fAۏz\�E(\�\�z���U��&\�\���\Z�F��NC�ʬ�+z~�\�V\�\�Y�\"0^��Z���R/i�2���\�\�\�z=ϖ\���{<\�s2Oę�lj1MK�\�ü$2IC�Z0�n�e��EKάom\�G��ƭ\�(\�Xm�W\�\�}yB�&2�X\�?ұ_7D}oe\�\�xLϸz\�\�\�I�\�}l�K\�kY{>\�\�e\�L�@[�z�\�\�\�ĕ5�\�\� k-D�Ex�9ߝ�;\�\�\�\�Q};\�}l7�|\�̂\�}m�^\�Y9@-\�lI0y\�g\�\�S�\�J:\�,��u�a�\'�\�*�\�%�Ä�\"\�;aT\��g\�t\�\���\�n�\�՞b\�zdƸ�WH�\�\��\�=/���\�}\�z\�\�E�#\�m\'��\�@\�\�`�|L�-�jR�Z\�m\�\��laY[?��\�k��\�ߒ�\� ���;�;\�\�m�/\�\��\�km�\�ު\�KLG$\�\�\�e\�j+�ԋ�=�ʞD�XU��v{�CQ|c��N����^\�\� \�,���XQO\�\\\�kvo�~�0�/�ub�׻t��ڻQN�\�\�ơX�L\\S��2q P�a�{˵�xLo\�\��\�G�\�<@�\�~�7��e�E�\��`ߓ�\0d_���\0�\"��\�U\��Mb%����ߝ\�\�:\��#�8r;��\�u�\�\����y\�_��k\�vbf��\�J3�\�\��u����\��]@�[���\�<�\�\�p\�_��\��\��\�%$\��O\�\�\"�N�\�V\�E��Co&I��#_G�(9��=I�\�\�y\�4\�o�o |��-\�\�w�\�{\�L~�\�U\�*\�K\�\�\�\�/���t\�{\�G�\") \�\� \�\�\�ҿ]\�ssڸ\�˸\n�\�\\-ܵ�M�r[�s�s;z���8\�\�\�\�\"q!�Q.�p�Fx+w+\�c\��\�݃\�^\�k\�F>\�=�\�)\�)�Osh\�M\�Y�\�\�\�.\�{܏���;�?\�~�\�\�\�\��\�\Z\�K\�Ƚ��\Z\�o�w��CK�?r��r�@x4a�>\��B�ނ��/FX �\�\�D8���p>_�p	���_���o\"�0\�B�Є\�\����\�\�/<&<�\�\'��\�\�τ�a�M\�W\�6X.\�\�;j`�?����\�s\�\�w����\�q\�\�\0\�_σA�.\�(�9(��\�\��AZ�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  34[ 686]  40[ 556]  232[ 525]  244[ 527]  292[ 239]  299[ 260]  305[ 853 551]  314[ 552]  341[ 561]  357[ 323]  362[ 559]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-22T13:37:47-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-22T13:37:47-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:DocumentID><xmpMM:InstanceID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Filter/FlateDecode/Length 108>>\r\nstream\r\nx�-̽@@\�w\"�\�#ւH\�a� ׂ�P�D*8g�\r\��\�ݷ@(\�U\�9\�[P�`J��M�=\�Ѝ\� \�E\�\��\�\��b�#���Q\�%�\�\�A\�.����!�\�\��ؐ�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003030 00000 n\r\n0000011144 00000 n\r\n0000011310 00000 n\r\n0000011337 00000 n\r\n0000014518 00000 n\r\n0000014563 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] >>\r\nstartxref\r\n14872\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Prev 14872/XRefStm 14563>>\r\nstartxref\r\n15629\r\n%%EOF',13);
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
INSERT INTO `documento_parcial` VALUES (1,'2023-10-03 14:17:10','ReporteParcial','Aceptado',NULL,1),(2,'2023-10-03 14:17:11','EvaluacionParcialPorOV','Aceptado',NULL,1),(3,'2024-05-02 11:45:54','ReporteParcial','Aceptado',NULL,2),(4,'2024-05-02 11:45:55','EvaluacionParcialPorOV','Aceptado',NULL,2),(5,'2024-10-05 17:33:12','ReporteParcial','Aceptado',NULL,3),(6,'2024-10-05 17:33:15','EvaluacionParcialPorOV','Aceptado',NULL,3),(7,'2025-06-23 20:44:00','ReporteParcial','Entregado',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 217>>\r\nstream\r\nx��O\�j\�0�\�sL\n�w\��FP?Z\�C�!�\�C�O5m\��Э�C�Su\�\�h�\�\�\�\�qBU\�}\�Ԃ\�\�4bq:��\�2%\�m�/�(�\�ـ\�.��\�I��&�\�A�|\�ax׊\�D`�2_���E\�\�\�0�e!\�\�+\�h\�Z�EZY��#\��\�>\n�\�U\��\�϶�bsɑؚv�\�\�ܕI�9�xUL�\�0<k\�I��V�-b\�X\�3g��\�_B/���]\�\�*�D\�\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203827-06\'00\') /ModDate(D:20250623203827-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 288>>\r\nstream\r\nx�]\�\�j�0\��<E.��bb�mA�N\'x�f\�\0����!�����\��\n?N��8I��n�r4���\��\�Qiia�oV\0\�4\�J%\�]�SoH\�\�ݺ8�Z=Τ(h\�鋋�+ݜ\�<�Iޭ�\��n��λ�\�hG)K*a\��\�歟�&۶\�ו[�>\�7\�\Z�)�\�ÈY\�bz�\�W \�E\�GI@\�u�\�\�0�\�ކ\�ǽ�\�X\�J\�!*EU5*稗c\�\�\�\\�q�G�P\�sT�ڝ�\ZT��,*�y��x~�\�v\�	�2�\��\�\�J�\�~����U�<أ\��\�\�f6!�_x*��\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8106/Length1 21412>>\r\nstream\r\nx�\�|xי\�fF۲�m�\Z![�Ȗ��\r6$66\�\�alO���%,YBL\�PQ�\�m�l��ͫ	m\�4c\�\�nͣ\�mH��\�n��4ɦ�l\�צio�ۦ`\���=L�7�i�\�eF\�\�9��\��>��\�@\0`\\�{�k;�pB@ ���wM\�?�}5	\�u\'\�y�Rx�qΓ\0s�c�\�hL�~e\�K\0����g\�C�ퟟe(ـL�\�\�\��\�\0K\�ȹ\�\'K\�\�{wҞū��\�\�����\�\�/\�c�]���\��W�b%\�H\�(�s@\�J�\\sP:6g�\���^\�1�\�=\0�oC7\"\�9\�\�\0X�\�W�C\�X\�.�\�qj��\�\�\�\�d1@\�\��Y@m\�	?�|\�տ�<#\�㵯\�?�\�\�\�֟%\�\�\�č���\�\���{u��%��\r�\�\�C�J�3��jg���P%7\�:�=�p�\�:0\�\�38\�\�Ν�A\�\�x\���� w\��\�=�\�B����\�\�\\�\�.:ƿ�k��Ͽ�Z<	Fz��\�S9\�ݠ|\�:�\�]��\�\�\��t.\�\�g�UwaY¡����\�\�v�����\�=\�\\�\��\�\�\�\��c6���{�\�>�\�\�V�\��\r\�\�{|z���\�\�\�\�\�q\�t\\:.��K\��\����N\�\��ß�\"�\������u�t\\:2y�\��\�\'\����v�~\�7!aw�}OS�o���a\rl�.\�	d\�C\0\��<O�sdoH&�~\���\�0�Ї��\�\"\�\�P���u\��oïI.�1�&�6QP~y�f��`\������P�\�\�oI\�\�\�����\�صG?w\�\�N^}x\�\�U\���\�c\�\��ph$\�\�\�\r\r\�^πԿw\�\�];w���o\�\�۳�k\�:;\�ׯk[b1\�\�T���\�[��[U	S�y\�̫�$��E10��\�!*�-}\�\�\�ֵeV��\�fU\\�P\�J/ɛ\�\�\�g\�\\d\�\�c\�ܲ�OlM\��A\�\�\�\�\�+\�cZK\�Zz��6\���\�X?\�]\�p{j\�&*ЕHx���@��l����\�\�n�\�mS6��OF\�)#����-\�2�ZD\\�\�Sf�˳\�v�h�}�\�?\�^�\��U(\�\�s\n\�m\�v�\"zDQ\�W\���V�\�\�ʴ~wz�He	�\�*�ݧ�\�-�\�6+\�\�y\�F�o�r�\�=;�N�1��\�\��\�\�\�\�\�*Ǳ�\�\"��a9��H\�i:	F\�$gd\�e�]\0�lT`\�\��gL\�xNq*ά\n�3A.\\�S�:\�JQ�3��I�z�Fm\�3y\n8\\KlP=\�KW�\�et\�L\\>������y\nis<j\"��l\nyv3\�)29�\�*;\�8uk��HIq�ijNɲ�<\�\��\�\�{\�ȟA�h�GUe\��\�aˤ\��>�^\�\�\�\�\�Ԧ]��UĴV\\=}���s�{mU%\�.�\�&�\�\�S�g\'­SfsKg�s�%ؔ��\�;j\�\�D���0M��v���Il�l\�ӎ(\�6�_\�w`S4�%\�hVH�\ZJ�8�b�\�J���7)�6�Yɳ5�G>�QG\�t\�`kVH�\�\�V[�8ן\�\�0]]}Ce�n	y+.���\�)�q�\�%hR\�lr�m����];q�Rg��\�Zq\�%\�%�D�k��\�ڐm\�Zw֌V1��$O?R��1�DD�\�$ы^Fs\�s=6l\�\�A\�\�\�\�K��6�\r=\�r%$4�L\��\�n\�8\�Gՠ�R��NZq\�蚯\�\"8%\�@�m@E\�\�y>n\�|\� Re\�lT�vOt\�Z�HA/ɫ\�qV\�\�VS�X\��H\"�E$bL\�yU�G�v\�P�fv}\�n��\�kN5W�N3�Ϫ\�+SnG�DR&Ąh�5\�(`�\�ѫ_\�ac\�#\�⤧���D�}�\�Ȱ�?�\�8�&\�Ӓ�\��XRI/�\�*�9\�d�\�\�����\�Z&*:���M.Zv�T{��\�\�MJ\�\�\\��L1\�0(\�6+Vk�.Z\��TG���>\�	[B!�bE#{����\�~\��$c�<Q�\�\�6T�y�r+k�Y\�H\�U0_�\�ZP\�I`6*�q�\�*\nE	�1�Uk7\\�\�\�֏ۂh\�Dj	3�:��\�\�\�H%̩��8�}\�J\�1�\�P���OȡWԬ�O\�J�\��\nW��\�\��E���hG\��0�\�\�lQ\�z��\��\�tjY*`\�4İ�K�EkJ\�<U_U��}L\�S�+0Њ�:�\�jN&	��J�sx��j\0�Q���0C���P!3�\�\�P�\�$�\�N%�\�\�\Z\�o��\�M\�� :��N����\�t\�B�\�$��<�ig&d�s\�\��t�c�I���׼w\Z\�T\�Y��\��\�*�u\'�)>�ë\�\�k\\Ċ��۳�=m\�\�\�`�\Z������D�ǁ��\�\�\��:Ь$m6h\�\�\ZP����\����e[�p\�M�l\'9 F\�Jz˱��\��=-F\�|���߫n\�\�eXY��>\Z\�Y�sXlGii\�\�ӕ	n�2ve̡e�\nG\�\�1�&\r)O\Z\�X\"=�c\�\�\�ܰkp\�a�଄\�&̨ES\�ac�\Zٍū\�P\�\����;\�:�X�\'���mjw]�&{!\�P�FT�Q\�}sU颢�ú�\�T5ly8`F\�\�\�\�\�\�A3j\�\\�J��\���?\�HQ�N@�s+\�<׆�\�jv�9\�\�j�W?��\�K[Iy\�*5�W\�5\�jLsf\�\�\�\�FoKs��)b\�g`�L�\�\�\�\��iGU��h�\"�F��\\ES\"�������\�P`�\�N��P&0\���\�\�\�3�\��\��\"�\�ۢ\�\�\��7\�\�pb|\'^\�j{�\�rCѥ���K}oH���#57\�A����\�a{�&K=\�\"\�I�w�\�J�2\�:&�\�xȡ=\�N\�\�^\�\�]\�E?>g�|\�\�O�*�R\�\�%\��\�/I��ט��,\�M��\�\r�f\�jX��ٴ\�\����\�e�n|�8����Z�8\�\�\�\�M����b�h(G�{�1\�\�.��kTԂ��8U:���Kt\��\�Y\�ʲ\\���z��\�q�a�\�\�*�\��RW(\�l\���\�bSDq�DD�[\�N$p;M\�\�Զ>\�!R��>Ч��l��e��4ݤS\�G\�ץ���R\�\"(�6)q�\�\�h���j�ᇩ?\�\06U�`ׄ&v%v\���UYHkz`�`��q@Mn���+��&iٳ,i\�]�쪾ٲ�:i\�\�LZ\�\�3��ʤe{UҲ�\�e�#i\�]\�a\�Y��t_��l��!K\�RѲyI�eӒ�,�$-.KZ:\�IK�\�ai/��/?cYW���U$-�Y\�ڒ��\�IK�\��e�5iqY�|F<c�RLZ�o���-�E,M���FKҲ\�2iY�0biX��\�/<cY�\���nA\�R�\�!˲��\�Yy���2b�|\�K\�*�_6o�m�˲��?o�u�q56,��,��\�-ٵ�4iYP���\�\�k\�9���i\�|Wm�\�\��y�J|;���6���\�\��F\�V]#�U�\�\�\�P�5�1w��Q����\�ֻ��\�h\�\�\�\�͹\���\\:r�\���\�S�dw�b\�ک�\�JE��ڠ\�+�u\�ξ)Bnp��zX\�ܩ\�\�\�w�l\�$ײ�oJ\�op7�h\'kj}��d����Cm�\�\Z�\�Nw)R\r?cd.\�\�	E\�N�\��\n�瑩\�;��ԕB�ڇC\�Y\�9^<i� �az@�8`)�Fa�\0$\�\�E�!�\n��\�E����~!��`#\�\�c$�\�\�(r�`�(}7\��8zynE�^\�F`l�\�H�\�7M/\�:��YPUP\�y�8�2]��;۟+�\�΅\�\�ń��1�\�ך_�-�C\�(,*m�Y��\�ZX�\�^�����d\�l�\�Zh%\��\r\r\�\�\�\��9�ԈA�7\�/N\�+��)/���^\�_y\�\�DV�jj\�\�ֻ7|\�g��rWˊł�\�\'^�./��ם·Ͼ\�=\\U��a\�澮�㇆��\��\�\�;=#>\�?�0@.��\�s�^����E�\�\nQ\�(�#6\�\�[y#��\�\�\�OM��\�k�$�3]\�O�\�\�c���\Zp\�f\�\�\�\�\�[B�^�\�\�\\!\��6p,��OT\0t\��\�Y`q���|\�d҃\�\Z5���E�\�\�;\�B�K\�\nm\�]y��\�N�\�٩+�W�N\�\\�k>�?�o��#��c/�	����	\�@�+/?/\�d\�O-�|��%ԩz��\�\�\�V��=\�w�\�\�ML�B\��\�m\�\�?\�5\�=}푓�\�����\�\�ǯ\��ߎ�K@�����\�\�9s@D	�\�ڣ��\�,)�E\\i��wr����s\�g\"7&6��\�wj\�\��6N�@j;�;z\�\�wu\�_=<����\�{�!\�=\�+ν\�}\�\���Q�}\�w�o\�\�\"XVW\��܈\�f��ن�e\�QE�&��u��e��\�4\�\�Wd�\n�j7�\�v�^YmÊzA?gv	��\�\�=_#�\�=�WN\�;\�x�\�\�NC\�T�\�\�\�\�\�\�]\�\�u\��2n\�\�\���_Z��\��\\�K�;\'\���\�3ܾ\�/�+��L7̩���\��l4DJU��E��\�\�i�hv��\�\�L�\�%%u�L]\�U}\�\�\��\�\��x��_h��/\\yx\�\���|\�ta\�\���\���D\��W\�\�m\r�~eh^�	�(`�ؘr#����ҋ\�i�\�:3��֥\�P�҃�;\���\�	\�\�\'����k�o�\\zT>z\�\�\�[\'�\����8\�O߰\�}����u?�\�\�Ok\Z���\�+͎���iNH��\�Q\�X7C�\"\�E�f:�2%����7�\��[�\�ow����\���\�Ǧ%n6|�\�狎�����5�ޛ��\�콫\�\��e\�>~Ӎ�\�p�\�֭cu\��d�@\�ȥ+\��Z��\n���sω\�j\Z��&����\�\��_��^\�{�\�z�\�cz<\�C\�p\�	J�k^����Rl�\'�\�w\���2��Wj�!�[q\�\�lU<��H.cT��$\�\�6���n9=v\��@���\�z�`8Kv\�g>}O\0�MZ/Ж�\�Lsʙ3ӈ.\�\�\�\�E=\�򉫹\�\�\�\�o�⫡Ы_L�\\9\�_\�\�p�y�\�/\�\�\���o\�\�\�7Ǐ\�=�/\�$=\�wb/ͤ{�\��1�Z&\�E\�\�zC�\�T@��\�RͲ�ºҌx\�b�e��V�ކ�{\�\�-�?x�f\�!ߝ\�d\�\�c�߼t\�\�\�;t\�\�\�4���\��\�Y?]H^{f\�ѧ#��oث��;\��\n`�+/\'%<W΂@%\�͡�\Z\n\���~\�\�K\�G�E��6\�no�<\�K+���v\n\�l\\������}�<}�H�B����.\n[}]}\�d��\�\�\�\�\�\�\�\��{\�U�\�aX8ӱ\�_?v\�\�N阺\�~ɿ\�����\�5{VnĤ��\�gk��8�\�\n1p\�ʫ�\�\��\��#��ONowҕw�\�\�M�%\�\�#\�M\�\�oDwt\�r�\�\�Ν\��d|���\�\�\�PMz�*^X\0v�X��p�\�8\�8���b��{��ka-�s����[lIV1d�C:�\��=\�\�{\�o����߸\�z\�\�뫻[�\�H;W�|h\�\�\��a�\�u�W9��s�;x\�\���?s=߹��YՈ_�\Z\�B�\n7�_jDMh֮�p\�jIK�y�\�~ 2�\�\�\��Nȕ�q������|�_z�\�Ǥ\�ǻ\';\�>4~7��\�\��\�!\\]9�\��r�l\���E4SXd{\�[c�!{ٟ3�>RZX���}eúu\�+1Rq3\�\�o��Qt\�\�^\�\�\�\�P\�N�_\��\�_��\�\n��@HY��`�\�\n�n���f\�S�?�\�d�wVث\�۽{���;\�p��*֧<��\�P\�`^I+\�\�c9�%)�\�7tO\��\�X�pI\�+�Ño?7�\�=A\��V��p\��o}~\�Or���d\�_Й�X\�w2\'g\�:7�	\�0wM��\�Eϓ=\�qN\�\�Ξ�<\'?�\�\��\�S(Z.��\�K\�\�9��\�y\�\�Or���<_�\��<h\'��߭\�\�\�Vhm:\�\�n~�\�\�\�BV[����\�\��1\�\�\'/\�\�i\�p\�6jms}aF@�\�x\�t��vN\�*0\�h\�\�H#����J�u�hm�&�\�\��4���,��\�\��b\�Q��\�\� �n�Hw�\�΁�Z;zM\�km\�\�j\�|�x�:�]\0\�̯jms�nh���Bk\� �p�\�\�ɢYsWi\�\�H\�\�\r���v��\�����\���C)\��8\�5��\�\�\�Ţb��#��\�)\��dq\�Y,Ƥ��,�Ř\�C#1qL��^yT�²W\�a)\�Q�Ȑ(�\�X\�;.��kF��Ķ�\�C#8_#r@�F<�!\�O��%$*.\�\�b\�(���c���\�\nVK\�A�\Z��5\�*F]=\rT�hL�Tohoi\�\�\�\�z�:Ѷ\�x���F/k\�\��)vɑ�?\ZE�E4\�\'Gd\�r(\"�\�do�8��Z��+\�XH�F\�Ű�\�\�@L\�zPF\�#ԣcRDFb�(E�!�_B~�7\�\�s�8\�\�h#\��\�m\�\�L�W�ԉt,5$��B\�:,\Z��=�G%yq/\�!5\���\�^5�\�4E���b0\�\�һ\�\�\n\����R\��)\�x�Q�\�\�#t\�Q��Q9�QofkF;FC���Cc���\�1_(8\��4q]\�\'�9\���I\�\'{bC\�C�@h��\�	�x�ԢhKCi 4*3S԰��b���\�8Tm(\�P\�Y󗚢R�5*=\Zø�\�\����\�t�	\�BQ��$\�\"�WJ�\�Qf1\rEB\�0˛P0,��\0g�<H�m\��V��f٪\�u\r\��I\�x8\�ft=9Ew(.�q\Z��e��\�Dd�\�cH\�\�\�?���b�^�rZh\�a>S\�X��:�\�^�1�\�ŇlGB޸\'�Q�\��s+霔\0tޘ\�\�\�W\0R\�\�h\Z	��K�KE98 {�ȑ\�Ŵe\�,���=:#zi^����QJL\�*\�Tohl$��3�\'���#Ԝ�B��q\�`\����4>9�\�Q,��\�Ur\Z�c��\�?\�G���*�\�;\��<ȪUl<\�j\��Wc\�\�c\�e��\��ޘos3s�\�Pn�I��P5x-\�\�F\��\"�(^�C\\��w�A	1~l����(<��݈�EYOƻ�ԣ���Ge�/�a62�-\�%@t�J�\�\\�*�(Ƌt�#�\�y�q�va)\"�6��7�m	�(b\�H9�\�\�\���\�6\�\�(�?�ɧ\�D�*OB�\'KÔ�))T�1�\�\�\�\�\�x\�\�G\�N\�� b%M��gJ�\�\�xWe\�f~\n!�F��\�V\�h\��\�&\�A\�\�Q/,e>oa~\ZG�Tt\�H/�Ə\��\�\�8Y�Z�E-*>6&k�b1\�t\�B%�\Z\�x�r��B\\%\�o�Ef�\�3nQM�.\�,�C�fǇs$��cL��q\��{��\��� i�\���8\�&3�3\�L5\����q��\�\�<�ѻKhNJl\r�g\�\���h��B�1-\�h#lť\��\�8y�g��#�\�\�g�d�l2ٛ�UM\�lMVf����ئR\�}9+Za��\�m\�xY[\�z�\�RFӔ\�۔,5լv��VU�\�\�L\\/\�ʬ����\�\Z;/�2\��1o/\Z�T��k�.\�(3r�R\�\�!��\�UiR\�i�\n�5:����\�\�ez�5����!�~!V\�2Q\�^�#��i>\�\�A*�3~\�^�3gE\�\nT�>�Y�ɯ\�**}Dl\"iۣ,\�Fw5\�\�\�\�\�X:�\�i�K��V�O�Q�Ӆv�!֏#\�L��13-U�l?\Zb?6���iْ\�V-RК�\n6C4@=\�\�v\Z*Ub]\�\�+U\�\�\�>\�N\'��L\�2�>�1�^Rke9�#6��E�z�-\�\�3(\�h�\�<e^��\�4%�Vt7\�\�$��k��w[5�=,ZRz}�\�>\�|8>cE�Yƪs=\ZY\�K\�ei,]�\��#ۙuC\�\��`V�\�\�Ψg�y��Y\�\�v����\�\�UneZ\���+cL��\�#|�zB9e]\�\�tN��� �R�ӜHםsWu���\�p\�\�&\�{.dA\��6S�UY9@-Qm�1y�g\�\�SǵJ:\�,�u~�ܓfd�\�\�\�`L{��0�\�\�a�\�||l�	_4Gէ\�-2\����4|l\�\�k~v~\�YO}��~�z�\�Ԗ\�\�a�;�vly�V�Yդ\\պۃ\�H\�\�*��~ �\�ܒwҿOw��hw��\������\��\�\�oë>��\�_���/1��P\0_��;�7:kV�\��P\�`�I�s.�ݡ�x\�\�\�h�x��Q:+@15\�F\�\�U\�ͅ�f�\�w	�~�B\�$\�{<\�j<\��\rRl�Rl�*\�uY�G�U*v`�J�F�F|�5>\�$\�F\��\�..�$�\0\�\�=�@\�\�U�\�\�\�+Y�^5\�\�$V��M\��\�@޼;�̾$GnB\��N1�\�6\�ڠ\�\�\0p\�\�\�G\�|�\�o.#�=c.-W\�I��\��N�\�-N\��@x3<�\�[p\Z\�_û߃\� �-\�K�\��GL\�R��\�\�A(�	�W�\�/�o!|��Dݞ O`�y\n\�ߒ�E�,�{�o�\��W\�}\�O���\0\�k\�5�o�7�E\�F��\�\�o\��O�@8�3 \�\�\�п�\�qZ�\�VrN�\�\\#\�\�\�[���p[\�p��q\����9\�\�\�\�!rA�a.�p��Dx-w-\��/\"���\�\�7>\�M!|�{\�ܓ�\�\�.\�\�Y�/qh\�}\����W�?\�~�\�\'\�O��{\�\�\����\�_q\�!�\r��r\�sgNs\�@x4��G�\�|B3oFX\�!,\�K\�\�\�\"\\\�/B���BX\�\� t\�k�\�-@�+��\�*�\"\�#\�Ax�p����\n�c�	\�\���\�cl�#�\�wu:�\�<��\Z0�\0W=��\'����\�`~\�8\�)\0\�o�\�A\'|y\�\��Zx\��\0�\�\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  132[ 577]  135[ 606]  205[ 531]  232[ 525]  244[ 527]  278[ 239]  299[ 260]  314[ 552]  341[ 561]  344[ 334]  357[ 323]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:38:27-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:38:27-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:3377F257-081F-43DD-9DB0-81931A5948B7</xmpMM:DocumentID><xmpMM:InstanceID>uuid:3377F257-081F-43DD-9DB0-81931A5948B7</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] /Filter/FlateDecode/Length 109>>\r\nstream\r\nx�c`\0����� �Z�n�)Ə`�YBM�P��7���6B�\�\�-�b�ȱ7100\�c`�P\��B�B(FU\�\�Ǳ��+LqS\�\���N6�jS�\0\�QG\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000788 00000 n\r\n0000000916 00000 n\r\n0000000944 00000 n\r\n0000001099 00000 n\r\n0000001172 00000 n\r\n0000001409 00000 n\r\n0000001463 00000 n\r\n0000001517 00000 n\r\n0000001684 00000 n\r\n0000001922 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002648 00000 n\r\n0000003011 00000 n\r\n0000011207 00000 n\r\n0000011371 00000 n\r\n0000011398 00000 n\r\n0000014579 00000 n\r\n0000014624 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] >>\r\nstartxref\r\n14934\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<57F277331F08DD439DB081931A5948B7><57F277331F08DD439DB081931A5948B7>] /Prev 14934/XRefStm 14624>>\r\nstartxref\r\n15691\r\n%%EOF',11),(8,'2025-06-23 20:44:00','EvaluacionParcialPorOV','Entregado',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 251>>\r\nstream\r\nx��PMK\�0�\�\�+��Iڤ�0\�/\�d\n\�akOu�?8iԓ9d2\�yaǷ\�1cw\�w�e�\�����{fh�޵\�\�	d\0�\�탁��VW�h\�NZ\�BL/Z���\r�\�1\��W\���0_\�步�\��\�SD45g6\"��\�9=M�\�\Z1!�C\�NPrHVk\�\���R\�d\�7U5SWy\�D�\�\�HB���Z�m\�	1^ͤ�LFj\�\�3L�Z\r�\�V�M\��M\�z��\�G\Zk\�\�;\������O\�\�S\�\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203923-06\'00\') /ModDate(D:20250623203923-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 333>>\r\nstream\r\nx�]�_k�0\�\�\�)\�\�=�VmAg+��?\�\�i\��&\�N�1\�\��o�\�\�F	��\�ssT;������x�\��\Z\�\�9\�#�IXD\��ͅ\�\�c�H`\�\�2\�O$\�i\�f��\�]�b:\�	^�\0=\�]}T�\�\��\�� \r\rIQP��\�S\�\�4@ۺ�>�em=�\�E���\�\'�\�8\�N��\�]\�k�\nR\�\�w\�u\��w��:\�Zun�\�Q�\�T#m7HI�T>zJ��=Rʐ��4v\�X\�i�y_Z!ő���\�`\�T\�&X\\:��\�\�\�kt\�q\�\�m^�\�uÒu&f�O�EHi\�	;e�ϟa7\�\�\���S�\�sC������S���\�p�$\�>���s��I��\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8298/Length1 21668>>\r\nstream\r\nx�\�|x\�\��\�\�n6W6$��e�ln$$�uIH \��\0Y��\�N�K\�\�\�nB�(Q�\��Uk�\n�b�\�	VO\�V\�\n����\�X�z\���\�\�\�\�i�G!��\�7��\r \�\�Q\�\���\�y综\�{\�ofY\0� ��������\�N\�\�\�^\��\�S/\�\�ލ�\�.���[\�\�\0\�\�c�\�PD�~c�\0s�\�\���2\��\�C�{|#���\�\��g\02�<�\�.>\�׻\�^u\�:�� \�[��b�?�s�Ork���\0SU_\�%=��\�Q��E�\�\�v�L~�	\�{_\�\��\�;�\0:\�\�1. �\�\�S�\�\�帾<G\�\�B5\�S}Đ\"�B�\�SJ��M�;\�\�t�\�OK�MY�W\�4Q=\�\�oE?�\�\�Tמ\"�O�GMӰk�ץ\�=�4\�Tz��\�\�8�\�\�ǐh\�b\�q�*	r唽\�# �\�\�`\0��F8�K\�\�\�\�	\�\�~�\�L8z\"p\�\�<����K\�\�>}J��4���\�K\����&�)\��\�(\�`��BԿ��\�a\�<���\��\��\�=��\��ǈQ�ۿ0^5\�\�%\��\�d�4�-\\�\��s�Z�\�t��\�\�\�ټ&\�o�\�\�����\'�0:!\�\��\��\�4w\��z\�\�|V�&��\�\�\������ǅ\�\�q\�p\\8��>\�}��\�G>7A>\��+\\�\��\�\�q\�8\�K���ω���\�\�\�\�E�-\�4��\��\�烈��K�VA�	\�\��@�!x��g\�?\��\�i\�8\�o\05\�5\�\�p�=7�L�m�\�o�c\�F=O#�\r\� >�/�\�\�ߐcDE�\�\�r�/{���\�d+\�\���G��<����\�H5i \�\�v2\�h�ڝw\�~ݵ��\�{\��\�\\u\�\�\�+v�\��F\�ʎP0\�\�\rn\�z�e��O\�ݶu\�\�M�=֯\�\�Z۱f\���+\�ۖ/k�k1g����̌f[��Q^c�\�\�,/#��YMc�\�\Z��:\�\�XWt\��,-�Z��6�\�P��zI\�+1\�D�\n\�\"�]�k7\��-�^6�#ݓz\���\�\�R�\�\��Վ���2\�Ov��1ݖ���*t\�b\�1\�Kp\�Q8FX\�\��\'j⴩}v�\�\�##\�	��ݽ\�\�\�J���)�\�\�Ї�k�\�\�[{T��߹��+Q٧\�\�\�vj\�^Ut��j,�\�u\�Ĭ*\�\��\���\ncV�Ut:�ş-�\�6+\�\�i\�F\��s��]{��1\�\�w\�\�\�\�\�\�+ƹ�\�\"���rt�ҎH;���g�p&�_x\���\�\nl�\�]�3%\���qژYcT\�90{\\\�mƑ�p̤�\�Ѱ\�\�\�&�1ә\'�\�\\c�ځVB\�82�#ݑ\�es\�:tG�D\�t�e�lR8�4;\�\�1�g,\�Qx�Q\�\�1\� &ۓC\�)Z\n!\�)�nB�u{\��\� b4ѣ��e�[m�M�\�\�\�^\�Ym\�\�Ц]��EİV]=��c�{iy�.�\�&ڜcӦ\�B-cfs\�X32\�\Z�1\�X\�k�i!G\�fn�0\�K\�\\�\�^D�a\�\�\r�\\\�\�^��׎M\�\�\Zk�Q!Ql\�\���1\"��\�\�2��1KͰ\�Mj��)9s9\\�\�\�L��I%��\�[l-\�o\�e\�\�tt\�\�;%��:l�*ؚ\n\�h\�|�AP��1XmG\�V`��wl\�$�\�c��\�C(�\\\�/�b\�\�\�)\�ҥΔ-bLuH�^\�hq2d\�Dl�I���\�\�l\�ܸ��\�\�\�\�r\�\�6��\��P\�B\�\�,�9]\�\�E�\�2\�DuҋGs�\�Տ\��}��>m�f\�cg\�#V꘭��cw\�\�v[�1\�%�U#\�*��Z\�@��DR�D\�)#37&zD\�a?1u`rד\�ҫ�V�Ŋ*�\�\�뱪\�U�ӞD�\�=}bL4\�\Zl�\�\�\�ի\Z��\�%\�\�d���\�8 \�\�a,#�\�\�X\"\�p�P�\�\�HbI%\�Ț+�\�{:\�^�\�ۋ��=\�BQ5\�]\�hpѲۡ\�Ӂ�oR�\�M�B5\rw�~I�Y�Z�4i5\�S��zT(�\�l1���%���\�KUci�\�\'d�I2:�\�%��mEq�u(�\��Չ(\\	�%\Z�E�F���\�P�ˋ�\�1�Z[�\�\n��\���-�f�Ud��0��\�hω�4\�\���\�٧T\�\�Ƕ��L��OЮ!�U���G\�H���6v\�U�`NR\�I\'\��9�\Z\�P҆\�u`T\�բ\�u\�\�\�a\�\�\�\�ôe8\�\�.\��	y35y5�F\�\�b�\�\�T��V�A�N�\�L�Qhm\r\�\�\��6�\��H�\�Jd�����|⃂d�W\��3X#{m\�r:){cDW0\�1�05��N�\�:\'\�I?mL�\�\�\�Ic2\�9M%\�d\�\�\�;4\�Y\��\�\�\�:=+\���U�\�\�\�V\�\n.bE\�\�\�Z˞66a6جiX\�P}\�*Q\�\�&\�t�N�j�VhT�V�b\�\r\�l\�	��e[�r\�M�lG8 &\�\"zK�-\Z\�H\ZV{Z�\�\�YX\�c�^��Q��aQ\�b�hdd�Ng�����\�P(8YȔ�\�v=�58dO\�ӜLKX\�D\�b\�I#7�\�F��\�s���>3�\�M5�\�\�jTj:?+^sP�\�vN�ܮ\�	-u\�b���mɡ�U��\�y(Z=\nY�K��ٍ�tP\�&6º�niT\�m%�8aF\�g�\�\�\�I3J\�l����\��0dO`kF@�3J�8ק\�\�Zt۝\�j�W/��\�KϤL=K�Ψ�:yͧ\�\'mIbt��%)\�\�\�\�g`�ЀKE3���ٳE\�~�a���\����4\�b���O\��q|\0\�p	\�ؙ\�(�}�}\�ә�\�lX\�rv\�N\�t\�hV3�\�\�ݛ\�i\0T�G�\�k{�H1���::�\�>-Q�\�\�ڄ\��YJ\�k\�\�\�\�Qj�\�\�N��J�\�*��c\�h�\���\�(\�\�Ռ\�\�vQ\�\�sV3��-\�(�t�)����>\�x%�\�!\�\Z3��:\�\�1�\�\�\"Y���!����{�Pҳ��މ\�\�\�-rj��\�M�\�(�sq*&\�዆���W���1\�ō�:\�`&��G�\�\�b+�\�\�,cQa}\�K�`\�i?ߴH\�c�R�\�vZ�)\�\��|Xh����K\".+r\�b��\�l\�Mj}�\�)+�O\�)F\�-,\�w��nV\r7\�X��\"���\�vE���\�h#�`��\�ɍF٤\�\Z~��cu`\���:\�\�\�\�F|?���(c]\�\�9�\�N*	8\�۪▭\�-��es\�˦ʸecE\�\�8a\�)�[6�\�-\�\�OX\�\�\�\�y햮yqK\���e\���-\�D˚�-�\�s������8nYQ\Z���\�-m\��\�\�\',ˊ\�֒���\�a\�R[\�\�<\'ni���,�\�-\�Ö\�\��\�ĸ\�R\�e�Xii��X\Zf\�-\���e�e�\�Y��nV\�R;\�ea\�	KMQ\�R]\��eA�b�(�\�R^�X\�\�\�j)A^\�3/\�l�\�\�\�g^�\�:\�R���\��\�\�f\�o�U�\�\�-��5l�Q�߰i����h{�E����S\�\�\�\�֛\�\�9\�\�\���u�zn��W�sJ]κ\���ui\�\�u9\��\�	\�\�z\�:gMN\�i\�\�0�\�\�f趯8�\�\\��:6�d�Z\�E!�6�\��*�۸�g����n�f5�Po\�\�9\�6\�I�k^\�3&\�7:��v�\��5\��\�NRN��~��5�y]o\';\��>>if�\�	y\���\��r\�\�%�\�\�7@�և\�\�%\�\�9n<i{�`�@�(�`\01�a;�l�c\0�@\�k��+�\���5\�A�t�\�\�=����>�B꣌\�\�d\�tEa/\�\\�4\�8��Z\�\0[c>:\�o��7�S`*�C�c\��q\�ņb!c�7C0�+fO�J8L\n*_m~�:��=7���j��\\knɜ\�څu5\��ӧ\r\�\\+)�����va�m�q�-1�f4�\�Ϗ_T\\UU\\\\]=���\�\��,466\�u�\�\�:\����\�\�|\��\��\�\�7*��+\�u�\�\�S\�w��-�k\\\�\�1�\�`�{�}E-�\�\�D��H�(tdg&�PV�	�2\�W\�䢔aRCl���j\�M\�oO�?=�\�\�?_��\�;���\"#\�\�qf\�*��Q4>g,�\�\"�\�r)>Q\�2	!;׃}!����8�\�5.rdL&�e�β�\�D��\�\�V�R�M��܎\�7q�\rM��w\�6n�]�c8�t��\�a\�ӳ��,#��)I+���Z9��\�\\�~W�\'o��_>3v\��%C\�U��N�\�_\�\�S\�wN}\�>ꦶ\�\�\�3ݔ:���a\�3�kd��\�)\�j\�\�Tyӧq\�\�\�\�a\�c\�\�\�\�\�\�~1�\�\�Bf�\��\�[\�\��š�ly\�Сo\��c\�Z\�^z�,R\�\�_zi�\'\�[?����\��\�?��\�Z��e�t(pdfgf\�\�JZ�:��\�f\�\�6�J~3�b$\�\�\��IR�\�;G\�_34m;~\�\�#�O��{p\���W�娗Ж`�\��\�yh/	�M?�/z�\�Ln}j��\�\�\�n\��B\�\�\�\�Ϳ�a.X�33�\�6���)�\"Ȥ6b~�ϭ�SS�\�\�.�d\"�1�gs\�sm�h�Kjj3rw\�W��E\�~�{�;4\�xtŗ���Ӛ\�\�\�\�Ս��\�<\�\�\��pKG�\�v޶��}�\�t\���\�l]��u�mj�=��\�L6�\�\�\�3�lJS\n4�\�\�y\�\���I�hf\�ؘۨ\�jP���+�\�\���^�\�q�q\�\��\�_v\�\��k��y�\�\�\�>�֎\��*[}ϩ\�on}c5\�Vy�V3��YsN��\r\�\�L\�>՜4J�\�>�{AnM\��	9\�{\�\�\�&\�\�Uy��\�\�Z5xcټ}\�\�\�S\�>���wlZ\�e}�ԍ˜_���\�\���}��\�zL�-�e���\��Q�\�ԓ\�,r��Bs\�pw%5FC\�T��\��\�/�\�\� \�YΟD:Y�\'ih�ؘ\�:/c))�V�\�\�8�\�>\�1\�\�~�jҡI�\'\�9G\r�d0B\�HI�@j\�\�kj��\�\�WV<P\�,_q�KH;E6\�\�\�d\�ο\�0��̼1MA:�#��\�)WK��܃\�\�\�{߭�g�j\�\�VΟ��\����O_\�m^�\�\�xZ\�\�\�\�Jfv�bN\�\�\�Р\�uVfW\�\�\�\�\�K7\��r0�\�=�\�\�y����\�<\�\�\�\�}{׮�\���[#��\�\�{H�\�m?��\�E\�\�\�B{5��x<\�\�h\"dX���K����G\�\�ܜL\�\"]uȡN\�b�jAWBw-�\�^�K�\�#-7?�\�!\�\���;i\�\�\�]I�\�\�\�]�\�\�\�?~�aὫ�v�y���\�]\�\�s\�\�O�=\���r|�\�m�ݹ������!3=�<Cg��z\�tj�\�7�\�n�N+ht��\�V\����\�t7�\�w\��Ŀ�Q�y0C�\"���d&hy�EK<=\�/�}����\�n+\�\�\�)߿�\�}�\�M��M��#��ood����8D\�Z3�!)\�\�\n64#\"�=4~3F\�/����Y����5�t�cڔ%˨\�dٚ?5��X�8#gkϕ�yt���Q�\�*h\�޿\��}\�u\�\�/\�\��޸⫧��ش\�\�NF\�\�Ϫ�}����+\�>\�]�J\�\�\�\�YV\�\�~&dM�ʚU`E�,\�%�d҃A~JeJڛv,\��ޡ�\�W\�8zӆ�\�ݐ�\��ʎ+�?}��+_8�rpp.W�a\�5�+*\�\�\��/]�c\�\�7\�+\�64i\�KؾW9��M\�-0�$47���zjP\�?Rp:P�ڲ塡Q���;\�vs\�\�\�F\�<\�+=~\�\�\����F:\��߷{\�>��#\�\�\�\�X\�q��\�H�9C\�f\�Q\'\�P��J9\\Zj\�:m.x� �rQ[ۢ�e\�\�7\"�\�\0}90�jx\�\�V[\�\�ZW\�F\�_\��� �?5\�`{��\����OU\�d��6k\���\�\�\�Y\�CS2y\�6u��-�\�\�K܁���}\�=Xa�=\�\�\0�vf��p\\-TZTS\n*�{EXϻ\r.����$\�M\��|\�?����d��\'\�i8ʻ�ϝ\�\�>;7ex\�\��\�\�\�|\�??�$\�Oun�L\�]���\�99C\�\���۹\�\�\�\�\�ߙt�:�\�\�\�\��\�Op~����\� ��O�pυ\�\�y\�p~.\�\�\�\��\�\��Y���x^�?8�ؓ���\�ފ\�h\�oH\r\�#�/�\��z�OR\�\�\�w\�mc\�x\Z\�\'\�\�\�G��\�v\�\r�\��9?w��h\�i|O3\\��\�Sp\Z!˰Wo/F��\��t\"d��\�&��e\�\�\�d\r\�m>e\\Hi`N\�>�mLO%\�6A�\�z;��\�\�L\�\�zNogAUv�\�\�\�\�g/\�\�9�\���\�6�\�ϝ�\ru\�\�-\�\�\�\�]��\�Sp\ZaFn�\�^��]\�������.%\�G\�\�\n*R\�T�K|>�\�;\���\�N9,+C��B\�\�\�\�AY	\�#R�O��b\�\�\r���@D�¢[�}��\��1$)1\Z\�DIG�\��oD\\p+7��Q�\',�^\�\'I#H\�\�%!ɫ�Ź�H$\�w�o\�\�p��R�\��)�J��aW\���}�~)��ʕm\�-��Z*�\�y�[hD�\�\�\�Se�;d\�\�\r�QmU\�Ȋ�R(R \"�\�\�~Efb�<�2 ����(FĐ��qA�/\"y��.䑴�谤Ȉ\��p8\�\�JHOt]Q��03��^��:R\�\�\�W̙ǘ�e\�G�H\�S\�0\Z!���\�\�\�4\�\�勺��i�\�\�\�90\�j~D�\�0j@\�,�A���\�e�V(\�\�\�=e�\�KI\�E#8��.9@W��AE\�H��r3]\'�c8�K�\Z4���\�\���5�AEׅ=2[\��\�\�\�+BG(z\�\�S\�\\��\�K5\n7�0���C2SEsk AI5	��CNէ\�	E\�u{i!*�h�P\�\��݋�\�T`\�\�ԲbI(S�%1�Hn\�/)�	��d\ZP�\����?$�AE�<\�I\�z4���jA㚚�ډE\�h(\�\�d4�*Dg0*��굔4CӸY��A_�|҈f��\�\�Y�S\�CNw\r:�g*�\�K�\�\�\�\��Z\\��CH	���z\�ז\�5	h�a�\�\�9�\0$�;!}0\�\�z牲�Ov��#�\�I\�\�YX�D{x�\���\Z�\�z�KD\�\�*�x��;8\�%\�d\�I��d��DV��\�\rV/\Z)�\�}�\�Œ�i��S�\�S�o�e�HT)L\�p�?aAV�\"#� V��g��6\Z\� Ӏ\�\�uG<kB�k]\�]r[DB���A�j�\�k!�V�\\�@\�x\�Cǚ��@�A	G�\�\n@�9�O:ql\0<8f=\�2��n�ٍ�2\�\�� �	`KD|	����\�\�iQ*��\�?�Xtčx��gB�����!\�Pn1\�\�\0�%�\�8\ZE\�l\�1�g݈�[l�\�9���ΟJ�0>���\�	\�\'�P\�^�4\�2Dp,\rP�\�\0\�Q�Q\�^�t�\�\�QI�A�r����\�\�\�)�+���+��\�\�����\�\�C-�\Z�V\�\�1�73;� V\�;��@�\�ځ�\�`��\�a\�ۢ\���u[��0Y\�PƼFg\'�E�R\�\�X�o�y&�և��΁ja\Z&�Х\�qv�$bt�\�u\�nv�Y��4$]>\ZAt$��\�L\�h��{�\�5?F�\�\�u�9h\�	MhLJ,��\�\�\�U4��H\"��aԋ\n˸�e:%Ҍ��\�\�p\�j\��l,U��\�M\�GM\�(\�ɲ{Ҷ۔K�/�x+\�\�\�Ǭ\�a#n\�֤\�c�h�\�$��\�6�K\�G%�\"\�*�&�W�\��_\�e���j���\Z9#�&\�f\�\�\�\'�Jճ.\�0\'����\'t܎.\�W\�IP�\�\�\�rt8\�5�\�\�\�\�\�\�5�TCZ����Mx%5[8\�m�j�D�O\�!5S\'�\n�Ԭާk=_�UT�\�(I\�\�,\���\�ڮ0�\�\�\�\n�;!f�p\��\�W\���YuS��I\�\\;\�\0\�G�\�D��>1)5\r*\�~4�~LC)�ף%a�jĠ5�\�@\r\�A-\�\�w\Z\�Ub]\�\�+Qߵ\�>\�\�\n\�ɲM\����ZI��!�0���\�-�\�\�Tg��\�\�I�\�D�Y!\�2P\�i��\�Nf%�q\ZIւs\�ZT����d~kyb6���!�\�Z�NE\��\�Q\ZIVbm�H�vr\�\��͟�G�\'ճ�>NB�\�f�\\D\�e\��D\�[�\�s�Zf\�>\�|�\�O(gfֹlO\��Xk.\�\�\�;���d\�9��&ç�\�\��\�\�\�{Ϲ4H\�\�&\�՘TM�\�xVT؞:�W\�a�y�\���bO�U2\�KP��	D\�w�jφ���\�\�\�&t\�՞b�g&�\'2$Qgi�x؞\�\�\�\\qֳ�\�t�T\�@\�	�.�zb؀-7�j\r����Vw���1\�XE\�\��\�.~7��|\�<�~��\�\��\�z\�\�\�\�~\'^�a�M��^-}�\�}�\Z��ba}EU�\�V\�G\ZĚ��;\�	y\�+�}\rb]���?LW�\�HUE}ŢF�\�\�^��\���!/}!mk]�U�Z\�J)(�G_��L�\��2q\�[��\�\r�kaEoDY\�S-b����p�\�\�B\���\�.\�0�\�ID\02��J\�\0�_�\�b��	�p�X\��71G\�wg\0�\�f\��#�c\�f$�\�u�\�\����y\�}<Gs\0׉\�^�����4�\�36`j�O,6�nq܂\�\0<�\�p\�?�{�F����4\�CH&\�B�C\�!��5\�B��\"��\�^O��\�Qre;J�b�y\�\�>C~B@�{%?#�\�/\�+_\'�#|���\�m\��&ȝ����\�o$�\�4�\�\\&\��\� �<nB7aW����G���a3�\n\�Zn-\�.�\�znB\'�a/�6\�\�\�v�~Ώ0ąs{^\�]�\�F\�V�_\�\�Cx��\�G�1�\�㾇\�	\�	�Or�\�4\�\�8ԋ�\�/_\��\�ܫ_\�^C�k\�\r�oq�#\�\�;�\���\�\�jʽϝB8΍\�QU�i<ڜ\�\�s�y3\�<>a>��p?\�l~6\�9|9\�*�\n��_���o\"\\&����\�Va+\�{�{>\"^xLx\�G�\�\���_a�]\�?�g0�X\�\�wԀ1�\�\�o`�^�\��\��/<\�H#�Ơ\�O��̛\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  40[ 556]  105[ 732]  132[ 577]  171[ 585]  205[ 531]  232[ 525]  278[ 239]  299[ 260]  306[ 551]  314[ 552 552]  341[ 561]  344[ 334]  362[ 559]  381[ 452]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:39:23-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:39:23-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:DocumentID><xmpMM:InstanceID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nx�-\��\r@P\����H����:\�I�q��6$�B|3\��/\�\�Y�\�\�\�s\�c17\�[����\�\�*gfB�h<\���\'|+��/C��OƓ���wҌb%]�%\�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000822 00000 n\r\n0000000950 00000 n\r\n0000000978 00000 n\r\n0000001133 00000 n\r\n0000001206 00000 n\r\n0000001443 00000 n\r\n0000001497 00000 n\r\n0000001551 00000 n\r\n0000001718 00000 n\r\n0000001956 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002682 00000 n\r\n0000003090 00000 n\r\n0000011478 00000 n\r\n0000011678 00000 n\r\n0000011705 00000 n\r\n0000014886 00000 n\r\n0000014931 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] >>\r\nstartxref\r\n15239\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Prev 15239/XRefStm 14931>>\r\nstartxref\r\n15996\r\n%%EOF',11),(9,'2025-06-24 19:28:00','ReporteParcial','Entregado',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nx��OMk\�0��ޱ-4�\�8�!\Z�-\�a4��ء�.��~��\�\�\�\�4$�\����|>���MO\r(9=f\�۲}�ǈ�I�hE�؀PJ\��\�z\�\�m�A��\�*\�2辴b!\���\���\�$�ݞ	�M��Z�iwZ}TD+�V\� v�خ��bQ�\�>�M *y�X#p�~�\�1�05ĦY�\�:��螵\�ȋ�Z�׋�\�ź\"+샗��\�\�濎`\�&|�\�Er\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nx�]\�\�j\�0\0ໟ\�\�\�P\����@���\�~X�Hm�3,�q\�C\�~�T:�!�I�%\'M\�vF{���Y\�\����r�\�W\'��\�\rKWZ��\�/���$\�\�\�a\�\�8��\�\�G.ޭ|sT\�X\�\�8m.|\�\�\���\�\���x.X]sc\�\�e��\�<��m�B\\�uj�2>W<C�t9+X\� �\r\��aռ:�U30\�_<-�\�<\�\��\�\�]\Z҅(\�:\�G��iQ!%\�T�ʨ4{\"5�<#=����,Q{A:�2RC\�Q�[fA�]\�x^^\nT�w\�\�GT&�\�[7�\��*\�Yʫsa��t8�89m\���v��*~�g�	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nx�\�|xՙ\�93��eٖ�C\�D#\�6	\�+~%�CP\�؎\�<\�I�8�KcK�^Iv��lHP\�\�\�h!-�\"\�LؖGy\�ז@w\�n�}\0M\�\�\�\�\�ei�\�vib\���ɲ1�-�\�_\�h�9\�?��\�\���0B(\0�l[z+�;�\�\Z!����}\�����q�z\�\��O\��\�f��Ƨ�\�a\���E�\"�\�\���#�_\�2 ��\r`zx\�;9�����\�\�Z�(���\�\�08g��\�o��Z�}\�\�\r50�g�\�\n���eoOB�0�3���A�/\�}��=\�\�B�W\�\�\"�\�V�1~�\'.\Z\��O�֮G(�<�\�\'Q5̇	}P��#\�\\�J�\'���\�s|\�m\�d��JU\�x\�\�\�\�\�\��\�ٴ�6�j\� ��u�\���J\�\�?�\�\�\�C�!4\0W�_�+\r�%7f�Fw\0ߌTH��\�\��\�+s\r3?�k:\�rp<b�\�<�ཀྵ�\�\�(\�\�yYmS\�#|�̱������e_��>��\�D���r�{P\�b\�\������^�\�lh\��\�p`a�U_��\��,B�\�\�A\�\�Zn\�\�\�wpV\�ѹz�\�\�?���*\�|�{\���rŃ;t\�s�\r�^\�\�\�z\\:.��Kǥ\��\�k�w��t0\� \�\'�{\�>	\�\'�\��\�\�=�&?K�O{\\,}\�}�����G?Kٟ\���]�u�t\\:>���bk\�\�:�Ɵ��&�|��\�+��\n\�e\�\0�LT�V�uh\�A�Q=��E/\�\�\�\�|\�8;\�y?�`�Lb�5\�_\0�u0�\�\�D.\�!_\�N#H[��\�bzR�\�`\���\�E\�\�\�j܈�a;ޅE<ʾ���u\�u\����\�\��\�کk<�\�\�މ\�H8$\�	�>\�ب\�=2,��C\�\��ջw\�\�t\�wl\�\�׻�{\�\�M�:;6��-7tiex:]\�biu\�ehZ�\�\�\�2S�\�4\�b\�c��vsW��u�\�lv-\�-ƕ��SpE��	��U�Xt\�Z��\�\�\�A:	��9#y~urN\�Ř�>{�\�\n��q;\'�\�Mw$�-|uG��iĖ\0\�f�ƴ�j��,qXbCV�\�b�vZ�\�\��\�\�=̷G��\r�\�\�a9��\�N{�vl\0jĔ\�\�\�4��\���1\�\�\�1u�e�\�5\�\�Ũ�{\�\�1,�f��w8N\�_,$\�3\�bP\�\�:m\�\�zw\�\� �\�\�g0\�2\�\�.�9�H\n\�2K�d��\�\��\�-�7��!4Eg9��c\'XAq\�#\�iF\�dA�T�\rv�\�4\'\�\�\�\�2nJ�^�Pka\�@f�E\�:)\�%��M��imi6=��@,\�q�<�i=�\�\�8\r<{(�4��N�\�PN=\n\�P\�T��F O6|۬\�vڟ\�#\�O!P4����u�\�l�̦\�V;D�u\Zo�Bj�![\�\�CZ\�l�vB;h���\�^_^F���[D�\�1��\r�N-]\�Hd\�5�`ӂ�t\�\Z�S�$�\�\�iʖt8-m�@b�m�@9�󃱡A+tyC[��d�@�Q�4ÖLc��Ek�oj}Lg�c\�\�\�\�U\�*yFMf4�\�Η�\�ji\�{�N\�d��\�>bv�;f�1\�\�l�\�P3\�\�Lj�F��`[\�\�kw?lR\�>\Z]\�O۸R�)�\�z3\���2eY�ޑ����\�l�s(Z�v\" [-\�/��\�^tw\�$k�vڣz�\�e\�lQ\�6\�N�1\�pR�\�zP\r���f��R��\�K�\�\0N\�hh\�2$#\����T�����WL�\�NK�(\�)�b,d��w9\�Aݴn|$N!\�!��y\�Дae�Dc#s�\�䰍��\�\n9Wb\\)\�<�96j�y\�$��\Z⣼�\�h!�.n\'\�`L�)�@���\� :�ۇ ��a\�`4�q��+MJ���sXBI\�} �)!\�Ħ��A?8X\�=f#S��Hr��\�-\�\�\r�.B�\�\"���1\r\��\�b�j#�V\�>ё\�P�=��Ѩ%\ZàbI�Ҙ���\\\��Z�H\�\�H׶��\�;���\�bv\0	SB}	��j1D�3\n\�\�\r�MU�͉\�\rQ�Z��\�r�\�\�p[\�\r|OC-@&\'t��Ʉi%�\�\�Oi\�g�ޭ)�\�\�O�*k)WЬ\�\�N�h\�:{�1�`5L\�q\���8OU\�\�AV\�j>\�\�ٕ\�\�\�d�10y`h\�%�EsB\�tY_Y��~\�\��VӖ@�c\� Ok�9�I\0}PZ^\�Rue��xe�\Z2���\�$\�yR>\�AA��\�x:�B7\�\�A9\"^K��uTfLܥ&��B�$\�ɧ����\�я�\�L\�d�Ts�x\�<�ɞ3+\�b\�QeW*�N4\�\��K^�V*8*�s+}\�\�\�`1k�������X�n\"Զ��W;\�\�@��YP\�\�A�(�,0��eC��a�gy�AXkYM.i�\�\�\�@�\'\�Ȑ��Bu�\�5x�6�!�Fj\Z\�4\Z\�qR��\�*#\�)S\Z��*Y,\�qkr~�\�IMZ2MN�(�	97J8n\�.�*��d´J4cit�T�R\�ǋb\�\0u\�\�\�ddΝr�\0l�3\Z%�mzw&١�\�l�\�j\r�d��%�\�\0�\�MDk)�a�i�:r\�J\�a\�\0�/ʩ��\�\�E�L�3\�?nMP\�N\0�u%r�+\�\�j9;\'�赑sH\�ȩ\�te�\�\�U}��Ӵ���$3r��$9�\�4\�\�30gT�\�R\�\0\�j��,Uam�ƚR�@E��\�h4=Q�I��w%��\�����x@�3�\�\�\�fP�\�\� �\�k����\�roJ#	P\�=��Rs\�\�D�c(�l\�T\�b\�{M�$���	�\r\�-����\�,\�\�+\�N\�pU��\�i$��\�H��ʃ\�A\�\�(�\�<\�\�O[p�\��[O����\�E\�\�#�\�ט\�\�,\�C��\�\r�b\�\�\Z�F~�(\�p\�J\�k�\rx�8�u�C.U\�\�\�\�\�!��|�hĎP\�*s�����T�\"�\�)\�\�\�L���@\�\�t��:\�x��\��q\�<YU*6`\�k&��m�L\�\�B�%\�\�$��\��\�\�4j!oR\�\�2$S���<���\�X\�h�C}!I7\�t��B򺔔�?!Mi�M��9�F�\�˹��t=�\�\�REhtWt\'��cK�`Ef:(\�\�N�	�\��⦫W\�M�+%Ӯ\���ʸigE\�\�8k��\�M;\�\�\�\�gM۬qSߊNS�犸i\����W\�-\�[M��?bڴ<n\�xy\�\�U\Z7u�ZM\�#�\r\�gM\�\�qS[I\�\�Z\�i�%nj)���\�gM\�\�q�\���\�*��i-7]ɟ0�\�+MM\�$S㲸��7�6M�V-�L\�K㦺�gM��gM5�qSu\�#��U���\�JSy�d�b\�զ�U�\�x\�.K�\�T\�.�l�yɕ&~\rtL\�FL\�V,\�ߵ� n*̏��u�5\�/�\�o\�_b\�&�\�_tYS�{gnCζ\�ö���Ѡߦj`�qp\�Y\��\�\�t\�4\r\�m��C\�@��\�6f�\�a@�ͦ\�g\�ͨ\�\�uZ\�\�i��c�X���@xm���\�ж��\�i�or�\�F���+vs��qA�$���\�i��\�ь�\�j�\"�Ѯ2�ZqJCp��\�y^!W�Ɂ5A�\�\�\�,F�f\�PN��\�b�����8g\����\0\�\�ct\0]�|\�&�\Z\�\�CA4�z��\"ȋF�b`��!\�D\�����GnX1p��\r�\0pڏ6�z;\� \0�fǁ�Aʉ\�\��\����\�6\�\�����h7P\�G\�\�+�NĢ,��\�Q�m\���\�UŜ.ϣ\����Ź����V\�\r�Vg\�\0�f\�4T�ܓm\�.)*�����\�_��V��͸�~U}}]m��H�Ȓ�Ѩ\�\Z\���ˊ������gֱk\��\\SSc}\�\���\�\�^wOw˪\"N\���\�oWW�\�^\�;\�\�\�+/k�o\�b\�>x\��X��\�\�UG�\�\�\�s�c\r\�!�-C\�i\�j�rTYб��&�\�\Zla\�l��\�\�?>��\�ԅ����_��?xO\�e\�5\�ؔ��%u)�f��7J\��i&c�w;�֒\��!���f!�\���e�z�\Z�A�V[��\�PI�\���&ۢ\\c�\�;\�_�^;�j|�j�����\�\�>x��\��?��?\���;wp\�G<Zj\�L+(X�\��=+\��ʡ\�\�\��Ե˘�\\[�X\�ـ�}o�\��\�\�эC\�\�Oo\�[�k\�\�˸�so��kf��j\��\�\'�\�\�\�<�\�z#W^x���\�Ѯ=�@�\���\�\�ٷ\�2��m\�Kt�\�b\�B�<�d*D\�D�ICv��jekQ)I�\�U�A��/ce[.W�/��_Uǩ\�\�\�{��\��U\\\�\�b􁑧\"]7�l\�jZ�;]\�\�ϼ��\�9���[ɬ?�{ؿ\�\�\���G<\"�v\�O]�\�U\�걎�n?#���C�L����%\�Z��kH�Vm�Ջd`AvMR�\�R�%\�\�\�\�7\�\�\�wW��rZ\�W7�\�T�\�x\�\�59\�;�zkO�fF��s7�;n\�\�D\�\�s�=\����k\��%\�Lbd\�GY�DY>�QNC\�\rH�\�˘\ZP�&��f�S\��C/\��w�`���i\�<\�>Ⱥ���<\�\�\�/\��_\�o{g\�sY+\�Nz�#�me\�n>�x;�\�o�z���\nI:��ҫV\nD,X��_S���8T\�P���\�F\'�9����\��a\��=�3��\nlz�\�HX-�+�4{d\�!�k���\��\�S�\�\�}��Z��\�wk9��\�M�o?r\�̮v�UΦ�\�\�{bϑ�\�,\���\�\����=�I>Su����׎\�\�F \�\�-ީի����\�\��\r�\�\�9�ξ}\�\�䑁S�އ\�a\�\�\"\�����\\����ٙ\�\�e�Y(�\�.9/�V\�&\�\�-E��g\�j�^i�\�\�\�@U��o/Ɍ\�{+qޑ��\���X��\�\�ݪړ��\���ԃ\�B�f�\�\�O?\�q\�\�\�٧\�1\�\'(-���%�\�\�I�\�,\"��/��^qK$��\�\�ó�?�q��Җ�}�\�C�k�\�2[N�^��|Yn��k���+in-�`\�j \�Ԃ\�aP���{\�R�dy~�\� \�>\�9�\��G\��(ݻy�\��͛���y\��cg�z\�廵�\�scN\�\�kvJ�;�6���\�\�u\�fs\�ƽ}\�\�\��\�[/ٰǾ1\�^D�\��\�~\�Q\�!�-S����6�IWK9JU[k�k\�h����Y�+I�/\�*�\�\�{�\�1\n�\�菾�\�\�\�����\�\�߲?b_W�S\'eq�V�\�\�\�ޖ3���J\�\���_��k\����o-�\���\�G��\� s\�\�=\�\�\��5\�\�\�oo�\�\�\�\�7ٷh��\�\�t�^-,�5$?7YE��Q0��\�-TI�}\�ݮg�\� �\��-���ˏ��o�\�\�\�\�N�<��\�\�\�\'���y:\�\�\�\�\�\�\"�\�2\�̟T}��B\�f\�K���Y\�\�\��\�E�5/W@��&^\\�h�j΍5?�\�\�\�;�\��?�\�Wo\�8|\�\�\�;�o�QS{ce\�!\�\�\�`\�kG6��-g\�w�o\�\�_\�\\�?�+\�\�\�rՍl\�\�\�fY#vh�:e>e\�\"O�4!;w݇w��q�\�������\�w\�~x��X6\�q��r\�ɃSO\r\nO]s\�Ia\�ɞ�\��L\�Gb�8໪eP�\nl\�*�Z�\�KX\�)wn�9ٙ��n-��&�Ybt\�\�=\�3\�\�m(i�\�9�s�\�_\0#0�\r\�Ȧ>X�|Z��\�\�\�\�\�\�\r,�#\�e��r��T�g��.�J�\�[7���\�%ly \�q�\�x\'�ٝsR\�\�\��rxzP,R�\�n\�c?\�%\�[�sV��<g\�^<pݖ\�7�\��\�\�\�5z�+p�V\�\�|\�,\��\ZMC�֚��j9\n�}\��m�����I@_�z\��%O5�L>�*��;\�\�~\�L3>�\�2f��`\�\�\�Կ�1�3������K\ZZ�rmi\�`\�q]Q��\�-e\�d4l\�\�C�cٕ�;:V׷�\�/�q\�	\�ub\�\'�GG]}[[}]\��\�Y/��s!\�t\Z\�\���Ղ\�1�=�k}\���3�\���\�Y\�@lt\�\�o%�㟫�f�\�\�iV\�£��rk`\�;/\�\�UO㌙�\0\�g�\�\�B)A0י1�%\�m\�zÈ鞙j\�{\\Wq[���̮A\���\�V\��<������n\��\�\Z\��7j;?u�\'��������\�k\�_\�N\�\��\�XӇ\�\�d\����>m\�Ҹ��ڥv��\�ЧjGh�h�-\��a�\��\��\��Z\�\��Tm\�_��\\j�\��\\�{\�R�:�=B\�]\�j�\�O\��`$\��a\�(}6ϥ\�U(�ݫ\�\�)x\rjH\�3\�\�\�\rJ?YU���!�>{V\�Z�\�\�*�RR�i)4MH�:�\�\�\0�q\�[�\\\Z(Tݦ\�1\�\�UJ�A��	�Ϧ๔�\n\�(}u\n^��d_�rT_Q�i�PJ駣>�KJ_��2\n�~{,�]\�g�\�7��!�\��n`�>�D髐.{�\�OK�iB�����\Z�\��:_]U]\�o\�8�@(0\�[R0 	aO�_��\�z�ψ;\�{Đ(���\n�\�-\�Ec�\�/\�\�W\�\�|\�\�	\�\���B�K���\�\�=~>(Ha>\��Gx��#�I~h�_\�wI7\�m�;\���^\�%\�+�~\'eH��%A�#��\�\�p8j��\�ݑ�\ng�W)\0�|�p�T�\�)u\�70T\�BaQ�\�\�\�Һ���\�\�ZQ�\'%b��!U�\n�[�|�P\�\���(��\�$�â���D��\�-H#b\����R�\�/[\�I��N�\�.^�N�\0�xW�\��0u3?\�\�`#\�AQ���h\�/q\"�KL\�\��@$�%��\�(\"�7\�\":$���G�@\�+\��FB`ѳ�\�\\�ar�Y�Ȑ\�r�\�.a=	2D�N\�OV�������zS[g��4DJ�84���ʝp|s-!I�Ѕ\�\"]\�\n�˨\�Q\�&B>\�z\�4g�\�\��B�4\r����HM�\�\��ASY\��\�lP���[\0ՇD\�_r�\n)\�HDz(q\��\�a+Pq\�XBD�K�K\�	\�X�hv3�H�H�\�M�� ��G�xi;���U]Q��iKM}\�\�P$\�z@3��*xG \���I��m�qJ�@\��\nz�I\�\�A\��\�0����t�\�D;%�<\��W\�\�y\�!�R�q�!*��amY�\0Λp{�\�y \�\�Y\�~\�$�ܳ�}C�+�8|�����uJ��\�D/ɫ�z`���E�b���~o@p\�\�� �J��90¾�\�E2hܢ78ףPa\�\�\�$ $Ǥ�\�3\��+U\n�w�\� �V\�\�`\0�I\�=Y	I	\�I\�\�\�\�\�-A\�Lȵ^\�>�#,@|\�\���Q��\�ۄ<ȉ$@!8�Qp-ГP�B0\��Q̬C^h<\�\�r\�\\��D��@=\�E)�`V�k\Z�3~\�\�@/�!\�@f�4�q/\�e�J!\�\'��`\\@7N�h \0\�\�<\���B���$�\�p�\0\�I\�Q�f]@�k\���$��|�\"�h#Q9D�\0xg��	�R�l`�\�\�a��P#��6s�g�W\0�\0\�VPtQ9\�L\�P9�wy\n\�J\�\0�J\� P�m%ڈ: B�h3\�X�.������i�ё#�5|�Ⱥn\�\�G\�R�\�+Qq\�9Q\�\�\�?\�Ņ\�h\�\�쬷W���Q�hd�t}�r)�uaj�N��ΑD�NP�\�\�E�!:\�JAяd�D�6�j=�\�Ds��\�p2_{\�\�(\�\�ZBrR�{�3\'\�\"Y,gB\0䇕#Q�\�K\�Q�pr\��\�\�W{a죸Tf�7u?ʚF\�,K\�\'\���O�\'\�bJ��4o�\�\�n�qѾ�\�\�E�%)�Է	Yr<*i\�\�)V��\�߳q]\�we)q�m	&34</�f흠\�\�}lL�&�\����㢐p��q(�T�L�\�Nꕗ\�щdԜT\'\�ӣ\�טR\rI\�К6�\�\�\�\\X\�i��?\�ԝ:wU�\�@\�\�C�ճ��ZE������=D\�\�O�\�Y/\�f��s������%�/Pz����H���p>��\�L#t��\��\�<H��-��\����@�\�v%[ު\nR�\�T�\�Q\�V\�4D�@+��\�W��\�\�}��\n\Z���\�\��0ĔxI��A\�0	\�\�\�-�\�\�T^A���<\�D�z!Hw�ӄR\�\�K<�4��\�m\�v\�h	\��-\�� \�\�\��+�u*\\De,\�\�\�p�\�\��Dl\�\�\r^���R\�o.fxN=�\�y�c�˅��,?�\�r˒r\�[ \�	%\�\�Y\�	e�\�Z\�\�d��\���\n���J֝s�u�K};\�}\�n�\�g!R\�ks\�jJ\�b�lK�\�K<+J\��:�T\�	jy�\�\�\�=aNV�4.��\'^�����l��y2�\����\�S�_�\�,\�\�I\�Y�?nz\�\�(~��г��t��\�|\' �\�\0\�;�蹨V[h\�$\\\�\��}@\�A+��P\��\�\�%��p�+W\�\�!�ץ\�].��\��1օ\�>�\�u\�%�/\�\�kpmEmCEUT�����d8\��C=C�|}�&\�\"��SU\�P�����\�\�\��.a\�C^H�:�se��ιQ�\���I\�[ƷK�8VƏ{\�e\�\�H�<��Nd�v��E\�i\�og\�QX��@0�7!4\�I�Cx^��\n1xE\�k��ZT7�5\���L�;C(���\�O�\��\\�XKp��2J\�}�\���ϔ�\�@0K\�$���a�\�aka�\Z��	�~D�[�B�\�	\��o�3\0��\�=\�;��}1ր�ӱ`&^Њ�\0܊�\0E|\�58\n\����\0Ï�nO㧡\Z?\�\��\�\0_�\��\Z�\��\0�O�?\�?�&~\�9|\�;�_\0��t�{�>�?\�8\�\�h\0�1\�\03\��\�dr��\0M\�\0˘\n�uL�5̕\0[�M\0�2[\�2}\0�3;\0:��\0\�\�bF�� 8�L���\�M\�-\0\�b\��\0\�\r��1\�\0�d��\��g��y�y\�\�\����\'�?b�\�O��\0�\�3�o1o<ǀ�\�/�\�\0�w\�=��c�R\�}\�<�faL�a�\�l&�	\��\Z\0\�9\0\�\�|��\�\�\0��\�\0�\�\0�\�*�6v��a\�s%��\\+�����\�N|�{�\�\�S\���1\�\����\��7�wU*�\�,��\Zѿu����\�q\�\�U\�\� �XX\�,Bܷ�����>\�\� 9\��-\�\���\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nx�-\�\�@@෿\'c\�@\npՀvЂ�\�\�A�P�Zyr\�7�\�����\0>6r\�LEV�v ���9\�]2:�,��!�8�\�\�c.=%��B~	MO�\�\�B�\0/\�g\�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',13),(10,'2025-06-24 19:28:00','EvaluacionParcialPorOV','Entregado',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 251>>\r\nstream\r\nx��PMK\�0�\�\�+��Iڤ�0\�/\�d\n\�akOu�?8iԓ9d2\�yaǷ\�1cw\�w�e�\�����{fh�޵\�\�	d\0�\�탁��VW�h\�NZ\�BL/Z���\r�\�1\��W\���0_\�步�\��\�SD45g6\"��\�9=M�\�\Z1!�C\�NPrHVk\�\���R\�d\�7U5SWy\�D�\�\�HB���Z�m\�	1^ͤ�LFj\�\�3L�Z\r�\�V�M\��M\�z��\�G\Zk\�\�;\������O\�\�S\�\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623203923-06\'00\') /ModDate(D:20250623203923-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 333>>\r\nstream\r\nx�]�_k�0\�\�\�)\�\�=�VmAg+��?\�\�i\��&\�N�1\�\��o�\�\�F	��\�ssT;������x�\��\Z\�\�9\�#�IXD\��ͅ\�\�c�H`\�\�2\�O$\�i\�f��\�]�b:\�	^�\0=\�]}T�\�\��\�� \r\rIQP��\�S\�\�4@ۺ�>�em=�\�E���\�\'�\�8\�N��\�]\�k�\nR\�\�w\�u\��w��:\�Zun�\�Q�\�T#m7HI�T>zJ��=Rʐ��4v\�X\�i�y_Z!ő���\�`\�T\�&X\\:��\�\�\�kt\�q\�\�m^�\�uÒu&f�O�EHi\�	;e�ϟa7\�\�\���S�\�sC������S���\�p�$\�>���s��I��\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8298/Length1 21668>>\r\nstream\r\nx�\�|x\�\��\�\�n6W6$��e�ln$$�uIH \��\0Y��\�N�K\�\�\�nB�(Q�\��Uk�\n�b�\�	VO\�V\�\n����\�X�z\���\�\�\�\�i�G!��\�7��\r \�\�Q\�\���\�y综\�{\�ofY\0� ��������\�N\�\�\�^\��\�S/\�\�ލ�\�.���[\�\�\0\�\�c�\�PD�~c�\0s�\�\���2\��\�C�{|#���\�\��g\02�<�\�.>\�׻\�^u\�:�� \�[��b�?�s�Ork���\0SU_\�%=��\�Q��E�\�\�v�L~�	\�{_\�\��\�;�\0:\�\�1. �\�\�S�\�\�帾<G\�\�B5\�S}Đ\"�B�\�SJ��M�;\�\�t�\�OK�MY�W\�4Q=\�\�oE?�\�\�Tמ\"�O�GMӰk�ץ\�=�4\�Tz��\�\�8�\�\�ǐh\�b\�q�*	r唽\�# �\�\�`\0��F8�K\�\�\�\�	\�\�~�\�L8z\"p\�\�<����K\�\�>}J��4���\�K\����&�)\��\�(\�`��BԿ��\�a\�<���\��\��\�=��\��ǈQ�ۿ0^5\�\�%\��\�d�4�-\\�\��s�Z�\�t��\�\�\�ټ&\�o�\�\�����\'�0:!\�\��\��\�4w\��z\�\�|V�&��\�\�\������ǅ\�\�q\�p\\8��>\�}��\�G>7A>\��+\\�\��\�\�q\�8\�K���ω���\�\�\�\�E�-\�4��\��\�烈��K�VA�	\�\��@�!x��g\�?\��\�i\�8\�o\05\�5\�\�p�=7�L�m�\�o�c\�F=O#�\r\� >�/�\�\�ߐcDE�\�\�r�/{���\�d+\�\���G��<����\�H5i \�\�v2\�h�ڝw\�~ݵ��\�{\��\�\\u\�\�\�+v�\��F\�ʎP0\�\�\rn\�z�e��O\�ݶu\�\�M�=֯\�\�Z۱f\���+\�ۖ/k�k1g����̌f[��Q^c�\�\�,/#��YMc�\�\Z��:\�\�XWt\��,-�Z��6�\�P��zI\�+1\�D�\n\�\"�]�k7\��-�^6�#ݓz\���\�\�R�\�\��Վ���2\�Ov��1ݖ���*t\�b\�1\�Kp\�Q8FX\�\��\'j⴩}v�\�\�##\�	��ݽ\�\�\�J���)�\�\�Ї�k�\�\�[{T��߹��+Q٧\�\�\�vj\�^Ut��j,�\�u\�Ĭ*\�\��\���\ncV�Ut:�ş-�\�6+\�\�i\�F\��s��]{��1\�\�w\�\�\�\�\�\�+ƹ�\�\"���rt�ҎH;���g�p&�_x\���\�\nl�\�]�3%\���qژYcT\�90{\\\�mƑ�p̤�\�Ѱ\�\�\�&�1ә\'�\�\\c�ځVB\�82�#ݑ\�es\�:tG�D\�t�e�lR8�4;\�\�1�g,\�Qx�Q\�\�1\� &ۓC\�)Z\n!\�)�nB�u{\��\� b4ѣ��e�[m�M�\�\�\�^\�Ym\�\�Ц]��EİV]=��c�{iy�.�\�&ڜcӦ\�B-cfs\�X32\�\Z�1\�X\�k�i!G\�fn�0\�K\�\\�\�^D�a\�\�\r�\\\�\�^��׎M\�\�\Zk�Q!Ql\�\���1\"��\�\�2��1KͰ\�Mj��)9s9\\�\�\�L��I%��\�[l-\�o\�e\�\�tt\�\�;%��:l�*ؚ\n\�h\�|�AP��1XmG\�V`��wl\�$�\�c��\�C(�\\\�/�b\�\�\�)\�ҥΔ-bLuH�^\�hq2d\�Dl�I���\�\�l\�ܸ��\�\�\�\�r\�\�6��\��P\�B\�\�,�9]\�\�E�\�2\�DuҋGs�\�Տ\��}��>m�f\�cg\�#V꘭��cw\�\�v[�1\�%�U#\�*��Z\�@��DR�D\�)#37&zD\�a?1u`rד\�ҫ�V�Ŋ*�\�\�뱪\�U�ӞD�\�=}bL4\�\Zl�\�\�\�ի\Z��\�%\�\�d���\�8 \�\�a,#�\�\�X\"\�p�P�\�\�HbI%\�Ț+�\�{:\�^�\�ۋ��=\�BQ5\�]\�hpѲۡ\�Ӂ�oR�\�M�B5\rw�~I�Y�Z�4i5\�S��zT(�\�l1���%���\�KUci�\�\'d�I2:�\�%��mEq�u(�\��Չ(\\	�%\Z�E�F���\�P�ˋ�\�1�Z[�\�\n��\���-�f�Ud��0��\�hω�4\�\���\�٧T\�\�Ƕ��L��OЮ!�U���G\�H���6v\�U�`NR\�I\'\��9�\Z\�P҆\�u`T\�բ\�u\�\�\�a\�\�\�\�ôe8\�\�.\��	y35y5�F\�\�b�\�\�T��V�A�N�\�L�Qhm\r\�\�\��6�\��H�\�Jd�����|⃂d�W\��3X#{m\�r:){cDW0\�1�05��N�\�:\'\�I?mL�\�\�\�Ic2\�9M%\�d\�\�\�;4\�Y\��\�\�\�:=+\���U�\�\�\�V\�\n.bE\�\�\�Z˞66a6جiX\�P}\�*Q\�\�&\�t�N�j�VhT�V�b\�\r\�l\�	��e[�r\�M�lG8 &\�\"zK�-\Z\�H\ZV{Z�\�\�YX\�c�^��Q��aQ\�b�hdd�Ng�����\�P(8YȔ�\�v=�58dO\�ӜLKX\�D\�b\�I#7�\�F��\�s���>3�\�M5�\�\�jTj:?+^sP�\�vN�ܮ\�	-u\�b���mɡ�U��\�y(Z=\nY�K��ٍ�tP\�&6º�niT\�m%�8aF\�g�\�\�\�I3J\�l����\��0dO`kF@�3J�8ק\�\�Zt۝\�j�W/��\�KϤL=K�Ψ�:yͧ\�\'mIbt��%)\�\�\�\�g`�ЀKE3���ٳE\�~�a���\����4\�b���O\��q|\0\�p	\�ؙ\�(�}�}\�ә�\�lX\�rv\�N\�t\�hV3�\�\�ݛ\�i\0T�G�\�k{�H1���::�\�>-Q�\�\�ڄ\��YJ\�k\�\�\�\�Qj�\�\�N��J�\�*��c\�h�\���\�(\�\�Ռ\�\�vQ\�\�sV3��-\�(�t�)����>\�x%�\�!\�\Z3��:\�\�1�\�\�\"Y���!����{�Pҳ��މ\�\�\�-rj��\�M�\�(�sq*&\�዆���W���1\�ō�:\�`&��G�\�\�b+�\�\�,cQa}\�K�`\�i?ߴH\�c�R�\�vZ�)\�\��|Xh����K\".+r\�b��\�l\�Mj}�\�)+�O\�)F\�-,\�w��nV\r7\�X��\"���\�vE���\�h#�`��\�ɍF٤\�\Z~��cu`\���:\�\�\�\�F|?���(c]\�\�9�\�N*	8\�۪▭\�-��es\�˦ʸecE\�\�8a\�)�[6�\�-\�\�OX\�\�\�\�y햮yqK\���e\���-\�D˚�-�\�s������8nYQ\Z���\�-m\��\�\�\',ˊ\�֒���\�a\�R[\�\�<\'ni���,�\�-\�Ö\�\��\�ĸ\�R\�e�Xii��X\Zf\�-\���e�e�\�Y��nV\�R;\�ea\�	KMQ\�R]\��eA�b�(�\�R^�X\�\�\�j)A^\�3/\�l�\�\�\�g^�\�:\�R���\��\�\�f\�o�U�\�\�-��5l�Q�߰i����h{�E����S\�\�\�\�֛\�\�9\�\�\���u�zn��W�sJ]κ\���ui\�\�u9\��\�	\�\�z\�:gMN\�i\�\�0�\�\�f趯8�\�\\��:6�d�Z\�E!�6�\��*�۸�g����n�f5�Po\�\�9\�6\�I�k^\�3&\�7:��v�\��5\��\�NRN��~��5�y]o\';\��>>if�\�	y\���\��r\�\�%�\�\�7@�և\�\�%\�\�9n<i{�`�@�(�`\01�a;�l�c\0�@\�k��+�\���5\�A�t�\�\�=����>�B꣌\�\�d\�tEa/\�\\�4\�8��Z\�\0[c>:\�o��7�S`*�C�c\��q\�ņb!c�7C0�+fO�J8L\n*_m~�:��=7���j��\\knɜ\�څu5\��ӧ\r\�\\+)�����va�m�q�-1�f4�\�Ϗ_T\\UU\\\\]=���\�\��,466\�u�\�\�:\����\�\�|\��\��\�\�7*��+\�u�\�\�S\�w��-�k\\\�\�1�\�`�{�}E-�\�\�D��H�(tdg&�PV�	�2\�W\�䢔aRCl���j\�M\�oO�?=�\�\�?_��\�;���\"#\�\�qf\�*��Q4>g,�\�\"�\�r)>Q\�2	!;׃}!����8�\�5.rdL&�e�β�\�D��\�\�V�R�M��܎\�7q�\rM��w\�6n�]�c8�t��\�a\�ӳ��,#��)I+���Z9��\�\\�~W�\'o��_>3v\��%C\�U��N�\�_\�\�S\�wN}\�>ꦶ\�\�\�3ݔ:���a\�3�kd��\�)\�j\�\�Tyӧq\�\�\�\�a\�c\�\�\�\�\�\�~1�\�\�Bf�\��\�[\�\��š�ly\�Сo\��c\�Z\�^z�,R\�\�_zi�\'\�[?����\��\�?��\�Z��e�t(pdfgf\�\�JZ�:��\�f\�\�6�J~3�b$\�\�\��IR�\�;G\�_34m;~\�\�#�O��{p\���W�娗Ж`�\��\�yh/	�M?�/z�\�Ln}j��\�\�\�n\��B\�\�\�\�Ϳ�a.X�33�\�6���)�\"Ȥ6b~�ϭ�SS�\�\�.�d\"�1�gs\�sm�h�Kjj3rw\�W��E\�~�{�;4\�xtŗ���Ӛ\�\�\�\�Ս��\�<\�\�\��pKG�\�v޶��}�\�t\���\�l]��u�mj�=��\�L6�\�\�\�3�lJS\n4�\�\�y\�\���I�hf\�ؘۨ\�jP���+�\�\���^�\�q�q\�\��\�_v\�\��k��y�\�\�\�>�֎\��*[}ϩ\�on}c5\�Vy�V3��YsN��\r\�\�L\�>՜4J�\�>�{AnM\��	9\�{\�\�\�&\�\�Uy��\�\�Z5xcټ}\�\�\�S\�>���wlZ\�e}�ԍ˜_���\�\���}��\�zL�-�e���\��Q�\�ԓ\�,r��Bs\�pw%5FC\�T��\��\�/�\�\� \�YΟD:Y�\'ih�ؘ\�:/c))�V�\�\�8�\�>\�1\�\�~�jҡI�\'\�9G\r�d0B\�HI�@j\�\�kj��\�\�WV<P\�,_q�KH;E6\�\�\�d\�ο\�0��̼1MA:�#��\�)WK��܃\�\�\�{߭�g�j\�\�VΟ��\����O_\�m^�\�\�xZ\�\�\�\�Jfv�bN\�\�\�Р\�uVfW\�\�\�\�\�K7\��r0�\�=�\�\�y����\�<\�\�\�\�}{׮�\���[#��\�\�{H�\�m?��\�E\�\�\�B{5��x<\�\�h\"dX���K����G\�\�ܜL\�\"]uȡN\�b�jAWBw-�\�^�K�\�#-7?�\�!\�\���;i\�\�\�]I�\�\�\�]�\�\�\�?~�aὫ�v�y���\�]\�\�s\�\�O�=\���r|�\�m�ݹ������!3=�<Cg��z\�tj�\�7�\�n�N+ht��\�V\����\�t7�\�w\��Ŀ�Q�y0C�\"���d&hy�EK<=\�/�}����\�n+\�\�\�)߿�\�}�\�M��M��#��ood����8D\�Z3�!)\�\�\n64#\"�=4~3F\�/����Y����5�t�cڔ%˨\�dٚ?5��X�8#gkϕ�yt���Q�\�*h\�޿\��}\�u\�\�/\�\��޸⫧��ش\�\�NF\�\�Ϫ�}����+\�>\�]�J\�\�\�\�YV\�\�~&dM�ʚU`E�,\�%�d҃A~JeJڛv,\��ޡ�\�W\�8zӆ�\�ݐ�\��ʎ+�?}��+_8�rpp.W�a\�5�+*\�\�\��/]�c\�\�7\�+\�64i\�KؾW9��M\�-0�$47���zjP\�?Rp:P�ڲ塡Q���;\�vs\�\�\�F\�<\�+=~\�\�\����F:\��߷{\�>��#\�\�\�\�X\�q��\�H�9C\�f\�Q\'\�P��J9\\Zj\�:m.x� �rQ[ۢ�e\�\�7\"�\�\0}90�jx\�\�V[\�\�ZW\�F\�_\��� �?5\�`{��\����OU\�d��6k\���\�\�\�Y\�CS2y\�6u��-�\�\�K܁���}\�=Xa�=\�\�\0�vf��p\\-TZTS\n*�{EXϻ\r.����$\�M\��|\�?����d��\'\�i8ʻ�ϝ\�\�>;7ex\�\��\�\�\�|\�??�$\�Oun�L\�]���\�99C\�\���۹\�\�\�\�\�ߙt�:�\�\�\�\��\�Op~����\� ��O�pυ\�\�y\�p~.\�\�\�\��\�\��Y���x^�?8�ؓ���\�ފ\�h\�oH\r\�#�/�\��z�OR\�\�\�w\�mc\�x\Z\�\'\�\�\�G��\�v\�\r�\��9?w��h\�i|O3\\��\�Sp\Z!˰Wo/F��\��t\"d��\�&��e\�\�\�d\r\�m>e\\Hi`N\�>�mLO%\�6A�\�z;��\�\�L\�\�zNogAUv�\�\�\�\�g/\�\�9�\���\�6�\�ϝ�\ru\�\�-\�\�\�\�]��\�Sp\ZaFn�\�^��]\�������.%\�G\�\�\n*R\�T�K|>�\�;\���\�N9,+C��B\�\�\�\�AY	\�#R�O��b\�\�\r���@D�¢[�}��\��1$)1\Z\�DIG�\��oD\\p+7��Q�\',�^\�\'I#H\�\�%!ɫ�Ź�H$\�w�o\�\�p��R�\��)�J��aW\���}�~)��ʕm\�-��Z*�\�y�[hD�\�\�\�Se�;d\�\�\r�QmU\�Ȋ�R(R \"�\�\�~Efb�<�2 ����(FĐ��qA�/\"y��.䑴�谤Ȉ\��p8\�\�JHOt]Q��03��^��:R\�\�\�W̙ǘ�e\�G�H\�S\�0\Z!���\�\�\�4\�\�勺��i�\�\�\�90\�j~D�\�0j@\�,�A���\�e�V(\�\�\�=e�\�KI\�E#8��.9@W��AE\�H��r3]\'�c8�K�\Z4���\�\���5�AEׅ=2[\��\�\�\�+BG(z\�\�S\�\\��\�K5\n7�0���C2SEsk AI5	��CNէ\�	E\�u{i!*�h�P\�\��݋�\�T`\�\�ԲbI(S�%1�Hn\�/)�	��d\ZP�\����?$�AE�<\�I\�z4���jA㚚�ډE\�h(\�\�d4�*Dg0*��굔4CӸY��A_�|҈f��\�\�Y�S\�CNw\r:�g*�\�K�\�\�\�\��Z\\��CH	���z\�ז\�5	h�a�\�\�9�\0$�;!}0\�\�z牲�Ov��#�\�I\�\�YX�D{x�\���\Z�\�z�KD\�\�*�x��;8\�%\�d\�I��d��DV��\�\rV/\Z)�\�}�\�Œ�i��S�\�S�o�e�HT)L\�p�?aAV�\"#� V��g��6\Z\� Ӏ\�\�uG<kB�k]\�]r[DB���A�j�\�k!�V�\\�@\�x\�Cǚ��@�A	G�\�\n@�9�O:ql\0<8f=\�2��n�ٍ�2\�\�� �	`KD|	����\�\�iQ*��\�?�Xtčx��gB�����!\�Pn1\�\�\0�%�\�8\ZE\�l\�1�g݈�[l�\�9���ΟJ�0>���\�	\�\'�P\�^�4\�2Dp,\rP�\�\0\�Q�Q\�^�t�\�\�QI�A�r����\�\�\�)�+���+��\�\�����\�\�C-�\Z�V\�\�1�73;� V\�;��@�\�ځ�\�`��\�a\�ۢ\���u[��0Y\�PƼFg\'�E�R\�\�X�o�y&�և��΁ja\Z&�Х\�qv�$bt�\�u\�nv�Y��4$]>\ZAt$��\�L\�h��{�\�5?F�\�\�u�9h\�	MhLJ,��\�\�\�U4��H\"��aԋ\n˸�e:%Ҍ��\�\�p\�j\��l,U��\�M\�GM\�(\�ɲ{Ҷ۔K�/�x+\�\�\�Ǭ\�a#n\�֤\�c�h�\�$��\�6�K\�G%�\"\�*�&�W�\��_\�e���j���\Z9#�&\�f\�\�\�\'�Jճ.\�0\'����\'t܎.\�W\�IP�\�\�\�rt8\�5�\�\�\�\�\�\�5�TCZ����Mx%5[8\�m�j�D�O\�!5S\'�\n�Ԭާk=_�UT�\�(I\�\�,\���\�ڮ0�\�\�\�\n�;!f�p\��\�W\���YuS��I\�\\;\�\0\�G�\�D��>1)5\r*\�~4�~LC)�ף%a�jĠ5�\�@\r\�A-\�\�w\Z\�Ub]\�\�+Qߵ\�>\�\�\n\�ɲM\����ZI��!�0���\�-�\�\�Tg��\�\�I�\�D�Y!\�2P\�i��\�Nf%�q\ZIւs\�ZT����d~kyb6���!�\�Z�NE\��\�Q\ZIVbm�H�vr\�\��͟�G�\'ճ�>NB�\�f�\\D\�e\��D\�[�\�s�Zf\�>\�|�\�O(gfֹlO\��Xk.\�\�\�;���d\�9��&ç�\�\��\�\�\�{Ϲ4H\�\�&\�՘TM�\�xVT؞:�W\�a�y�\���bO�U2\�KP��	D\�w�jφ���\�\�\�&t\�՞b�g&�\'2$Qgi�x؞\�\�\�\\qֳ�\�t�T\�@\�	�.�zb؀-7�j\r����Vw���1\�XE\�\��\�.~7��|\�<�~��\�\��\�z\�\�\�\�~\'^�a�M��^-}�\�}�\Z��ba}EU�\�V\�G\ZĚ��;\�	y\�+�}\rb]���?LW�\�HUE}ŢF�\�\�^��\���!/}!mk]�U�Z\�J)(�G_��L�\��2q\�[��\�\r�kaEoDY\�S-b����p�\�\�B\���\�.\�0�\�ID\02��J\�\0�_�\�b��	�p�X\��71G\�wg\0�\�f\��#�c\�f$�\�u�\�\����y\�}<Gs\0׉\�^�����4�\�36`j�O,6�nq܂\�\0<�\�p\�?�{�F����4\�CH&\�B�C\�!��5\�B��\"��\�^O��\�Qre;J�b�y\�\�>C~B@�{%?#�\�/\�+_\'�#|���\�m\��&ȝ����\�o$�\�4�\�\\&\��\� �<nB7aW����G���a3�\n\�Zn-\�.�\�znB\'�a/�6\�\�\�v�~Ώ0ąs{^\�]�\�F\�V�_\�\�Cx��\�G�1�\�㾇\�	\�	�Or�\�4\�\�8ԋ�\�/_\��\�ܫ_\�^C�k\�\r�oq�#\�\�;�\���\�\�jʽϝB8΍\�QU�i<ڜ\�\�s�y3\�<>a>��p?\�l~6\�9|9\�*�\n��_���o\"\\&����\�Va+\�{�{>\"^xLx\�G�\�\���_a�]\�?�g0�X\�\�wԀ1�\�\�o`�^�\��\��/<\�H#�Ơ\�O��̛\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  40[ 556]  105[ 732]  132[ 577]  171[ 585]  205[ 531]  232[ 525]  278[ 239]  299[ 260]  306[ 551]  314[ 552 552]  341[ 561]  344[ 334]  362[ 559]  381[ 452]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T20:39:23-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T20:39:23-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:DocumentID><xmpMM:InstanceID>uuid:0256FC97-6C93-4225-94BE-AD26C2CE0FD5</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nx�-\��\r@P\����H����:\�I�q��6$�B|3\��/\�\�Y�\�\�\�s\�c17\�[����\�\�*gfB�h<\���\'|+��/C��OƓ���wҌb%]�%\�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000822 00000 n\r\n0000000950 00000 n\r\n0000000978 00000 n\r\n0000001133 00000 n\r\n0000001206 00000 n\r\n0000001443 00000 n\r\n0000001497 00000 n\r\n0000001551 00000 n\r\n0000001718 00000 n\r\n0000001956 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002682 00000 n\r\n0000003090 00000 n\r\n0000011478 00000 n\r\n0000011678 00000 n\r\n0000011705 00000 n\r\n0000014886 00000 n\r\n0000014931 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] >>\r\nstartxref\r\n15239\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<97FC5602936C254294BEAD26C2CE0FD5><97FC5602936C254294BEAD26C2CE0FD5>] /Prev 15239/XRefStm 14931>>\r\nstartxref\r\n15996\r\n%%EOF',13);
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
INSERT INTO `estudiante` VALUES (1,'S19287321','Victor Aguilar Alvaréz','H','zs19287321@estudiantes.ux.mx','21785631',9,8.4,0,1,NULL),(2,'S20827776','Maria Fernanda Dominguez','M','zS20827776@estudiantes.uv.mx','2267469088',8,8.7,0,2,NULL),(3,'S20349810','José Hernández Zacarías','H','zS20349810@estudiantes.uv.mx','2254891021',10,7.6,0,3,NULL),(4,'S19834121','Diana Gómez Lomelí','M','zs19834121@estudiantes.ux.mx','2187432149',11,9,1,4,2),(5,'S20432114','Jorge Ramirez Morales','H','zs20432114@estudiantes.ux.mx','2287609842',10,8.7,0,5,3),(6,'S19824523','José Vicente Carrera','H','zS19824523@estudiantes.uv.mx','2081649822',11,8,0,9,NULL),(7,'S21894511','Ester Sánchez Domínguez','M','zS21894511@estudiantes.uv.mx','1987029843',10,9,0,11,13),(8,'S21890657','Juan Perez Fernandez','H','zS21894511@estudiantes.uv.mx','2176491021',10,8,0,4,10),(9,'S19327102','Daniela Garcia Juaréz','M','zS19327102@estudiantes.uv.mx','2287105478',11,9,0,11,NULL),(10,'S22087162','Lucio Salazar Venevidez','H','zS22087162@estudiantes.uv.mx','2398764512',9,10,0,10,12);
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
INSERT INTO `experiencia_educativa` VALUES (1,15037,'Practicas Profesionales de Ingeniería de Software',1),(2,15037,'Practicas Profesionales de Ingeniería de Software',2),(3,15038,'Practicas Profesionales de Ingeniería de Software',3),(4,15038,'Practicas Profesionales de Ingeniería de Software',4),(5,15038,'Practicas Profesionales de Ingeniería de Software',5);
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
INSERT INTO `oficio_asignacion` VALUES (1,4,4,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1577\n/Filter /FlateDecode\n>>\nstream\r\nx��Wko\�6��_��\�Pd����`�FQi�4\nle\�\�M�\�.C\�d�3��\����l�C�\rHl�\�{\�=\���;��\�E��\�\�Y�ε\�\�t&l��n}v�&7\�\�63yQ+m�-|ms���U\�Lx*`���\rm06��T𤌆\�\n\�{S�&�@/�\�E\�\�Y\�=�](�J%�k\�V�\�<�jZ�\\y%\��*2��3�FZ\�*�\�ݥ_u\���\�\�W\�v\�&vַ]{�]�_U\�e{}\�\�U�lo.��>��Ī��sW\�_�U\\(i\Z\�0`\�5�i��\�\��\'���ä}\0��\n@\�i~Sx�K�\0\�!c\�Og��W^�ֹ\�\nre\�ᩀQ�Sh\Z���ڀ��\�$����\���\�\�*��\�\�f<��C�r���T\ZH�0�Ǌ�U��\Zfz䁢UsL\�`����4\�14��vJZq@!d\��04\�\r7��ɤ��\�\�\�cxfX�)�65׆G2\0FR8\r\�T\�z@n�ezӞӦ\n+$\"P���T5�)\�\�r�Ni`~�)&A\�\�i�8\�\�D),���S�py��@�R.��\n�\n�\�$����\�yx��uh�D���\�D%\'�%լ�V�O�q\�\rp�Z����\�m{s\�ڷ��g�~��y\��\�\�#4<\�\��\�V��\�\"_���8|\�\�Gjy\��a���~\�w�^\�?\�\�`�x\"]�\�ėas�\�\�\�\�\�A�\�a�^?\��\0L�u�$��a\�BN\�S>\�2\�f$Fx\�<�옟&\�\�\ZB\�bnZY\"�򆹅Ox�6\0F\�0Ҥ\"�*\�P\�\�	�B/\�\�\�`ƅ��X9f\�\\\�X׺\�S7Mِ~)\�r\�-\�1\�GI��\�Bk\�\�\�~u\�׏b=\���\�\��\r�B\�{�\�n\���i\�\�\�b���M��\�?�e\rN��3�)\�P\0r\��dQ\�d\"���M��\�ft��:\�\��TL\Z��\�\�G6:/	��\����} \�2\�\\\�Z\"\n\�`S\�5���2\"I\'6H}\�w\\��!\�s\��\�J\�\�a��FG59>�\����*�I+9\Z�\�\�O\�6N\�K��@\�\�\�()D�$��;Ì�NDO�Xw\�q��;6�x�\��)(\�~����\�T�a	|#im\�)���ȗ|S���itLT\�\��xC,O�S�K�\�M\r�L\�L�\�$�#\�#\�\�\�i1\�Q	H���,�(f͞\�X�x\�C2@�ɱ\�3�\�c��{�M����iM\Z\�T\�V�����5v�QC\�p\�\�i�i!�\�H�)�-�C\�0\�(n\��\�DI�)q7���4\0e\�\�\�F\�*.<\�\�,D�\�A=l\"\�	�t��[\�\�x\� 3�\�<߬;�����\0\�\�\� \�S\�\�=���TUd1!;�\�x\�\�\���m	t\��\'\�\�\�\�pk�U��G%{rh:+\�B�4q�	\���\�ϠQ�\�ǌ\\�\���\"2���vU�\'�K\�	��$O�̓#\�\�L�9))O��ҹ@)VW\n�\�\�Ӎ��)�*�l\' ߜm1\�\�E\�\Z�\�\�m�Zp\r\�#��\r��7\� ��\�]�ۏnϭ�y\�C�Ap��-�F0\n4�J\�\�\�\�F\�;�&[��F�b�\�k\��\�}3i\�-�sqyW\�\�\�ݭ\�ewu\�÷�+x����-z�Z�8Q���Q,$d\�q�^w\��_^6\�6\r\�\�ú_���m�}��\�\�ˋ\�\��\�\�\�\�\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001899 00000 n\r\n0000001932 00000 n\r\n0000001963 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<FBD92506CB97B721AD6891E140C22626> <FBD92506CB97B721AD6891E140C22626>]\n/Size 8\n>>\nstartxref\n2060\n%%EOF\n'),(2,4,8,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1577\n/Filter /FlateDecode\n>>\nstream\r\nx��WkO\�F�ί��\�jEm\�+�P%w<f�X�Ӫ�f�w�j	\�	����\�1\�I\�\n�� q\�y\�\��Ԝ�P�\"ME\�\�,U\�Z4\�g:6ID�>�\��\ZgR��4+�6\�f���\�F\�\"sY�\r<e0J\�̆6�\�L*xRF\�g\�\�M5�@/�\�E\�\�Y\�=�](�r%3�k\�V�\�<�jZ�Ty%\�\�\�\���3�FfZ\�bX\�K�j\�e!J/n�\��\�5\�\�\�\�Y\�6\�9v�~U,�\�\�u��VͲ����X�8rl���\�]\�7~%V\�0\�BIS�+H�JMe%</�\n>\�$\0&��\�\�x\���U\0JJ\�\�\�T�!	@2��t�y\�u\�J�j� WF�2u�?��q��\r\�KOrK�X\�?1x\������Z\�.l�cx)T*\�\�\0J��3�A{�x\\�j�a�G(Z5\�\��\rfZ\�O\�C�kǤB\�\�-�C#\�pck�L\Z�H}�=�g`��y�qAajSrmx$`$�S\�N%�\�VHQ�7\�\�0m�p�1%�]\r��ȩԤ�#㊉\�\�z�3�\�\�d)4�.�ӄ�y����T.d\n2R�\�B�T\�\�P\n�><[\�;�`2T\�\�b���ň�rVW�\�$\���->\\�\�����r\�{ъ݋Xo>o�\�C\�~��\�\�oz�t_\�Sw\�w��<\�ݮ\��\�\�ݾ/\�=\�Ɖ \�չp\�}\'�\�\�\�i\�\�\�ϗN�\�n�YoZX\0��:m�^D�0~!/\�)\'m>\�&$Hx\�4�옣&p\�\ZB\�b~jY\"�����x�V\0F\�0Ҥ$+^Q\�\�	�B/k�\�_aƅ\Z\�X9f\���u\�#��\Z�!\rS\���[\�c���\\��֘\�1\�\�\�ܮ�\�z����\�w\�Z�\�-\�i׵\��\�\�q\�W�zćnj&\�/c\�@�S B\�Gj2����|+Y\�7In�c#B}\�\�C:QV�\�\�~*&\rӇJ\�\�#+���EL\�`ҕ>���\�Ne-r������\�`���\0��\�;.\�Y�\�9d�\�j%�\�˰II�59>\�\����bX�Vr4.\�A���m��\�y�\�ћQR�HN�A�\��\n��C\�	\�\�\�\�\�8��׏A�\�\�,l%�\Z\rK\�\�Qk#�H��\�\�G�\�e�T���D\�q�\�ir*v����\�\�)\�Dq�`~��~>� ƻ@ *\�\�8�Y�g1V1=��ir��L�\�X�\�d�\��miZE�F8U�ՠ\'.\'j�g\�\�`�l\��޴�\\vI�\�܌���!p\� n\��\�DI\�1q7�f��4\0e\�\�\�F\�*.<\�\�$D�f�A=�\�#F\�\r7�\�\�U�\�B\�|�b\�N�Rhp�xN`!��v\�y\�\����7�M\�ٖ@AQ�\�q�=�v/�6Z5jzT�\'��\�ᰒ.\�K\��P�\��\ZU�|\�\�̎a\�z+\�!\�kj{a�P\��q2���PzH\�\�\�<9\"�Τ����\�\�4�i ��buŀ@+\�a>ޘI�<� ��Ȇp\�\�\�f��Yt�p�1)?\�\�W�\��b\�\�A\�\�V\�\�\�x��w�ѭ�s+g���i\\zp-�\0�͢��<���\�ާ\�&��X\�\�\��\��\�\�&\��eq..���\�\�c�l�n�o�vqoԥ��IO_-U\0g�m\�\� 2�\�Po�\��//��w\�\�_]�۬۵��\�ۇ�\�\�v\�//�9���\�x\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001899 00000 n\r\n0000001932 00000 n\r\n0000001963 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<A620A276876705DC6F5F0E57042904A8> <A620A276876705DC6F5F0E57042904A8>]\n/Size 8\n>>\nstartxref\n2060\n%%EOF\n'),(3,4,1,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1549\n/Filter /FlateDecode\n>>\nstream\r\nx��Xk�\�D���b>��\�K�JflPR�\�v\rm�%\�\"��\�{g\�v��XR7q\�q\�>\�9sݯ�7_\rZi��?\�h�ʩ\�W�PUj{ws\�6^�\�u���;\�|\�:8\�B[Ǻr��jZeB\���Lm=Y\�賥\��o��Gh\�\��v���nm��5uO6+\�u��\�vc=\�Q\�\�Ҡke\�ձqm\��\�~\�U׿Q\�۾U\�o\�\�4sk5mw�\\\"�8��\�\�06\�H�a�����\rϤqk\�@v�k��gr���y]��o��\�R�\�\�\�Ŀ7�\"�\�\��\�^\�M\�\�\�鴛>�?L\���Wu(a�\r\�\�\�\�\�\�9\�\�+ř�S\�G7玽���n��C�2���\�U0�\�\���s�R=-ͺ�	U\�Ѭ�\�j\�\� 2\�1Ь�]=R�2\�\�\�Vu02F�<[$�\�_Kd{N�8�\\����\�p�\�����\�sr<\�\�#\�>\n���a7�\�\�\�r�$�vg\��:\�#2X@Z\��gUa��Ю�1M�9\ZA�\�w�z\r\�[\�)�E0l\�-㦍O\�\�\�wǣ�ܖ]\�m\Z\�\�\�C�4:\�um<��\n\�s\���\�60<*N3��#\�\��{\�$�]%A\\B�\�\�\����qN\�7�jq\0�QXUI�\�\�\�:;Y\���^\�\���\�Ө><�?\��Ь��\�m�\��I}�\�v�\�~�\�t��\�\�\�n7\�Om�\���0�d�sMn\0\�\�\�\�\��\�)И�ʌa�%>\�UA�	�F+�\�޺/\�,�RH\�̩T%$\r��n\�4+|f\\\r��_\�\'V\0�0:�ɾx�\� +�\�^�a}\���fy\�\�\�\�h�\�2\�\�q\�\�~�{PG�\�s�(\�\�8\�i\�\�H��\�8�\�0?M\',�S�>\�aڧ��\�~.q|��交C�\Z��1\�>,\�\�\"Մ\�R\�\�,l\��+euN�\�i4��]\�_\�\��$\"]\�\'Љ\�#!�Y`�\\J{\�\� ]\�e\�\�zK:\�Y!�\�(kW�$7�.\�\�\�̦�%ٜ��6\�dK�\�٥,\\\�mv��W\�\�؋\�R\�HÄ\�nZ\�7��[(ם\�/�#\�^b�8\�\'�:\�,9�L���ks^�\�\�2Ǻ\�-h0�\�\"P���\���N+*հ6\r��\�_]9�!���̧\�9�g2.��\�C\�8�ىfI��?n�\�4\0\�\�n\�\�p\�WԵH\�?1\�VsDBYM|�r�k�83��\��س�e!�\�\�\�!\�,�A7t&7\�\�>q�M	<Σ\��ao|����\�}c\�JLϲ�J\�9�Ǚ�C\�y\�Q�BS�\�rnaXLȵ^:7\�\�	\�\0���g\�z���xM\�e\�Y\�\�UVesfg=�;\�\�\�\"KċĨ���\�^�|-N\� [-���ܳB\�\�p^ɘ\�\��C�_r�y\'sBU����\�IZr\�\��^K\�K��*���U�r�\�)\�k7\�⊸��VJ\�\�\�\�qh]L�v��+�a}\�ę)9MJ�\�J\r\���<ԋ.Qt�@-;�9\�=\�\�Bj�n��>!1�\�\�}$�W\��5\�	ō\�O�&\�\�.�\0$��K*\�\��`��ұ,,n#�؞\�\�Q\�~��|�|��\�\�*\�\�H����\�̽��S0�\�F~[\�g\�\�\�\�WZ��)�\�\�$\��\�y}\��\�[\�\�~\�\�t8\�\�\�;\�\�t?�\Z\�\�b\�oo�b}\�\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001871 00000 n\r\n0000001904 00000 n\r\n0000001935 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<DE437A980FFDC83E010F3AF3BD962036> <DE437A980FFDC83E010F3AF3BD962036>]\n/Size 8\n>>\nstartxref\n2032\n%%EOF\n'),(4,4,2,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1527\n/Filter /FlateDecode\n>>\nstream\r\nx��W\�n\�F|\�Ẉ\n9�6\�0�X��\�;-1�k\�\���zwu\����H`{M\�\�]]U3�ay\�]_��V\�\�\�j{\�\�\�\�\�U*T�Zޟ�q�\���C\�k\�Y\�cбupޅ�nu\�<=i\Ze���\�VFCO\�;�]\��\�\�\�\�\�?\��Z�y��_]��\�\\\�7��\�\�m�P\�5=.\�ꢺ�~w\�\�\�\�i\���\�.ޠ�\Z77\�WWץ��uy}^�Ѕ�_.�\�*.\�\�e\�qK�\�\�i\�0��\�\�Q\�n\�m?��Ow\�\�\�\�\�:$Tlm[[�\�2*6:\�v�v\�:�P�\'M��ӎ\�fy���(��\�Mo�EW��_\�\�\r��%\�,\��p*B\�QoM(\�2\�ѕŌ�z-͊�FY�\�v43�F�W���6�\�yE�\r\�k\�V\�Fk\�\�\�X	(��\��a#����B;Є�d{�\�iF�y��\�\�t���˖�7N\�;uX��gA�\�\�\"m��;*���|$裵\�bmO#\ZzR��r|�o\�\�\�\�\�\�\���[�.�.��a~_\�o\�?>\'̵m<��*\�s`\�S�\�*\�II\Z�����3\�\��K�%Z\�\�*DQ DDm��\�\�i\�ic��\�Ae��� \��- 4S��\0D\�\�	�s�%|PJjV\�a\�lu�{�~X+b���~{�\�\���\�\�\�\�\�jX��v�\Z?�q�\�\�?�\�HS\�\�v(\�+\�3\�x\�\�9�L�Pqx�msRY5L���\�*��\�?Q�\�\�J_c��%��%\�@�:aUbRϬ\�fN��i\�U�>\��b!����\�2r\�%\�θ�q�{<xn\�u�-��L�6���\'���\�F\�֛aE��zì\�8�\���4n1��\�>=\�a\\���\�\�T6\�����Q{\r\�Ԙo_I\�b�j\�\�\�\��\�ln/0�euv\���B��	\�Q돬z�$bL!]\�\���wqh	\�%\�\��t\�1Ig\�CH}\�\�\�g\�:0{\�a&\�\�=()\�إM:�\�\�b\�6\�\�o�\�\�Zg\�p*�)p^�\���HÂ�\�a;\�G`�;\�8[�=6�|�\��%(h?\�-\�Vf�Ѵ�K�Q�6\�\n�%��>\��\�/ �\�4g������\�49��T\�\�\�\�\�r~ueO�8 \�?6�?\�&l\\��\"B\�8�ىg	V%7\�³�43\�|O�\�X��k�\��4�\�X#��\�jғ�ZǙ4�\rW̞כR\�n����B�G\��\�$�:��\�\�쀞8ɦ$\�N���io|K���\�ycx�6=\�\�*EX\�\�\�\�Q9B\�b\�|�a3�Т\�\�;�\���\��s\�\0;\�Kϋ��\'U�Y\�\�N~8\�8\�Ƭ[\"]$E=�Ǚ\�\�˽8\�yբ\�Iɑ���\�J��^��ߧ��`Xw\�\�aT\�\�G�dvK�3\�<�\�\�\�\�n�\��\�\�\�%\�\�S��N\�\�qt&\�9)+��Ǧ�tm����DZ�\�&ΊH\�4	Õ\�	(7\�g;�\����\�\�\�\���R\����\�\'$\�\�u���\�\�ԥ;���Ɣi\\}p\�@\0A�gqIE�h\�\rW:��\�i�[\\\�\�\��}=�Ƶ�+몭�\"\�)�.�\�\�z�b\�\�nE����9?km.K:\�7�E.\�Rė\����\�w���\�\�\�\�~�W��\�\�n��gXɇM\\�}�\�\�\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001849 00000 n\r\n0000001882 00000 n\r\n0000001913 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<0F8E3A51917350EABDE31EF4A864FA08> <0F8E3A51917350EABDE31EF4A864FA08>]\n/Size 8\n>>\nstartxref\n2010\n%%EOF\n'),(5,4,10,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1524\n/Filter /FlateDecode\n>>\nstream\r\nx��W\�n\�6}\�W\�\�)\nW\�jF��R�;��\�7\�V�)\�q:K�\�\�{�\�,	j�<c\r\�{\�=\��iq\�CW���\�\�j}a\�bvf*\�J,Ϯ̥�����l-�66:����Ƶ\�\�\�Xx�0J9\�R���T\Z��5\�\�\��h\�\�\�ŏ�Q,�<[|�\�\�7o/D7oo�\��oE��\�E�!�\�\��<Ļ7i\��\�:\�9v@c;�\�\�f��/�_\�^�>\�\�\�C�\�E���;n\�/O/�e/\�\�\�a#��\�m?\�/\�f\�|QK�*�\�^צ҄��F�`jc�1	x�0Ji�m�\���9@PQ�\��\�\�)g\�\�v�z�}Nv��q���\r\�րb\�3�:�\�8��^\r�\"V��Jx��F�V��\�6�eiE�\r\�\���\�\r\�Α_i(��\�;*<��i\�\�Y.�A�Po�\�Y�\�`�@$��0�\rxْ��\�\�h��\�\�4҇�G{zL[\�\��W�\�\�J\�\�Gr!t�bX\�\�zR�+̔\�\�th3\��j\� �Ԋ\�B\�<\�(`6\��R9U+�dN�*\�XJk\0ώPO-�ոs��\�1�4\�\�e 4�O\�]SKD�҈ɥ\�\�3�,�:m\�Q*X\�!`\0��\�$o�a)Y�\�XID�9�8R�kUB>�\�o��x\�}X/\��,~e\�]\�\�\�zX�����k7�\�I�\�\�qٯ�LV۾��`N(C\�\�0\�k21\\E\�YH\�甲Z�lI\�R=�\��DYJ#\�*]�se,\�x4pU��c>%uć0!n\�e-�:\�øP�8��܂���e\�t<r\�%\�ʸ���z,2\\�\�`�\�Z29F�\�,�X\��/b=+\���[o��~\�\�\�\��X�O\�ۗg|V�f�\Z\����Bg8j+\�rPdĶo$�\�\"�j\\{lp\�\�lj�0�e5\�.\�[3i�\"ط�=�\����-9�t!&ұ\�c\�\�]�%�@\�8�\��3T�tb<�Է�\�8;ҁ\�cY/HV\�A	aƐ6	4:�\�\�l\�\�\�k\�J�\�\�-��m��W\��\nً磤���.�3ȉP@t\�\���\���q䓋\�/A�\�\�l��\ZMK�\�Ek#�H��\�\�G��e0�\�$Q��\��<MN\�.Ր7u<��\\�\�IG\��˯�x#�6\�@�|1B�q�a\�b�J<f��% \�\�X\�=��c�b]�����iC\Z\�T\�V�����5v�QC\�p\�\�i�i!�\�H�)�=Z�7��a\�Yܤ/bꉒlJ\�~l��D{e=\0\�\�\�獢U|z\�U���\�A=\�2\��r��\�\��\�Bf�E��1vD\'\\)��\0��\�A����{^u\�<��\�bBv\�\�\�\��\�3b=ے\�[\�7\�8\�^|��{ �Z4=*9�C\�\�pXI�\�e��]�_\n�t\�}��\\>\�ȕ̎a\�7F�G\��\�^\�-Uy�8ٻ��PzJ\�\�\�<9\"�Τ=\'%\�\�iq\�D:�(\�\�*�V\�\�b���\"8M�AQ%�\r\�仸���Yt�\0�u\�\�w��\\\���\�\�%\�Ût�\�\�m\�ԥ;��a�Ɣi\\}p\rH\0F�fQIY�\�\�)z�4d�\�Sl�x̓\��v��ͤ�\�b\�^��\�mhg\�\�ᵻ�/�o\�o�\n~}w;q\�\�+�N\�d\�&�f���9Dυz\�]\�y�-,�_-�֛\�c�(~\��\�z\��_\�\�K\\��\�\��\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001846 00000 n\r\n0000001879 00000 n\r\n0000001910 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<EE95253D4F0202C92548B6E49680DD66> <EE95253D4F0202C92548B6E49680DD66>]\n/Size 8\n>>\nstartxref\n2007\n%%EOF\n'),(6,4,3,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1567\n/Filter /FlateDecode\n>>\nstream\r\nx��WYo\�6~ϯ\�c�X��xY@P@KQ��\�lm�>jcm\�\"�S\�)\���\�AR\�E�@b\�\�5\�C\�S{\�C��<\�׫\\]k\�\�^\�L\�,\�\�\�FOLn�\�mf\�V\�x[�\�\�Vm�\��6\�T@/i\�A\�LR2\Z>+\�\�Mi��Z\�_�(\�߯\�\�\�\�F\�Z\�B5�/2%U\�N5\Zf�\�̕��g�\ZU�Rye5\�U�㻪��Φ\�vQ\�󅨽�_\�\���/\�t\��\�l���\�\�\��Z,緟\�t>\�KQO��խu\�\�բ�\����\�l\�\��׭�T\�ܜ����\�\"��\�\��V�z\�ԉE�u�{\�\�l{]X�\0�*��r�)�Ty]�Z\�C\nO\���У	$\0�\0#@*M\�H~SdVZ���\�Jl���QЪ\�\�f@��\�(\�yR�`ÈZ�\�He��\�\�0\�#��fͭ\�w0\�Ќ@,�s�+�s\�\�oB\�\�-�CÅ.l\r�D�ƨ��\�\���0R �M(Lmj<-\�\0I\�4�R�\�jj�uKk:L��V�\�\\	O�ݻ����LWHj\�\�\�)SB�)��\�\�z�9�\�͔)@��\�-&�\�(-\�\ZR*Yʉ\�e\�%fKC� \�l	\�\�S\"��)KN#JY�9�]�b�\��+\�Gщ��X�7[\�\�\��\�\�\�\�;\�\�5j�{\�\�[z\�\�\��\�\�\'��\�\��xx���!�4\�\�|Q-��\�\�\�\�<���n\'�x\�\�\��\�պ�	`\�\�%W$L\�\�kі�8�Q\�1�\0�\����i�V�!�!\�e��%\�\�,M�c�J\�(\�]\�ؒ�d\�!�ꑰB+{�o�\r\�B\�`䊹��\��av\�9.�)\�.e\\�\�D-(�\Z`�\�6er�x���\�V\�eC�ݾ\��[��#�\�}\'�\������\�3>\����\�\��c B\�Gn\n,	h\09�V�\�k* ��\��:�w��\�W/\�S�hX>D�#\�\�J\�1%l[��\�At\\�1\�T�l�%�@\�k\\vMA\� �(\�Qa\0��]i\\��!\�#\�Pi�Z����0}��wt�\�y\����*\�I39\�\�\�/\�6N\�K��!\�T�\�R�HI��ʌ#\n\�\r-\�!\"\�\�hvw^8\�\�\�\�\��An��c��)t�\�k�(�\�\�\�Fu\�7\�\0��z\�DeL��6\�\�8W��jS\�=\�\�R�5I\��\�v\�\��4��\�\0A�$\�#D���5\�,\�*ţGX�*m�-�՞�yM�\�\�LM�h\��\�e5��\�D�q\�<.{�oL$\�.I����;�\�S8�<���E\�@?Q�eJ\�\ro�	\�^\Z�r\�\��F\�,.<\�\�,D�\�	\'6\�Q\�B\�	\�\�x��b�y>U1v$\'�%+�	<7��/�vny\�\�𢫢�	١\'>?�\�,�/��\�\�\�\�{���8�\�h\�\�\��ɞ*4m�L���&\�7����\��t�8W(v\�ȇ,�q\�������C\���$/\�̣-\�lO:��\� \�<\r.\ZD炤\�]) \�\n\�0�\�\�\�\0N`�\�$�!\�|V�\�h�s�?\�hL\�~�\�h��\�>68�\��>��\�\\:\�\�:\�[%\�ԇL�\�\�Sh�`hQ\�\�\�\�������0ڍ\�}�c\�3�\�?~\�=���\�\���x����\'\�Y�.Iυ{¿�R�g��\�\�uSࢥ�~��\�\��c\�w�_.�I!�7\�?�\�~�\�V\�~\�=\�^�\�6|�\�\�\�?��\�\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001889 00000 n\r\n0000001922 00000 n\r\n0000001953 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<EE6B2D8C01FDD8B40803081AD575E906> <EE6B2D8C01FDD8B40803081AD575E906>]\n/Size 8\n>>\nstartxref\n2050\n%%EOF\n'),(7,4,5,_binary '%PDF-1.4\n%\�\��\�\n1 0 obj\n<<\n/Type /Catalog\n/Version /1.4\n/Pages 2 0 R\n>>\nendobj\n2 0 obj\n<<\n/Type /Pages\n/Kids [3 0 R]\n/Count 1\n>>\nendobj\n3 0 obj\n<<\n/Type /Page\n/MediaBox [0.0 0.0 612.0 792.0]\n/Parent 2 0 R\n/Contents 4 0 R\n/Resources 5 0 R\n>>\nendobj\n4 0 obj\n<<\n/Length 1509\n/Filter /FlateDecode\n>>\nstream\r\nx��WkO\�F�ί��l��~\�K��\�����\�)R�\�ݦ��:a�\�\�\�>f\�vVEj�K\�\�\�\�s\�93�T�}_\�\"�E��,�J\�7g*&�D�:�R�:օ�M�㤔J[�\�\�\�Fie\�H\"�\�)�Q�I�k��Q����V\�\�x�3]�\�\�?\���?��\��\�w\�兰\��d*>\�\�\�\�\�;��y)\�\�v2�,\�y^\�\�\�n>�\����\�^\\\�\�BG5�V,fU}�ϭ�f\�i�דY�h\Z�\�\�\�b�\�\�v\�!a\�B\�*����*)J+%�r	\�S�R�(h�p�\0a����S�U)�$�I�\�O]�\�	� H\�\\�@T\�@1\�@\��H\�\nz%̲tX��T0\�\"��V�M\�m0Kӊ\0;\�+\�W(	�\�#���\�7TS\r7���\�\\C��>\�\�\�0\��<H�\�Ia*]B\�aK@�NE;��pJ\"3�U�g�i\'�s.+\0\�H\�	A/e\�X��+j+\�w\Z��,YL�Wìa\�\�\�Rp\�]R+&\nA\�,�ie�\�1��>U�j�)	\��\r!\�Z0�oe0ݔ\�ň|\�\�;;���\�ĢƯ���W�Z\�l\�c\�}\�B\�K\�\�םX�O\"�\�K|n��\�R\�K\�\�\�;\r��\�\�\���\������\�\�Ņ(��V<��\�\�v\�t\�\�\�V�\�v�]�X\0��:M�D\0�`\0R!\�!M\�f\"r\r\�\�[01�#�\�BĤt|2\�\Z\\��qnbD!	EE\�0�$�4����V�^\Z��\�>���#�X\\|\�9\�h.o\�#�\��!\�R\�ـNԣ��)Yf�!�cěԹYm\�z6���\�v\�Z�\�\r\�i\�6\��\�\�q\�_b�}Ƈv\�j&���l �!.t�#\�	��\0@���,��\�#3������\�ÅN�UE�{���I\�\��\����Kº%r0\�J\�H\�~�y{2���Y\�\�suBn���Hҁ3\0R߶�\"�Y�\�s\��\�JӖn��F{5�n\0��\����5i��\�8h\��\���\�>o�=2J\n\�H0h\�8#��\0\�\�\��םp�^�?Vx�j\�\�\��V\�P�n	\�|#h�\�)\��ȗl����a�O4\�\�\�X�&�d�\�ț*��2\�IG\�g\�\�GRb�\08��,_�k\�Ŭس��\Z`�Iȴ��8ҫ9\�+\�5X\�Y�VQ�N�m\�\�ˉZc\�\�5\�\r�͞\��˞)�>�bD\��\�8�؋�\�E\�@=Q�YH�\�[�K�}�\0�ݟϛ�V)\�3ύ\\�q�\�\� �\�c0\nG��>�P\��2\�򕊱#:\�zH!\��\�<�B<e\�\�\�{\�IUy��\�7�@\�ٖ@NQo\�q�=�~/v5Z5h�W�%��\�ᰒ���\"\�W�~.\�\�i4�p��˙\�\�\���C�\�\�\�\�n�\�\�\�dtI9�t�䩓ypD�I#\'%\�\�qSG�\�Q�\����\�pI&E8p2CJ�D6��/\�&\�p̢\�+�I\�^\�\�_-��\�\�\�8\�\���\�\�U.\\\�{�\�\�V\�<�.S\'��\�Z\"�E%eyb{�\�˞\"[�F�b�\�k\�3\�\�?~�\�\�{\��q���\�\�Ί\�|^O�\�WQZ1Y\�nJۋ\�\�}R:p�lG�XH\�b��z\�]\�y\�,Xn\�_\�n�^5+\�K\�5�\�\�\�͆_^l}\�\��b\r\nendstream\nendobj\n5 0 obj\n<<\n/Font 6 0 R\n>>\nendobj\n6 0 obj\n<<\n/F1 7 0 R\n>>\nendobj\n7 0 obj\n<<\n/Type /Font\n/Subtype /Type1\n/BaseFont /Helvetica\n/Encoding /WinAnsiEncoding\n>>\nendobj\nxref\n0 8\n0000000000 65535 f\r\n0000000015 00000 n\r\n0000000078 00000 n\r\n0000000135 00000 n\r\n0000000247 00000 n\r\n0000001831 00000 n\r\n0000001864 00000 n\r\n0000001895 00000 n\r\ntrailer\n<<\n/Root 1 0 R\n/ID [<8D2577174E540BE702874BEE22A09F99> <8D2577174E540BE702874BEE22A09F99>]\n/Size 8\n>>\nstartxref\n1992\n%%EOF\n');
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
INSERT INTO `organizacion_vinculada` VALUES (1,'Departamento de Tránsito de Coatzacoalcos','PUBLICO','coatzacoalcostransito@mexico.gov.mx','2274501988','Calle 16 de Septiembre No.27','Coatzacoalcos','Veracruz'),(2,'MiddleTek','PRIVADO','middletekBusiness@middletek.com','2190398122','Colonia Reyes Cuauthemoc Num.122','Monterrey','Nuevo Leon'),(3,'Departamento de TIC del Banco del Bienestar','PUBLICO','bancobienestar@mexico.gov.mx','2298760211','Paseo de la Reforma No.274','Ciudad de México','México'),(4,'Strongware Soluciones SA','PRIVADO','strongwarecontacto@strongware.com','2209750062','Col. Niños Heroes Calle Juan Escutia No.14','Reynosa','Tamaulipas'),(5,'Free Software Foundation','SOCIAL','fsfprojectadmin@fsf.org','6175425942','31 Milk Street','Boston','Massachusetts'),(6,'SaipanCo','PUBLICO','saipanCo@corp.com','2283452765','Calle 5 Av. Juárez','Saipan','Veracruz'),(7,'Satou System','SOCIAL','pruebas@gmail.com','2282141329','Av. México No. 10','Banderilla','Veracruz');
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
INSERT INTO `profesor` VALUES (1,'Lic. Ramiro Ramirez Rodriguez',99345,NULL),(2,'Mtra. Ana Maria Lopez',34213,NULL),(3,'Dr. Santiago Sanchez de Jesús',43722,NULL),(4,'Lic. Diana Sarahi Dominguez',53291,4),(5,'Mtro. Fernando Hernnandez Ezequiel',48731,5),(6,'Mtro. Luis Fernando Salazar',65431,11);
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
INSERT INTO `proyecto` VALUES (1,'Sistema de Control de Tránsito','Participar en la elaboración de un sistema de control de tránsito para el municipio de Coatzacoalcos','ICONIX',1,'2024-02-10','2024-05-24',1,1),(2,'Sistema de Atención al Cliente','Desarrollar un sistema para la atención al cliente en línea','SCRUM',2,'2023-02-19','2023-05-31',2,2),(3,'Sistema de Nomina','Desarrollar un sistema para el control de Nóminas del Banco del Bienestar','ICONIX',1,'2024-08-15','2024-11-30',3,3),(4,'Sistema de Control Hidroponico','Desarrollar un sistema para el monitoreo de laboratorios hidropónicos','Kanban',3,'2025-02-18','2025-07-09',4,4),(5,'Open Audio Studio','Participar en el desarrollo de un modulo para un editor de audio libre','Scrum',1,'2025-02-20','2025-07-18',5,5),(8,'Punto de Venta Veterinaria','Desarrollar un sistema de punto de venta para una veterinaria','XP',1,'2025-02-08','2025-06-28',2,2),(9,'Programa de Monitoreo Industrial','Participar en el desarollo de un sistema de superivison de maquinaria','ICONIX',1,'2025-02-11','2025-06-29',4,4),(10,'Sistema de Atención Hotelera','Desarrollar un sistema para servicio al huesped','Kanban',1,'2025-02-02','2025-06-30',2,2),(11,'Desarrollo de E-comerce','Realizar la tienda oficial de la compañia','XP',2,'2025-02-20','2025-06-30',7,7),(12,'Prueba de Registro','Demostrar el caso de uso registrar proyecto','ICONIX',2,'2025-07-01','2025-07-01',2,2),(13,'Proyecto Actualizado','Demostrar la actualizacion de un Proyecto','Scrum',2,'2025-02-12','2025-06-30',4,4);
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
INSERT INTO `reporte_mensual` VALUES (1,'Feb',90,'Aceptado','Observaciones...',NULL,1),(2,'Mar',110,'Aceptado','Observaciones...',NULL,2),(3,'Abr',100,'Aceptado','Observaciones...',NULL,3),(4,'May',120,'Aceptado','Observaciones...',NULL,4),(5,'Ago',100,'Aceptado','Observaciones...',NULL,5),(6,'Sep',110,'Aceptado','Observaciones...',NULL,6),(7,'Oct',115,'Aceptado','Observaciones...',NULL,7),(8,'Nov',95,'Aceptado','Observaciones...',NULL,8),(9,'Jun',140,'Aceptado','Me retracto, buen trabajo',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nx��O�j1\���)\��ݭV\'\�!\�=lrE\�A!�\�*N�����\"I�-vw�\�Ǡڟ3b��\��U��y\�\�x)��eJh�ZQI9�aV�}`|�z�ìU3jUm\r�ߵ2\"\"�\�\�{x\ne�x\�no\�Eb�A\�\rwZ�F\"\�T\�H\�n��u\�Ү6\rѶ�ʂ]���d� k2\\g:u�4)/p�\�\�|\���U/?>i\�_3�׌u�d�\�\�\�\�\�\�����Z|�EW\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250622133747-06\'00\') /ModDate(D:20250622133747-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 303>>\r\nstream\r\nx�]�\�j\�0E\��\n-\�E�\�WZ0�4���>�\�p�q*�e!+�}����$8̽�\�Lth\�VIK�3\�,�\�\�b8\���\",�Br��|\�5���[fc����%�>]q�f����N\�@�w#�Hu���C縻h�#(KcRUT�\�>z\�\�[?�жm��K�l�\�Oq\\4\���0|0랃\�\�H�SѲq�\"�\�]��\���{\�\�I\�\�q�e\�c�\�%P�\"5Y ��d�}�\�@\��ή��\�Xʼ���gQ�\�P\�td\r�\�s�]�T��\n\�FK\�\'�$�Ə\�o\�6g~1ƍ׊�\�S�\nn�ד\�.�g�t\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8024/Length1 21328>>\r\nstream\r\nx�\�|\rxו\�3#Y�e#0?4b�ȶ�\�ۄ̯�\rX�\�\�\�\��lc�۔��\r䅆�4)!ل4i�1��\�6M���\�6$Mw\�fS6٦��/M�m_7kϽ3�e\�\�\��\�\�\�eFs\�\�s\�=�\�\�!\0� ���\�U��_\�\Z\�~\�v�w�\�x\�\�\�)�\�u\�?\�\r\�ђ\�S\00�(\�\�y��\�\�\��\�{\��\'\�\�\�\�)���\�\��\�\�P\�\�+��`\�\�\0�m~E\�-�\���\�2^5~D�/<�\�a�?�\�}Q�l\���T5\�ʯ,��`\�\0y���?j\nM�\�Dz1�$\��\��lY�8.,��\�}S���\�8�<\Z�\'R��\�P�hL�F���>�Mj;\�\��F\�\�{���䛀��e��\����\�\�\�\�\�\�\�~\�4\�\Z�\��y9�\\�&\�\�L�\�;�\�\�\n�1\�@�u\n\�8\�.B�\�8\�\���\�v0�\�P%\\\�)��;wz��\�=��\�\�Ӽ7��\"<W.k:��qU\"�\�t�\�\�@-��x\nL\�O\�0u2���\�\�0��\��\�\�\�\��\n\�N�?��\�\��9\�[�7\�5\�7NN�7�\0\�8\�a|��>��\�t\��p�&;��X�\'\�\�_�O�\�?\�\�#\�Ο�\�OZ��\�\�\�\�q\��z\\=���r\���\�G>6E>\��\��I\�p\��z��\�O@(�v�~\�7\r!aw��\�9`A�\�\�jh�M�\�ob\��\�\��<���\�jX��^\r\�h\"{4\�,\���%ڗ\�V���r\� f�~�x9\�\���C��r¯\�m�=q����ԑmD!�\�\�^��/~\�\�[\�Oj�\��\��\�����D<�/\Z	��}{�\�\�\�햻\�ܰ��];=�;�o\�h\�ںe\�ַ�[ۼ\�f\�\�-##�y�R��W^#y�\�\�//#��Q\�aHu�ST\�[;\�\�:�\�X\�v�U��nU(m��\�Kz\�d��p.�\�\�.mغ�SlJv�A\�t�\�i\�+2czK\�\Z;:\�f\'\���kY?\�]7a�%=,�*�&��\�Kﶎ\�04~փ�x$�\�)٥NiGL`�wt5b˜nq-r\�[�/\�\�<\�[;;U��ǳ��+U٧�<TK��v�*zEQ5�Jݭ�I�J�$�\�o\�D�ٚ�Kv\�\�9�zn��\�ȋ���\�:\�&G\�wv^�`6\�\�<\�����3�\0\�:/`����X���v`�Ȝ\�L�\�z�\r0\�F�`}/Z�p�4��\�<�\�,� \�\�\�\�=/h#\�4��8��֨\�\�&�Б��õ\�����q\�\�&w�\�\�p�:����6��cfR@�#ȳ��ϓ\�\\�\�\�ԦS#%\�\rgp�9%\�b�\�4÷�Y�mg\�cf@�\"E=\�˚F�\�Ni,��vb\��F\�fg�6\�\�M\"��\�n老]V\�y\�\�5\�e4�\�NI�J��iӒѦ��qC�s�%؈ltt9�Z\�\�D�,u��|i�Wj\�B	�\r~Z\�\�.v�\�]Nl��\�d3\�\n�RC\�Ǘ�����U\�7�Y͓�5_jȌ\\\�i#F:�#5��D\�z�\�$\�$�R7f����\�\�㑑�\�dU�\Z�#4\�z�IФ�\�\�D\�6`nq�\�\�EJ�!&�k\��\���2\�\�O\�CҚ5��MbRu\�\�.�h\�0b\\��l�dч^Fs\�s\�6w\�s:vv&\�>\�\'��\�f[E�ǚ\�x�\�q>�\�e��\�\'���Ro�\�\"twI\�\Z��Ή�މ��\�\�I\�8v\'\�\\/5���^�O\�1\�\�ϣ����\�D$�HĘ2\�IK}�G\�v\�T{\�w��n3��\�kZ����f^�]\�kU�g�DV��Ťh�\�$\n\�\�\�\�R\r\�\�ʴ8i\�!b=\"\�\�n\�ed\�ܕLgNIj\�9�%�Tҁ��Rj�:\�*vyĮ.\�\�\�[EՀw�G�\�E\�n�fO+\�~�\�\�v�tY\�\�zdE�c�V\�ռOuP;h\�T��LJI����\�H�\��\�\�Bo��:%Y� Ry����ͨ.\�\�fm�\�$\�J�/\�qX-�)\�&1\�ݸ\��E\�\�X�Ī��\�\�n\�\�mA��\�\"���L�\�B{d�\�RB�\�>5\�ٝS:�a��S#61��Y[�ښ&\�al\�s�܌8H�\'mX?(\�<Ci�׍Ye��E�\�\�\�\�\�\�Щ\�t��i�ae�n�\�������P#��\�\'�T5�b�UuІs�9cI�mTZ�\�3u5���D}�ҥw�R�٤m�\"-��� K\���O=ۊ5�K��\�Cś� :��Nj����tp2W蒴O>��0�\�y\�\�t�c�I�\�׽w\�4\�\�\��\��\�*\�u�XU�\�\�\�f\�\n.bE\�\�\�\�ʞ6v\�j�\�9X\�\�|\\U�\�\�\�M�\�vD\�\�z�:Ь$\�4c\�\r(�u���%�S9\�fZ\�9�IZAo�Ҋ�\�`��\�\�R`\�B�\�v���\Z�+�+飑�:�\�v����N�U\�q��N=�58\�̌\�5��\����%3�\�nP\�\r���Ig%M�1a&=�j.�\�\�a�pQ��\�Z�\�s\Z\�\�Z�@�ÛL\�\�6����P��\�ŨZ-*Y�k��9���R\�&�a]\\n9T-l��8`A\�\�\�\�\�Aj\�U�\�\�|\�p��5\'�\�y�Z�\�\��l-;�l5ӫI�饯�|}��\'T}��\�\�\�R�\�\�G\�!f|��\�-\�:\�O���d\�\�q\�J��\�%��\��O\��|\0\�p	�\�D�zぱ.�|\�4[�\�z�2w�ԗC^��\�H�_\�ޔK�\�{\��\�ǉ,\�0]�\�ؙ\�\�9\�q�\��\�Ö�>w��\�b��^�;�J\�np\�\�e��c\�h�G���\�!\Z\�O3v�v�b\0��\Z	>m\�F�[�H�MV\����eV�\�k\�L|�j�O\�� YD�Vj/C����{�Pڹ\�Z\��\��\�\�x�R\�\�&�WGR-E8��\�EC=\�ܫ�I���ѡSQ\�\�\�\�\�f.���@\�\�\�VX\�\�[^�\�\�\�|�R\�i���B\�.\r\�\�B���\�\�X�v�\'�\�\�4)\�7�\�\Z�C�l}2�O1:�u���u\�sh�\�\�S�͡�Ki7��\�P\Zm$\�\�T\�\�h��]Z�ᇩ?R�&_p\�B�\�\'w\���]�K\�z`�p��q@M�H5wjϒ�톥)\�nW\�v�\�m�+e\�Y��y*.\�:\�R�\�)\�\�\�mΔ�c\�z[����mqʶu\�ö\�E�m\�\�&\�\�\�6-L\�6^��mp�l\�N[˂^ۺmk�lͥ)[S\�ö5R\�\�8?ek�_����ln�ö\�ċ�Ub\�v�x¶Rt\�\�\�\�lu\�R�Z[ʶ\�6l[>7f����UϽh[6碭jN\�V9\�a\�\�%1[Eٵ�\�m\�l�(k�l\�\��n\�|~\��\�\���+�a�\�k��hf\�\�sg�lsJR6k\���]3kJ\�v\�v�\�\�ڞ>��Ŀsjm\�Z˶b�\�SPk\�f�\�	x�=Sj\n�\�\�\�m˩5n+\�\�y�\�\�֚�\�8j\�p\�n��\\ �C�s\���T\�\�ԺK%G\�\�v\n\�A5Ua\�\�]�#�\��\�6�۰A���\�\�\�\'I�qk\��\�4��N\'\�\'k\�}��d����Skh\�:�\�\�t�iR?nd&\Z\�	ũ�\�\�\rE\0��\�\�\�\��5̀b�\�S\�s|x\�\��\�\0����^�\�C��\��a\'Ġ)z\�F���8c\0\�>\�� ��n�M8��q��2��\��\�D\�۰�\�[�\�6\�\�Cl�\�؍�\�с~\�\�a=\�0�B9�ܳ\�g_cX \�M\�	K\�\�S�.�\Z_i�NeQgQ\�\�%K\�ًJ\�;��\�TU�L�f4؋\�\�Q����z�C�o�.�Gr�\���\�Y�,Y���rt5�\�\�\"\�\�\�մm\�\��\�S��rk\�\���a��O�\�Z��E���o]�c[_y\�ښ�-����\�k\�-sn��\�\�\�9�Q�@\�\�]�\'��F@]�,\�X\�*B-㤊H���j\�M\�Oϐ\�>=|\���>E�\�\rCûϐ�\�#���p\�f�\�\�[Ab^v\�\��\\>!d�vp.�RU\0C!J̓\�`yj:\�\�\�\�U��\"{�P<}\Z\'H�U�\�\r	�\�~@\�u\�菿?���F~�/�\�\�\�24���4���|a\�[#\�1����|\��\�f�\��\�M��\�0\�\���\�x�}W�sg\r\r\'G\�??\�<	\Z\�\�3ln�[��\�F0\"/S�Wq��F0^��!UE�~W_ ���?;�jt��\�U��\�o\�\�}F�\�\�\�x\�{��\�\�o��ÿ\�\�f\��)\'6\�5\�ŵ�.ג�M\�41h�KfH�\�JJ\�+˫\n9��3/\�\�}\�Ⱦ\'���ƃ}\�>�\��n\�\�\�C�\"�=�\�}\�\�\�|^\�oG�o\�\�\�\�\�{So\�?�kl0\�m)̋@lv>J�j\�\�Wҏs�\�Eh\�5F\�5(�(�y{\�\�{�\���\\g���\�/7\�+[tX9|\�\�\�\�\�g��}�6s\�w�9�\�\�\�Z2\�\�\�̣O<�k\�\"\�>\�A������i\�1JŵU\�4��o�\�\�;S��9�\�\�=ϟ��\�+\�I�p z�\�{|T\�\�G�|��\�?�\�\�\�w.MY��\�tW�\�{\�V\�s\�\�\���\�=Ev\�b�̀�\�\�bs�1F���\�&bc5J�F˧��Y+t���\�\�S]4Huu���6mJ\��\����|\�\�\�\�\�3�\����\�Y�\�3֙e1�\�	�[��g\Z �y�L�:�N,���N.\�T\�\�S�\�6��s�\�\�:�\�=`\\\���A)H\�\�y�\�vỏc�4?_\�TT�u�ol-T\�\�<�	���5K�޺F:s�\����{�=8wsK\�1��i\�\�u�c�\�Fɿt�>\�\�CW>\�]�6|���\�f֐\��\���V�+L�nsZ]�\�\�b\��\�;\�\�\�\��|9􍇳i��\0�%�R��\�\�D��i�\�\�\�\�*\�|#[Kܒ\�/\�\��x���#��\��X1\�XSs�e\�җO�~\��맿|i\�\�{�\�\�C��g\�P�gFO	S1�\�U4��0?6K7�\�٩��%K\�\�v1\�\�|\�5E�R�\�9E%%g\�5,�?�������\\d\�\�#7\�;�h\�\�\�S�e�7w\��\�\��/\�\�׍�W�9\�\�3���G7\�\�|\�\�\n�0ݝ����\�x�j:�}y�q\��\�f��\�D��6\�|\�\�Xv�U#9\��\�X݅\�\�\��ܽ9�\�X��JgUQU:��\�\�\�\�TO\�_\�\�\�\�y\�\�ً�ș��\�ڑ+�w\�G(\�/�~\��׀\��\�\�\�e\�Ve��feM�3\�\�_=�༎-\�ϗ?x\�\�zx\�_\�\��\�\�ݮ�ܹ˕\'\��hڹr\�=C\�F�@�;\�n�b�\�\�\�TpU}�rFmQU%\�}��\�\�m�4\�\��V\�ҁ�oط斷\�a\�ƞO\�q|\�m9\�ns�\�d�\�-\\��ލ}}��k\�nI\�X\\��k\�\�\�r\�m���u\r�F�j\�h\n\�T��\��&Ԅf\�\�\�g���T\�cx<\�ڽ���CJYwG�\�Ǖˏ\Z~�K~\�\�C�\�C\��\r��\�\�\�=\�\�GR$c�\�\�=�X,yB ��F�E�\��1�r9|V\�b�\�\�\"׊��5kג��\�ݽO��4>\�i��in��n��o\�\\�񟊖\�	��PH[��`Њ�i��\�S\��n6[\�\��{w\�\��Zw���\�\�$\�5>�OJy��9�\�\�*�\�s�)Ó�`\�_\�?\�큣p\�?y�\�\�\�\�X��Ygg\����\�Տ\�\�\n�\�Y纬\�\�܄\�r\�ײ��\�\�\��z��#��z^=��WϏ\�~�\�W\�O\��\�\���\�\"/�ߘ\�\�\�V\0\�m\��\�h9�>�\�gᅬ����zۘ�ρ\�L��|���]N\�&�mɢ/\Z�E0\Zt�\�\0\�Mz;7��̆[\�\�J�?N1\'\�QÝz�@�٠�9(4\�m>/d�\r0\�|Xo�\�9˴MPl�Oo\�\�\�Y��\�\�\���\�\�\��т�z��[^\�ۖ,�Ec��\�\�R�m����z;7��f\�\�\�H\��U�rI\�2qS��\�#=	�1�Fbr\"	W���A�-\�\�O\�\�6%�\�_�\�\�W\��}J,<_L\�\�AE�\�	 .\�D\�	qP��>e@	F��O�ŨK��\�@�W�\�x�\�7$v��þ\�1��\�돋�0\�WĘT䰗1��锨�\�Ņ�D\"\Z�s�z	w�7r\�\�A)\�\\:u9�vu#ݮ�O(1\�ƖƦ\�\�M!ߢ\n�-:�\�\�Kk�u�[�X(��\�\"�\�Wb\nj\��\�	\�W&\�\���\�/\�z�21\�\�Ubq�\�Nȁ�f�ed<B=:(\�$\��r<\�d\�\'�\"\���N07�=���6R\�o\�g\�_Ą�9H�H\�\�C\� :!ҟ@�\����\�(C\"o�\�GuH��.��W�#2폣T\�21\�z\�]afE������L\�(\�\��\"\�\�U\�t\�\�\�ĸ����7�uL;FC�D�C���\�A$4\��4���_as|t��W\�&(��\�D��\� 5\�	�ԢxKC�;2�0S���#	\�TӀ�?:T}(\�Q\�nE\����r�51*=���\�\�����VV��&\"q��,&b�O	ɱ�4\�\�b\�E��,o\"��FmJoP�mG�P�*+�,�\�RUS=6)\���]O�\'\�/�\�!\Z��e��\�\��\�c\r\�C�㣱\0����^�rzh\�a>S\�\�X��:B\�^�ѣ\�\��l�\�\"�~o��\�\�\�9i\�A�\�P\0\�\�\�>��D%ԭ��ȑÇi\�\�YZge{|\\\�2�\�PJB	\�*�T_d0�Ⱦ\�ޓ5W)1jNE!\�ODq\�`\����4~%\�Q,��\�5r\Z�c��?\�@�+\�U\n�w�\"�\� �V��h�I\�?\�¤\�O\�Ph\�\���-Q\�L̵\���%!c|\� B%,�k�6A\0��\�\�\�\�\Z��(�2b\�\nC�!wO\�\�~����w��e�*x�}l$�-\�e\�Ft�J�?\�\\z�*�(Ƈt�cG�����a�Q��1\�~���^l\�x\�ۏ�C\�\�fp5����-l7\�%ƙ��.�jcr�<\�\�,\r\����P\�\�P���C�\�\�\�1ʳ�W ��+\�:(P�<\�:�&\�.\�\�\�b~� t!�\�Ei]�Z0BM�\�V\�1�72?\r!U::Z��B\���\�ke�C,q=ڢ?St_\���3]|PƢFGǼE�\�\�\�\"���7\�\"f\�[\\�@�K0�\�\�b\�\�\�x��st�\�Pt\�>v��Q/Rʺ~4�(�mS�\�c\�L5��kqLd\�}���\�\�1KhN\�l\r\�\�\�\�Y4��L�����a4�1�\�\�z�霼ȳ���應��\�1\\�\rcٛ�5M�ٚ,\�\�\'m��M�\�d�JV��,o�\�\�~�񱶦u7\�E��g(�̷iYZ<\\�v��UM��\�ﱸN滲��j�D3���Ec\�2o�>4&\�Jӯ��8��\�c�r�q/Rx�\\�&֫͝ [����y�N>�g@ׯ.�\Z\�\�a5m,*٫5���\�\�l�\�\�\�+u��8[��׻u�\�\�+��\��X\�\�8˷0\�e��+�Y\�\�Ų\�N�y.�\�\�\�i%���e\��8M�3\��~?r�74\�Q��fAۏz\�E(\�\�z���U��&\�\���\Z�F��NC�ʬ�+z~�\�V\�\�Y�\"0^��Z���R/i�2���\�\�\�z=ϖ\���{<\�s2Oę�lj1MK�\�ü$2IC�Z0�n�e��EKάom\�G��ƭ\�(\�Xm�W\�\�}yB�&2�X\�?ұ_7D}oe\�\�xLϸz\�\�\�I�\�}l�K\�kY{>\�\�e\�L�@[�z�\�\�\�ĕ5�\�\� k-D�Ex�9ߝ�;\�\�\�\�Q};\�}l7�|\�̂\�}m�^\�Y9@-\�lI0y\�g\�\�S�\�J:\�,��u�a�\'�\�*�\�%�Ä�\"\�;aT\��g\�t\�\���\�n�\�՞b\�zdƸ�WH�\�\��\�=/���\�}\�z\�\�E�#\�m\'��\�@\�\�`�|L�-�jR�Z\�m\�\��laY[?��\�k��\�ߒ�\� ���;�;\�\�m�/\�\��\�km�\�ު\�KLG$\�\�\�e\�j+�ԋ�=�ʞD�XU��v{�CQ|c��N����^\�\� \�,���XQO\�\\\�kvo�~�0�/�ub�׻t��ڻQN�\�\�ơX�L\\S��2q P�a�{˵�xLo\�\��\�G�\�<@�\�~�7��e�E�\��`ߓ�\0d_���\0�\"��\�U\��Mb%����ߝ\�\�:\��#�8r;��\�u�\�\����y\�_��k\�vbf��\�J3�\�\��u����\��]@�[���\�<�\�\�p\�_��\��\��\�%$\��O\�\�\"�N�\�V\�E��Co&I��#_G�(9��=I�\�\�y\�4\�o�o |��-\�\�w�\�{\�L~�\�U\�*\�K\�\�\�\�/���t\�{\�G�\") \�\� \�\�\�ҿ]\�ssڸ\�˸\n�\�\\-ܵ�M�r[�s�s;z���8\�\�\�\�\"q!�Q.�p�Fx+w+\�c\��\�݃\�^\�k\�F>\�=�\�)\�)�Osh\�M\�Y�\�\�\�.\�{܏���;�?\�~�\�\�\�\��\�\Z\�K\�Ƚ��\Z\�o�w��CK�?r��r�@x4a�>\��B�ނ��/FX �\�\�D8���p>_�p	���_���o\"�0\�B�Є\�\����\�\�/<&<�\�\'��\�\�τ�a�M\�W\�6X.\�\�;j`�?����\�s\�\�w����\�q\�\�\0\�_σA�.\�(�9(��\�\��AZ�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  34[ 686]  40[ 556]  232[ 525]  244[ 527]  292[ 239]  299[ 260]  305[ 853 551]  314[ 552]  341[ 561]  357[ 323]  362[ 559]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-22T13:37:47-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-22T13:37:47-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:DocumentID><xmpMM:InstanceID>uuid:91A7F102-6901-4AD8-AE03-B6A896B0C481</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Filter/FlateDecode/Length 108>>\r\nstream\r\nx�-̽@@\�w\"�\�#ւH\�a� ׂ�P�D*8g�\r\��\�ݷ@(\�U\�9\�[P�`J��M�=\�Ѝ\� \�E\�\��\�\��b�#���Q\�%�\�\�A\�.����!�\�\��ؐ�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003030 00000 n\r\n0000011144 00000 n\r\n0000011310 00000 n\r\n0000011337 00000 n\r\n0000014518 00000 n\r\n0000014563 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] >>\r\nstartxref\r\n14872\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<02F1A7910169D84AAE03B6A896B0C481><02F1A7910169D84AAE03B6A896B0C481>] /Prev 14872/XRefStm 14563>>\r\nstartxref\r\n15629\r\n%%EOF',27),(10,'Jun',117,'Aceptado','Buen trabajo',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nx��OMk\�0��ޱ-4�\�8�!\Z�-\�a4��ء�.��~��\�\�\�\�4$�\����|>���MO\r(9=f\�۲}�ǈ�I�hE�؀PJ\��\�z\�\�m�A��\�*\�2辴b!\���\���\�$�ݞ	�M��Z�iwZ}TD+�V\� v�خ��bQ�\�>�M *y�X#p�~�\�1�05ĦY�\�:��螵\�ȋ�Z�׋�\�ź\"+샗��\�\�濎`\�&|�\�Er\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nx�]\�\�j\�0\0ໟ\�\�\�P\����@���\�~X�Hm�3,�q\�C\�~�T:�!�I�%\'M\�vF{���Y\�\����r�\�W\'��\�\rKWZ��\�/���$\�\�\�a\�\�8��\�\�G.ޭ|sT\�X\�\�8m.|\�\�\���\�\���x.X]sc\�\�e��\�<��m�B\\�uj�2>W<C�t9+X\� �\r\��aռ:�U30\�_<-�\�<\�\��\�\�]\Z҅(\�:\�G��iQ!%\�T�ʨ4{\"5�<#=����,Q{A:�2RC\�Q�[fA�]\�x^^\nT�w\�\�GT&�\�[7�\��*\�Yʫsa��t8�89m\���v��*~�g�	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nx�\�|xՙ\�93��eٖ�C\�D#\�6	\�+~%�CP\�؎\�<\�I�8�KcK�^Iv��lHP\�\�\�h!-�\"\�LؖGy\�ז@w\�n�}\0M\�\�\�\�\�ei�\�vib\���ɲ1�-�\�_\�h�9\�?��\�\���0B(\0�l[z+�;�\�\Z!����}\�����q�z\�\��O\��\�f��Ƨ�\�a\���E�\"�\�\���#�_\�2 ��\r`zx\�;9�����\�\�Z�(���\�\�08g��\�o��Z�}\�\�\r50�g�\�\n���eoOB�0�3���A�/\�}��=\�\�B�W\�\�\"�\�V�1~�\'.\Z\��O�֮G(�<�\�\'Q5̇	}P��#\�\\�J�\'���\�s|\�m\�d��JU\�x\�\�\�\�\�\��\�ٴ�6�j\� ��u�\���J\�\�?�\�\�\�C�!4\0W�_�+\r�%7f�Fw\0ߌTH��\�\��\�+s\r3?�k:\�rp<b�\�<�ཀྵ�\�\�(\�\�yYmS\�#|�̱������e_��>��\�D���r�{P\�b\�\������^�\�lh\��\�p`a�U_��\��,B�\�\�A\�\�Zn\�\�\�wpV\�ѹz�\�\�?���*\�|�{\���rŃ;t\�s�\r�^\�\�\�z\\:.��Kǥ\��\�k�w��t0\� \�\'�{\�>	\�\'�\��\�\�=�&?K�O{\\,}\�}�����G?Kٟ\���]�u�t\\:>���bk\�\�:�Ɵ��&�|��\�+��\n\�e\�\0�LT�V�uh\�A�Q=��E/\�\�\�\�|\�8;\�y?�`�Lb�5\�_\0�u0�\�\�D.\�!_\�N#H[��\�bzR�\�`\���\�E\�\�\�j܈�a;ޅE<ʾ���u\�u\����\�\��\�کk<�\�\�މ\�H8$\�	�>\�ب\�=2,��C\�\��ջw\�\�t\�wl\�\�׻�{\�\�M�:;6��-7tiex:]\�biu\�ehZ�\�\�\�2S�\�4\�b\�c��vsW��u�\�lv-\�-ƕ��SpE��	��U�Xt\�Z��\�\�\�A:	��9#y~urN\�Ř�>{�\�\n��q;\'�\�Mw$�-|uG��iĖ\0\�f�ƴ�j��,qXbCV�\�b�vZ�\�\��\�\�=̷G��\r�\�\�a9��\�N{�vl\0jĔ\�\�\�4��\���1\�\�\�1u�e�\�5\�\�Ũ�{\�\�1,�f��w8N\�_,$\�3\�bP\�\�:m\�\�zw\�\� �\�\�g0\�2\�\�.�9�H\n\�2K�d��\�\��\�-�7��!4Eg9��c\'XAq\�#\�iF\�dA�T�\rv�\�4\'\�\�\�\�2nJ�^�Pka\�@f�E\�:)\�%��M��imi6=��@,\�q�<�i=�\�\�8\r<{(�4��N�\�PN=\n\�P\�T��F O6|۬\�vڟ\�#\�O!P4����u�\�l�̦\�V;D�u\Zo�Bj�![\�\�CZ\�l�vB;h���\�^_^F���[D�\�1��\r�N-]\�Hd\�5�`ӂ�t\�\Z�S�$�\�\�iʖt8-m�@b�m�@9�󃱡A+tyC[��d�@�Q�4ÖLc��Ek�oj}Lg�c\�\�\�\�U\�*yFMf4�\�Η�\�ji\�{�N\�d��\�>bv�;f�1\�\�l�\�P3\�\�Lj�F��`[\�\�kw?lR\�>\Z]\�O۸R�)�\�z3\���2eY�ޑ����\�l�s(Z�v\" [-\�/��\�^tw\�$k�vڣz�\�e\�lQ\�6\�N�1\�pR�\�zP\r���f��R��\�K�\�\0N\�hh\�2$#\����T�����WL�\�NK�(\�)�b,d��w9\�Aݴn|$N!\�!��y\�Дae�Dc#s�\�䰍��\�\n9Wb\\)\�<�96j�y\�$��\Z⣼�\�h!�.n\'\�`L�)�@���\� :�ۇ ��a\�`4�q��+MJ���sXBI\�} �)!\�Ħ��A?8X\�=f#S��Hr��\�-\�\�\r�.B�\�\"���1\r\��\�b�j#�V\�>ё\�P�=��Ѩ%\ZàbI�Ҙ���\\\��Z�H\�\�H׶��\�;���\�bv\0	SB}	��j1D�3\n\�\�\r�MU�͉\�\rQ�Z��\�r�\�\�p[\�\r|OC-@&\'t��Ʉi%�\�\�Oi\�g�ޭ)�\�\�O�*k)WЬ\�\�N�h\�:{�1�`5L\�q\���8OU\�\�AV\�j>\�\�ٕ\�\�\�d�10y`h\�%�EsB\�tY_Y��~\�\��VӖ@�c\� Ok�9�I\0}PZ^\�Rue��xe�\Z2���\�$\�yR>\�AA��\�x:�B7\�\�A9\"^K��uTfLܥ&��B�$\�ɧ����\�я�\�L\�d�Ts�x\�<�ɞ3+\�b\�QeW*�N4\�\��K^�V*8*�s+}\�\�\�`1k�������X�n\"Զ��W;\�\�@��YP\�\�A�(�,0��eC��a�gy�AXkYM.i�\�\�\�@�\'\�Ȑ��Bu�\�5x�6�!�Fj\Z\�4\Z\�qR��\�*#\�)S\Z��*Y,\�qkr~�\�IMZ2MN�(�	97J8n\�.�*��d´J4cit�T�R\�ǋb\�\0u\�\�\�ddΝr�\0l�3\Z%�mzw&١�\�l�\�j\r�d��%�\�\0�\�MDk)�a�i�:r\�J\�a\�\0�/ʩ��\�\�E�L�3\�?nMP\�N\0�u%r�+\�\�j9;\'�赑sH\�ȩ\�te�\�\�U}��Ӵ���$3r��$9�\�4\�\�30gT�\�R\�\0\�j��,Uam�ƚR�@E��\�h4=Q�I��w%��\�����x@�3�\�\�\�fP�\�\� �\�k����\�roJ#	P\�=��Rs\�\�D�c(�l\�T\�b\�{M�$���	�\r\�-����\�,\�\�+\�N\�pU��\�i$��\�H��ʃ\�A\�\�(�\�<\�\�O[p�\��[O����\�E\�\�#�\�ט\�\�,\�C��\�\r�b\�\�\Z�F~�(\�p\�J\�k�\rx�8�u�C.U\�\�\�\�\�!��|�hĎP\�*s�����T�\"�\�)\�\�\�L���@\�\�t��:\�x��\��q\�<YU*6`\�k&��m�L\�\�B�%\�\�$��\��\�\�4j!oR\�\�2$S���<���\�X\�h�C}!I7\�t��B򺔔�?!Mi�M��9�F�\�˹��t=�\�\�REhtWt\'��cK�`Ef:(\�\�N�	�\��⦫W\�M�+%Ӯ\���ʸigE\�\�8k��\�M;\�\�\�\�gM۬qSߊNS�犸i\����W\�-\�[M��?bڴ<n\�xy\�\�U\Z7u�ZM\�#�\r\�gM\�\�qS[I\�\�Z\�i�%nj)���\�gM\�\�q�\���\�*��i-7]ɟ0�\�+MM\�$S㲸��7�6M�V-�L\�K㦺�gM��gM5�qSu\�#��U���\�JSy�d�b\�զ�U�\�x\�.K�\�T\�.�l�yɕ&~\rtL\�FL\�V,\�ߵ� n*̏��u�5\�/�\�o\�_b\�&�\�_tYS�{gnCζ\�ö���Ѡߦj`�qp\�Y\��\�\�t\�4\r\�m��C\�@��\�6f�\�a@�ͦ\�g\�ͨ\�\�uZ\�\�i��c�X���@xm���\�ж��\�i�or�\�F���+vs��qA�$���\�i��\�ь�\�j�\"�Ѯ2�ZqJCp��\�y^!W�Ɂ5A�\�\�\�,F�f\�PN��\�b�����8g\����\0\�\�ct\0]�|\�&�\Z\�\�CA4�z��\"ȋF�b`��!\�D\�����GnX1p��\r�\0pڏ6�z;\� \0�fǁ�Aʉ\�\��\����\�6\�\�����h7P\�G\�\�+�NĢ,��\�Q�m\���\�UŜ.ϣ\����Ź����V\�\r�Vg\�\0�f\�4T�ܓm\�.)*�����\�_��V��͸�~U}}]m��H�Ȓ�Ѩ\�\Z\���ˊ������gֱk\��\\SSc}\�\���\�\�^wOw˪\"N\���\�oWW�\�^\�;\�\�\�+/k�o\�b\�>x\��X��\�\�UG�\�\�\�s�c\r\�!�-C\�i\�j�rTYб��&�\�\Zla\�l��\�\�?>��\�ԅ����_��?xO\�e\�5\�ؔ��%u)�f��7J\��i&c�w;�֒\��!���f!�\���e�z�\Z�A�V[��\�PI�\���&ۢ\\c�\�;\�_�^;�j|�j�����\�\�>x��\��?��?\���;wp\�G<Zj\�L+(X�\��=+\��ʡ\�\�\��Ե˘�\\[�X\�ـ�}o�\��\�\�эC\�\�Oo\�[�k\�\�˸�so��kf��j\��\�\'�\�\�\�<�\�z#W^x���\�Ѯ=�@�\���\�\�ٷ\�2��m\�Kt�\�b\�B�<�d*D\�D�ICv��jekQ)I�\�U�A��/ce[.W�/��_Uǩ\�\�\�{��\��U\\\�\�b􁑧\"]7�l\�jZ�;]\�\�ϼ��\�9���[ɬ?�{ؿ\�\�\���G<\"�v\�O]�\�U\�걎�n?#���C�L����%\�Z��kH�Vm�Ջd`AvMR�\�R�%\�\�\�\�7\�\�\�wW��rZ\�W7�\�T�\�x\�\�59\�;�zkO�fF��s7�;n\�\�D\�\�s�=\����k\��%\�Lbd\�GY�DY>�QNC\�\rH�\�˘\ZP�&��f�S\��C/\��w�`���i\�<\�>Ⱥ���<\�\�\�/\��_\�o{g\�sY+\�Nz�#�me\�n>�x;�\�o�z���\nI:��ҫV\nD,X��_S���8T\�P���\�F\'�9����\��a\��=�3��\nlz�\�HX-�+�4{d\�!�k���\��\�S�\�\�}��Z��\�wk9��\�M�o?r\�̮v�UΦ�\�\�{bϑ�\�,\���\�\����=�I>Su����׎\�\�F \�\�-ީի����\�\��\r�\�\�9�ξ}\�\�䑁S�އ\�a\�\�\"\�����\\����ٙ\�\�e�Y(�\�.9/�V\�&\�\�-E��g\�j�^i�\�\�\�@U��o/Ɍ\�{+qޑ��\���X��\�\�ݪړ��\���ԃ\�B�f�\�\�O?\�q\�\�\�٧\�1\�\'(-���%�\�\�I�\�,\"��/��^qK$��\�\�ó�?�q��Җ�}�\�C�k�\�2[N�^��|Yn��k���+in-�`\�j \�Ԃ\�aP���{\�R�dy~�\� \�>\�9�\��G\��(ݻy�\��͛���y\��cg�z\�廵�\�scN\�\�kvJ�;�6���\�\�u\�fs\�ƽ}\�\�\��\�[/ٰǾ1\�^D�\��\�~\�Q\�!�-S����6�IWK9JU[k�k\�h����Y�+I�/\�*�\�\�{�\�1\n�\�菾�\�\�\�����\�\�߲?b_W�S\'eq�V�\�\�\�ޖ3���J\�\���_��k\����o-�\���\�G��\� s\�\�=\�\�\��5\�\�\�oo�\�\�\�\�7ٷh��\�\�t�^-,�5$?7YE��Q0��\�-TI�}\�ݮg�\� �\��-���ˏ��o�\�\�\�\�N�<��\�\�\�\'���y:\�\�\�\�\�\�\"�\�2\�̟T}��B\�f\�K���Y\�\�\��\�E�5/W@��&^\\�h�j΍5?�\�\�\�;�\��?�\�Wo\�8|\�\�\�;�o�QS{ce\�!\�\�\�`\�kG6��-g\�w�o\�\�_\�\\�?�+\�\�\�rՍl\�\�\�fY#vh�:e>e\�\"O�4!;w݇w��q�\�������\�w\�~x��X6\�q��r\�ɃSO\r\nO]s\�Ia\�ɞ�\��L\�Gb�8໪eP�\nl\�*�Z�\�KX\�)wn�9ٙ��n-��&�Ybt\�\�=\�3\�\�m(i�\�9�s�\�_\0#0�\r\�Ȧ>X�|Z��\�\�\�\�\�\�\r,�#\�e��r��T�g��.�J�\�[7���\�%ly \�q�\�x\'�ٝsR\�\�\��rxzP,R�\�n\�c?\�%\�[�sV��<g\�^<pݖ\�7�\��\�\�\�5z�+p�V\�\�|\�,\��\ZMC�֚��j9\n�}\��m�����I@_�z\��%O5�L>�*��;\�\�~\�L3>�\�2f��`\�\�\�Կ�1�3������K\ZZ�rmi\�`\�q]Q��\�-e\�d4l\�\�C�cٕ�;:V׷�\�/�q\�	\�ub\�\'�GG]}[[}]\��\�Y/��s!\�t\Z\�\���Ղ\�1�=�k}\���3�\���\�Y\�@lt\�\�o%�㟫�f�\�\�iV\�£��rk`\�;/\�\�UO㌙�\0\�g�\�\�B)A0י1�%\�m\�zÈ鞙j\�{\\Wq[���̮A\���\�V\��<������n\��\�\Z\��7j;?u�\'��������\�k\�_\�N\�\��\�XӇ\�\�d\����>m\�Ҹ��ڥv��\�ЧjGh�h�-\��a�\��\��\��Z\�\��Tm\�_��\\j�\��\\�{\�R�:�=B\�]\�j�\�O\��`$\��a\�(}6ϥ\�U(�ݫ\�\�)x\rjH\�3\�\�\�\rJ?YU���!�>{V\�Z�\�\�*�RR�i)4MH�:�\�\�\0�q\�[�\\\Z(Tݦ\�1\�\�UJ�A��	�Ϧ๔�\n\�(}u\n^��d_�rT_Q�i�PJ駣>�KJ_��2\n�~{,�]\�g�\�7��!�\��n`�>�D髐.{�\�OK�iB�����\Z�\��:_]U]\�o\�8�@(0\�[R0 	aO�_��\�z�ψ;\�{Đ(���\n�\�-\�Ec�\�/\�\�W\�\�|\�\�	\�\���B�K���\�\�=~>(Ha>\��Gx��#�I~h�_\�wI7\�m�;\���^\�%\�+�~\'eH��%A�#��\�\�p8j��\�ݑ�\ng�W)\0�|�p�T�\�)u\�70T\�BaQ�\�\�\�Һ���\�\�ZQ�\'%b��!U�\n�[�|�P\�\���(��\�$�â���D��\�-H#b\����R�\�/[\�I��N�\�.^�N�\0�xW�\��0u3?\�\�`#\�AQ���h\�/q\"�KL\�\��@$�%��\�(\"�7\�\":$���G�@\�+\��FB`ѳ�\�\\�ar�Y�Ȑ\�r�\�.a=	2D�N\�OV�������zS[g��4DJ�84���ʝp|s-!I�Ѕ\�\"]\�\n�˨\�Q\�&B>\�z\�4g�\�\��B�4\r����HM�\�\��ASY\��\�lP���[\0ՇD\�_r�\n)\�HDz(q\��\�a+Pq\�XBD�K�K\�	\�X�hv3�H�H�\�M�� ��G�xi;���U]Q��iKM}\�\�P$\�z@3��*xG \���I��m�qJ�@\��\nz�I\�\�A\��\�0����t�\�D;%�<\��W\�\�y\�!�R�q�!*��amY�\0Λp{�\�y \�\�Y\�~\�$�ܳ�}C�+�8|�����uJ��\�D/ɫ�z`���E�b���~o@p\�\�� �J��90¾�\�E2hܢ78ףPa\�\�\�$ $Ǥ�\�3\��+U\n�w�\� �V\�\�`\0�I\�=Y	I	\�I\�\�\�\�\�-A\�Lȵ^\�>�#,@|\�\���Q��\�ۄ<ȉ$@!8�Qp-ГP�B0\��Q̬C^h<\�\�r\�\\��D��@=\�E)�`V�k\Z�3~\�\�@/�!\�@f�4�q/\�e�J!\�\'��`\\@7N�h \0\�\�<\���B���$�\�p�\0\�I\�Q�f]@�k\���$��|�\"�h#Q9D�\0xg��	�R�l`�\�\�a��P#��6s�g�W\0�\0\�VPtQ9\�L\�P9�wy\n\�J\�\0�J\� P�m%ڈ: B�h3\�X�.������i�ё#�5|�Ⱥn\�\�G\�R�\�+Qq\�9Q\�\�\�?\�Ņ\�h\�\�쬷W���Q�hd�t}�r)�uaj�N��ΑD�NP�\�\�E�!:\�JAяd�D�6�j=�\�Ds��\�p2_{\�\�(\�\�ZBrR�{�3\'\�\"Y,gB\0䇕#Q�\�K\�Q�pr\��\�\�W{a죸Tf�7u?ʚF\�,K\�\'\���O�\'\�bJ��4o�\�\�n�qѾ�\�\�E�%)�Է	Yr<*i\�\�)V��\�߳q]\�we)q�m	&34</�f흠\�\�}lL�&�\����㢐p��q(�T�L�\�Nꕗ\�щdԜT\'\�ӣ\�טR\rI\�К6�\�\�\�\\X\�i��?\�ԝ:wU�\�@\�\�C�ճ��ZE������=D\�\�O�\�Y/\�f��s������%�/Pz����H���p>��\�L#t��\��\�<H��-��\����@�\�v%[ު\nR�\�T�\�Q\�V\�4D�@+��\�W��\�\�}��\n\Z���\�\��0ĔxI��A\�0	\�\�\�-�\�\�T^A���<\�D�z!Hw�ӄR\�\�K<�4��\�m\�v\�h	\��-\�� \�\�\��+�u*\\De,\�\�\�p�\�\��Dl\�\�\r^���R\�o.fxN=�\�y�c�˅��,?�\�r˒r\�[ \�	%\�\�Y\�	e�\�Z\�\�d��\���\n���J֝s�u�K};\�}\�n�\�g!R\�ks\�jJ\�b�lK�\�K<+J\��:�T\�	jy�\�\�\�=aNV�4.��\'^�����l��y2�\����\�S�_�\�,\�\�I\�Y�?nz\�\�(~��г��t��\�|\' �\�\0\�;�蹨V[h\�$\\\�\��}@\�A+��P\��\�\�%��p�+W\�\�!�ץ\�].��\��1օ\�>�\�u\�%�/\�\�kpmEmCEUT�����d8\��C=C�|}�&\�\"��SU\�P�����\�\�\��.a\�C^H�:�se��ιQ�\���I\�[ƷK�8VƏ{\�e\�\�H�<��Nd�v��E\�i\�og\�QX��@0�7!4\�I�Cx^��\n1xE\�k��ZT7�5\���L�;C(���\�O�\��\\�XKp��2J\�}�\���ϔ�\�@0K\�$���a�\�aka�\Z��	�~D�[�B�\�	\��o�3\0��\�=\�;��}1ր�ӱ`&^Њ�\0܊�\0E|\�58\n\����\0Ï�nO㧡\Z?\�\��\�\0_�\��\Z�\��\0�O�?\�?�&~\�9|\�;�_\0��t�{�>�?\�8\�\�h\0�1\�\03\��\�dr��\0M\�\0˘\n�uL�5̕\0[�M\0�2[\�2}\0�3;\0:��\0\�\�bF�� 8�L���\�M\�-\0\�b\��\0\�\r��1\�\0�d��\��g��y�y\�\�\����\'�?b�\�O��\0�\�3�o1o<ǀ�\�/�\�\0�w\�=��c�R\�}\�<�faL�a�\�l&�	\��\Z\0\�9\0\�\�|��\�\�\0��\�\0�\�\0�\�*�6v��a\�s%��\\+�����\�N|�{�\�\�S\���1\�\����\��7�wU*�\�,��\Zѿu����\�q\�\�U\�\� �XX\�,Bܷ�����>\�\� 9\��-\�\���\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nx�-\�\�@@෿\'c\�@\npՀvЂ�\�\�A�P�Zyr\�7�\�����\0>6r\�LEV�v ���9\�]2:�,��!�8�\�\�c.=%��B~	MO�\�\�B�\0/\�g\�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',28),(11,'Jun',7,'Aceptado','actividades correctas',_binary '%PDF-1.7\r\n%����\r\n1 0 obj\r\n<</Type/Catalog/Pages 2 0 R/Lang(es) /StructTreeRoot 15 0 R/MarkInfo<</Marked true>>/Metadata 27 0 R/ViewerPreferences 28 0 R>>\r\nendobj\r\n2 0 obj\r\n<</Type/Pages/Count 1/Kids[ 3 0 R] >>\r\nendobj\r\n3 0 obj\r\n<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 5 0 R/F2 12 0 R>>/ExtGState<</GS10 10 0 R/GS11 11 0 R>>/ProcSet[/PDF/Text/ImageB/ImageC/ImageI] >>/MediaBox[ 0 0 612 792] /Contents 4 0 R/Group<</Type/Group/S/Transparency/CS/DeviceRGB>>/Tabs/S/StructParents 0>>\r\nendobj\r\n4 0 obj\r\n<</Filter/FlateDecode/Length 221>>\r\nstream\r\nx��OMk\�0��ޱ-4�\�8�!\Z�-\�a4��ء�.��~��\�\�\�\�4$�\����|>���MO\r(9=f\�۲}�ǈ�I�hE�؀PJ\��\�z\�\�m�A��\�*\�2辴b!\���\���\�$�ݞ	�M��Z�iwZ}TD+�V\� v�خ��bQ�\�>�M *y�X#p�~�\�1�05ĦY�\�:��螵\�ȋ�Z�׋�\�ź\"+샗��\�\�濎`\�&|�\�Er\r\nendstream\r\nendobj\r\n5 0 obj\r\n<</Type/Font/Subtype/Type0/BaseFont/BCDEEE+Aptos/Encoding/Identity-H/DescendantFonts 6 0 R/ToUnicode 23 0 R>>\r\nendobj\r\n6 0 obj\r\n[ 7 0 R] \r\nendobj\r\n7 0 obj\r\n<</BaseFont/BCDEEE+Aptos/Subtype/CIDFontType2/Type/Font/CIDToGIDMap/Identity/DW 1000/CIDSystemInfo 8 0 R/FontDescriptor 9 0 R/W 25 0 R>>\r\nendobj\r\n8 0 obj\r\n<</Ordering(Identity) /Registry(Adobe) /Supplement 0>>\r\nendobj\r\n9 0 obj\r\n<</Type/FontDescriptor/FontName/BCDEEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n10 0 obj\r\n<</Type/ExtGState/BM/Normal/ca 1>>\r\nendobj\r\n11 0 obj\r\n<</Type/ExtGState/BM/Normal/CA 1>>\r\nendobj\r\n12 0 obj\r\n<</Type/Font/Subtype/TrueType/Name/F2/BaseFont/BCDFEE+Aptos/Encoding/WinAnsiEncoding/FontDescriptor 13 0 R/FirstChar 32/LastChar 32/Widths 26 0 R>>\r\nendobj\r\n13 0 obj\r\n<</Type/FontDescriptor/FontName/BCDFEE+Aptos/Flags 32/ItalicAngle 0/Ascent 939/Descent -282/CapHeight 939/AvgWidth 561/MaxWidth 1682/FontWeight 400/XHeight 250/StemV 56/FontBBox[ -500 -282 1182 939] /FontFile2 24 0 R>>\r\nendobj\r\n14 0 obj\r\n<</Author(��\0A\0b\0e\0l\0 \0H\0e\0r\0n\0\�\0n\0d\0e\0z\0 \0Y\0o\0n\0g) /Creator(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) /CreationDate(D:20250623213148-06\'00\') /ModDate(D:20250623213148-06\'00\') /Producer(��\0M\0i\0c\0r\0o\0s\0o\0f\0t\0�\0 \0W\0o\0r\0d\0 \0p\0a\0r\0a\0 \0M\0i\0c\0r\0o\0s\0o\0f\0t\0 \03\06\05) >>\r\nendobj\r\n22 0 obj\r\n<</Type/ObjStm/N 7/First 46/Filter/FlateDecode/Length 316>>\r\nstream\r\nx�mQۊ\�@}_\�\�\�x[\�.b)��\�\�X�m���q\n�\��l�k\�a��\�\�\�ɤ@\0j\n#j*\�3f\�\��c.M`8@_�p:�\�#ac��7\�Ļ:\�\�*\�!8F�3�\�ޚ�Q۲�i]�\��u\�\�J|���\�88�\�Z��-i�o\�Q\�\"\�XK�bW2,\�\�Ր~GOP�􆵌\���\\ksy�S\�\��	���/\�Xz~\�S��\\�CI,+h_X\�b\�/\����\�z�\���^2\��ȋI�{�:\��˜\�^��Y\'��Ņ:\�\��eNW�)�\�\�(�/	�\n���W&\�-OpӦ����\�1\�n\�\�C]\��\��\�Zzo\�\�/�\�\r\nendstream\r\nendobj\r\n23 0 obj\r\n<</Filter/FlateDecode/Length 296>>\r\nstream\r\nx�]\�\�j\�0\0ໟ\�\�\�P\����@���\�~X�Hm�3,�q\�C\�~�T:�!�I�%\'M\�vF{���Y\�\����r�\�W\'��\�\rKWZ��\�/���$\�\�\�a\�\�8��\�\�G.ޭ|sT\�X\�\�8m.|\�\�\���\�\���x.X]sc\�\�e��\�<��m�B\\�uj�2>W<C�t9+X\� �\r\��aռ:�U30\�_<-�\�<\�\��\�\�]\Z҅(\�:\�G��iQ!%\�T�ʨ4{\"5�<#=����,Q{A:�2RC\�Q�[fA�]\�x^^\nT�w\�\�GT&�\�[7�\��*\�Yʫsa��t8�89m\���v��*~�g�	\r\nendstream\r\nendobj\r\n24 0 obj\r\n<</Filter/FlateDecode/Length 8477/Length1 21920>>\r\nstream\r\nx�\�|xՙ\�93��eٖ�C\�D#\�6	\�+~%�CP\�؎\�<\�I�8�KcK�^Iv��lHP\�\�\�h!-�\"\�LؖGy\�ז@w\�n�}\0M\�\�\�\�\�ei�\�vib\���ɲ1�-�\�_\�h�9\�?��\�\���0B(\0�l[z+�;�\�\Z!����}\�����q�z\�\��O\��\�f��Ƨ�\�a\���E�\"�\�\���#�_\�2 ��\r`zx\�;9�����\�\�Z�(���\�\�08g��\�o��Z�}\�\�\r50�g�\�\n���eoOB�0�3���A�/\�}��=\�\�B�W\�\�\"�\�V�1~�\'.\Z\��O�֮G(�<�\�\'Q5̇	}P��#\�\\�J�\'���\�s|\�m\�d��JU\�x\�\�\�\�\�\��\�ٴ�6�j\� ��u�\���J\�\�?�\�\�\�C�!4\0W�_�+\r�%7f�Fw\0ߌTH��\�\��\�+s\r3?�k:\�rp<b�\�<�ཀྵ�\�\�(\�\�yYmS\�#|�̱������e_��>��\�D���r�{P\�b\�\������^�\�lh\��\�p`a�U_��\��,B�\�\�A\�\�Zn\�\�\�wpV\�ѹz�\�\�?���*\�|�{\���rŃ;t\�s�\r�^\�\�\�z\\:.��Kǥ\��\�k�w��t0\� \�\'�{\�>	\�\'�\��\�\�=�&?K�O{\\,}\�}�����G?Kٟ\���]�u�t\\:>���bk\�\�:�Ɵ��&�|��\�+��\n\�e\�\0�LT�V�uh\�A�Q=��E/\�\�\�\�|\�8;\�y?�`�Lb�5\�_\0�u0�\�\�D.\�!_\�N#H[��\�bzR�\�`\���\�E\�\�\�j܈�a;ޅE<ʾ���u\�u\����\�\��\�کk<�\�\�މ\�H8$\�	�>\�ب\�=2,��C\�\��ջw\�\�t\�wl\�\�׻�{\�\�M�:;6��-7tiex:]\�biu\�ehZ�\�\�\�2S�\�4\�b\�c��vsW��u�\�lv-\�-ƕ��SpE��	��U�Xt\�Z��\�\�\�A:	��9#y~urN\�Ř�>{�\�\n��q;\'�\�Mw$�-|uG��iĖ\0\�f�ƴ�j��,qXbCV�\�b�vZ�\�\��\�\�=̷G��\r�\�\�a9��\�N{�vl\0jĔ\�\�\�4��\���1\�\�\�1u�e�\�5\�\�Ũ�{\�\�1,�f��w8N\�_,$\�3\�bP\�\�:m\�\�zw\�\� �\�\�g0\�2\�\�.�9�H\n\�2K�d��\�\��\�-�7��!4Eg9��c\'XAq\�#\�iF\�dA�T�\rv�\�4\'\�\�\�\�2nJ�^�Pka\�@f�E\�:)\�%��M��imi6=��@,\�q�<�i=�\�\�8\r<{(�4��N�\�PN=\n\�P\�T��F O6|۬\�vڟ\�#\�O!P4����u�\�l�̦\�V;D�u\Zo�Bj�![\�\�CZ\�l�vB;h���\�^_^F���[D�\�1��\r�N-]\�Hd\�5�`ӂ�t\�\Z�S�$�\�\�iʖt8-m�@b�m�@9�󃱡A+tyC[��d�@�Q�4ÖLc��Ek�oj}Lg�c\�\�\�\�U\�*yFMf4�\�Η�\�ji\�{�N\�d��\�>bv�;f�1\�\�l�\�P3\�\�Lj�F��`[\�\�kw?lR\�>\Z]\�O۸R�)�\�z3\���2eY�ޑ����\�l�s(Z�v\" [-\�/��\�^tw\�$k�vڣz�\�e\�lQ\�6\�N�1\�pR�\�zP\r���f��R��\�K�\�\0N\�hh\�2$#\����T�����WL�\�NK�(\�)�b,d��w9\�Aݴn|$N!\�!��y\�Дae�Dc#s�\�䰍��\�\n9Wb\\)\�<�96j�y\�$��\Z⣼�\�h!�.n\'\�`L�)�@���\� :�ۇ ��a\�`4�q��+MJ���sXBI\�} �)!\�Ħ��A?8X\�=f#S��Hr��\�-\�\�\r�.B�\�\"���1\r\��\�b�j#�V\�>ё\�P�=��Ѩ%\ZàbI�Ҙ���\\\��Z�H\�\�H׶��\�;���\�bv\0	SB}	��j1D�3\n\�\�\r�MU�͉\�\rQ�Z��\�r�\�\�p[\�\r|OC-@&\'t��Ʉi%�\�\�Oi\�g�ޭ)�\�\�O�*k)WЬ\�\�N�h\�:{�1�`5L\�q\���8OU\�\�AV\�j>\�\�ٕ\�\�\�d�10y`h\�%�EsB\�tY_Y��~\�\��VӖ@�c\� Ok�9�I\0}PZ^\�Rue��xe�\Z2���\�$\�yR>\�AA��\�x:�B7\�\�A9\"^K��uTfLܥ&��B�$\�ɧ����\�я�\�L\�d�Ts�x\�<�ɞ3+\�b\�QeW*�N4\�\��K^�V*8*�s+}\�\�\�`1k�������X�n\"Զ��W;\�\�@��YP\�\�A�(�,0��eC��a�gy�AXkYM.i�\�\�\�@�\'\�Ȑ��Bu�\�5x�6�!�Fj\Z\�4\Z\�qR��\�*#\�)S\Z��*Y,\�qkr~�\�IMZ2MN�(�	97J8n\�.�*��d´J4cit�T�R\�ǋb\�\0u\�\�\�ddΝr�\0l�3\Z%�mzw&١�\�l�\�j\r�d��%�\�\0�\�MDk)�a�i�:r\�J\�a\�\0�/ʩ��\�\�E�L�3\�?nMP\�N\0�u%r�+\�\�j9;\'�赑sH\�ȩ\�te�\�\�U}��Ӵ���$3r��$9�\�4\�\�30gT�\�R\�\0\�j��,Uam�ƚR�@E��\�h4=Q�I��w%��\�����x@�3�\�\�\�fP�\�\� �\�k����\�roJ#	P\�=��Rs\�\�D�c(�l\�T\�b\�{M�$���	�\r\�-����\�,\�\�+\�N\�pU��\�i$��\�H��ʃ\�A\�\�(�\�<\�\�O[p�\��[O����\�E\�\�#�\�ט\�\�,\�C��\�\r�b\�\�\Z�F~�(\�p\�J\�k�\rx�8�u�C.U\�\�\�\�\�!��|�hĎP\�*s�����T�\"�\�)\�\�\�L���@\�\�t��:\�x��\��q\�<YU*6`\�k&��m�L\�\�B�%\�\�$��\��\�\�4j!oR\�\�2$S���<���\�X\�h�C}!I7\�t��B򺔔�?!Mi�M��9�F�\�˹��t=�\�\�REhtWt\'��cK�`Ef:(\�\�N�	�\��⦫W\�M�+%Ӯ\���ʸigE\�\�8k��\�M;\�\�\�\�gM۬qSߊNS�犸i\����W\�-\�[M��?bڴ<n\�xy\�\�U\Z7u�ZM\�#�\r\�gM\�\�qS[I\�\�Z\�i�%nj)���\�gM\�\�q�\���\�*��i-7]ɟ0�\�+MM\�$S㲸��7�6M�V-�L\�K㦺�gM��gM5�qSu\�#��U���\�JSy�d�b\�զ�U�\�x\�.K�\�T\�.�l�yɕ&~\rtL\�FL\�V,\�ߵ� n*̏��u�5\�/�\�o\�_b\�&�\�_tYS�{gnCζ\�ö���Ѡߦj`�qp\�Y\��\�\�t\�4\r\�m��C\�@��\�6f�\�a@�ͦ\�g\�ͨ\�\�uZ\�\�i��c�X���@xm���\�ж��\�i�or�\�F���+vs��qA�$���\�i��\�ь�\�j�\"�Ѯ2�ZqJCp��\�y^!W�Ɂ5A�\�\�\�,F�f\�PN��\�b�����8g\����\0\�\�ct\0]�|\�&�\Z\�\�CA4�z��\"ȋF�b`��!\�D\�����GnX1p��\r�\0pڏ6�z;\� \0�fǁ�Aʉ\�\��\����\�6\�\�����h7P\�G\�\�+�NĢ,��\�Q�m\���\�UŜ.ϣ\����Ź����V\�\r�Vg\�\0�f\�4T�ܓm\�.)*�����\�_��V��͸�~U}}]m��H�Ȓ�Ѩ\�\Z\���ˊ������gֱk\��\\SSc}\�\���\�\�^wOw˪\"N\���\�oWW�\�^\�;\�\�\�+/k�o\�b\�>x\��X��\�\�UG�\�\�\�s�c\r\�!�-C\�i\�j�rTYб��&�\�\Zla\�l��\�\�?>��\�ԅ����_��?xO\�e\�5\�ؔ��%u)�f��7J\��i&c�w;�֒\��!���f!�\���e�z�\Z�A�V[��\�PI�\���&ۢ\\c�\�;\�_�^;�j|�j�����\�\�>x��\��?��?\���;wp\�G<Zj\�L+(X�\��=+\��ʡ\�\�\��Ե˘�\\[�X\�ـ�}o�\��\�\�эC\�\�Oo\�[�k\�\�˸�so��kf��j\��\�\'�\�\�\�<�\�z#W^x���\�Ѯ=�@�\���\�\�ٷ\�2��m\�Kt�\�b\�B�<�d*D\�D�ICv��jekQ)I�\�U�A��/ce[.W�/��_Uǩ\�\�\�{��\��U\\\�\�b􁑧\"]7�l\�jZ�;]\�\�ϼ��\�9���[ɬ?�{ؿ\�\�\���G<\"�v\�O]�\�U\�걎�n?#���C�L����%\�Z��kH�Vm�Ջd`AvMR�\�R�%\�\�\�\�7\�\�\�wW��rZ\�W7�\�T�\�x\�\�59\�;�zkO�fF��s7�;n\�\�D\�\�s�=\����k\��%\�Lbd\�GY�DY>�QNC\�\rH�\�˘\ZP�&��f�S\��C/\��w�`���i\�<\�>Ⱥ���<\�\�\�/\��_\�o{g\�sY+\�Nz�#�me\�n>�x;�\�o�z���\nI:��ҫV\nD,X��_S���8T\�P���\�F\'�9����\��a\��=�3��\nlz�\�HX-�+�4{d\�!�k���\��\�S�\�\�}��Z��\�wk9��\�M�o?r\�̮v�UΦ�\�\�{bϑ�\�,\���\�\����=�I>Su����׎\�\�F \�\�-ީի����\�\��\r�\�\�9�ξ}\�\�䑁S�އ\�a\�\�\"\�����\\����ٙ\�\�e�Y(�\�.9/�V\�&\�\�-E��g\�j�^i�\�\�\�@U��o/Ɍ\�{+qޑ��\���X��\�\�ݪړ��\���ԃ\�B�f�\�\�O?\�q\�\�\�٧\�1\�\'(-���%�\�\�I�\�,\"��/��^qK$��\�\�ó�?�q��Җ�}�\�C�k�\�2[N�^��|Yn��k���+in-�`\�j \�Ԃ\�aP���{\�R�dy~�\� \�>\�9�\��G\��(ݻy�\��͛���y\��cg�z\�廵�\�scN\�\�kvJ�;�6���\�\�u\�fs\�ƽ}\�\�\��\�[/ٰǾ1\�^D�\��\�~\�Q\�!�-S����6�IWK9JU[k�k\�h����Y�+I�/\�*�\�\�{�\�1\n�\�菾�\�\�\�����\�\�߲?b_W�S\'eq�V�\�\�\�ޖ3���J\�\���_��k\����o-�\���\�G��\� s\�\�=\�\�\��5\�\�\�oo�\�\�\�\�7ٷh��\�\�t�^-,�5$?7YE��Q0��\�-TI�}\�ݮg�\� �\��-���ˏ��o�\�\�\�\�N�<��\�\�\�\'���y:\�\�\�\�\�\�\"�\�2\�̟T}��B\�f\�K���Y\�\�\��\�E�5/W@��&^\\�h�j΍5?�\�\�\�;�\��?�\�Wo\�8|\�\�\�;�o�QS{ce\�!\�\�\�`\�kG6��-g\�w�o\�\�_\�\\�?�+\�\�\�rՍl\�\�\�fY#vh�:e>e\�\"O�4!;w݇w��q�\�������\�w\�~x��X6\�q��r\�ɃSO\r\nO]s\�Ia\�ɞ�\��L\�Gb�8໪eP�\nl\�*�Z�\�KX\�)wn�9ٙ��n-��&�Ybt\�\�=\�3\�\�m(i�\�9�s�\�_\0#0�\r\�Ȧ>X�|Z��\�\�\�\�\�\�\r,�#\�e��r��T�g��.�J�\�[7���\�%ly \�q�\�x\'�ٝsR\�\�\��rxzP,R�\�n\�c?\�%\�[�sV��<g\�^<pݖ\�7�\��\�\�\�5z�+p�V\�\�|\�,\��\ZMC�֚��j9\n�}\��m�����I@_�z\��%O5�L>�*��;\�\�~\�L3>�\�2f��`\�\�\�Կ�1�3������K\ZZ�rmi\�`\�q]Q��\�-e\�d4l\�\�C�cٕ�;:V׷�\�/�q\�	\�ub\�\'�GG]}[[}]\��\�Y/��s!\�t\Z\�\���Ղ\�1�=�k}\���3�\���\�Y\�@lt\�\�o%�㟫�f�\�\�iV\�£��rk`\�;/\�\�UO㌙�\0\�g�\�\�B)A0י1�%\�m\�zÈ鞙j\�{\\Wq[���̮A\���\�V\��<������n\��\�\Z\��7j;?u�\'��������\�k\�_\�N\�\��\�XӇ\�\�d\����>m\�Ҹ��ڥv��\�ЧjGh�h�-\��a�\��\��\��Z\�\��Tm\�_��\\j�\��\\�{\�R�:�=B\�]\�j�\�O\��`$\��a\�(}6ϥ\�U(�ݫ\�\�)x\rjH\�3\�\�\�\rJ?YU���!�>{V\�Z�\�\�*�RR�i)4MH�:�\�\�\0�q\�[�\\\Z(Tݦ\�1\�\�UJ�A��	�Ϧ๔�\n\�(}u\n^��d_�rT_Q�i�PJ駣>�KJ_��2\n�~{,�]\�g�\�7��!�\��n`�>�D髐.{�\�OK�iB�����\Z�\��:_]U]\�o\�8�@(0\�[R0 	aO�_��\�z�ψ;\�{Đ(���\n�\�-\�Ec�\�/\�\�W\�\�|\�\�	\�\���B�K���\�\�=~>(Ha>\��Gx��#�I~h�_\�wI7\�m�;\���^\�%\�+�~\'eH��%A�#��\�\�p8j��\�ݑ�\ng�W)\0�|�p�T�\�)u\�70T\�BaQ�\�\�\�Һ���\�\�ZQ�\'%b��!U�\n�[�|�P\�\���(��\�$�â���D��\�-H#b\����R�\�/[\�I��N�\�.^�N�\0�xW�\��0u3?\�\�`#\�AQ���h\�/q\"�KL\�\��@$�%��\�(\"�7\�\":$���G�@\�+\��FB`ѳ�\�\\�ar�Y�Ȑ\�r�\�.a=	2D�N\�OV�������zS[g��4DJ�84���ʝp|s-!I�Ѕ\�\"]\�\n�˨\�Q\�&B>\�z\�4g�\�\��B�4\r����HM�\�\��ASY\��\�lP���[\0ՇD\�_r�\n)\�HDz(q\��\�a+Pq\�XBD�K�K\�	\�X�hv3�H�H�\�M�� ��G�xi;���U]Q��iKM}\�\�P$\�z@3��*xG \���I��m�qJ�@\��\nz�I\�\�A\��\�0����t�\�D;%�<\��W\�\�y\�!�R�q�!*��amY�\0Λp{�\�y \�\�Y\�~\�$�ܳ�}C�+�8|�����uJ��\�D/ɫ�z`���E�b���~o@p\�\�� �J��90¾�\�E2hܢ78ףPa\�\�\�$ $Ǥ�\�3\��+U\n�w�\� �V\�\�`\0�I\�=Y	I	\�I\�\�\�\�\�-A\�Lȵ^\�>�#,@|\�\���Q��\�ۄ<ȉ$@!8�Qp-ГP�B0\��Q̬C^h<\�\�r\�\\��D��@=\�E)�`V�k\Z�3~\�\�@/�!\�@f�4�q/\�e�J!\�\'��`\\@7N�h \0\�\�<\���B���$�\�p�\0\�I\�Q�f]@�k\���$��|�\"�h#Q9D�\0xg��	�R�l`�\�\�a��P#��6s�g�W\0�\0\�VPtQ9\�L\�P9�wy\n\�J\�\0�J\� P�m%ڈ: B�h3\�X�.������i�ё#�5|�Ⱥn\�\�G\�R�\�+Qq\�9Q\�\�\�?\�Ņ\�h\�\�쬷W���Q�hd�t}�r)�uaj�N��ΑD�NP�\�\�E�!:\�JAяd�D�6�j=�\�Ds��\�p2_{\�\�(\�\�ZBrR�{�3\'\�\"Y,gB\0䇕#Q�\�K\�Q�pr\��\�\�W{a죸Tf�7u?ʚF\�,K\�\'\���O�\'\�bJ��4o�\�\�n�qѾ�\�\�E�%)�Է	Yr<*i\�\�)V��\�߳q]\�we)q�m	&34</�f흠\�\�}lL�&�\����㢐p��q(�T�L�\�Nꕗ\�щdԜT\'\�ӣ\�טR\rI\�К6�\�\�\�\\X\�i��?\�ԝ:wU�\�@\�\�C�ճ��ZE������=D\�\�O�\�Y/\�f��s������%�/Pz����H���p>��\�L#t��\��\�<H��-��\����@�\�v%[ު\nR�\�T�\�Q\�V\�4D�@+��\�W��\�\�}��\n\Z���\�\��0ĔxI��A\�0	\�\�\�-�\�\�T^A���<\�D�z!Hw�ӄR\�\�K<�4��\�m\�v\�h	\��-\�� \�\�\��+�u*\\De,\�\�\�p�\�\��Dl\�\�\r^���R\�o.fxN=�\�y�c�˅��,?�\�r˒r\�[ \�	%\�\�Y\�	e�\�Z\�\�d��\���\n���J֝s�u�K};\�}\�n�\�g!R\�ks\�jJ\�b�lK�\�K<+J\��:�T\�	jy�\�\�\�=aNV�4.��\'^�����l��y2�\����\�S�_�\�,\�\�I\�Y�?nz\�\�(~��г��t��\�|\' �\�\0\�;�蹨V[h\�$\\\�\��}@\�A+��P\��\�\�%��p�+W\�\�!�ץ\�].��\��1օ\�>�\�u\�%�/\�\�kpmEmCEUT�����d8\��C=C�|}�&\�\"��SU\�P�����\�\�\��.a\�C^H�:�se��ιQ�\���I\�[ƷK�8VƏ{\�e\�\�H�<��Nd�v��E\�i\�og\�QX��@0�7!4\�I�Cx^��\n1xE\�k��ZT7�5\���L�;C(���\�O�\��\\�XKp��2J\�}�\���ϔ�\�@0K\�$���a�\�aka�\Z��	�~D�[�B�\�	\��o�3\0��\�=\�;��}1ր�ӱ`&^Њ�\0܊�\0E|\�58\n\����\0Ï�nO㧡\Z?\�\��\�\0_�\��\Z�\��\0�O�?\�?�&~\�9|\�;�_\0��t�{�>�?\�8\�\�h\0�1\�\03\��\�dr��\0M\�\0˘\n�uL�5̕\0[�M\0�2[\�2}\0�3;\0:��\0\�\�bF�� 8�L���\�M\�-\0\�b\��\0\�\r��1\�\0�d��\��g��y�y\�\�\����\'�?b�\�O��\0�\�3�o1o<ǀ�\�/�\�\0�w\�=��c�R\�}\�<�faL�a�\�l&�	\��\Z\0\�9\0\�\�|��\�\�\0��\�\0�\�\0�\�*�6v��a\�s%��\\+�����\�N|�{�\�\�S\���1\�\����\��7�wU*�\�,��\Zѿu����\�q\�\�U\�\� �XX\�,Bܷ�����>\�\� 9\��-\�\���\�\r\nendstream\r\nendobj\r\n25 0 obj\r\n[ 0[ 471]  97[ 790]  135[ 606]  205[ 531]  244[ 527]  299[ 260]  306[ 551]  314[ 552]  341[ 561]  344[ 334]  348[ 486]  357[ 323]  362[ 559]  848[ 534]  985[ 203] ] \r\nendobj\r\n26 0 obj\r\n[ 203] \r\nendobj\r\n27 0 obj\r\n<</Type/Metadata/Subtype/XML/Length 3098>>\r\nstream\r\n<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?><x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"3.1-701\">\n<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n<rdf:Description rdf:about=\"\"  xmlns:pdf=\"http://ns.adobe.com/pdf/1.3/\">\n<pdf:Producer>Microsoft® Word para Microsoft 365</pdf:Producer></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n<dc:creator><rdf:Seq><rdf:li>Abel Hernández Yong</rdf:li></rdf:Seq></dc:creator></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\">\n<xmp:CreatorTool>Microsoft® Word para Microsoft 365</xmp:CreatorTool><xmp:CreateDate>2025-06-23T21:31:48-06:00</xmp:CreateDate><xmp:ModifyDate>2025-06-23T21:31:48-06:00</xmp:ModifyDate></rdf:Description>\n<rdf:Description rdf:about=\"\"  xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\">\n<xmpMM:DocumentID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:DocumentID><xmpMM:InstanceID>uuid:A99FA5E5-A2D3-4A53-8BD2-D1AAEA743736</xmpMM:InstanceID></rdf:Description>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n</rdf:RDF></x:xmpmeta><?xpacket end=\"w\"?>\r\nendstream\r\nendobj\r\n28 0 obj\r\n<</DisplayDocTitle true>>\r\nendobj\r\n29 0 obj\r\n<</Type/XRef/Size 29/W[ 1 4 2] /Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Filter/FlateDecode/Length 107>>\r\nstream\r\nx�-\�\�@@෿\'c\�@\npՀvЂ�\�\�A�P�Zyr\�7�\�����\0>6r\�LEV�v ���9\�]2:�,��!�8�\�\�c.=%��B~	MO�\�\�B�\0/\�g\�\r\nendstream\r\nendobj\r\nxref\r\n0 30\r\n0000000015 65535 f\r\n0000000017 00000 n\r\n0000000163 00000 n\r\n0000000219 00000 n\r\n0000000497 00000 n\r\n0000000792 00000 n\r\n0000000920 00000 n\r\n0000000948 00000 n\r\n0000001103 00000 n\r\n0000001176 00000 n\r\n0000001413 00000 n\r\n0000001467 00000 n\r\n0000001521 00000 n\r\n0000001688 00000 n\r\n0000001926 00000 n\r\n0000000016 65535 f\r\n0000000017 65535 f\r\n0000000018 65535 f\r\n0000000019 65535 f\r\n0000000020 65535 f\r\n0000000021 65535 f\r\n0000000022 65535 f\r\n0000000000 65535 f\r\n0000002652 00000 n\r\n0000003023 00000 n\r\n0000011590 00000 n\r\n0000011775 00000 n\r\n0000011802 00000 n\r\n0000014983 00000 n\r\n0000015028 00000 n\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] >>\r\nstartxref\r\n15336\r\n%%EOF\r\nxref\r\n0 0\r\ntrailer\r\n<</Size 30/Root 1 0 R/Info 14 0 R/ID[<E5A59FA9D3A2534A8BD2D1AAEA743736><E5A59FA9D3A2534A8BD2D1AAEA743736>] /Prev 15336/XRefStm 15028>>\r\nstartxref\r\n16093\r\n%%EOF',40);
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
INSERT INTO `responsable_tecnico` VALUES (1,'Lic. Pedro Hernández Peréz','Area TIC del Dpto. de Tránsito de Coatzacoalcos','Jefe del Area TIC','pperezhernandez@gov.veracruz.mx',1),(2,'Ing. Francisca Dorantes de Lourdes','Dpto. de Desarollo de MiddleTek','Lider de Desarrollo','lourdesdf@middletek.com',2),(3,'Mtro. Carlos Lopéz Dominguez','Dpto. Soluciones Digitales','Administrador de Proyectos Internos','cldominguez@gov.cdmx.mx',3),(4,'Lic. Victoria Sanchéz de la Cruz','Dpto. de Desarrollo de Strongware','Gestora de Proyectos','victoriacruz@strongware.com',4),(5,'Phd. Edwin Braun','Project Workshop','Lead Administrator','edbraun@fsk.internal.org',5),(6,'Satou Sakura','IT','Jefe de I+D','sakurasatou@employess.saipan.com',6),(7,'seth marquez rodriguez','Sistemas','Director','cuentadesoportea@gmail.com',7);
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
INSERT INTO `rubrica_presentacion` VALUES (1,'2023-09-30 14:40:25',8.5,8,8.5,8.5,8.5,8.4,'Observaciones...',1,1,3),(2,'2023-11-30 15:24:12',9,9,9.5,8.5,9,9,'Observaciones...',1,1,3),(4,'2024-04-30 13:55:32',7.5,7,8,7.5,7.5,7.5,'Observaciones...',2,2,1),(5,'2024-06-05 17:12:07',8,8,8.5,7.5,8,8,'Observaciones...',2,2,4),(6,'2024-09-30 14:13:45',9.5,9.5,10,9.5,9.5,9.6,'Observaciones...',3,3,5),(7,'2024-11-30 13:52:02',9.5,9,9.5,9.5,9.5,9.4,'Observaciones...',3,3,5),(36,'2025-06-23 20:46:21',8,9,8,9,8,8.4,'hola 123',4,4,6),(37,'2025-06-23 20:48:05',8,9,8,8,9,8.4,'observaciones...',5,4,6),(38,'2025-06-25 01:41:22',10,8.5,7,6.5,6,7.6,'Se guarda calificación final.',7,4,6);
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
INSERT INTO `usuario` VALUES (1,'jangel@uv.mx',_binary '7\��8��\�\�\r\n���','COORDINADOR',1),(2,'zs19834121@estudiantes.ux.mx',_binary 'N\��;߯\0�\�\��|H|','ESTUDIANTE',0),(3,'zs20432114@estudiantes.ux.mx',_binary '3=�z}�3\�q\�e�pi','ESTUDIANTE',1),(4,'dsarahi@uv.mx',_binary '��\n\�U0\�\��c��\�','PROFESOR',1),(5,'hfernando@uv.mx',_binary ')\�hY�V\������S\�\"','PROFESOR',1),(9,'ana_coordinador',_binary 'XD	.\�U X�pq��','COORDINADOR',1),(10,'juan_estudiante',_binary '?�\�\�\�ݵ\\(+.�*�','ESTUDIANTE',1),(11,'luis_profesor',_binary 'P-���v0\�K\�?\�!_','PROFESOR',1),(12,'zS22087162',_binary 'I@+\�ӕۚ2�6','ESTUDIANTE',1),(13,'ester',_binary '���\�b\�\�.t�\�{��','ESTUDIANTE',1);
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
