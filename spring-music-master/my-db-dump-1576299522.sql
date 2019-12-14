-- MySQL dump 10.13  Distrib 8.0.18, for osx10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: service_instance_db
-- ------------------------------------------------------
-- Server version	5.7.26-29-log

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `id` varchar(40) NOT NULL,
  `album_id` varchar(255) DEFAULT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `release_year` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `track_count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES ('76dfa91a-6fc1-4ade-b91d-07e3acd6af10',NULL,'Nirvana','Rock','1991','Nevermind',0),('3c259597-b562-4fe4-be28-6e284778b82e',NULL,'The Beach Boys','Rock','1966','Pet Sounds',0),('f78c1a15-da50-45cb-ba4a-91c72401aa33',NULL,'Marvin Gaye','Rock','1971','What\'s Going On',0),('79037766-2f3e-4fd6-a199-5f408e53ac50',NULL,'Jimi Hendrix Experience','Rock','1967','Are You Experienced?',0),('5580bd9f-41d5-4ac3-945f-60034ec993ac',NULL,'U2','Rock','1987','The Joshua Tree',0),('f592c6f6-628c-4e08-a05a-e794f704c52c',NULL,'The Beatles','Rock','1969','Abbey Road',0),('62877c49-7a7c-4671-b68c-66fc873ee610',NULL,'Fleetwood Mac','Rock','1977','Rumours',0),('1e181b02-9b73-4893-85dc-46f91d64f63a',NULL,'Elvis Presley','Rock','1976','Sun Sessions',0),('f4b5046d-8ccd-4ffa-93aa-8ed498a29fe3',NULL,'Michael Jackson','Pop','1982','Thriller',0),('f03c76ab-6909-4925-aec5-075aabdf23bd',NULL,'The Rolling Stones','Rock','1972','Exile on Main Street',0),('ba31394c-19a1-4a6b-9d29-1054cd425302',NULL,'Bruce Springsteen','Rock','1975','Born to Run',0),('12175f31-3955-46a2-af49-7ec9f3e12e9b',NULL,'The Clash','Rock','1980','London Calling',0),('67341901-58d2-4ffa-a6d1-445be75d35db',NULL,'The Eagles','Rock','1976','Hotel California',0),('eca989d4-34ed-40c4-904e-11a1d93705a6',NULL,'Led Zeppelin','Rock','1969','Led Zeppelin',0),('b02272c1-84e7-4ea6-b686-554bfc3e640b',NULL,'Led Zeppelin','Rock','1971','IV',0),('a68a0afd-8fb8-498d-a2df-c29b9067af08',NULL,'Police','Rock','1983','Synchronicity',0),('6c7308de-6ecf-4a88-b3e4-bf5179fdf825',NULL,'U2','Rock','1991','Achtung Baby',0),('04abb0ca-99e4-4f3f-a7a4-103cfe24f18b',NULL,'The Rolling Stones','Rock','1969','Let it Bleed',0),('e44c172c-3225-4cc7-b2f6-eeab4080b5d3',NULL,'The Beatles','Rock','1965','Rubber Soul',0),('cb536845-834f-4587-99e3-6aa98217df22',NULL,'The Ramones','Rock','1976','The Ramones',0),('31c44b68-c022-4062-8559-6bc497abe06d',NULL,'Queen','Rock','1975','A Night At The Opera',0),('f1247af4-9320-4350-a59c-ae9bd9671766',NULL,'Boston','Rock','1978','Don\'t Look Back',0),('b7a06e19-bacc-477d-8d38-d77123aa1f8d',NULL,'BB King','Blues','1956','Singin\' The Blues',0),('04dd75ae-82cd-43ec-8e52-1115468a11c4',NULL,'Albert King','Blues','1967','Born Under A Bad Sign',0),('fe0c3df6-1367-4427-9168-22f3b7378ee6',NULL,'Muddy Waters','Blues','1964','Folk Singer',0),('efd57d41-25e2-4f51-8d19-0079a1f74982',NULL,'The Fabulous Thunderbirds','Blues','1979','Rock With Me',0),('e3cf630e-8aab-4f73-b0b3-93a36db1e642',NULL,'Robert Johnson','Blues','1961','King of the Delta Blues',0),('c43df53d-d3df-436d-81ec-8cef3c9284f8',NULL,'Stevie Ray Vaughan','Blues','1983','Texas Flood',0),('a45c879a-edb6-4385-bdab-f1236551af78',NULL,'Stevie Ray Vaughan','Blues','1984','Couldn\'t Stand The Weather',0);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-14 13:58:52
