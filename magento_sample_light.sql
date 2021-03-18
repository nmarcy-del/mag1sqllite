-- MySQL dump 10.13  Distrib 5.6.21, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: magento_1_9_1_0
-- ------------------------------------------------------
-- Server version	5.6.21-1+deb.sury.org~precise+1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_assert`
--

DROP TABLE IF EXISTS `admin_assert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_assert`
--

LOCK TABLES `admin_assert` WRITE;
/*!40000 ALTER TABLE `admin_assert` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_assert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  `gws_is_all` int(11) NOT NULL DEFAULT '1' COMMENT 'Yes/No Flag',
  `gws_websites` varchar(255) DEFAULT NULL COMMENT 'Comma-separated Website Ids',
  `gws_store_groups` varchar(255) DEFAULT NULL COMMENT 'Comma-separated Store Groups Ids',
  PRIMARY KEY (`role_id`),
  KEY `IDX_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role`
--

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;
INSERT INTO `admin_role` VALUES (1,0,1,1,'G',0,'Administrators',1,NULL,NULL);
/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_rule`
--

DROP TABLE IF EXISTS `admin_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_ADMIN_RULE_ROLE_ID_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_rule`
--

LOCK TABLES `admin_rule` WRITE;
/*!40000 ALTER TABLE `admin_rule` DISABLE KEYS */;
INSERT INTO `admin_rule` VALUES (1,1,'all',NULL,0,'G','allow');
/*!40000 ALTER TABLE `admin_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_user`
--

DROP TABLE IF EXISTS `admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(100) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  `failures_num` smallint(6) DEFAULT '0' COMMENT 'Failure Number',
  `first_failure` timestamp NULL DEFAULT NULL COMMENT 'First Failure',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Expiration Lock Dates',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Admin User Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_user`
--

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminnotification_inbox`
--

DROP TABLE IF EXISTS `adminnotification_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB AUTO_INCREMENT=414 DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminnotification_inbox`
--

LOCK TABLES `adminnotification_inbox` WRITE;
/*!40000 ALTER TABLE `adminnotification_inbox` DISABLE KEYS */;
INSERT INTO `adminnotification_inbox` VALUES (242,4,'2008-07-25 02:24:40','Magento 1.1 Production Version Now Available','We are thrilled to announce the availability of the production release of Magento 1.1. Read more about the release in the Magento Blog.','http://www.magentocommerce.com/blog/comments/magento-11-is-here-1/',0,0),(243,4,'2008-08-02 02:30:16','Updated iPhone Theme is now available','Updated iPhone theme for Magento 1.1 is now available on Magento Connect and for upgrade through your Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/updated-iphone-theme-for-magento-11-is-now-available/',0,0),(244,3,'2008-08-02 02:40:27','Magento version 1.1.2 is now available','Magento version 1.1.2 is now available for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-version-112-is-now-available/',0,0),(245,3,'2008-08-13 18:51:46','Magento version 1.1.3 is now available','Magento version 1.1.3 is now available','http://www.magentocommerce.com/blog/comments/magento-version-113-is-now-available/',0,0),(246,1,'2008-09-02 22:10:31','Magento Version 1.1.4 Security Update Now Available','Magento 1.1.4 Security Update Now Available. If you are using Magento version 1.1.x, we highly recommend upgrading to this version as soon as possible.','http://www.magentocommerce.com/blog/comments/magento-version-114-security-update/',0,0),(247,3,'2008-09-15 23:09:54','Magento version 1.1.5 Now Available','Magento version 1.1.5 Now Available.\n\nThis release includes many bug fixes, a new category manager and a new skin for the default Magento theme.','http://www.magentocommerce.com/blog/comments/magento-version-115-now-available/',0,0),(248,3,'2008-09-17 21:18:35','Magento version 1.1.6 Now Available','Magento version 1.1.6 Now Available.\n\nThis version includes bug fixes for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-116-now-available/',0,0),(249,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(250,3,'2008-11-20 04:31:12','Magento version 1.1.7 Now Available','Magento version 1.1.7 Now Available.\n\nThis version includes over 350 issue resolutions for Magento 1.1.x that are listed in the release notes section, and new functionality that includes:\n\n-Google Website Optimizer integration\n-Google Base integration\n-Scheduled DB logs cleaning option','http://www.magentocommerce.com/blog/comments/magento-version-117-now-available/',0,0),(251,3,'2008-11-27 00:24:50','Magento Version 1.1.8 Now Available','Magento version 1.1.8 now available.\n\nThis version includes some issue resolutions for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-118-now-available/',0,0),(252,3,'2008-12-30 10:45:59','Magento version 1.2.0 is now available for download and upgrade','We are extremely happy to announce the availability of Magento version 1.2.0 for download and upgrade.\n\nThis version includes numerous issue resolutions for Magento version 1.1.x and some highly requested new features such as:\n\n    * Support for Downloadable/Digital Products. \n    * Added Layered Navigation to site search result page.\n    * Improved site search to utilize MySQL fulltext search\n    * Added support for fixed-taxes on product level.\n    * Upgraded Zend Framework to the latest stable version 1.7.2','http://www.magentocommerce.com/blog/comments/magento-version-120-is-now-available/',0,0),(253,2,'2008-12-31 00:59:22','Magento version 1.2.0.1 now available','Magento version 1.2.0.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1201-available/',0,0),(254,2,'2009-01-12 23:41:49','Magento version 1.2.0.2 now available','Magento version 1.2.0.2 is now available for download and upgrade. This version includes an issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1202-now-available/',0,0),(255,3,'2009-01-24 03:25:56','Magento version 1.2.0.3 now available','Magento version 1.2.0.3 is now available for download and upgrade. This version includes issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1203-now-available/',0,0),(256,3,'2009-02-03 00:57:00','Magento version 1.2.1 is now available for download and upgrade','We are happy to announce the availability of Magento version 1.2.1 for download and upgrade.\n\nThis version includes some issue resolutions for Magento version 1.2.x. A full list of items included in this release can be found on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-121-now-available/',0,0),(257,3,'2009-02-24 03:45:47','Magento version 1.2.1.1 now available','Magento version 1.2.1.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1211-now-available/',0,0),(258,3,'2009-02-27 04:39:24','CSRF Attack Prevention','We have just posted a blog entry about a hypothetical CSRF attack on a Magento admin panel. Please read the post to find out if your Magento installation is at risk at http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/','http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/',0,0),(259,2,'2009-03-04 02:03:58','Magento version 1.2.1.2 now available','Magento version 1.2.1.2 is now available for download and upgrade.\nThis version includes some updates to improve admin security as described in the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-1212-now-available/',0,0),(260,3,'2009-03-31 03:22:40','Magento version 1.3.0 now available','Magento version 1.3.0 is now available for download and upgrade. This version includes numerous issue resolutions for Magento version 1.2.x and new features as described on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-130-is-now-available/',0,0),(261,3,'2009-04-18 05:06:02','Magento version 1.3.1 now available','Magento version 1.3.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and new features such as Checkout By Amazon and Amazon Flexible Payment. To see a full list of updates please check the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-131-now-available/',0,0),(262,3,'2009-05-19 23:31:21','Magento version 1.3.1.1 now available','Magento version 1.3.1.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and a security update for Magento installations that run on multiple domains or sub-domains. If you are running Magento with multiple domains or sub-domains we highly recommend upgrading to this version.','http://www.magentocommerce.com/blog/comments/magento-version-1311-now-available/',0,0),(263,3,'2009-05-29 23:54:06','Magento version 1.3.2 now available','This version includes some improvements and issue resolutions for version 1.3.x that are listed on the release notes page. also included is a Beta version of the Compile module.','http://www.magentocommerce.com/blog/comments/magento-version-132-now-available/',0,0),(264,3,'2009-06-01 20:32:52','Magento version 1.3.2.1 now available','Magento version 1.3.2.1 now available for download and upgrade.\n\nThis release solves an issue for users running Magento with PHP 5.2.0, and changes to index.php to support the new Compiler Module.','http://www.magentocommerce.com/blog/comments/magento-version-1321-now-available/',0,0),(265,3,'2009-07-02 02:21:44','Magento version 1.3.2.2 now available','Magento version 1.3.2.2 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1322-now-available/',0,0),(266,3,'2009-07-23 07:48:54','Magento version 1.3.2.3 now available','Magento version 1.3.2.3 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. We recommend to upgrade to this version if PayPal payment modules are in use. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1323-now-available/',0,0),(267,4,'2009-08-28 19:26:28','PayPal is updating Payflow Pro and Website Payments Pro (Payflow Edition) UK.','If you are using Payflow Pro and/or Website Payments Pro (Payflow Edition) UK.  payment methods, you will need to update the URLâ€˜s in your Magento Administrator Panel in order to process transactions after September 1, 2009. Full details are available here: http://www.magentocommerce.com/wiki/paypal_payflow_changes','http://www.magentocommerce.com/wiki/paypal_payflow_changes',0,0),(268,2,'2009-09-23 21:16:49','Magento Version 1.3.2.4 Security Update','Magento Version 1.3.2.4 is now available. This version includes a security updates for Magento 1.3.x that solves possible XSS vulnerability issue on customer registration page and is available through SVN, Download Page and through the Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-version-1324-security-update/',0,0),(269,4,'2009-09-25 15:57:54','Magento Preview Version 1.4.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha2-now-available/',0,0),(270,4,'2009-10-07 01:55:40','Magento Preview Version 1.4.0.0-alpha3 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha3 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha3-now-available/',0,0),(271,4,'2009-12-09 02:30:36','Magento Preview Version 1.4.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-beta1-now-available/',0,0),(272,4,'2009-12-31 12:22:12','Magento Preview Version 1.4.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-rc1-now-available/',0,0),(273,4,'2010-02-13 06:39:53','Magento CE Version 1.4.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.0.0 Stable for upgrade and download.','http://bit.ly/c53rpK',0,0),(274,3,'2010-02-20 05:39:36','Magento CE Version 1.4.0.1 Stable is now available','Magento CE 1.4.0.1 Stable is now available for upgrade and download.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1401-stable-now-available/',0,0),(275,4,'2010-04-23 21:09:03','Magento Version CE 1.3.3.0 Stable - Now Available With Support for 3-D Secure','Based on community requests, we are excited to announce the release of Magento CE 1.3.3.0-Stable with support for 3-D Secure. This release is intended for Magento merchants using version 1.3.x, who want to add support for 3-D Secure.','http://www.magentocommerce.com/blog/comments/magento-version-ce-1330-stable-now-available-with-support-for-3-d-secure/',0,0),(276,4,'2010-05-31 18:20:21','Announcing the Launch of Magento Mobile','The Magento team is pleased to announce the launch of Magento mobile, a new product that will allow Magento merchants to easily create branded, native mobile storefront applications that are deeply integrated with Magentoâ€™s market-leading eCommerce platform. The product includes a new administrative manager, a native iPhone app that is fully customizable, and a service where Magento manages the submission and maintenance process for the iTunes App Store.\n\nLearn more by visiting the Magento mobile product page and sign-up to be the first to launch a native mobile commerce app, fully integrated with Magento.','http://www.magentocommerce.com/product/mobile',0,0),(277,4,'2010-06-10 21:08:08','Magento CE Version 1.4.1.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.0 Stable for upgrade and download. Some of the highlights of this release include: Enhanced PayPal integration (more info to follow), Change of Database structure of the Sales module to no longer use EAV, and much more.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1410-stable-now-available/',0,0),(278,4,'2010-07-26 22:37:34','Magento CE Version 1.4.1.1 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-now-available/',0,0),(279,4,'2010-07-28 06:12:12','Magento CE Version 1.4.2.0-beta1 Preview Release Now Available','This release gives a preview of the new Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-beta1-now-available/',0,0),(280,4,'2010-07-28 21:15:01','Magento CE Version 1.4.1.1 Patch Available','As some users experienced issues with upgrading to CE 1.4.1.1 through PEAR channels we provided a patch for it that is available on our blog http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/',0,0),(281,4,'2010-10-12 01:13:25','Magento Mobile is now live!','Magento Mobile is now live! Signup today to have your own native iPhone mobile-shopping app in iTunes for the holiday season! Learn more at http://www.magentomobile.com/','http://www.magentomobile.com/',0,0),(282,4,'2010-11-09 00:52:06','Magento CE Version 1.4.2.0-RC1 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC1 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc1-now-available/',0,0),(283,4,'2010-12-02 23:33:00','Magento CE Version 1.4.2.0-RC2 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC2 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc2-now-available/',0,0),(284,4,'2010-12-09 01:29:55','Magento CE Version 1.4.2.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1420-stable-now-available/',0,0),(285,4,'2010-12-18 02:23:55','Magento Preview Version CE 1.5.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha1-now-available/',0,0),(286,4,'2010-12-30 02:51:08','Magento Preview Version CE 1.5.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha2-now-available/',0,0),(287,4,'2011-01-14 03:35:36','Magento Preview Version CE 1.5.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta1-now-available/',0,0),(288,4,'2011-01-22 00:19:09','Magento Preview Version CE 1.5.0.0-beta2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta2-now-available/',0,0),(289,4,'2011-01-28 00:27:57','Magento Preview Version CE 1.5.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc1-now-available/',0,0),(290,4,'2011-02-04 00:56:33','Magento Preview Version CE 1.5.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc2-now-available/',0,0),(291,4,'2011-02-08 22:43:23','Magento CE Version 1.5.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.5.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-community-professional-and-enterprise-editions-releases-now-availab/',0,0),(292,4,'2011-02-10 02:42:57','Magento CE 1.5.0.1 stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.0.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-1501-stable-now-available/',0,0),(293,4,'2011-03-18 22:15:45','Magento CE 1.5.1.0-beta1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-beta1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-beta1-now-available/',0,0),(294,4,'2011-03-31 19:43:02','Magento CE 1.5.1.0-rc1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-rc1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-rc1-now-available/',0,0),(295,4,'2011-04-26 20:21:07','Magento CE 1.5.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1510-stable-now-available/',0,0),(296,4,'2011-05-26 20:33:23','Magento Preview Version CE 1.6.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-alpha1-now-available/',0,0),(297,4,'2011-06-15 19:12:08','Magento Preview Version CE 1.6.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-beta1for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-beta1-now-available/',0,0),(298,4,'2011-06-30 20:03:58','Magento Preview Version CE 1.6.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc1-now-available/',0,0),(299,4,'2011-07-11 20:07:39','Magento Preview Version CE 1.6.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc2-now-available/',0,0),(300,4,'2011-08-19 18:58:31','Magento CE 1.6.0.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1600-stable-now-available/',0,0),(301,4,'2011-09-17 02:31:26','Magento Preview Version CE 1.6.1.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-beta1-now-available/',0,0),(302,4,'2011-09-29 16:44:10','Magento Preview Version CE 1.6.1.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-rc1-now-available/',0,0),(303,4,'2011-10-19 18:50:05','Magento CE 1.6.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1610-stable-now-available/',0,0),(304,4,'2011-12-30 20:39:35','Magento Preview Version CE 1.7.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-alpha1-now-available/',0,0),(305,4,'2012-01-11 20:24:20','Magento CE 1.6.2.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1620-stable-now-available/',0,0),(306,4,'2012-03-02 22:54:12','Magento Preview Version CE 1.7.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-beta1-now-available/',0,0),(307,4,'2012-04-23 11:02:40','Magento Community Preview Version CE 1.7.0.0-RC1 has been released!','Learn more about the exciting new features and updates in this release and how you can take it for a test drive. As this is a preview version, we need to stress that it\'s likely unstable and that we DON\'T recommend that you use it in any production environment just yet.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-rc1-now-available/',0,0),(308,4,'2012-05-11 06:46:54','Magento Community 1.7 and Magento Enterprise 1.12 now available!','Learn more about the exciting new features and updates in these releases.','http://www.magentocommerce.com/blog/comments/magento-enterprise-112-and-community-17-now-available/',0,0),(309,4,'2012-06-20 15:54:07','Magento Community Edition 1.7.0.1 now available! ','We have just released an updated version of Magento Community Edition, version 1.7.0.1. This update delivers new, minor functionality and fixes for some potential security vulnerabilities.','http://www.magentocommerce.com/blog/comments/magento-community-edition-1701-released/',0,0),(310,4,'2012-07-05 16:21:43','Important Security Update - Zend Platform Vulnerability','We have recently learned of a serious vulnerability in the Zend platform on which Magento is built. Learn more and access a patch that addresses this issue. ','http://www.magentocommerce.com/blog/comments/important-security-update-zend-platform-vulnerability/',0,0),(311,4,'2012-11-19 18:27:42','Wrap up more holiday sales with financing','Give your customers up to 6 months financing. You get paid right away with Bill Me Later, a PayPal service. It’s a great way to extend financing in time for the holidays. Learn More.','http://www.magentocommerce.com/paypal/billmelater?utm_source=CEMessaging&utm_medium=copy&utm_content=sixmonths&utm_campaign=BML',0,0),(312,4,'2012-12-07 09:22:30','Increase Your Sales With PayPal','Magento merchants using PayPal Express Checkout can help increase their sales on average 18%. It is one simple thing you can do right now to help boost your sales. Learn more.','http://www.magentocommerce.com/add-paypal?utm_source=CEModule&utm_medium=copy&utm_content=18&utm_campaign=choosepaypal',0,0),(313,4,'2013-01-15 20:02:07','Imagine 2013 Registration is Now Open!','Join 1500 merchants, partners, developers and enthusiasts from 35+ countries around the world for Magento’s premier global conference! Collaborate, learn, network and get inspired by the future of eCommerce. Tickets will sell out fast! April 8th – 10th in Las Vegas.','https://registration.imagineecommerce.com/',0,0),(314,4,'2013-02-12 15:53:42','Get More eCommerce Power with Magento Enterprise','Limited time offer: Get a free, customized evaluation of your Community Edition site from a Magento Solution Partner. This evaluation gives you a clear look at the numerous benefits you can achieve by upgrading to Enterprise Edition. ','http://www.magentocommerce.com/community-to-enterprise?utm_source=CEMM&utm_medium=copy&utm_campaign=CE2EE',0,0),(315,2,'2013-09-27 14:28:13','Magento Community Edition 1.8.0.0 - now available for download!','Get tax, security, performance, and many other improvements. \n\nLearn more at http://www.magentocommerce.com/blog/comments/magento-community-edition-one-eight-now-available/ ','http://www.magentocommerce.com/blog/comments/magento-community-edition-one-eight-now-available/',0,0),(316,4,'2013-12-11 13:35:06','Magento Community Edition 1.8.1.0 is here!','This new version offers significant tax calculation, product quality, and security enhancements. Be sure to carefully review the upgrade instructions before starting. More information is available at http://www.magentocommerce.com/blog/comments/magento-community-edition-1810-is-here/','http://www.magentocommerce.com/blog/comments/magento-community-edition-1810-is-here/',0,0),(317,4,'2013-12-12 21:24:39','Important Magento Community Edition Patch','A security patch is available for Magento Community Edition 1.4.0.0 through 1.7.0.2; the issue has been fixed in Magento Community Edition 1.8.0.0 and later. It resolves a vulnerability discovered through our quarterly penetration testing process and has not been reported by merchants. We encourage all merchants to apply the patch in their next regularly scheduled maintenance cycle. The patch is available at http://www.magentocommerce.com/download in the Magento Community Edition Patches section.','http://www.magentocommerce.com/download',0,0),(318,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(319,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(320,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(321,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(322,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(323,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(324,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(325,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(326,4,'2014-01-21 16:34:48','PHP 5.4 Patch Now Available','Magento is advancing its platform and making development more efficient by adding support for PHP 5.4. Patches are available for download at www.magentocommerce.com/download and you can learn more about this update in our blog post at http://www.magentocommerce.com/blog/comments/magento-now-supports-php-54 .','http://www.magentocommerce.com/blog/comments/magento-now-supports-php-54',0,0),(327,4,'2014-02-03 14:14:54','Imagine 2014 Registration is Open','Register today to join us May 12-14 at the Hard Rock Hotel in Las Vegas for Imagine 2014, Magento\'s annual conference.\n\nEarly-bird registration pricing ends February 17 so don’t delay!\n\nhttp://www.imagineecommerce.com?utm_source=magento&utm_medium=cerss&utm_campaign=registrationopen\n\n','http://www.imagineecommerce.com?utm_source=magento&utm_medium=cerss&utm_campaign=registrationopen',1,0),(328,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(329,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(330,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(331,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(332,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(333,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(334,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(335,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(336,4,'2014-02-20 15:51:46','Discover Card Validation Patch Available','A patch that resolves an issue with validating Discover credit cards is now available for download at http://www.magentocommerce.com/download. More information on the patch is available in the Magento Knowledge Base at http://www.magentocommerce.com/knowledge-base/entry/discover-card-validation','http://www.magentocommerce.com/knowledge-base/entry/discover-card-validation ',1,0),(337,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(338,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(339,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(340,4,'2014-03-04 23:12:26','Learn How to Quickly Increase Sales on Your Site','Adding the PayPal Express Checkout button to your checkout page can help increase sales 18% on average. It’s fast and easy and you can do it right now to boost sales. Express Checkout is already seamlessly integrated into Community Edition.','http://magento.com/paypal/CE_Express_Checkout_NA?utm_source=messagemodule&utm_medium=message&utm_campaign=Ceexpresscheckout',1,0),(341,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(342,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(343,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(344,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(345,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(346,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(347,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(348,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(349,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(350,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(351,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(352,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(353,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(354,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(355,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(356,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(357,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(358,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(359,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(360,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(361,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(362,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(363,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(364,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(365,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(366,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(367,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(368,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(369,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(370,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(371,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(372,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(373,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(374,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(375,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(376,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(377,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(378,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(379,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(380,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(381,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(382,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(383,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(384,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(385,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(386,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(387,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(388,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(389,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(390,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(391,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(392,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(393,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(394,4,'2008-11-08 12:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(395,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(396,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(397,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(398,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(399,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(400,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(401,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(402,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(403,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(404,4,'2014-05-13 16:46:11','Magento Community Edition 1.9 is now available!','It accelerates your entry into the mobile commerce space by slashing the time and cost of getting a mobile device-friendly responsive site.  And a new Bill Me Later payment option helps boost your sales. Visit http://magento.com/blog/magento-news/magento-enables-responsive-sites-half-time to learn more.','http://magento.com/blog/magento-news/magento-enables-responsive-sites-half-time',0,0),(405,4,'2014-10-08 04:55:06','It’s still not too late: Boost your 2014 Holiday sales today.','See results in as little as one week with eBay Enterprise Display and 2 business days with eBay Enterprise Affiliate. DID YOU KNOW: Get access to over 128 million highly qualified shoppers on eBay.com with eBay Enterprise Display. And the average retail client using product retargeting sees a $10 to $1 ROI on retargeting spend during Q4. With the eBay Enterprise Affiliate Network, get access to over 200,000 active network publishers across 30+ verticals, and only pay when a customer makes a purchase (Affiliate Network is only available in the U.S. & Canada).  GET STARTED TODAY by visiting www.ebayenterprise.com/turbochargesales','http://www.ebayenterprise.com/turbochargesales',0,0),(406,4,'2014-11-12 19:03:26','Important: PayPal Users Must Discontinue Using SSL 3.0 By December 3, 2014','To address a vulnerability with the SSL 3.0 security protocol, PayPal and other payment gateways will be disabling SSL 3.0 support. Merchants must upgrade to Transport Layer Service (TLS) by December 3, 2014 to avoid PayPal payment operation failures. Learn more about what you need to do at https://devblog.paypal.com/poodle-ssl-3-0-vulnerability/','https://devblog.paypal.com/poodle-ssl-3-0-vulnerability/',0,0),(407,4,'2014-11-24 23:25:21','Magento Community Edition 1.9.1 is available!','Magento Community Edition 1.9.1 empowers merchants to deliver compelling shopping experiences by offering enhanced responsive design capabilities, new swatches to display product variations, and improved performance through support for MySQL 5.6 and PHP 5.5. It also includes support for Google Universal Analytics and over 70 product improvements. Find out more at http://magento.com/blog/magento-news/magento-community-edition-191-now-available-download','http://magento.com/blog/magento-news/magento-community-edition-191-now-available-download',0,0),(408,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(409,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(410,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(411,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(412,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(413,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0);
/*!40000 ALTER TABLE `adminnotification_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api2_acl_attribute`
--

DROP TABLE IF EXISTS `api2_acl_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api2_acl_attribute`
--

LOCK TABLES `api2_acl_attribute` WRITE;
/*!40000 ALTER TABLE `api2_acl_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `api2_acl_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api2_acl_role`
--

DROP TABLE IF EXISTS `api2_acl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api2_acl_role`
--

LOCK TABLES `api2_acl_role` WRITE;
/*!40000 ALTER TABLE `api2_acl_role` DISABLE KEYS */;
INSERT INTO `api2_acl_role` VALUES (1,'2013-01-14 10:12:41',NULL,'Guest'),(2,'2013-01-14 10:12:41',NULL,'Customer');
/*!40000 ALTER TABLE `api2_acl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api2_acl_rule`
--

DROP TABLE IF EXISTS `api2_acl_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`),
  CONSTRAINT `FK_API2_ACL_RULE_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api2_acl_rule`
--

LOCK TABLES `api2_acl_rule` WRITE;
/*!40000 ALTER TABLE `api2_acl_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `api2_acl_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api2_acl_user`
--

DROP TABLE IF EXISTS `api2_acl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` (`role_id`),
  CONSTRAINT `FK_API2_ACL_USER_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api2_acl_user`
--

LOCK TABLES `api2_acl_user` WRITE;
/*!40000 ALTER TABLE `api2_acl_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `api2_acl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_assert`
--

DROP TABLE IF EXISTS `api_assert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_assert`
--

LOCK TABLES `api_assert` WRITE;
/*!40000 ALTER TABLE `api_assert` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_assert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_role`
--

DROP TABLE IF EXISTS `api_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_role`
--

LOCK TABLES `api_role` WRITE;
/*!40000 ALTER TABLE `api_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_rule`
--

DROP TABLE IF EXISTS `api_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_API_RULE_ROLE_ID_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_rule`
--

LOCK TABLES `api_rule` WRITE;
/*!40000 ALTER TABLE `api_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_session`
--

DROP TABLE IF EXISTS `api_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_API_SESSION_SESSID` (`sessid`),
  CONSTRAINT `FK_API_SESSION_USER_ID_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_session`
--

LOCK TABLES `api_session` WRITE;
/*!40000 ALTER TABLE `api_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_user`
--

DROP TABLE IF EXISTS `api_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(100) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_user`
--

LOCK TABLES `api_user` WRITE;
/*!40000 ALTER TABLE `api_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_log`
--

DROP TABLE IF EXISTS `captcha_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_log`
--

LOCK TABLES `captcha_log` WRITE;
/*!40000 ALTER TABLE `captcha_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `captcha_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_anc_categs_index_idx`
--

DROP TABLE IF EXISTS `catalog_category_anc_categs_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_anc_categs_index_idx`
--

LOCK TABLES `catalog_category_anc_categs_index_idx` WRITE;
/*!40000 ALTER TABLE `catalog_category_anc_categs_index_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_anc_categs_index_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_anc_categs_index_tmp`
--

DROP TABLE IF EXISTS `catalog_category_anc_categs_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_anc_categs_index_tmp`
--

LOCK TABLES `catalog_category_anc_categs_index_tmp` WRITE;
/*!40000 ALTER TABLE `catalog_category_anc_categs_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_anc_categs_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_anc_products_index_idx`
--

DROP TABLE IF EXISTS `catalog_category_anc_products_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_IDX_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_anc_products_index_idx`
--

LOCK TABLES `catalog_category_anc_products_index_idx` WRITE;
/*!40000 ALTER TABLE `catalog_category_anc_products_index_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_anc_products_index_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_anc_products_index_tmp`
--

DROP TABLE IF EXISTS `catalog_category_anc_products_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_TMP_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_anc_products_index_tmp`
--

LOCK TABLES `catalog_category_anc_products_index_tmp` WRITE;
/*!40000 ALTER TABLE `catalog_category_anc_products_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_anc_products_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_entity`
--

DROP TABLE IF EXISTS `catalog_category_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_PATH_ENTITY_ID` (`path`,`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_entity`
--

--
-- Table structure for table `catalog_category_entity_datetime`
--

DROP TABLE IF EXISTS `catalog_category_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DTIME_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_entity_decimal`
--

DROP TABLE IF EXISTS `catalog_category_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_entity_int`
--

DROP TABLE IF EXISTS `catalog_category_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_entity_text`
--

DROP TABLE IF EXISTS `catalog_category_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=911 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_entity_varchar`
--

DROP TABLE IF EXISTS `catalog_category_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1071 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_flat_store_1`
--

DROP TABLE IF EXISTS `catalog_category_flat_store_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_flat_store_1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entity_id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parent_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'updated_at',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'path',
  `position` int(11) NOT NULL COMMENT 'position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'level',
  `children_count` int(11) NOT NULL COMMENT 'children_count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `all_children` text COMMENT 'All Children',
  `available_sort_by` text COMMENT 'Available Product Listing Sort By',
  `children` text COMMENT 'Children',
  `custom_apply_to_products` int(11) DEFAULT NULL COMMENT 'Apply To Products',
  `custom_design` varchar(255) DEFAULT NULL COMMENT 'Custom Design',
  `custom_design_from` datetime DEFAULT NULL COMMENT 'Active From',
  `custom_design_to` datetime DEFAULT NULL COMMENT 'Active To',
  `custom_layout_update` text COMMENT 'Custom Layout Update',
  `custom_use_parent_settings` int(11) DEFAULT NULL COMMENT 'Use Parent Category Settings',
  `default_sort_by` varchar(255) DEFAULT NULL COMMENT 'Default Product Listing Sort By',
  `description` text COMMENT 'Description',
  `display_mode` varchar(255) DEFAULT NULL COMMENT 'Display Mode',
  `filter_price_range` decimal(12,4) DEFAULT NULL COMMENT 'Layered Navigation Price Step',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `include_in_menu` int(11) DEFAULT NULL COMMENT 'Include in Navigation Menu',
  `is_active` int(11) DEFAULT NULL COMMENT 'Is Active',
  `is_anchor` int(11) DEFAULT NULL COMMENT 'Is Anchor',
  `landing_page` int(11) DEFAULT NULL COMMENT 'CMS Block',
  `meta_description` text COMMENT 'Meta Description',
  `meta_keywords` text COMMENT 'Meta Keywords',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `path_in_store` text COMMENT 'Path In Store',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Image',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'URL Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_1_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_1_PATH` (`path`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_1_LEVEL` (`level`),
  CONSTRAINT `FK_CATALOG_CATEGORY_FLAT_STORE_1_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_FLAT_STORE_1_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Flat (Store 1)';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_flat_store_2`
--

DROP TABLE IF EXISTS `catalog_category_flat_store_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_flat_store_2` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entity_id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parent_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'updated_at',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'path',
  `position` int(11) NOT NULL COMMENT 'position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'level',
  `children_count` int(11) NOT NULL COMMENT 'children_count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `all_children` text COMMENT 'All Children',
  `available_sort_by` text COMMENT 'Available Product Listing Sort By',
  `children` text COMMENT 'Children',
  `custom_apply_to_products` int(11) DEFAULT NULL COMMENT 'Apply To Products',
  `custom_design` varchar(255) DEFAULT NULL COMMENT 'Custom Design',
  `custom_design_from` datetime DEFAULT NULL COMMENT 'Active From',
  `custom_design_to` datetime DEFAULT NULL COMMENT 'Active To',
  `custom_layout_update` text COMMENT 'Custom Layout Update',
  `custom_use_parent_settings` int(11) DEFAULT NULL COMMENT 'Use Parent Category Settings',
  `default_sort_by` varchar(255) DEFAULT NULL COMMENT 'Default Product Listing Sort By',
  `description` text COMMENT 'Description',
  `display_mode` varchar(255) DEFAULT NULL COMMENT 'Display Mode',
  `filter_price_range` decimal(12,4) DEFAULT NULL COMMENT 'Layered Navigation Price Step',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `include_in_menu` int(11) DEFAULT NULL COMMENT 'Include in Navigation Menu',
  `is_active` int(11) DEFAULT NULL COMMENT 'Is Active',
  `is_anchor` int(11) DEFAULT NULL COMMENT 'Is Anchor',
  `landing_page` int(11) DEFAULT NULL COMMENT 'CMS Block',
  `meta_description` text COMMENT 'Meta Description',
  `meta_keywords` text COMMENT 'Meta Keywords',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `path_in_store` text COMMENT 'Path In Store',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Image',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'URL Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_2_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_2_PATH` (`path`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_2_LEVEL` (`level`),
  CONSTRAINT `FK_CATALOG_CATEGORY_FLAT_STORE_2_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_FLAT_STORE_2_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Flat (Store 2)';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_flat_store_3`
--

DROP TABLE IF EXISTS `catalog_category_flat_store_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_flat_store_3` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entity_id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parent_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'updated_at',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'path',
  `position` int(11) NOT NULL COMMENT 'position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'level',
  `children_count` int(11) NOT NULL COMMENT 'children_count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `all_children` text COMMENT 'All Children',
  `available_sort_by` text COMMENT 'Available Product Listing Sort By',
  `children` text COMMENT 'Children',
  `custom_apply_to_products` int(11) DEFAULT NULL COMMENT 'Apply To Products',
  `custom_design` varchar(255) DEFAULT NULL COMMENT 'Custom Design',
  `custom_design_from` datetime DEFAULT NULL COMMENT 'Active From',
  `custom_design_to` datetime DEFAULT NULL COMMENT 'Active To',
  `custom_layout_update` text COMMENT 'Custom Layout Update',
  `custom_use_parent_settings` int(11) DEFAULT NULL COMMENT 'Use Parent Category Settings',
  `default_sort_by` varchar(255) DEFAULT NULL COMMENT 'Default Product Listing Sort By',
  `description` text COMMENT 'Description',
  `display_mode` varchar(255) DEFAULT NULL COMMENT 'Display Mode',
  `filter_price_range` decimal(12,4) DEFAULT NULL COMMENT 'Layered Navigation Price Step',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `include_in_menu` int(11) DEFAULT NULL COMMENT 'Include in Navigation Menu',
  `is_active` int(11) DEFAULT NULL COMMENT 'Is Active',
  `is_anchor` int(11) DEFAULT NULL COMMENT 'Is Anchor',
  `landing_page` int(11) DEFAULT NULL COMMENT 'CMS Block',
  `meta_description` text COMMENT 'Meta Description',
  `meta_keywords` text COMMENT 'Meta Keywords',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `path_in_store` text COMMENT 'Path In Store',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Image',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'URL Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_3_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_3_PATH` (`path`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_3_LEVEL` (`level`),
  CONSTRAINT `FK_CATALOG_CATEGORY_FLAT_STORE_3_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_FLAT_STORE_3_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Flat (Store 3)';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_flat_store_4`
--

DROP TABLE IF EXISTS `catalog_category_flat_store_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_flat_store_4` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entity_id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parent_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'updated_at',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'path',
  `position` int(11) NOT NULL COMMENT 'position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'level',
  `children_count` int(11) NOT NULL COMMENT 'children_count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `all_children` text COMMENT 'All Children',
  `available_sort_by` text COMMENT 'Available Product Listing Sort By',
  `children` text COMMENT 'Children',
  `custom_apply_to_products` int(11) DEFAULT NULL COMMENT 'Apply To Products',
  `custom_design` varchar(255) DEFAULT NULL COMMENT 'Custom Design',
  `custom_design_from` datetime DEFAULT NULL COMMENT 'Active From',
  `custom_design_to` datetime DEFAULT NULL COMMENT 'Active To',
  `custom_layout_update` text COMMENT 'Custom Layout Update',
  `custom_use_parent_settings` int(11) DEFAULT NULL COMMENT 'Use Parent Category Settings',
  `default_sort_by` varchar(255) DEFAULT NULL COMMENT 'Default Product Listing Sort By',
  `description` text COMMENT 'Description',
  `display_mode` varchar(255) DEFAULT NULL COMMENT 'Display Mode',
  `filter_price_range` decimal(12,4) DEFAULT NULL COMMENT 'Layered Navigation Price Step',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `include_in_menu` int(11) DEFAULT NULL COMMENT 'Include in Navigation Menu',
  `is_active` int(11) DEFAULT NULL COMMENT 'Is Active',
  `is_anchor` int(11) DEFAULT NULL COMMENT 'Is Anchor',
  `landing_page` int(11) DEFAULT NULL COMMENT 'CMS Block',
  `meta_description` text COMMENT 'Meta Description',
  `meta_keywords` text COMMENT 'Meta Keywords',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `path_in_store` text COMMENT 'Path In Store',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Image',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'URL Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_4_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_4_PATH` (`path`),
  KEY `IDX_CATALOG_CATEGORY_FLAT_STORE_4_LEVEL` (`level`),
  CONSTRAINT `FK_CATALOG_CATEGORY_FLAT_STORE_4_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_FLAT_STORE_4_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Flat (Store 4)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_category_product`
--

DROP TABLE IF EXISTS `catalog_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_category_product_index`
--

DROP TABLE IF EXISTS `catalog_category_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `15D3C269665C74C2219037D534F4B0DC` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`),
  CONSTRAINT `FK_CATALOG_CATEGORY_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_category_product_index_enbl_idx`
--

DROP TABLE IF EXISTS `catalog_category_product_index_enbl_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_IDX_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_product_index_enbl_idx`
--

LOCK TABLES `catalog_category_product_index_enbl_idx` WRITE;
/*!40000 ALTER TABLE `catalog_category_product_index_enbl_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_product_index_enbl_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_product_index_enbl_tmp`
--

DROP TABLE IF EXISTS `catalog_category_product_index_enbl_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_TMP_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_category_product_index_idx`
--

DROP TABLE IF EXISTS `catalog_category_product_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_compare_item`
--

DROP TABLE IF EXISTS `catalog_compare_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CMP_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_eav_attribute`
--

DROP TABLE IF EXISTS `catalog_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  `search_weight` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Search Weight',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_CATALOG_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_bundle_option`
--

DROP TABLE IF EXISTS `catalog_product_bundle_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_bundle_option_value`
--

DROP TABLE IF EXISTS `catalog_product_bundle_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_bundle_price_index`
--

DROP TABLE IF EXISTS `catalog_product_bundle_price_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_bundle_selection`
--

DROP TABLE IF EXISTS `catalog_product_bundle_selection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_bundle_selection_price`
--

DROP TABLE IF EXISTS `catalog_product_bundle_selection_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_bundle_stock_index`
--

DROP TABLE IF EXISTS `catalog_product_bundle_stock_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_enabled_index`
--

DROP TABLE IF EXISTS `catalog_product_enabled_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENABLED_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_entity`
--

DROP TABLE IF EXISTS `catalog_product_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  CONSTRAINT `FK_CAT_PRD_ENTT_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=906 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_datetime`
--

DROP TABLE IF EXISTS `catalog_product_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13419 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_entity_datetime`
--

LOCK TABLES `catalog_product_entity_datetime` WRITE;
/*!40000 ALTER TABLE `catalog_product_entity_datetime` DISABLE KEYS */;
INSERT INTO `catalog_product_entity_datetime` VALUES (2273,4,104,0,231,NULL),(2274,4,105,0,231,NULL),(2275,4,93,0,231,NULL),(2276,4,94,0,231,NULL),(2277,4,77,0,231,NULL),(2278,4,78,0,231,NULL),(2279,4,104,0,232,NULL),(2280,4,105,0,232,NULL),(2281,4,93,0,232,NULL),(2282,4,94,0,232,NULL),(2283,4,77,0,232,NULL),(2284,4,78,0,232,NULL),(2285,4,104,0,233,NULL),(2286,4,105,0,233,NULL),(2287,4,93,0,233,NULL),(2288,4,94,0,233,NULL),(2289,4,77,0,233,NULL),(2290,4,78,0,233,NULL),(2291,4,104,0,234,NULL),(2292,4,105,0,234,NULL),(2293,4,93,0,234,NULL),(2294,4,94,0,234,NULL),(2295,4,77,0,234,NULL),(2296,4,78,0,234,NULL),(2297,4,104,0,235,NULL),(2298,4,105,0,235,NULL),(2299,4,93,0,235,NULL),(2300,4,94,0,235,NULL),(2301,4,77,0,235,NULL),(2302,4,78,0,235,NULL),(2303,4,104,0,236,NULL),(2304,4,105,0,236,NULL),(2305,4,93,0,236,NULL),(2306,4,94,0,236,NULL),(2307,4,77,0,236,NULL),(2308,4,78,0,236,NULL),(2309,4,104,0,237,NULL),(2310,4,105,0,237,NULL),(2311,4,93,0,237,NULL),(2312,4,94,0,237,NULL),(2313,4,77,0,237,NULL),(2314,4,78,0,237,NULL),(2315,4,104,0,238,NULL),(2316,4,105,0,238,NULL),(2317,4,93,0,238,NULL),(2318,4,94,0,238,NULL),(2319,4,77,0,238,NULL),(2320,4,78,0,238,NULL),(2321,4,104,0,239,NULL),(2322,4,105,0,239,NULL),(2323,4,93,0,239,NULL),(2324,4,94,0,239,NULL),(2325,4,77,0,239,NULL),(2326,4,78,0,239,NULL),(2327,4,104,0,240,NULL),(2328,4,105,0,240,NULL),(2329,4,93,0,240,NULL),(2330,4,94,0,240,NULL),(2331,4,77,0,240,NULL),(2332,4,78,0,240,NULL),(2333,4,104,0,241,NULL),(2334,4,105,0,241,NULL),(2335,4,93,0,241,NULL),(2336,4,94,0,241,NULL),(2337,4,77,0,241,NULL),(2338,4,78,0,241,NULL),(2339,4,104,0,242,NULL),(2340,4,105,0,242,NULL),(2341,4,93,0,242,NULL),(2342,4,94,0,242,NULL),(2343,4,77,0,242,NULL),(2344,4,78,0,242,NULL),(2345,4,104,0,243,NULL),(2346,4,105,0,243,NULL),(2347,4,93,0,243,NULL),(2348,4,94,0,243,NULL),(2349,4,77,0,243,NULL),(2350,4,78,0,243,NULL),(2351,4,104,0,244,NULL),(2352,4,105,0,244,NULL),(2353,4,93,0,244,NULL),(2354,4,94,0,244,NULL),(2355,4,77,0,244,NULL),(2356,4,78,0,244,NULL),(2357,4,104,0,245,NULL),(2358,4,105,0,245,NULL),(2359,4,93,0,245,NULL),(2360,4,94,0,245,NULL),(2361,4,77,0,245,NULL),(2362,4,78,0,245,NULL),(2363,4,104,0,246,NULL),(2364,4,105,0,246,NULL),(2365,4,93,0,246,NULL),(2366,4,94,0,246,NULL),(2367,4,77,0,246,NULL),(2368,4,78,0,246,NULL),(2369,4,104,0,247,NULL),(2370,4,105,0,247,NULL),(2371,4,93,0,247,NULL),(2372,4,94,0,247,NULL),(2373,4,77,0,247,NULL),(2374,4,78,0,247,NULL),(2375,4,104,0,248,NULL),(2376,4,105,0,248,NULL),(2377,4,93,0,248,NULL),(2378,4,94,0,248,NULL),(2379,4,77,0,248,NULL),(2380,4,78,0,248,NULL),(2381,4,104,0,249,NULL),(2382,4,105,0,249,NULL),(2383,4,93,0,249,NULL),(2384,4,94,0,249,NULL),(2385,4,77,0,249,NULL),(2386,4,78,0,249,NULL),(2387,4,104,0,250,NULL),(2388,4,105,0,250,NULL),(2389,4,93,0,250,NULL),(2390,4,94,0,250,NULL),(2391,4,77,0,250,NULL),(2392,4,78,0,250,NULL),(2393,4,104,0,251,NULL),(2394,4,105,0,251,NULL),(2395,4,93,0,251,NULL),(2396,4,94,0,251,NULL),(2397,4,77,0,251,NULL),(2398,4,78,0,251,NULL),(2399,4,104,0,252,NULL),(2400,4,105,0,252,NULL),(2401,4,93,0,252,NULL),(2402,4,94,0,252,NULL),(2403,4,77,0,252,NULL),(2404,4,78,0,252,NULL),(2405,4,104,0,253,NULL),(2406,4,105,0,253,NULL),(2407,4,93,0,253,NULL),(2408,4,94,0,253,NULL),(2409,4,77,0,253,NULL),(2410,4,78,0,253,NULL),(2411,4,104,0,254,NULL),(2412,4,105,0,254,NULL),(2413,4,93,0,254,'2013-03-01 00:00:00'),(2414,4,94,0,254,NULL),(2415,4,77,0,254,NULL),(2416,4,78,0,254,NULL),(2417,4,104,0,255,NULL),(2418,4,105,0,255,NULL),(2419,4,93,0,255,'2013-03-01 00:00:00'),(2420,4,94,0,255,NULL),(2421,4,77,0,255,NULL),(2422,4,78,0,255,NULL),(2423,4,104,0,256,NULL),(2424,4,105,0,256,NULL),(2425,4,93,0,256,'2013-03-01 00:00:00'),(2426,4,94,0,256,NULL),(2427,4,77,0,256,NULL),(2428,4,78,0,256,NULL),(2429,4,104,0,257,NULL),(2430,4,105,0,257,NULL),(2431,4,93,0,257,'2013-03-01 00:00:00'),(2432,4,94,0,257,NULL),(2433,4,77,0,257,NULL),(2434,4,78,0,257,NULL),(2435,4,104,0,258,NULL),(2436,4,105,0,258,NULL),(2437,4,93,0,258,'2013-03-01 00:00:00'),(2438,4,94,0,258,NULL),(2439,4,77,0,258,NULL),(2440,4,78,0,258,NULL),(2441,4,104,0,259,NULL),(2442,4,105,0,259,NULL),(2443,4,93,0,259,'2013-03-01 00:00:00'),(2444,4,94,0,259,NULL),(2445,4,77,0,259,NULL),(2446,4,78,0,259,NULL),(2447,4,104,0,260,NULL),(2448,4,105,0,260,NULL),(2449,4,93,0,260,'2013-03-01 00:00:00'),(2450,4,94,0,260,NULL),(2451,4,77,0,260,NULL),(2452,4,78,0,260,NULL),(2453,4,104,0,261,NULL),(2454,4,105,0,261,NULL),(2455,4,93,0,261,'2013-03-01 00:00:00'),(2456,4,94,0,261,NULL),(2457,4,77,0,261,NULL),(2458,4,78,0,261,NULL),(2459,4,104,0,262,NULL),(2460,4,105,0,262,NULL),(2461,4,93,0,262,'2013-03-01 00:00:00'),(2462,4,94,0,262,NULL),(2463,4,77,0,262,NULL),(2464,4,78,0,262,NULL),(2465,4,104,0,263,NULL),(2466,4,105,0,263,NULL),(2467,4,93,0,263,'2013-03-01 00:00:00'),(2468,4,94,0,263,NULL),(2469,4,77,0,263,NULL),(2470,4,78,0,263,NULL),(2489,4,104,0,267,NULL),(2490,4,105,0,267,NULL),(2491,4,93,0,267,'2013-03-01 00:00:00'),(2492,4,94,0,267,NULL),(2493,4,77,0,267,NULL),(2494,4,78,0,267,NULL),(2495,4,104,0,268,NULL),(2496,4,105,0,268,NULL),(2497,4,93,0,268,'2013-03-01 00:00:00'),(2498,4,94,0,268,NULL),(2499,4,77,0,268,NULL),(2500,4,78,0,268,NULL),(2501,4,104,0,269,NULL),(2502,4,105,0,269,NULL),(2503,4,93,0,269,'2013-03-01 00:00:00'),(2504,4,94,0,269,NULL),(2505,4,77,0,269,NULL),(2506,4,78,0,269,NULL),(2507,4,104,0,270,NULL),(2508,4,105,0,270,NULL),(2509,4,93,0,270,'2013-03-01 00:00:00'),(2510,4,94,0,270,NULL),(2511,4,77,0,270,NULL),(2512,4,78,0,270,NULL),(2513,4,104,0,271,NULL),(2514,4,105,0,271,NULL),(2515,4,93,0,271,'2013-03-01 00:00:00'),(2516,4,94,0,271,NULL),(2517,4,77,0,271,NULL),(2518,4,78,0,271,NULL),(2519,4,104,0,272,NULL),(2520,4,105,0,272,NULL),(2521,4,93,0,272,'2013-03-01 00:00:00'),(2522,4,94,0,272,NULL),(2523,4,77,0,272,NULL),(2524,4,78,0,272,NULL),(2525,4,104,0,273,NULL),(2526,4,105,0,273,NULL),(2527,4,93,0,273,'2013-03-01 00:00:00'),(2528,4,94,0,273,NULL),(2529,4,77,0,273,NULL),(2530,4,78,0,273,NULL),(2531,4,104,0,274,NULL),(2532,4,105,0,274,NULL),(2533,4,93,0,274,'2013-03-01 00:00:00'),(2534,4,94,0,274,NULL),(2535,4,77,0,274,NULL),(2536,4,78,0,274,NULL),(2537,4,104,0,275,NULL),(2538,4,105,0,275,NULL),(2539,4,93,0,275,'2013-03-01 00:00:00'),(2540,4,94,0,275,NULL),(2541,4,77,0,275,NULL),(2542,4,78,0,275,NULL),(2543,4,104,0,276,NULL),(2544,4,105,0,276,NULL),(2545,4,93,0,276,'2013-03-01 00:00:00'),(2546,4,94,0,276,NULL),(2547,4,77,0,276,NULL),(2548,4,78,0,276,NULL),(2549,4,104,0,277,NULL),(2550,4,105,0,277,NULL),(2551,4,93,0,277,'2013-03-01 00:00:00'),(2552,4,94,0,277,NULL),(2553,4,77,0,277,NULL),(2554,4,78,0,277,NULL),(2555,4,104,0,278,NULL),(2556,4,105,0,278,NULL),(2557,4,93,0,278,'2013-03-01 00:00:00'),(2558,4,94,0,278,NULL),(2559,4,77,0,278,NULL),(2560,4,78,0,278,NULL),(2561,4,104,0,279,NULL),(2562,4,105,0,279,NULL),(2563,4,93,0,279,'2013-03-01 00:00:00'),(2564,4,94,0,279,NULL),(2565,4,77,0,279,NULL),(2566,4,78,0,279,NULL),(2567,4,104,0,280,NULL),(2568,4,105,0,280,NULL),(2569,4,93,0,280,'2013-03-01 00:00:00'),(2570,4,94,0,280,NULL),(2571,4,77,0,280,NULL),(2572,4,78,0,280,NULL),(2573,4,104,0,281,NULL),(2574,4,105,0,281,NULL),(2575,4,93,0,281,'2013-03-01 00:00:00'),(2576,4,94,0,281,NULL),(2577,4,77,0,281,NULL),(2578,4,78,0,281,NULL),(2579,4,104,0,282,NULL),(2580,4,105,0,282,NULL),(2581,4,93,0,282,'2013-03-01 00:00:00'),(2582,4,94,0,282,NULL),(2583,4,77,0,282,NULL),(2584,4,78,0,282,NULL),(2585,4,104,0,283,NULL),(2586,4,105,0,283,NULL),(2587,4,93,0,283,'2013-03-01 00:00:00'),(2588,4,94,0,283,NULL),(2589,4,77,0,283,NULL),(2590,4,78,0,283,NULL),(2591,4,104,0,284,'2013-05-08 00:00:00'),(2592,4,105,0,284,NULL),(2593,4,93,0,284,'2013-05-08 00:00:00'),(2594,4,94,0,284,NULL),(2595,4,77,0,284,'2013-03-05 00:00:00'),(2596,4,78,0,284,NULL),(2597,4,104,0,285,NULL),(2598,4,105,0,285,NULL),(2599,4,93,0,285,'2013-03-01 00:00:00'),(2600,4,94,0,285,NULL),(2601,4,77,0,285,NULL),(2602,4,78,0,285,NULL),(2603,4,104,0,286,NULL),(2604,4,105,0,286,NULL),(2605,4,93,0,286,'2013-03-01 00:00:00'),(2606,4,94,0,286,NULL),(2607,4,77,0,286,NULL),(2608,4,78,0,286,NULL),(2609,4,104,0,287,NULL),(2610,4,105,0,287,NULL),(2611,4,93,0,287,'2013-03-01 00:00:00'),(2612,4,94,0,287,NULL),(2613,4,77,0,287,NULL),(2614,4,78,0,287,NULL),(2615,4,104,0,288,NULL),(2616,4,105,0,288,NULL),(2617,4,93,0,288,'2013-03-01 00:00:00'),(2618,4,94,0,288,NULL),(2619,4,77,0,288,NULL),(2620,4,78,0,288,NULL),(2621,4,104,0,289,NULL),(2622,4,105,0,289,NULL),(2623,4,93,0,289,'2013-03-01 00:00:00'),(2624,4,94,0,289,NULL),(2625,4,77,0,289,NULL),(2626,4,78,0,289,NULL),(2627,4,104,0,290,NULL),(2628,4,105,0,290,NULL),(2629,4,93,0,290,'2013-03-01 00:00:00'),(2630,4,94,0,290,NULL),(2631,4,77,0,290,NULL),(2632,4,78,0,290,NULL),(2633,4,104,0,291,NULL),(2634,4,105,0,291,NULL),(2635,4,93,0,291,'2013-03-01 00:00:00'),(2636,4,94,0,291,NULL),(2637,4,77,0,291,NULL),(2638,4,78,0,291,NULL),(2639,4,104,0,292,NULL),(2640,4,105,0,292,NULL),(2641,4,93,0,292,'2013-03-01 00:00:00'),(2642,4,94,0,292,NULL),(2643,4,77,0,292,NULL),(2644,4,78,0,292,NULL),(2645,4,104,0,293,NULL),(2646,4,105,0,293,NULL),(2647,4,93,0,293,'2013-03-01 00:00:00'),(2648,4,94,0,293,NULL),(2649,4,77,0,293,NULL),(2650,4,78,0,293,NULL),(2651,4,104,0,294,NULL),(2652,4,105,0,294,NULL),(2653,4,93,0,294,'2013-03-01 00:00:00'),(2654,4,94,0,294,NULL),(2655,4,77,0,294,NULL),(2656,4,78,0,294,NULL),(2657,4,104,0,295,NULL),(2658,4,105,0,295,NULL),(2659,4,93,0,295,'2013-03-01 00:00:00'),(2660,4,94,0,295,NULL),(2661,4,77,0,295,NULL),(2662,4,78,0,295,NULL),(2663,4,104,0,296,NULL),(2664,4,105,0,296,NULL),(2665,4,93,0,296,'2013-03-01 00:00:00'),(2666,4,94,0,296,NULL),(2667,4,77,0,296,NULL),(2668,4,78,0,296,NULL),(2669,4,104,0,297,NULL),(2670,4,105,0,297,NULL),(2671,4,93,0,297,'2013-03-01 00:00:00'),(2672,4,94,0,297,NULL),(2673,4,77,0,297,NULL),(2674,4,78,0,297,NULL),(2675,4,104,0,298,NULL),(2676,4,105,0,298,NULL),(2677,4,93,0,298,'2013-03-01 00:00:00'),(2678,4,94,0,298,NULL),(2679,4,77,0,298,NULL),(2680,4,78,0,298,NULL),(2681,4,104,0,299,NULL),(2682,4,105,0,299,NULL),(2683,4,93,0,299,'2013-03-01 00:00:00'),(2684,4,94,0,299,NULL),(2685,4,77,0,299,NULL),(2686,4,78,0,299,NULL),(2687,4,104,0,300,NULL),(2688,4,105,0,300,NULL),(2689,4,93,0,300,'2013-03-01 00:00:00'),(2690,4,94,0,300,NULL),(2691,4,77,0,300,NULL),(2692,4,78,0,300,NULL),(2693,4,104,0,301,NULL),(2694,4,105,0,301,NULL),(2695,4,93,0,301,'2013-03-01 00:00:00'),(2696,4,94,0,301,NULL),(2697,4,77,0,301,NULL),(2698,4,78,0,301,NULL),(2699,4,104,0,302,NULL),(2700,4,105,0,302,NULL),(2701,4,93,0,302,'2013-03-01 00:00:00'),(2702,4,94,0,302,NULL),(2703,4,77,0,302,NULL),(2704,4,78,0,302,NULL),(2705,4,104,0,303,NULL),(2706,4,105,0,303,NULL),(2707,4,93,0,303,'2013-03-01 00:00:00'),(2708,4,94,0,303,NULL),(2709,4,77,0,303,NULL),(2710,4,78,0,303,NULL),(2711,4,104,0,304,NULL),(2712,4,105,0,304,NULL),(2713,4,93,0,304,'2013-03-01 00:00:00'),(2714,4,94,0,304,NULL),(2715,4,77,0,304,NULL),(2716,4,78,0,304,NULL),(2717,4,104,0,305,NULL),(2718,4,105,0,305,NULL),(2719,4,93,0,305,'2013-03-01 00:00:00'),(2720,4,94,0,305,NULL),(2721,4,77,0,305,NULL),(2722,4,78,0,305,NULL),(2723,4,104,0,306,NULL),(2724,4,105,0,306,NULL),(2725,4,93,0,306,'2013-03-01 00:00:00'),(2726,4,94,0,306,NULL),(2727,4,77,0,306,NULL),(2728,4,78,0,306,NULL),(2729,4,104,0,307,NULL),(2730,4,105,0,307,NULL),(2731,4,93,0,307,'2013-03-01 00:00:00'),(2732,4,94,0,307,NULL),(2733,4,77,0,307,NULL),(2734,4,78,0,307,NULL),(2735,4,104,0,308,NULL),(2736,4,105,0,308,NULL),(2737,4,93,0,308,'2013-03-01 00:00:00'),(2738,4,94,0,308,NULL),(2739,4,77,0,308,NULL),(2740,4,78,0,308,NULL),(2741,4,104,0,309,NULL),(2742,4,105,0,309,NULL),(2743,4,93,0,309,NULL),(2744,4,94,0,309,NULL),(2745,4,77,0,309,NULL),(2746,4,78,0,309,NULL),(2747,4,104,0,310,NULL),(2748,4,105,0,310,NULL),(2749,4,93,0,310,'2013-03-01 00:00:00'),(2750,4,94,0,310,NULL),(2751,4,77,0,310,NULL),(2752,4,78,0,310,NULL),(2753,4,104,0,311,NULL),(2754,4,105,0,311,NULL),(2755,4,93,0,311,'2013-03-01 00:00:00'),(2756,4,94,0,311,NULL),(2757,4,77,0,311,NULL),(2758,4,78,0,311,NULL),(2759,4,104,0,312,NULL),(2760,4,105,0,312,NULL),(2761,4,93,0,312,'2013-03-01 00:00:00'),(2762,4,94,0,312,NULL),(2763,4,77,0,312,NULL),(2764,4,78,0,312,NULL),(2765,4,104,0,313,NULL),(2766,4,105,0,313,NULL),(2767,4,93,0,313,'2013-03-01 00:00:00'),(2768,4,94,0,313,NULL),(2769,4,77,0,313,NULL),(2770,4,78,0,313,NULL),(2771,4,104,0,314,NULL),(2772,4,105,0,314,NULL),(2773,4,93,0,314,'2013-03-01 00:00:00'),(2774,4,94,0,314,NULL),(2775,4,77,0,314,NULL),(2776,4,78,0,314,NULL),(2837,4,104,0,325,NULL),(2838,4,105,0,325,NULL),(2839,4,93,0,325,'2013-03-01 00:00:00'),(2840,4,94,0,325,NULL),(2841,4,77,0,325,NULL),(2842,4,78,0,325,NULL),(2843,4,104,0,326,NULL),(2844,4,105,0,326,NULL),(2845,4,93,0,326,'2013-03-01 00:00:00'),(2846,4,94,0,326,NULL),(2847,4,77,0,326,NULL),(2848,4,78,0,326,NULL),(2849,4,104,0,327,NULL),(2850,4,105,0,327,NULL),(2851,4,93,0,327,'2013-03-01 00:00:00'),(2852,4,94,0,327,NULL),(2853,4,77,0,327,NULL),(2854,4,78,0,327,NULL),(2855,4,104,0,328,NULL),(2856,4,105,0,328,NULL),(2857,4,93,0,328,'2013-03-01 00:00:00'),(2858,4,94,0,328,NULL),(2859,4,77,0,328,NULL),(2860,4,78,0,328,NULL),(2861,4,104,0,329,NULL),(2862,4,105,0,329,NULL),(2863,4,93,0,329,'2013-03-01 00:00:00'),(2864,4,94,0,329,NULL),(2865,4,77,0,329,NULL),(2866,4,78,0,329,NULL),(2909,4,104,0,337,NULL),(2910,4,105,0,337,NULL),(2911,4,93,0,337,NULL),(2912,4,94,0,337,NULL),(2913,4,77,0,337,NULL),(2914,4,78,0,337,NULL),(2915,4,104,0,338,NULL),(2916,4,105,0,338,NULL),(2917,4,93,0,338,NULL),(2918,4,94,0,338,NULL),(2919,4,77,0,338,'2013-03-05 00:00:00'),(2920,4,78,0,338,NULL),(2921,4,104,0,339,NULL),(2922,4,105,0,339,NULL),(2923,4,93,0,339,NULL),(2924,4,94,0,339,NULL),(2925,4,77,0,339,NULL),(2926,4,78,0,339,NULL),(2927,4,104,0,340,NULL),(2928,4,105,0,340,NULL),(2929,4,93,0,340,'2013-03-01 00:00:00'),(2930,4,94,0,340,NULL),(2931,4,77,0,340,NULL),(2932,4,78,0,340,NULL),(2933,4,104,0,341,NULL),(2934,4,105,0,341,NULL),(2935,4,93,0,341,'2013-03-01 00:00:00'),(2936,4,94,0,341,NULL),(2937,4,77,0,341,NULL),(2938,4,78,0,341,NULL),(2939,4,104,0,342,NULL),(2940,4,105,0,342,NULL),(2941,4,93,0,342,'2013-03-01 00:00:00'),(2942,4,94,0,342,NULL),(2943,4,77,0,342,NULL),(2944,4,78,0,342,NULL),(2945,4,104,0,343,NULL),(2946,4,105,0,343,NULL),(2947,4,93,0,343,'2013-03-01 00:00:00'),(2948,4,94,0,343,NULL),(2949,4,77,0,343,NULL),(2950,4,78,0,343,NULL),(2951,4,104,0,344,NULL),(2952,4,105,0,344,NULL),(2953,4,93,0,344,'2013-03-01 00:00:00'),(2954,4,94,0,344,NULL),(2955,4,77,0,344,NULL),(2956,4,78,0,344,NULL),(2957,4,104,0,345,NULL),(2958,4,105,0,345,NULL),(2959,4,93,0,345,'2013-03-01 00:00:00'),(2960,4,94,0,345,NULL),(2961,4,77,0,345,NULL),(2962,4,78,0,345,NULL),(2963,4,104,0,346,NULL),(2964,4,105,0,346,NULL),(2965,4,93,0,346,'2013-03-01 00:00:00'),(2966,4,94,0,346,NULL),(2967,4,77,0,346,NULL),(2968,4,78,0,346,NULL),(2969,4,104,0,347,NULL),(2970,4,105,0,347,NULL),(2971,4,93,0,347,'2013-03-01 00:00:00'),(2972,4,94,0,347,NULL),(2973,4,77,0,347,NULL),(2974,4,78,0,347,NULL),(2975,4,104,0,348,NULL),(2976,4,105,0,348,NULL),(2977,4,93,0,348,'2013-03-01 00:00:00'),(2978,4,94,0,348,NULL),(2979,4,77,0,348,NULL),(2980,4,78,0,348,NULL),(2981,4,104,0,349,NULL),(2982,4,105,0,349,NULL),(2983,4,93,0,349,'2013-03-01 00:00:00'),(2984,4,94,0,349,NULL),(2985,4,77,0,349,NULL),(2986,4,78,0,349,NULL),(2987,4,104,0,350,NULL),(2988,4,105,0,350,NULL),(2989,4,93,0,350,'2013-03-01 00:00:00'),(2990,4,94,0,350,NULL),(2991,4,77,0,350,NULL),(2992,4,78,0,350,NULL),(2993,4,104,0,351,NULL),(2994,4,105,0,351,NULL),(2995,4,93,0,351,'2013-03-01 00:00:00'),(2996,4,94,0,351,NULL),(2997,4,77,0,351,NULL),(2998,4,78,0,351,NULL),(2999,4,104,0,352,NULL),(3000,4,105,0,352,NULL),(3001,4,93,0,352,'2013-03-01 00:00:00'),(3002,4,94,0,352,NULL),(3003,4,77,0,352,NULL),(3004,4,78,0,352,NULL),(3005,4,104,0,353,NULL),(3006,4,105,0,353,NULL),(3007,4,93,0,353,'2013-03-01 00:00:00'),(3008,4,94,0,353,NULL),(3009,4,77,0,353,NULL),(3010,4,78,0,353,NULL),(3011,4,104,0,354,NULL),(3012,4,105,0,354,NULL),(3013,4,93,0,354,'2013-03-01 00:00:00'),(3014,4,94,0,354,NULL),(3015,4,77,0,354,NULL),(3016,4,78,0,354,NULL),(3017,4,104,0,355,NULL),(3018,4,105,0,355,NULL),(3019,4,93,0,355,'2013-03-01 00:00:00'),(3020,4,94,0,355,NULL),(3021,4,77,0,355,NULL),(3022,4,78,0,355,NULL),(3023,4,104,0,356,NULL),(3024,4,105,0,356,NULL),(3025,4,93,0,356,'2013-03-01 00:00:00'),(3026,4,94,0,356,NULL),(3027,4,77,0,356,NULL),(3028,4,78,0,356,NULL),(3029,4,104,0,357,NULL),(3030,4,105,0,357,NULL),(3031,4,93,0,357,'2013-03-01 00:00:00'),(3032,4,94,0,357,NULL),(3033,4,77,0,357,NULL),(3034,4,78,0,357,NULL),(3035,4,104,0,358,NULL),(3036,4,105,0,358,NULL),(3037,4,93,0,358,'2013-03-01 00:00:00'),(3038,4,94,0,358,NULL),(3039,4,77,0,358,NULL),(3040,4,78,0,358,NULL),(3041,4,104,0,359,NULL),(3042,4,105,0,359,NULL),(3043,4,93,0,359,'2013-03-01 00:00:00'),(3044,4,94,0,359,NULL),(3045,4,77,0,359,NULL),(3046,4,78,0,359,NULL),(3047,4,104,0,360,NULL),(3048,4,105,0,360,NULL),(3049,4,93,0,360,'2013-03-01 00:00:00'),(3050,4,94,0,360,NULL),(3051,4,77,0,360,NULL),(3052,4,78,0,360,NULL),(3053,4,104,0,361,NULL),(3054,4,105,0,361,NULL),(3055,4,93,0,361,'2013-03-01 00:00:00'),(3056,4,94,0,361,NULL),(3057,4,77,0,361,NULL),(3058,4,78,0,361,NULL),(3059,4,104,0,362,NULL),(3060,4,105,0,362,NULL),(3061,4,93,0,362,'2013-03-01 00:00:00'),(3062,4,94,0,362,NULL),(3063,4,77,0,362,NULL),(3064,4,78,0,362,NULL),(3065,4,104,0,363,NULL),(3066,4,105,0,363,NULL),(3067,4,93,0,363,'2013-03-01 00:00:00'),(3068,4,94,0,363,NULL),(3069,4,77,0,363,NULL),(3070,4,78,0,363,NULL),(3071,4,104,0,364,NULL),(3072,4,105,0,364,NULL),(3073,4,93,0,364,'2013-03-01 00:00:00'),(3074,4,94,0,364,NULL),(3075,4,77,0,364,NULL),(3076,4,78,0,364,NULL),(3077,4,104,0,365,NULL),(3078,4,105,0,365,NULL),(3079,4,93,0,365,'2013-03-01 00:00:00'),(3080,4,94,0,365,NULL),(3081,4,77,0,365,NULL),(3082,4,78,0,365,NULL),(3083,4,104,0,366,NULL),(3084,4,105,0,366,NULL),(3085,4,93,0,366,'2013-03-01 00:00:00'),(3086,4,94,0,366,NULL),(3087,4,77,0,366,NULL),(3088,4,78,0,366,NULL),(3089,4,104,0,367,NULL),(3090,4,105,0,367,NULL),(3091,4,93,0,367,'2013-03-01 00:00:00'),(3092,4,94,0,367,NULL),(3093,4,77,0,367,NULL),(3094,4,78,0,367,NULL),(3095,4,104,0,368,NULL),(3096,4,105,0,368,NULL),(3097,4,93,0,368,'2013-03-01 00:00:00'),(3098,4,94,0,368,NULL),(3099,4,77,0,368,NULL),(3100,4,78,0,368,NULL),(3101,4,104,0,369,NULL),(3102,4,105,0,369,NULL),(3103,4,93,0,369,'2013-03-01 00:00:00'),(3104,4,94,0,369,NULL),(3105,4,77,0,369,NULL),(3106,4,78,0,369,NULL),(3107,4,104,0,370,NULL),(3108,4,105,0,370,NULL),(3109,4,93,0,370,NULL),(3110,4,94,0,370,NULL),(3111,4,77,0,370,NULL),(3112,4,78,0,370,NULL),(3113,4,104,0,371,NULL),(3114,4,105,0,371,NULL),(3115,4,93,0,371,NULL),(3116,4,94,0,371,NULL),(3117,4,77,0,371,NULL),(3118,4,78,0,371,NULL),(3119,4,104,0,372,NULL),(3120,4,105,0,372,NULL),(3121,4,93,0,372,NULL),(3122,4,94,0,372,NULL),(3123,4,77,0,372,NULL),(3124,4,78,0,372,NULL),(3125,4,104,0,373,NULL),(3126,4,105,0,373,NULL),(3127,4,93,0,373,NULL),(3128,4,94,0,373,NULL),(3129,4,77,0,373,NULL),(3130,4,78,0,373,NULL),(3131,4,104,0,374,NULL),(3132,4,105,0,374,NULL),(3133,4,93,0,374,NULL),(3134,4,94,0,374,NULL),(3135,4,77,0,374,NULL),(3136,4,78,0,374,NULL),(3137,4,104,0,375,NULL),(3138,4,105,0,375,NULL),(3139,4,93,0,375,NULL),(3140,4,94,0,375,NULL),(3141,4,77,0,375,NULL),(3142,4,78,0,375,NULL),(3143,4,104,0,376,NULL),(3144,4,105,0,376,NULL),(3145,4,93,0,376,'2013-03-01 00:00:00'),(3146,4,94,0,376,NULL),(3147,4,77,0,376,NULL),(3148,4,78,0,376,NULL),(3149,4,104,0,377,NULL),(3150,4,105,0,377,NULL),(3151,4,93,0,377,'2013-03-01 00:00:00'),(3152,4,94,0,377,NULL),(3153,4,77,0,377,NULL),(3154,4,78,0,377,NULL),(3155,4,104,0,378,NULL),(3156,4,105,0,378,NULL),(3157,4,93,0,378,NULL),(3158,4,94,0,378,NULL),(3159,4,77,0,378,NULL),(3160,4,78,0,378,NULL),(3161,4,104,0,379,NULL),(3162,4,105,0,379,NULL),(3163,4,93,0,379,NULL),(3164,4,94,0,379,NULL),(3165,4,77,0,379,NULL),(3166,4,78,0,379,NULL),(3167,4,104,0,380,NULL),(3168,4,105,0,380,NULL),(3169,4,93,0,380,NULL),(3170,4,94,0,380,NULL),(3171,4,77,0,380,NULL),(3172,4,78,0,380,NULL),(3173,4,104,0,381,NULL),(3174,4,105,0,381,NULL),(3175,4,93,0,381,NULL),(3176,4,94,0,381,NULL),(3177,4,77,0,381,NULL),(3178,4,78,0,381,NULL),(3179,4,104,0,382,NULL),(3180,4,105,0,382,NULL),(3181,4,93,0,382,NULL),(3182,4,94,0,382,NULL),(3183,4,77,0,382,NULL),(3184,4,78,0,382,NULL),(3185,4,104,0,383,NULL),(3186,4,105,0,383,NULL),(3187,4,93,0,383,NULL),(3188,4,94,0,383,NULL),(3189,4,77,0,383,NULL),(3190,4,78,0,383,NULL),(3191,4,104,0,384,NULL),(3192,4,105,0,384,NULL),(3193,4,93,0,384,NULL),(3194,4,94,0,384,NULL),(3195,4,77,0,384,'2013-03-05 00:00:00'),(3196,4,78,0,384,NULL),(3197,4,104,0,385,NULL),(3198,4,105,0,385,NULL),(3199,4,93,0,385,NULL),(3200,4,94,0,385,NULL),(3201,4,77,0,385,NULL),(3202,4,78,0,385,NULL),(3203,4,104,0,386,NULL),(3204,4,105,0,386,NULL),(3205,4,93,0,386,NULL),(3206,4,94,0,386,NULL),(3207,4,77,0,386,NULL),(3208,4,78,0,386,NULL),(3209,4,104,0,387,NULL),(3210,4,105,0,387,NULL),(3211,4,93,0,387,'2013-03-01 00:00:00'),(3212,4,94,0,387,NULL),(3213,4,77,0,387,NULL),(3214,4,78,0,387,NULL),(3215,4,104,0,388,NULL),(3216,4,105,0,388,NULL),(3217,4,93,0,388,'2013-03-01 00:00:00'),(3218,4,94,0,388,NULL),(3219,4,77,0,388,NULL),(3220,4,78,0,388,NULL),(3221,4,104,0,389,NULL),(3222,4,105,0,389,NULL),(3223,4,93,0,389,NULL),(3224,4,94,0,389,NULL),(3225,4,77,0,389,NULL),(3226,4,78,0,389,NULL),(3227,4,104,0,390,NULL),(3228,4,105,0,390,NULL),(3229,4,93,0,390,NULL),(3230,4,94,0,390,NULL),(3231,4,77,0,390,NULL),(3232,4,78,0,390,NULL),(3233,4,104,0,391,NULL),(3234,4,105,0,391,NULL),(3235,4,93,0,391,NULL),(3236,4,94,0,391,NULL),(3237,4,77,0,391,NULL),(3238,4,78,0,391,NULL),(3239,4,104,0,392,NULL),(3240,4,105,0,392,NULL),(3241,4,93,0,392,NULL),(3242,4,94,0,392,NULL),(3243,4,77,0,392,NULL),(3244,4,78,0,392,NULL),(3245,4,104,0,393,NULL),(3246,4,105,0,393,NULL),(3247,4,93,0,393,NULL),(3248,4,94,0,393,NULL),(3249,4,77,0,393,NULL),(3250,4,78,0,393,NULL),(3251,4,104,0,394,NULL),(3252,4,105,0,394,NULL),(3253,4,93,0,394,NULL),(3254,4,94,0,394,NULL),(3255,4,77,0,394,NULL),(3256,4,78,0,394,NULL),(3257,4,104,0,395,NULL),(3258,4,105,0,395,NULL),(3259,4,93,0,395,NULL),(3260,4,94,0,395,NULL),(3261,4,77,0,395,NULL),(3262,4,78,0,395,NULL),(3263,4,104,0,396,NULL),(3264,4,105,0,396,NULL),(3265,4,93,0,396,NULL),(3266,4,94,0,396,NULL),(3267,4,77,0,396,NULL),(3268,4,78,0,396,NULL),(3269,4,104,0,397,NULL),(3270,4,105,0,397,NULL),(3271,4,93,0,397,NULL),(3272,4,94,0,397,NULL),(3273,4,77,0,397,NULL),(3274,4,78,0,397,NULL),(3275,4,104,0,398,NULL),(3276,4,105,0,398,NULL),(3277,4,93,0,398,NULL),(3278,4,94,0,398,NULL),(3279,4,77,0,398,NULL),(3280,4,78,0,398,NULL),(3281,4,104,0,399,NULL),(3282,4,105,0,399,NULL),(3283,4,93,0,399,NULL),(3284,4,94,0,399,NULL),(3285,4,77,0,399,NULL),(3286,4,78,0,399,NULL),(3287,4,104,0,400,NULL),(3288,4,105,0,400,NULL),(3289,4,93,0,400,NULL),(3290,4,94,0,400,NULL),(3291,4,77,0,400,NULL),(3292,4,78,0,400,NULL),(3299,4,104,0,402,NULL),(3300,4,105,0,402,NULL),(3301,4,93,0,402,NULL),(3302,4,94,0,402,NULL),(3303,4,77,0,402,NULL),(3304,4,78,0,402,NULL),(3305,4,104,0,403,NULL),(3306,4,105,0,403,NULL),(3307,4,93,0,403,NULL),(3308,4,94,0,403,NULL),(3309,4,77,0,403,'2013-03-05 00:00:00'),(3310,4,78,0,403,NULL),(3311,4,104,0,404,NULL),(3312,4,105,0,404,NULL),(3313,4,93,0,404,NULL),(3314,4,94,0,404,NULL),(3315,4,77,0,404,NULL),(3316,4,78,0,404,NULL),(3317,4,104,0,405,NULL),(3318,4,105,0,405,NULL),(3319,4,93,0,405,NULL),(3320,4,94,0,405,NULL),(3321,4,77,0,405,NULL),(3322,4,78,0,405,NULL),(3323,4,104,0,406,NULL),(3324,4,105,0,406,NULL),(3325,4,93,0,406,'2013-03-01 00:00:00'),(3326,4,94,0,406,NULL),(3327,4,77,0,406,NULL),(3328,4,78,0,406,NULL),(3329,4,104,0,407,NULL),(3330,4,105,0,407,NULL),(3331,4,93,0,407,NULL),(3332,4,94,0,407,NULL),(3333,4,77,0,407,NULL),(3334,4,78,0,407,NULL),(3335,4,104,0,408,NULL),(3336,4,105,0,408,NULL),(3337,4,93,0,408,NULL),(3338,4,94,0,408,NULL),(3339,4,77,0,408,NULL),(3340,4,78,0,408,NULL),(3341,4,104,0,409,NULL),(3342,4,105,0,409,NULL),(3343,4,93,0,409,NULL),(3344,4,94,0,409,NULL),(3345,4,77,0,409,NULL),(3346,4,78,0,409,NULL),(3347,4,104,0,410,NULL),(3348,4,105,0,410,NULL),(3349,4,93,0,410,'2013-03-01 00:00:00'),(3350,4,94,0,410,NULL),(3351,4,77,0,410,NULL),(3352,4,78,0,410,NULL),(3353,4,104,0,411,NULL),(3354,4,105,0,411,NULL),(3355,4,93,0,411,NULL),(3356,4,94,0,411,NULL),(3357,4,77,0,411,NULL),(3358,4,78,0,411,NULL),(3359,4,104,0,412,NULL),(3360,4,105,0,412,NULL),(3361,4,93,0,412,NULL),(3362,4,94,0,412,NULL),(3363,4,77,0,412,NULL),(3364,4,78,0,412,NULL),(3365,4,104,0,413,NULL),(3366,4,105,0,413,NULL),(3367,4,93,0,413,NULL),(3368,4,94,0,413,NULL),(3369,4,77,0,413,NULL),(3370,4,78,0,413,NULL),(3371,4,104,0,414,NULL),(3372,4,105,0,414,NULL),(3373,4,93,0,414,NULL),(3374,4,94,0,414,NULL),(3375,4,77,0,414,NULL),(3376,4,78,0,414,NULL),(3377,4,104,0,415,NULL),(3378,4,105,0,415,NULL),(3379,4,93,0,415,NULL),(3380,4,94,0,415,NULL),(3381,4,77,0,415,NULL),(3382,4,78,0,415,NULL),(3383,4,104,0,416,NULL),(3384,4,105,0,416,NULL),(3385,4,93,0,416,NULL),(3386,4,94,0,416,NULL),(3387,4,77,0,416,NULL),(3388,4,78,0,416,NULL),(3389,4,104,0,417,NULL),(3390,4,105,0,417,NULL),(3391,4,93,0,417,NULL),(3392,4,94,0,417,NULL),(3393,4,77,0,417,'2013-03-20 00:00:00'),(3394,4,78,0,417,NULL),(3395,4,104,0,418,NULL),(3396,4,105,0,418,NULL),(3397,4,93,0,418,'2013-03-01 00:00:00'),(3398,4,94,0,418,NULL),(3399,4,77,0,418,'2013-03-01 00:00:00'),(3400,4,78,0,418,NULL),(3401,4,104,0,419,NULL),(3402,4,105,0,419,NULL),(3403,4,93,0,419,NULL),(3404,4,94,0,419,NULL),(3405,4,77,0,419,NULL),(3406,4,78,0,419,NULL),(3407,4,104,0,420,NULL),(3408,4,105,0,420,NULL),(3409,4,93,0,420,NULL),(3410,4,94,0,420,NULL),(3411,4,77,0,420,NULL),(3412,4,78,0,420,NULL),(3413,4,104,0,421,NULL),(3414,4,105,0,421,NULL),(3415,4,93,0,421,'2013-03-01 00:00:00'),(3416,4,94,0,421,NULL),(3417,4,77,0,421,'2013-03-01 00:00:00'),(3418,4,78,0,421,NULL),(3419,4,104,0,422,NULL),(3420,4,105,0,422,NULL),(3421,4,93,0,422,NULL),(3422,4,94,0,422,NULL),(3423,4,77,0,422,NULL),(3424,4,78,0,422,NULL),(3425,4,104,0,423,'2013-05-10 00:00:00'),(3426,4,105,0,423,NULL),(3427,4,93,0,423,'2012-10-01 00:00:00'),(3428,4,94,0,423,'2013-04-01 00:00:00'),(3429,4,77,0,423,'2013-05-10 00:00:00'),(3430,4,78,0,423,NULL),(3431,4,104,0,424,NULL),(3432,4,105,0,424,NULL),(3433,4,93,0,424,NULL),(3434,4,94,0,424,NULL),(3435,4,77,0,424,NULL),(3436,4,78,0,424,NULL),(3437,4,104,0,425,NULL),(3438,4,105,0,425,NULL),(3439,4,93,0,425,'2013-03-01 00:00:00'),(3440,4,94,0,425,NULL),(3441,4,77,0,425,'2013-03-01 00:00:00'),(3442,4,78,0,425,NULL),(3443,4,104,0,426,NULL),(3444,4,105,0,426,NULL),(3445,4,93,0,426,NULL),(3446,4,94,0,426,NULL),(3447,4,77,0,426,NULL),(3448,4,78,0,426,NULL),(3449,4,104,0,427,NULL),(3450,4,105,0,427,NULL),(3451,4,93,0,427,NULL),(3452,4,94,0,427,NULL),(3453,4,77,0,427,NULL),(3454,4,78,0,427,NULL),(3455,4,104,0,428,NULL),(3456,4,105,0,428,NULL),(3457,4,93,0,428,NULL),(3458,4,94,0,428,NULL),(3459,4,77,0,428,NULL),(3460,4,78,0,428,NULL),(3467,4,104,0,430,NULL),(3468,4,105,0,430,NULL),(3469,4,93,0,430,NULL),(3470,4,94,0,430,NULL),(3471,4,77,0,430,NULL),(3472,4,78,0,430,NULL),(3473,4,104,0,431,NULL),(3474,4,105,0,431,NULL),(3475,4,93,0,431,NULL),(3476,4,94,0,431,NULL),(3477,4,77,0,431,NULL),(3478,4,78,0,431,NULL),(3479,4,104,0,432,NULL),(3480,4,105,0,432,NULL),(3481,4,93,0,432,NULL),(3482,4,94,0,432,NULL),(3483,4,77,0,432,NULL),(3484,4,78,0,432,NULL),(3485,4,104,0,433,NULL),(3486,4,105,0,433,NULL),(3487,4,93,0,433,NULL),(3488,4,94,0,433,NULL),(3489,4,77,0,433,NULL),(3490,4,78,0,433,NULL),(3491,4,104,0,434,NULL),(3492,4,105,0,434,NULL),(3493,4,93,0,434,NULL),(3494,4,94,0,434,NULL),(3495,4,77,0,434,NULL),(3496,4,78,0,434,NULL),(3497,4,104,0,435,NULL),(3498,4,105,0,435,NULL),(3499,4,93,0,435,NULL),(3500,4,94,0,435,NULL),(3501,4,77,0,435,NULL),(3502,4,78,0,435,NULL),(3503,4,104,0,436,NULL),(3504,4,105,0,436,NULL),(3505,4,93,0,436,NULL),(3506,4,94,0,436,NULL),(3507,4,77,0,436,NULL),(3508,4,78,0,436,NULL),(3509,4,104,0,437,NULL),(3510,4,105,0,437,NULL),(3511,4,93,0,437,NULL),(3512,4,94,0,437,NULL),(3513,4,77,0,437,NULL),(3514,4,78,0,437,NULL),(3519,4,104,0,439,NULL),(3520,4,105,0,439,NULL),(3521,4,93,0,439,NULL),(3522,4,94,0,439,NULL),(3523,4,104,0,440,NULL),(3524,4,105,0,440,NULL),(3525,4,93,0,440,NULL),(3526,4,94,0,440,NULL),(3527,4,104,0,441,NULL),(3528,4,105,0,441,NULL),(3529,4,93,0,441,NULL),(3530,4,94,0,441,NULL),(3531,4,77,0,441,NULL),(3532,4,78,0,441,NULL),(3533,4,104,0,442,NULL),(3534,4,105,0,442,NULL),(3535,4,93,0,442,NULL),(3536,4,94,0,442,NULL),(3537,4,77,0,442,NULL),(3538,4,78,0,442,NULL),(3575,4,93,0,445,NULL),(3576,4,94,0,445,NULL),(3577,4,77,0,445,NULL),(3578,4,78,0,445,NULL),(3579,4,104,0,445,NULL),(3580,4,105,0,445,NULL),(3581,4,93,0,446,NULL),(3582,4,94,0,446,NULL),(3583,4,77,0,446,NULL),(3584,4,78,0,446,NULL),(3585,4,104,0,446,NULL),(3586,4,105,0,446,NULL),(3587,4,93,0,447,NULL),(3588,4,94,0,447,NULL),(3589,4,77,0,447,NULL),(3590,4,78,0,447,NULL),(3591,4,104,0,447,NULL),(3592,4,105,0,447,NULL),(3593,4,93,0,448,NULL),(3594,4,94,0,448,NULL),(3595,4,77,0,448,NULL),(3596,4,78,0,448,NULL),(3597,4,104,0,448,NULL),(3598,4,105,0,448,NULL),(3599,4,93,0,449,NULL),(3600,4,94,0,449,NULL),(3601,4,77,0,449,NULL),(3602,4,78,0,449,NULL),(3603,4,104,0,449,NULL),(3604,4,105,0,449,NULL),(3605,4,93,0,450,NULL),(3606,4,94,0,450,NULL),(3607,4,77,0,450,NULL),(3608,4,78,0,450,NULL),(3609,4,104,0,450,NULL),(3610,4,105,0,450,NULL),(4093,4,93,0,456,NULL),(4094,4,94,0,456,NULL),(4095,4,77,0,456,NULL),(4096,4,78,0,456,NULL),(4097,4,104,0,456,NULL),(4098,4,105,0,456,NULL),(4242,4,93,0,457,NULL),(4243,4,94,0,457,NULL),(4244,4,77,0,457,NULL),(4245,4,78,0,457,NULL),(4246,4,104,0,457,NULL),(4247,4,105,0,457,NULL),(4248,4,93,0,458,NULL),(4249,4,94,0,458,NULL),(4250,4,77,0,458,NULL),(4251,4,78,0,458,NULL),(4252,4,104,0,458,NULL),(4253,4,105,0,458,NULL),(4254,4,93,0,459,NULL),(4255,4,94,0,459,NULL),(4256,4,77,0,459,NULL),(4257,4,78,0,459,NULL),(4258,4,104,0,459,NULL),(4259,4,105,0,459,NULL),(5776,4,93,0,475,'2013-03-01 00:00:00'),(5777,4,94,0,475,NULL),(5778,4,77,0,475,NULL),(5779,4,78,0,475,NULL),(5780,4,104,0,475,NULL),(5781,4,105,0,475,NULL),(5782,4,93,0,476,'2013-03-01 00:00:00'),(5783,4,94,0,476,NULL),(5784,4,77,0,476,NULL),(5785,4,78,0,476,NULL),(5786,4,104,0,476,NULL),(5787,4,105,0,476,NULL),(5798,4,93,0,477,'2013-03-01 00:00:00'),(5799,4,94,0,477,NULL),(5800,4,77,0,477,NULL),(5801,4,78,0,477,NULL),(5802,4,104,0,477,NULL),(5803,4,105,0,477,NULL),(5804,4,93,0,478,'2013-03-01 00:00:00'),(5805,4,94,0,478,NULL),(5806,4,77,0,478,NULL),(5807,4,78,0,478,NULL),(5808,4,104,0,478,NULL),(5809,4,105,0,478,NULL),(5825,4,93,0,479,NULL),(5826,4,94,0,479,NULL),(5827,4,77,0,479,NULL),(5828,4,78,0,479,NULL),(5829,4,104,0,479,NULL),(5830,4,105,0,479,NULL),(5831,4,93,0,480,NULL),(5832,4,94,0,480,NULL),(5833,4,77,0,480,NULL),(5834,4,78,0,480,NULL),(5835,4,104,0,480,NULL),(5836,4,105,0,480,NULL),(5837,4,93,0,481,NULL),(5838,4,94,0,481,NULL),(5839,4,77,0,481,NULL),(5840,4,78,0,481,NULL),(5841,4,104,0,481,NULL),(5842,4,105,0,481,NULL),(5843,4,93,0,482,NULL),(5844,4,94,0,482,NULL),(5845,4,77,0,482,NULL),(5846,4,78,0,482,NULL),(5847,4,104,0,482,NULL),(5848,4,105,0,482,NULL),(5930,4,93,0,483,'2013-03-01 00:00:00'),(5931,4,94,0,483,NULL),(5932,4,77,0,483,NULL),(5933,4,78,0,483,NULL),(5934,4,104,0,483,NULL),(5935,4,105,0,483,NULL),(5936,4,93,0,484,'2013-03-01 00:00:00'),(5937,4,94,0,484,NULL),(5938,4,77,0,484,NULL),(5939,4,78,0,484,NULL),(5940,4,104,0,484,NULL),(5941,4,105,0,484,NULL),(5957,4,93,0,485,'2013-03-01 00:00:00'),(5958,4,94,0,485,NULL),(5959,4,77,0,485,NULL),(5960,4,78,0,485,NULL),(5961,4,104,0,485,NULL),(5962,4,105,0,485,NULL),(5963,4,93,0,486,'2013-03-01 00:00:00'),(5964,4,94,0,486,NULL),(5965,4,77,0,486,NULL),(5966,4,78,0,486,NULL),(5967,4,104,0,486,NULL),(5968,4,105,0,486,NULL),(5969,4,93,0,487,'2013-03-01 00:00:00'),(5970,4,94,0,487,NULL),(5971,4,77,0,487,NULL),(5972,4,78,0,487,NULL),(5973,4,104,0,487,NULL),(5974,4,105,0,487,NULL),(5980,4,93,0,488,'2013-03-01 00:00:00'),(5981,4,94,0,488,NULL),(5982,4,77,0,488,NULL),(5983,4,78,0,488,NULL),(5984,4,104,0,488,NULL),(5985,4,105,0,488,NULL),(6011,4,93,0,489,'2013-03-01 00:00:00'),(6012,4,94,0,489,NULL),(6013,4,77,0,489,NULL),(6014,4,78,0,489,NULL),(6015,4,104,0,489,NULL),(6016,4,105,0,489,NULL),(6017,4,93,0,490,'2013-03-01 00:00:00'),(6018,4,94,0,490,NULL),(6019,4,77,0,490,NULL),(6020,4,78,0,490,NULL),(6021,4,104,0,490,NULL),(6022,4,105,0,490,NULL),(6023,4,93,0,491,'2013-03-01 00:00:00'),(6024,4,94,0,491,NULL),(6025,4,77,0,491,NULL),(6026,4,78,0,491,NULL),(6027,4,104,0,491,NULL),(6028,4,105,0,491,NULL),(6059,4,93,0,492,'2013-03-01 00:00:00'),(6060,4,94,0,492,NULL),(6061,4,77,0,492,NULL),(6062,4,78,0,492,NULL),(6063,4,104,0,492,NULL),(6064,4,105,0,492,NULL),(6065,4,93,0,493,'2013-03-01 00:00:00'),(6066,4,94,0,493,NULL),(6067,4,77,0,493,NULL),(6068,4,78,0,493,NULL),(6069,4,104,0,493,NULL),(6070,4,105,0,493,NULL),(6086,4,93,0,494,'2013-03-01 00:00:00'),(6087,4,94,0,494,NULL),(6088,4,77,0,494,NULL),(6089,4,78,0,494,NULL),(6090,4,104,0,494,NULL),(6091,4,105,0,494,NULL),(6092,4,93,0,495,'2013-03-01 00:00:00'),(6093,4,94,0,495,NULL),(6094,4,77,0,495,NULL),(6095,4,78,0,495,NULL),(6096,4,104,0,495,NULL),(6097,4,105,0,495,NULL),(6113,4,93,0,496,'2013-03-01 00:00:00'),(6114,4,94,0,496,NULL),(6115,4,77,0,496,NULL),(6116,4,78,0,496,NULL),(6117,4,104,0,496,NULL),(6118,4,105,0,496,NULL),(6119,4,93,0,497,'2013-03-01 00:00:00'),(6120,4,94,0,497,NULL),(6121,4,77,0,497,NULL),(6122,4,78,0,497,NULL),(6123,4,104,0,497,NULL),(6124,4,105,0,497,NULL),(6135,4,93,0,498,'2013-03-01 00:00:00'),(6136,4,94,0,498,NULL),(6137,4,77,0,498,NULL),(6138,4,78,0,498,NULL),(6139,4,104,0,498,NULL),(6140,4,105,0,498,NULL),(6141,4,93,0,499,'2013-03-01 00:00:00'),(6142,4,94,0,499,NULL),(6143,4,77,0,499,NULL),(6144,4,78,0,499,NULL),(6145,4,104,0,499,NULL),(6146,4,105,0,499,NULL),(6162,4,93,0,500,'2013-03-01 00:00:00'),(6163,4,94,0,500,NULL),(6164,4,77,0,500,'2013-03-05 00:00:00'),(6165,4,78,0,500,NULL),(6166,4,104,0,500,NULL),(6167,4,105,0,500,NULL),(6168,4,93,0,501,'2013-03-01 00:00:00'),(6169,4,94,0,501,NULL),(6170,4,77,0,501,'2013-03-05 00:00:00'),(6171,4,78,0,501,NULL),(6172,4,104,0,501,NULL),(6173,4,105,0,501,NULL),(6186,4,93,0,502,'2013-03-01 00:00:00'),(6187,4,94,0,502,NULL),(6188,4,77,0,502,NULL),(6189,4,78,0,502,NULL),(6190,4,104,0,502,NULL),(6191,4,105,0,502,NULL),(6192,4,93,0,503,'2013-03-01 00:00:00'),(6193,4,94,0,503,NULL),(6194,4,77,0,503,NULL),(6195,4,78,0,503,NULL),(6196,4,104,0,503,NULL),(6197,4,105,0,503,NULL),(6213,4,93,0,504,'2013-03-01 00:00:00'),(6214,4,94,0,504,NULL),(6215,4,77,0,504,NULL),(6216,4,78,0,504,NULL),(6217,4,104,0,504,NULL),(6218,4,105,0,504,NULL),(6219,4,93,0,505,'2013-03-01 00:00:00'),(6220,4,94,0,505,NULL),(6221,4,77,0,505,NULL),(6222,4,78,0,505,NULL),(6223,4,104,0,505,NULL),(6224,4,105,0,505,NULL),(6240,4,93,0,506,'2013-03-01 00:00:00'),(6241,4,94,0,506,NULL),(6242,4,77,0,506,NULL),(6243,4,78,0,506,NULL),(6244,4,104,0,506,NULL),(6245,4,105,0,506,NULL),(6246,4,93,0,507,'2013-03-01 00:00:00'),(6247,4,94,0,507,NULL),(6248,4,77,0,507,NULL),(6249,4,78,0,507,NULL),(6250,4,104,0,507,NULL),(6251,4,105,0,507,NULL),(6267,4,93,0,508,'2013-03-01 00:00:00'),(6268,4,94,0,508,NULL),(6269,4,77,0,508,NULL),(6270,4,78,0,508,NULL),(6271,4,104,0,508,NULL),(6272,4,105,0,508,NULL),(6273,4,93,0,509,'2013-03-01 00:00:00'),(6274,4,94,0,509,NULL),(6275,4,77,0,509,NULL),(6276,4,78,0,509,NULL),(6277,4,104,0,509,NULL),(6278,4,105,0,509,NULL),(6294,4,93,0,510,'2013-03-01 00:00:00'),(6295,4,94,0,510,NULL),(6296,4,77,0,510,NULL),(6297,4,78,0,510,NULL),(6298,4,104,0,510,NULL),(6299,4,105,0,510,NULL),(6300,4,93,0,511,'2013-03-01 00:00:00'),(6301,4,94,0,511,NULL),(6302,4,77,0,511,NULL),(6303,4,78,0,511,NULL),(6304,4,104,0,511,NULL),(6305,4,105,0,511,NULL),(6321,4,93,0,512,'2013-03-01 00:00:00'),(6322,4,94,0,512,NULL),(6323,4,77,0,512,NULL),(6324,4,78,0,512,NULL),(6325,4,104,0,512,NULL),(6326,4,105,0,512,NULL),(6327,4,93,0,513,'2013-03-01 00:00:00'),(6328,4,94,0,513,NULL),(6329,4,77,0,513,NULL),(6330,4,78,0,513,NULL),(6331,4,104,0,513,NULL),(6332,4,105,0,513,NULL),(6348,4,93,0,514,'2013-03-01 00:00:00'),(6349,4,94,0,514,NULL),(6350,4,77,0,514,NULL),(6351,4,78,0,514,NULL),(6352,4,104,0,514,NULL),(6353,4,105,0,514,NULL),(6354,4,93,0,515,'2013-03-01 00:00:00'),(6355,4,94,0,515,NULL),(6356,4,77,0,515,NULL),(6357,4,78,0,515,NULL),(6358,4,104,0,515,NULL),(6359,4,105,0,515,NULL),(6375,4,93,0,516,'2013-03-01 00:00:00'),(6376,4,94,0,516,NULL),(6377,4,77,0,516,NULL),(6378,4,78,0,516,NULL),(6379,4,104,0,516,NULL),(6380,4,105,0,516,NULL),(6381,4,93,0,517,'2013-03-01 00:00:00'),(6382,4,94,0,517,NULL),(6383,4,77,0,517,NULL),(6384,4,78,0,517,NULL),(6385,4,104,0,517,NULL),(6386,4,105,0,517,NULL),(6402,4,93,0,518,'2013-03-01 00:00:00'),(6403,4,94,0,518,NULL),(6404,4,77,0,518,NULL),(6405,4,78,0,518,NULL),(6406,4,104,0,518,NULL),(6407,4,105,0,518,NULL),(6408,4,93,0,519,'2013-03-01 00:00:00'),(6409,4,94,0,519,NULL),(6410,4,77,0,519,NULL),(6411,4,78,0,519,NULL),(6412,4,104,0,519,NULL),(6413,4,105,0,519,NULL),(6429,4,93,0,520,'2013-03-01 00:00:00'),(6430,4,94,0,520,NULL),(6431,4,77,0,520,NULL),(6432,4,78,0,520,NULL),(6433,4,104,0,520,NULL),(6434,4,105,0,520,NULL),(6435,4,93,0,521,'2013-03-01 00:00:00'),(6436,4,94,0,521,NULL),(6437,4,77,0,521,NULL),(6438,4,78,0,521,NULL),(6439,4,104,0,521,NULL),(6440,4,105,0,521,NULL),(6441,4,93,0,522,'2013-03-01 00:00:00'),(6442,4,94,0,522,NULL),(6443,4,77,0,522,NULL),(6444,4,78,0,522,NULL),(6445,4,104,0,522,NULL),(6446,4,105,0,522,NULL),(6447,4,93,0,523,'2013-03-01 00:00:00'),(6448,4,94,0,523,NULL),(6449,4,77,0,523,NULL),(6450,4,78,0,523,NULL),(6451,4,104,0,523,NULL),(6452,4,105,0,523,NULL),(6453,4,93,0,524,'2013-03-01 00:00:00'),(6454,4,94,0,524,NULL),(6455,4,77,0,524,NULL),(6456,4,78,0,524,NULL),(6457,4,104,0,524,NULL),(6458,4,105,0,524,NULL),(6459,4,93,0,525,'2013-03-01 00:00:00'),(6460,4,94,0,525,NULL),(6461,4,77,0,525,NULL),(6462,4,78,0,525,NULL),(6463,4,104,0,525,NULL),(6464,4,105,0,525,NULL),(6465,4,93,0,526,'2013-03-01 00:00:00'),(6466,4,94,0,526,NULL),(6467,4,77,0,526,NULL),(6468,4,78,0,526,NULL),(6469,4,104,0,526,NULL),(6470,4,105,0,526,NULL),(6476,4,93,0,527,NULL),(6477,4,94,0,527,NULL),(6478,4,77,0,527,NULL),(6479,4,78,0,527,NULL),(6480,4,104,0,527,NULL),(6481,4,105,0,527,NULL),(6482,4,93,0,528,'2013-03-01 00:00:00'),(6483,4,94,0,528,NULL),(6484,4,77,0,528,NULL),(6485,4,78,0,528,NULL),(6486,4,104,0,528,NULL),(6487,4,105,0,528,NULL),(6488,4,93,0,529,'2013-03-01 00:00:00'),(6489,4,94,0,529,NULL),(6490,4,77,0,529,NULL),(6491,4,78,0,529,NULL),(6492,4,104,0,529,NULL),(6493,4,105,0,529,NULL),(6494,4,93,0,530,'2013-03-01 00:00:00'),(6495,4,94,0,530,NULL),(6496,4,77,0,530,NULL),(6497,4,78,0,530,NULL),(6498,4,104,0,530,NULL),(6499,4,105,0,530,NULL),(6500,4,93,0,531,'2013-03-01 00:00:00'),(6501,4,94,0,531,NULL),(6502,4,77,0,531,NULL),(6503,4,78,0,531,NULL),(6504,4,104,0,531,NULL),(6505,4,105,0,531,NULL),(6506,4,93,0,532,'2013-03-01 00:00:00'),(6507,4,94,0,532,NULL),(6508,4,77,0,532,NULL),(6509,4,78,0,532,NULL),(6510,4,104,0,532,NULL),(6511,4,105,0,532,NULL),(6512,4,93,0,533,'2013-03-01 00:00:00'),(6513,4,94,0,533,NULL),(6514,4,77,0,533,NULL),(6515,4,78,0,533,NULL),(6516,4,104,0,533,NULL),(6517,4,105,0,533,NULL),(6598,4,93,0,534,'2013-03-01 00:00:00'),(6599,4,94,0,534,NULL),(6600,4,77,0,534,NULL),(6601,4,78,0,534,NULL),(6602,4,104,0,534,NULL),(6603,4,105,0,534,NULL),(6604,4,93,0,535,'2013-03-01 00:00:00'),(6605,4,94,0,535,NULL),(6606,4,77,0,535,NULL),(6607,4,78,0,535,NULL),(6608,4,104,0,535,NULL),(6609,4,105,0,535,NULL),(6610,4,93,0,536,'2013-03-01 00:00:00'),(6611,4,94,0,536,NULL),(6612,4,77,0,536,NULL),(6613,4,78,0,536,NULL),(6614,4,104,0,536,NULL),(6615,4,105,0,536,NULL),(6616,4,93,0,537,'2013-03-01 00:00:00'),(6617,4,94,0,537,NULL),(6618,4,77,0,537,NULL),(6619,4,78,0,537,NULL),(6620,4,104,0,537,NULL),(6621,4,105,0,537,NULL),(6622,4,93,0,538,'2013-03-01 00:00:00'),(6623,4,94,0,538,NULL),(6624,4,77,0,538,NULL),(6625,4,78,0,538,NULL),(6626,4,104,0,538,NULL),(6627,4,105,0,538,NULL),(6658,4,93,0,539,'2013-03-01 00:00:00'),(6659,4,94,0,539,NULL),(6660,4,77,0,539,NULL),(6661,4,78,0,539,NULL),(6662,4,104,0,539,NULL),(6663,4,105,0,539,NULL),(6664,4,93,0,540,'2013-03-01 00:00:00'),(6665,4,94,0,540,NULL),(6666,4,77,0,540,NULL),(6667,4,78,0,540,NULL),(6668,4,104,0,540,NULL),(6669,4,105,0,540,NULL),(6786,4,93,0,541,'2013-03-01 00:00:00'),(6787,4,94,0,541,NULL),(6788,4,77,0,541,NULL),(6789,4,78,0,541,NULL),(6790,4,104,0,541,NULL),(6791,4,105,0,541,NULL),(7080,4,93,0,542,NULL),(7081,4,94,0,542,NULL),(7082,4,77,0,542,NULL),(7083,4,78,0,542,NULL),(7084,4,104,0,542,NULL),(7085,4,105,0,542,NULL),(7175,4,77,1,284,'2013-03-05 00:00:00'),(7176,4,77,2,284,'2013-03-05 00:00:00'),(7177,4,77,3,284,'2013-03-05 00:00:00'),(7178,4,78,1,284,NULL),(7179,4,78,2,284,NULL),(7180,4,78,3,284,NULL),(7267,4,93,0,546,NULL),(7268,4,94,0,546,NULL),(7269,4,77,0,546,NULL),(7270,4,78,0,546,NULL),(7271,4,104,0,546,NULL),(7272,4,105,0,546,NULL),(7289,4,93,0,547,NULL),(7290,4,94,0,547,NULL),(7291,4,77,0,547,NULL),(7292,4,78,0,547,NULL),(7293,4,104,0,547,NULL),(7294,4,105,0,547,NULL),(7295,4,93,0,548,NULL),(7296,4,94,0,548,NULL),(7297,4,77,0,548,NULL),(7298,4,78,0,548,NULL),(7299,4,104,0,548,NULL),(7300,4,105,0,548,NULL),(7337,4,93,0,549,NULL),(7338,4,94,0,549,NULL),(7339,4,77,0,549,NULL),(7340,4,78,0,549,NULL),(7341,4,104,0,549,NULL),(7342,4,105,0,549,NULL),(7372,4,93,0,551,NULL),(7373,4,94,0,551,NULL),(7374,4,77,0,551,NULL),(7375,4,78,0,551,NULL),(7376,4,104,0,551,NULL),(7377,4,105,0,551,NULL),(7402,4,93,0,552,NULL),(7403,4,94,0,552,NULL),(7404,4,77,0,552,NULL),(7405,4,78,0,552,NULL),(7406,4,104,0,552,NULL),(7407,4,105,0,552,NULL),(7414,4,93,0,553,NULL),(7415,4,94,0,553,NULL),(7416,4,77,0,553,NULL),(7417,4,78,0,553,NULL),(7418,4,104,0,553,NULL),(7419,4,105,0,553,NULL),(7432,4,93,0,554,NULL),(7433,4,94,0,554,NULL),(7434,4,77,0,554,NULL),(7435,4,78,0,554,NULL),(7436,4,104,0,554,NULL),(7437,4,105,0,554,NULL),(7444,4,93,0,555,NULL),(7445,4,94,0,555,NULL),(7446,4,104,0,555,NULL),(7447,4,105,0,555,NULL),(8223,4,93,0,557,NULL),(8224,4,94,0,557,NULL),(8225,4,77,0,557,NULL),(8226,4,78,0,557,NULL),(8227,4,104,0,557,NULL),(8228,4,105,0,557,NULL),(8295,4,93,0,558,NULL),(8296,4,94,0,558,NULL),(8297,4,77,0,558,NULL),(8298,4,78,0,558,NULL),(8299,4,104,0,558,NULL),(8300,4,105,0,558,NULL),(8307,4,93,0,559,NULL),(8308,4,94,0,559,NULL),(8309,4,77,0,559,NULL),(8310,4,78,0,559,NULL),(8311,4,104,0,559,NULL),(8312,4,105,0,559,NULL),(8319,4,93,0,560,NULL),(8320,4,94,0,560,NULL),(8321,4,77,0,560,NULL),(8322,4,78,0,560,NULL),(8323,4,104,0,560,NULL),(8324,4,105,0,560,NULL),(8325,4,93,0,561,NULL),(8326,4,94,0,561,NULL),(8327,4,77,0,561,NULL),(8328,4,78,0,561,NULL),(8329,4,104,0,561,NULL),(8330,4,105,0,561,NULL),(8337,4,93,0,562,NULL),(8338,4,94,0,562,NULL),(8339,4,77,0,562,NULL),(8340,4,78,0,562,NULL),(8341,4,104,0,562,NULL),(8342,4,105,0,562,NULL),(8349,4,93,0,563,NULL),(8350,4,94,0,563,NULL),(8351,4,77,0,563,NULL),(8352,4,78,0,563,NULL),(8353,4,104,0,563,NULL),(8354,4,105,0,563,NULL),(8487,4,93,0,564,NULL),(8488,4,94,0,564,NULL),(8489,4,77,0,564,NULL),(8490,4,78,0,564,NULL),(8491,4,104,0,564,NULL),(8492,4,105,0,564,NULL),(9077,4,93,0,566,NULL),(9078,4,94,0,566,NULL),(9079,4,77,0,566,NULL),(9080,4,78,0,566,NULL),(9081,4,104,0,566,NULL),(9082,4,105,0,566,NULL),(9123,4,93,0,567,NULL),(9124,4,94,0,567,NULL),(9125,4,77,0,567,NULL),(9126,4,78,0,567,NULL),(9127,4,93,0,568,NULL),(9128,4,94,0,568,NULL),(9129,4,77,0,568,NULL),(9130,4,78,0,568,NULL),(9131,4,93,0,569,NULL),(9132,4,94,0,569,NULL),(9133,4,77,0,569,NULL),(9134,4,78,0,569,NULL),(9135,4,93,0,570,NULL),(9136,4,94,0,570,NULL),(9137,4,77,0,570,NULL),(9138,4,78,0,570,NULL),(9139,4,93,0,571,NULL),(9140,4,94,0,571,NULL),(9141,4,77,0,571,NULL),(9142,4,78,0,571,NULL),(9143,4,93,0,572,NULL),(9144,4,94,0,572,NULL),(9145,4,77,0,572,NULL),(9146,4,78,0,572,NULL),(9147,4,93,0,573,NULL),(9148,4,94,0,573,NULL),(9149,4,77,0,573,NULL),(9150,4,78,0,573,NULL),(9151,4,93,0,574,NULL),(9152,4,94,0,574,NULL),(9153,4,77,0,574,NULL),(9154,4,78,0,574,NULL),(9155,4,93,0,575,NULL),(9156,4,94,0,575,NULL),(9157,4,77,0,575,NULL),(9158,4,78,0,575,NULL),(9159,4,93,0,576,NULL),(9160,4,94,0,576,NULL),(9161,4,77,0,576,NULL),(9162,4,78,0,576,NULL),(9163,4,93,0,577,NULL),(9164,4,94,0,577,NULL),(9165,4,77,0,577,NULL),(9166,4,78,0,577,NULL),(9167,4,93,0,578,NULL),(9168,4,94,0,578,NULL),(9169,4,77,0,578,NULL),(9170,4,78,0,578,NULL),(9171,4,93,0,579,NULL),(9172,4,94,0,579,NULL),(9173,4,77,0,579,NULL),(9174,4,78,0,579,NULL),(9175,4,93,0,580,NULL),(9176,4,94,0,580,NULL),(9177,4,77,0,580,NULL),(9178,4,78,0,580,NULL),(9179,4,93,0,581,NULL),(9180,4,94,0,581,NULL),(9181,4,77,0,581,NULL),(9182,4,78,0,581,NULL),(9183,4,93,0,582,NULL),(9184,4,94,0,582,NULL),(9185,4,77,0,582,NULL),(9186,4,78,0,582,NULL),(9187,4,93,0,583,NULL),(9188,4,94,0,583,NULL),(9189,4,77,0,583,NULL),(9190,4,78,0,583,NULL),(9191,4,93,0,584,NULL),(9192,4,94,0,584,NULL),(9193,4,77,0,584,NULL),(9194,4,78,0,584,NULL),(9195,4,93,0,585,NULL),(9196,4,94,0,585,NULL),(9197,4,77,0,585,NULL),(9198,4,78,0,585,NULL),(9199,4,93,0,586,NULL),(9200,4,94,0,586,NULL),(9201,4,77,0,586,NULL),(9202,4,78,0,586,NULL),(9203,4,93,0,587,NULL),(9204,4,94,0,587,NULL),(9205,4,77,0,587,NULL),(9206,4,78,0,587,NULL),(9207,4,93,0,588,NULL),(9208,4,94,0,588,NULL),(9209,4,77,0,588,NULL),(9210,4,78,0,588,NULL),(9211,4,93,0,589,NULL),(9212,4,94,0,589,NULL),(9213,4,77,0,589,NULL),(9214,4,78,0,589,NULL),(9215,4,93,0,590,NULL),(9216,4,94,0,590,NULL),(9217,4,77,0,590,NULL),(9218,4,78,0,590,NULL),(9219,4,93,0,591,NULL),(9220,4,94,0,591,NULL),(9221,4,77,0,591,NULL),(9222,4,78,0,591,NULL),(9223,4,93,0,592,NULL),(9224,4,94,0,592,NULL),(9225,4,77,0,592,NULL),(9226,4,78,0,592,NULL),(9227,4,93,0,593,NULL),(9228,4,94,0,593,NULL),(9229,4,77,0,593,NULL),(9230,4,78,0,593,NULL),(9231,4,93,0,594,NULL),(9232,4,94,0,594,NULL),(9233,4,77,0,594,NULL),(9234,4,78,0,594,NULL),(9235,4,93,0,595,NULL),(9236,4,94,0,595,NULL),(9237,4,77,0,595,NULL),(9238,4,78,0,595,NULL),(9239,4,93,0,596,NULL),(9240,4,94,0,596,NULL),(9241,4,77,0,596,NULL),(9242,4,78,0,596,NULL),(9243,4,93,0,597,NULL),(9244,4,94,0,597,NULL),(9245,4,77,0,597,NULL),(9246,4,78,0,597,NULL),(9251,4,93,0,598,NULL),(9252,4,94,0,598,NULL),(9253,4,77,0,598,NULL),(9254,4,78,0,598,NULL),(9255,4,93,0,599,NULL),(9256,4,94,0,599,NULL),(9257,4,77,0,599,NULL),(9258,4,78,0,599,NULL),(9259,4,93,0,600,NULL),(9260,4,94,0,600,NULL),(9261,4,77,0,600,NULL),(9262,4,78,0,600,NULL),(9263,4,93,0,601,NULL),(9264,4,94,0,601,NULL),(9265,4,77,0,601,NULL),(9266,4,78,0,601,NULL),(9267,4,93,0,602,NULL),(9268,4,94,0,602,NULL),(9269,4,77,0,602,NULL),(9270,4,78,0,602,NULL),(9271,4,93,0,603,NULL),(9272,4,94,0,603,NULL),(9273,4,77,0,603,NULL),(9274,4,78,0,603,NULL),(9275,4,93,0,604,NULL),(9276,4,94,0,604,NULL),(9277,4,77,0,604,NULL),(9278,4,78,0,604,NULL),(9279,4,93,0,605,NULL),(9280,4,94,0,605,NULL),(9281,4,77,0,605,NULL),(9282,4,78,0,605,NULL),(9283,4,93,0,606,NULL),(9284,4,94,0,606,NULL),(9285,4,77,0,606,NULL),(9286,4,78,0,606,NULL),(9287,4,93,0,607,NULL),(9288,4,94,0,607,NULL),(9289,4,77,0,607,NULL),(9290,4,78,0,607,NULL),(9291,4,93,0,608,NULL),(9292,4,94,0,608,NULL),(9293,4,77,0,608,NULL),(9294,4,78,0,608,NULL),(9295,4,93,0,609,NULL),(9296,4,94,0,609,NULL),(9297,4,77,0,609,NULL),(9298,4,78,0,609,NULL),(9299,4,93,0,610,NULL),(9300,4,94,0,610,NULL),(9301,4,77,0,610,NULL),(9302,4,78,0,610,NULL),(9303,4,93,0,611,NULL),(9304,4,94,0,611,NULL),(9305,4,77,0,611,NULL),(9306,4,78,0,611,NULL),(9307,4,93,0,612,NULL),(9308,4,94,0,612,NULL),(9309,4,77,0,612,NULL),(9310,4,78,0,612,NULL),(9311,4,93,0,613,NULL),(9312,4,94,0,613,NULL),(9313,4,77,0,613,NULL),(9314,4,78,0,613,NULL),(9315,4,93,0,614,NULL),(9316,4,94,0,614,NULL),(9317,4,77,0,614,NULL),(9318,4,78,0,614,NULL),(9319,4,93,0,615,NULL),(9320,4,94,0,615,NULL),(9321,4,77,0,615,NULL),(9322,4,78,0,615,NULL),(9323,4,93,0,616,NULL),(9324,4,94,0,616,NULL),(9325,4,77,0,616,NULL),(9326,4,78,0,616,NULL),(9327,4,93,0,617,NULL),(9328,4,94,0,617,NULL),(9329,4,77,0,617,NULL),(9330,4,78,0,617,NULL),(9331,4,93,0,618,NULL),(9332,4,94,0,618,NULL),(9333,4,77,0,618,NULL),(9334,4,78,0,618,NULL),(9335,4,93,0,619,NULL),(9336,4,94,0,619,NULL),(9337,4,77,0,619,NULL),(9338,4,78,0,619,NULL),(9339,4,93,0,620,NULL),(9340,4,94,0,620,NULL),(9341,4,77,0,620,NULL),(9342,4,78,0,620,NULL),(9343,4,93,0,621,NULL),(9344,4,94,0,621,NULL),(9345,4,77,0,621,NULL),(9346,4,78,0,621,NULL),(9347,4,93,0,622,NULL),(9348,4,94,0,622,NULL),(9349,4,77,0,622,NULL),(9350,4,78,0,622,NULL),(9351,4,93,0,623,NULL),(9352,4,94,0,623,NULL),(9353,4,77,0,623,NULL),(9354,4,78,0,623,NULL),(9355,4,93,0,624,NULL),(9356,4,94,0,624,NULL),(9357,4,77,0,624,NULL),(9358,4,78,0,624,NULL),(9359,4,93,0,625,NULL),(9360,4,94,0,625,NULL),(9361,4,77,0,625,NULL),(9362,4,78,0,625,NULL),(9363,4,93,0,626,NULL),(9364,4,94,0,626,NULL),(9365,4,77,0,626,NULL),(9366,4,78,0,626,NULL),(9367,4,93,0,627,NULL),(9368,4,94,0,627,NULL),(9369,4,77,0,627,NULL),(9370,4,78,0,627,NULL),(9371,4,93,0,628,NULL),(9372,4,94,0,628,NULL),(9373,4,77,0,628,NULL),(9374,4,78,0,628,NULL),(9375,4,93,0,629,NULL),(9376,4,94,0,629,NULL),(9377,4,77,0,629,NULL),(9378,4,78,0,629,NULL),(9379,4,93,0,630,NULL),(9380,4,94,0,630,NULL),(9381,4,77,0,630,NULL),(9382,4,78,0,630,NULL),(9383,4,93,0,631,NULL),(9384,4,94,0,631,NULL),(9385,4,77,0,631,NULL),(9386,4,78,0,631,NULL),(9387,4,93,0,632,NULL),(9388,4,94,0,632,NULL),(9389,4,77,0,632,NULL),(9390,4,78,0,632,NULL),(9391,4,93,0,633,NULL),(9392,4,94,0,633,NULL),(9393,4,77,0,633,NULL),(9394,4,78,0,633,NULL),(9395,4,93,0,634,NULL),(9396,4,94,0,634,NULL),(9397,4,77,0,634,NULL),(9398,4,78,0,634,NULL),(9399,4,93,0,635,NULL),(9400,4,94,0,635,NULL),(9401,4,77,0,635,NULL),(9402,4,78,0,635,NULL),(9403,4,93,0,636,NULL),(9404,4,94,0,636,NULL),(9405,4,77,0,636,NULL),(9406,4,78,0,636,NULL),(9407,4,93,0,637,NULL),(9408,4,94,0,637,NULL),(9409,4,77,0,637,NULL),(9410,4,78,0,637,NULL),(9411,4,93,0,638,NULL),(9412,4,94,0,638,NULL),(9413,4,77,0,638,NULL),(9414,4,78,0,638,NULL),(9415,4,93,0,639,NULL),(9416,4,94,0,639,NULL),(9417,4,77,0,639,NULL),(9418,4,78,0,639,NULL),(9419,4,93,0,640,NULL),(9420,4,94,0,640,NULL),(9421,4,77,0,640,NULL),(9422,4,78,0,640,NULL),(9423,4,93,0,641,NULL),(9424,4,94,0,641,NULL),(9425,4,77,0,641,NULL),(9426,4,78,0,641,NULL),(9427,4,93,0,642,NULL),(9428,4,94,0,642,NULL),(9429,4,77,0,642,NULL),(9430,4,78,0,642,NULL),(9431,4,93,0,643,NULL),(9432,4,94,0,643,NULL),(9433,4,77,0,643,NULL),(9434,4,78,0,643,NULL),(9435,4,93,0,644,NULL),(9436,4,94,0,644,NULL),(9437,4,77,0,644,NULL),(9438,4,78,0,644,NULL),(9439,4,93,0,645,NULL),(9440,4,94,0,645,NULL),(9441,4,77,0,645,NULL),(9442,4,78,0,645,NULL),(9443,4,93,0,646,NULL),(9444,4,94,0,646,NULL),(9445,4,77,0,646,NULL),(9446,4,78,0,646,NULL),(9447,4,93,0,647,NULL),(9448,4,94,0,647,NULL),(9449,4,77,0,647,NULL),(9450,4,78,0,647,NULL),(9451,4,93,0,648,NULL),(9452,4,94,0,648,NULL),(9453,4,77,0,648,NULL),(9454,4,78,0,648,NULL),(9455,4,93,0,649,NULL),(9456,4,94,0,649,NULL),(9457,4,77,0,649,NULL),(9458,4,78,0,649,NULL),(9459,4,93,0,650,NULL),(9460,4,94,0,650,NULL),(9461,4,77,0,650,NULL),(9462,4,78,0,650,NULL),(9463,4,93,0,651,NULL),(9464,4,94,0,651,NULL),(9465,4,77,0,651,NULL),(9466,4,78,0,651,NULL),(9467,4,93,0,652,NULL),(9468,4,94,0,652,NULL),(9469,4,77,0,652,NULL),(9470,4,78,0,652,NULL),(9471,4,93,0,653,NULL),(9472,4,94,0,653,NULL),(9473,4,77,0,653,NULL),(9474,4,78,0,653,NULL),(9475,4,93,0,654,NULL),(9476,4,94,0,654,NULL),(9477,4,77,0,654,NULL),(9478,4,78,0,654,NULL),(9479,4,93,0,655,NULL),(9480,4,94,0,655,NULL),(9481,4,77,0,655,NULL),(9482,4,78,0,655,NULL),(9483,4,93,0,656,NULL),(9484,4,94,0,656,NULL),(9485,4,77,0,656,NULL),(9486,4,78,0,656,NULL),(9487,4,93,0,657,NULL),(9488,4,94,0,657,NULL),(9489,4,77,0,657,NULL),(9490,4,78,0,657,NULL),(9491,4,93,0,658,NULL),(9492,4,94,0,658,NULL),(9493,4,77,0,658,NULL),(9494,4,78,0,658,NULL),(9495,4,93,0,659,NULL),(9496,4,94,0,659,NULL),(9497,4,77,0,659,NULL),(9498,4,78,0,659,NULL),(9499,4,93,0,660,NULL),(9500,4,94,0,660,NULL),(9501,4,77,0,660,NULL),(9502,4,78,0,660,NULL),(9503,4,93,0,661,NULL),(9504,4,94,0,661,NULL),(9505,4,77,0,661,NULL),(9506,4,78,0,661,NULL),(9507,4,93,0,662,NULL),(9508,4,94,0,662,NULL),(9509,4,77,0,662,NULL),(9510,4,78,0,662,NULL),(9511,4,93,0,663,NULL),(9512,4,94,0,663,NULL),(9513,4,77,0,663,NULL),(9514,4,78,0,663,NULL),(9515,4,93,0,664,NULL),(9516,4,94,0,664,NULL),(9517,4,77,0,664,NULL),(9518,4,78,0,664,NULL),(9519,4,93,0,665,NULL),(9520,4,94,0,665,NULL),(9521,4,77,0,665,NULL),(9522,4,78,0,665,NULL),(9523,4,93,0,666,NULL),(9524,4,94,0,666,NULL),(9525,4,77,0,666,NULL),(9526,4,78,0,666,NULL),(9527,4,93,0,667,NULL),(9528,4,94,0,667,NULL),(9529,4,77,0,667,NULL),(9530,4,78,0,667,NULL),(9531,4,93,0,668,NULL),(9532,4,94,0,668,NULL),(9533,4,77,0,668,NULL),(9534,4,78,0,668,NULL),(9535,4,93,0,669,NULL),(9536,4,94,0,669,NULL),(9537,4,77,0,669,NULL),(9538,4,78,0,669,NULL),(9539,4,93,0,670,NULL),(9540,4,94,0,670,NULL),(9541,4,77,0,670,NULL),(9542,4,78,0,670,NULL),(9543,4,93,0,671,NULL),(9544,4,94,0,671,NULL),(9545,4,77,0,671,NULL),(9546,4,78,0,671,NULL),(9547,4,93,0,672,NULL),(9548,4,94,0,672,NULL),(9549,4,77,0,672,NULL),(9550,4,78,0,672,NULL),(9551,4,93,0,673,NULL),(9552,4,94,0,673,NULL),(9553,4,77,0,673,NULL),(9554,4,78,0,673,NULL),(9555,4,93,0,674,NULL),(9556,4,94,0,674,NULL),(9557,4,77,0,674,NULL),(9558,4,78,0,674,NULL),(9559,4,93,0,675,NULL),(9560,4,94,0,675,NULL),(9561,4,77,0,675,NULL),(9562,4,78,0,675,NULL),(9563,4,93,0,676,NULL),(9564,4,94,0,676,NULL),(9565,4,77,0,676,NULL),(9566,4,78,0,676,NULL),(9567,4,93,0,677,NULL),(9568,4,94,0,677,NULL),(9569,4,77,0,677,NULL),(9570,4,78,0,677,NULL),(9571,4,93,0,678,NULL),(9572,4,94,0,678,NULL),(9573,4,77,0,678,NULL),(9574,4,78,0,678,NULL),(9575,4,93,0,679,NULL),(9576,4,94,0,679,NULL),(9577,4,77,0,679,NULL),(9578,4,78,0,679,NULL),(9579,4,93,0,680,NULL),(9580,4,94,0,680,NULL),(9581,4,77,0,680,NULL),(9582,4,78,0,680,NULL),(9583,4,93,0,681,NULL),(9584,4,94,0,681,NULL),(9585,4,77,0,681,NULL),(9586,4,78,0,681,NULL),(9587,4,93,0,682,NULL),(9588,4,94,0,682,NULL),(9589,4,77,0,682,NULL),(9590,4,78,0,682,NULL),(9591,4,93,0,683,NULL),(9592,4,94,0,683,NULL),(9593,4,77,0,683,NULL),(9594,4,78,0,683,NULL),(9595,4,93,0,684,NULL),(9596,4,94,0,684,NULL),(9597,4,77,0,684,NULL),(9598,4,78,0,684,NULL),(9599,4,93,0,685,NULL),(9600,4,94,0,685,NULL),(9601,4,77,0,685,NULL),(9602,4,78,0,685,NULL),(9603,4,93,0,686,NULL),(9604,4,94,0,686,NULL),(9605,4,77,0,686,NULL),(9606,4,78,0,686,NULL),(9607,4,93,0,687,NULL),(9608,4,94,0,687,NULL),(9609,4,77,0,687,NULL),(9610,4,78,0,687,NULL),(9611,4,93,0,688,NULL),(9612,4,94,0,688,NULL),(9613,4,77,0,688,NULL),(9614,4,78,0,688,NULL),(9615,4,93,0,689,NULL),(9616,4,94,0,689,NULL),(9617,4,77,0,689,NULL),(9618,4,78,0,689,NULL),(9619,4,93,0,690,NULL),(9620,4,94,0,690,NULL),(9621,4,77,0,690,NULL),(9622,4,78,0,690,NULL),(9623,4,93,0,691,NULL),(9624,4,94,0,691,NULL),(9625,4,77,0,691,NULL),(9626,4,78,0,691,NULL),(9627,4,93,0,692,NULL),(9628,4,94,0,692,NULL),(9629,4,77,0,692,NULL),(9630,4,78,0,692,NULL),(9631,4,93,0,693,NULL),(9632,4,94,0,693,NULL),(9633,4,77,0,693,NULL),(9634,4,78,0,693,NULL),(9635,4,93,0,694,NULL),(9636,4,94,0,694,NULL),(9637,4,77,0,694,NULL),(9638,4,78,0,694,NULL),(9639,4,93,0,695,NULL),(9640,4,94,0,695,NULL),(9641,4,77,0,695,NULL),(9642,4,78,0,695,NULL),(9643,4,93,0,696,NULL),(9644,4,94,0,696,NULL),(9645,4,77,0,696,NULL),(9646,4,78,0,696,NULL),(9647,4,93,0,697,NULL),(9648,4,94,0,697,NULL),(9649,4,77,0,697,NULL),(9650,4,78,0,697,NULL),(9651,4,93,0,698,NULL),(9652,4,94,0,698,NULL),(9653,4,77,0,698,NULL),(9654,4,78,0,698,NULL),(9655,4,93,0,699,NULL),(9656,4,94,0,699,NULL),(9657,4,77,0,699,NULL),(9658,4,78,0,699,NULL),(9659,4,93,0,700,NULL),(9660,4,94,0,700,NULL),(9661,4,77,0,700,NULL),(9662,4,78,0,700,NULL),(9663,4,93,0,701,NULL),(9664,4,94,0,701,NULL),(9665,4,77,0,701,NULL),(9666,4,78,0,701,NULL),(9667,4,93,0,702,NULL),(9668,4,94,0,702,NULL),(9669,4,77,0,702,NULL),(9670,4,78,0,702,NULL),(9671,4,93,0,703,NULL),(9672,4,94,0,703,NULL),(9673,4,77,0,703,NULL),(9674,4,78,0,703,NULL),(9675,4,93,0,704,NULL),(9676,4,94,0,704,NULL),(9677,4,77,0,704,NULL),(9678,4,78,0,704,NULL),(9679,4,93,0,705,NULL),(9680,4,94,0,705,NULL),(9681,4,77,0,705,NULL),(9682,4,78,0,705,NULL),(9683,4,93,0,706,NULL),(9684,4,94,0,706,NULL),(9685,4,77,0,706,NULL),(9686,4,78,0,706,NULL),(9687,4,93,0,707,NULL),(9688,4,94,0,707,NULL),(9689,4,77,0,707,NULL),(9690,4,78,0,707,NULL),(9691,4,93,0,708,NULL),(9692,4,94,0,708,NULL),(9693,4,77,0,708,NULL),(9694,4,78,0,708,NULL),(9695,4,93,0,709,NULL),(9696,4,94,0,709,NULL),(9697,4,77,0,709,NULL),(9698,4,78,0,709,NULL),(9699,4,93,0,710,NULL),(9700,4,94,0,710,NULL),(9701,4,77,0,710,NULL),(9702,4,78,0,710,NULL),(9703,4,93,0,711,NULL),(9704,4,94,0,711,NULL),(9705,4,77,0,711,NULL),(9706,4,78,0,711,NULL),(9707,4,93,0,712,NULL),(9708,4,94,0,712,NULL),(9709,4,77,0,712,NULL),(9710,4,78,0,712,NULL),(9711,4,93,0,713,NULL),(9712,4,94,0,713,NULL),(9713,4,77,0,713,NULL),(9714,4,78,0,713,NULL),(9715,4,93,0,714,NULL),(9716,4,94,0,714,NULL),(9717,4,77,0,714,NULL),(9718,4,78,0,714,NULL),(9719,4,93,0,715,NULL),(9720,4,94,0,715,NULL),(9721,4,77,0,715,NULL),(9722,4,78,0,715,NULL),(9723,4,93,0,716,NULL),(9724,4,94,0,716,NULL),(9725,4,77,0,716,NULL),(9726,4,78,0,716,NULL),(9727,4,93,0,717,NULL),(9728,4,94,0,717,NULL),(9729,4,77,0,717,NULL),(9730,4,78,0,717,NULL),(9731,4,93,0,718,NULL),(9732,4,94,0,718,NULL),(9733,4,77,0,718,NULL),(9734,4,78,0,718,NULL),(9735,4,93,0,719,NULL),(9736,4,94,0,719,NULL),(9737,4,77,0,719,NULL),(9738,4,78,0,719,NULL),(9739,4,93,0,720,NULL),(9740,4,94,0,720,NULL),(9741,4,77,0,720,NULL),(9742,4,78,0,720,NULL),(9743,4,93,0,721,NULL),(9744,4,94,0,721,NULL),(9745,4,77,0,721,NULL),(9746,4,78,0,721,NULL),(9747,4,93,0,722,NULL),(9748,4,94,0,722,NULL),(9749,4,77,0,722,NULL),(9750,4,78,0,722,NULL),(9751,4,93,0,723,NULL),(9752,4,94,0,723,NULL),(9753,4,77,0,723,NULL),(9754,4,78,0,723,NULL),(9755,4,93,0,724,NULL),(9756,4,94,0,724,NULL),(9757,4,77,0,724,NULL),(9758,4,78,0,724,NULL),(9759,4,93,0,725,NULL),(9760,4,94,0,725,NULL),(9761,4,77,0,725,NULL),(9762,4,78,0,725,NULL),(9763,4,93,0,726,NULL),(9764,4,94,0,726,NULL),(9765,4,77,0,726,NULL),(9766,4,78,0,726,NULL),(9767,4,93,0,727,NULL),(9768,4,94,0,727,NULL),(9769,4,77,0,727,NULL),(9770,4,78,0,727,NULL),(9771,4,93,0,728,NULL),(9772,4,94,0,728,NULL),(9773,4,77,0,728,NULL),(9774,4,78,0,728,NULL),(9775,4,93,0,729,NULL),(9776,4,94,0,729,NULL),(9777,4,77,0,729,NULL),(9778,4,78,0,729,NULL),(9779,4,93,0,730,NULL),(9780,4,94,0,730,NULL),(9781,4,77,0,730,NULL),(9782,4,78,0,730,NULL),(9783,4,93,0,731,NULL),(9784,4,94,0,731,NULL),(9785,4,77,0,731,NULL),(9786,4,78,0,731,NULL),(9787,4,93,0,732,NULL),(9788,4,94,0,732,NULL),(9789,4,77,0,732,NULL),(9790,4,78,0,732,NULL),(9791,4,93,0,733,NULL),(9792,4,94,0,733,NULL),(9793,4,77,0,733,NULL),(9794,4,78,0,733,NULL),(9795,4,93,0,734,NULL),(9796,4,94,0,734,NULL),(9797,4,77,0,734,NULL),(9798,4,78,0,734,NULL),(9799,4,93,0,735,NULL),(9800,4,94,0,735,NULL),(9801,4,77,0,735,NULL),(9802,4,78,0,735,NULL),(9803,4,93,0,736,NULL),(9804,4,94,0,736,NULL),(9805,4,77,0,736,NULL),(9806,4,78,0,736,NULL),(9807,4,93,0,737,NULL),(9808,4,94,0,737,NULL),(9809,4,77,0,737,NULL),(9810,4,78,0,737,NULL),(9811,4,93,0,738,NULL),(9812,4,94,0,738,NULL),(9813,4,77,0,738,NULL),(9814,4,78,0,738,NULL),(9815,4,93,0,739,NULL),(9816,4,94,0,739,NULL),(9817,4,77,0,739,NULL),(9818,4,78,0,739,NULL),(9819,4,93,0,740,NULL),(9820,4,94,0,740,NULL),(9821,4,77,0,740,NULL),(9822,4,78,0,740,NULL),(9823,4,93,0,741,NULL),(9824,4,94,0,741,NULL),(9825,4,77,0,741,NULL),(9826,4,78,0,741,NULL),(9827,4,93,0,742,NULL),(9828,4,94,0,742,NULL),(9829,4,77,0,742,NULL),(9830,4,78,0,742,NULL),(9831,4,93,0,743,NULL),(9832,4,94,0,743,NULL),(9833,4,77,0,743,NULL),(9834,4,78,0,743,NULL),(9835,4,93,0,744,NULL),(9836,4,94,0,744,NULL),(9837,4,77,0,744,NULL),(9838,4,78,0,744,NULL),(9839,4,93,0,745,NULL),(9840,4,94,0,745,NULL),(9841,4,77,0,745,NULL),(9842,4,78,0,745,NULL),(9843,4,93,0,746,NULL),(9844,4,94,0,746,NULL),(9845,4,77,0,746,NULL),(9846,4,78,0,746,NULL),(9847,4,93,0,747,NULL),(9848,4,94,0,747,NULL),(9849,4,77,0,747,NULL),(9850,4,78,0,747,NULL),(9851,4,93,0,748,NULL),(9852,4,94,0,748,NULL),(9853,4,77,0,748,NULL),(9854,4,78,0,748,NULL),(9855,4,93,0,749,NULL),(9856,4,94,0,749,NULL),(9857,4,77,0,749,NULL),(9858,4,78,0,749,NULL),(9859,4,93,0,750,NULL),(9860,4,94,0,750,NULL),(9861,4,77,0,750,NULL),(9862,4,78,0,750,NULL),(9863,4,93,0,751,NULL),(9864,4,94,0,751,NULL),(9865,4,77,0,751,NULL),(9866,4,78,0,751,NULL),(9867,4,93,0,752,NULL),(9868,4,94,0,752,NULL),(9869,4,77,0,752,NULL),(9870,4,78,0,752,NULL),(9871,4,93,0,753,NULL),(9872,4,94,0,753,NULL),(9873,4,77,0,753,NULL),(9874,4,78,0,753,NULL),(9875,4,93,0,754,NULL),(9876,4,94,0,754,NULL),(9877,4,77,0,754,NULL),(9878,4,78,0,754,NULL),(9879,4,93,0,755,NULL),(9880,4,94,0,755,NULL),(9881,4,77,0,755,NULL),(9882,4,78,0,755,NULL),(9883,4,93,0,756,NULL),(9884,4,94,0,756,NULL),(9885,4,77,0,756,NULL),(9886,4,78,0,756,NULL),(9887,4,93,0,757,NULL),(9888,4,94,0,757,NULL),(9889,4,77,0,757,NULL),(9890,4,78,0,757,NULL),(9891,4,93,0,758,NULL),(9892,4,94,0,758,NULL),(9893,4,77,0,758,NULL),(9894,4,78,0,758,NULL),(9895,4,93,0,759,NULL),(9896,4,94,0,759,NULL),(9897,4,77,0,759,NULL),(9898,4,78,0,759,NULL),(9899,4,93,0,760,NULL),(9900,4,94,0,760,NULL),(9901,4,77,0,760,NULL),(9902,4,78,0,760,NULL),(9903,4,93,0,761,NULL),(9904,4,94,0,761,NULL),(9905,4,77,0,761,NULL),(9906,4,78,0,761,NULL),(9907,4,93,0,762,NULL),(9908,4,94,0,762,NULL),(9909,4,77,0,762,NULL),(9910,4,78,0,762,NULL),(9911,4,93,0,763,NULL),(9912,4,94,0,763,NULL),(9913,4,77,0,763,NULL),(9914,4,78,0,763,NULL),(9915,4,93,0,764,NULL),(9916,4,94,0,764,NULL),(9917,4,77,0,764,NULL),(9918,4,78,0,764,NULL),(9919,4,93,0,765,NULL),(9920,4,94,0,765,NULL),(9921,4,77,0,765,NULL),(9922,4,78,0,765,NULL),(9923,4,93,0,766,NULL),(9924,4,94,0,766,NULL),(9925,4,77,0,766,NULL),(9926,4,78,0,766,NULL),(9927,4,93,0,767,NULL),(9928,4,94,0,767,NULL),(9929,4,77,0,767,NULL),(9930,4,78,0,767,NULL),(9931,4,93,0,768,NULL),(9932,4,94,0,768,NULL),(9933,4,77,0,768,NULL),(9934,4,78,0,768,NULL),(9935,4,93,0,769,NULL),(9936,4,94,0,769,NULL),(9937,4,77,0,769,NULL),(9938,4,78,0,769,NULL),(9939,4,93,0,770,NULL),(9940,4,94,0,770,NULL),(9941,4,77,0,770,NULL),(9942,4,78,0,770,NULL),(9943,4,93,0,771,NULL),(9944,4,94,0,771,NULL),(9945,4,77,0,771,NULL),(9946,4,78,0,771,NULL),(9947,4,93,0,772,NULL),(9948,4,94,0,772,NULL),(9949,4,77,0,772,NULL),(9950,4,78,0,772,NULL),(9951,4,93,0,773,NULL),(9952,4,94,0,773,NULL),(9953,4,77,0,773,NULL),(9954,4,78,0,773,NULL),(9955,4,93,0,774,NULL),(9956,4,94,0,774,NULL),(9957,4,77,0,774,NULL),(9958,4,78,0,774,NULL),(9959,4,93,0,775,NULL),(9960,4,94,0,775,NULL),(9961,4,77,0,775,NULL),(9962,4,78,0,775,NULL),(9963,4,93,0,776,NULL),(9964,4,94,0,776,NULL),(9965,4,77,0,776,NULL),(9966,4,78,0,776,NULL),(9967,4,93,0,777,NULL),(9968,4,94,0,777,NULL),(9969,4,77,0,777,NULL),(9970,4,78,0,777,NULL),(9971,4,93,0,778,NULL),(9972,4,94,0,778,NULL),(9973,4,77,0,778,NULL),(9974,4,78,0,778,NULL),(9975,4,93,0,779,NULL),(9976,4,94,0,779,NULL),(9977,4,77,0,779,NULL),(9978,4,78,0,779,NULL),(9979,4,93,0,780,NULL),(9980,4,94,0,780,NULL),(9981,4,77,0,780,NULL),(9982,4,78,0,780,NULL),(9983,4,93,0,781,NULL),(9984,4,94,0,781,NULL),(9985,4,77,0,781,NULL),(9986,4,78,0,781,NULL),(9987,4,93,0,782,NULL),(9988,4,94,0,782,NULL),(9989,4,77,0,782,NULL),(9990,4,78,0,782,NULL),(9991,4,93,0,783,NULL),(9992,4,94,0,783,NULL),(9993,4,77,0,783,NULL),(9994,4,78,0,783,NULL),(9995,4,93,0,784,NULL),(9996,4,94,0,784,NULL),(9997,4,77,0,784,NULL),(9998,4,78,0,784,NULL),(9999,4,93,0,785,NULL),(10000,4,94,0,785,NULL),(10001,4,77,0,785,NULL),(10002,4,78,0,785,NULL),(10003,4,93,0,786,NULL),(10004,4,94,0,786,NULL),(10005,4,77,0,786,NULL),(10006,4,78,0,786,NULL),(10007,4,93,0,787,NULL),(10008,4,94,0,787,NULL),(10009,4,77,0,787,NULL),(10010,4,78,0,787,NULL),(10011,4,93,0,788,NULL),(10012,4,94,0,788,NULL),(10013,4,77,0,788,NULL),(10014,4,78,0,788,NULL),(10015,4,93,0,789,NULL),(10016,4,94,0,789,NULL),(10017,4,77,0,789,NULL),(10018,4,78,0,789,NULL),(10019,4,93,0,790,NULL),(10020,4,94,0,790,NULL),(10021,4,77,0,790,NULL),(10022,4,78,0,790,NULL),(10023,4,93,0,791,NULL),(10024,4,94,0,791,NULL),(10025,4,77,0,791,NULL),(10026,4,78,0,791,NULL),(10027,4,93,0,792,NULL),(10028,4,94,0,792,NULL),(10029,4,77,0,792,NULL),(10030,4,78,0,792,NULL),(10031,4,93,0,793,NULL),(10032,4,94,0,793,NULL),(10033,4,77,0,793,NULL),(10034,4,78,0,793,NULL),(10035,4,93,0,794,NULL),(10036,4,94,0,794,NULL),(10037,4,77,0,794,NULL),(10038,4,78,0,794,NULL),(10039,4,93,0,795,NULL),(10040,4,94,0,795,NULL),(10041,4,77,0,795,NULL),(10042,4,78,0,795,NULL),(10043,4,93,0,796,NULL),(10044,4,94,0,796,NULL),(10045,4,77,0,796,NULL),(10046,4,78,0,796,NULL),(10047,4,93,0,797,NULL),(10048,4,94,0,797,NULL),(10049,4,77,0,797,NULL),(10050,4,78,0,797,NULL),(10051,4,93,0,798,NULL),(10052,4,94,0,798,NULL),(10053,4,77,0,798,NULL),(10054,4,78,0,798,NULL),(10055,4,93,0,799,NULL),(10056,4,94,0,799,NULL),(10057,4,77,0,799,NULL),(10058,4,78,0,799,NULL),(10059,4,93,0,800,NULL),(10060,4,94,0,800,NULL),(10061,4,77,0,800,NULL),(10062,4,78,0,800,NULL),(10063,4,93,0,801,NULL),(10064,4,94,0,801,NULL),(10065,4,77,0,801,NULL),(10066,4,78,0,801,NULL),(10067,4,93,0,802,NULL),(10068,4,94,0,802,NULL),(10069,4,77,0,802,NULL),(10070,4,78,0,802,NULL),(10071,4,93,0,803,NULL),(10072,4,94,0,803,NULL),(10073,4,77,0,803,NULL),(10074,4,78,0,803,NULL),(10075,4,93,0,804,NULL),(10076,4,94,0,804,NULL),(10077,4,77,0,804,NULL),(10078,4,78,0,804,NULL),(10079,4,93,0,805,NULL),(10080,4,94,0,805,NULL),(10081,4,77,0,805,NULL),(10082,4,78,0,805,NULL),(10083,4,93,0,806,NULL),(10084,4,94,0,806,NULL),(10085,4,77,0,806,NULL),(10086,4,78,0,806,NULL),(10087,4,93,0,807,NULL),(10088,4,94,0,807,NULL),(10089,4,77,0,807,NULL),(10090,4,78,0,807,NULL),(11106,4,104,0,769,NULL),(11107,4,105,0,769,NULL),(11112,4,93,0,808,NULL),(11113,4,94,0,808,NULL),(11114,4,77,0,808,NULL),(11115,4,78,0,808,NULL),(11116,4,93,0,809,NULL),(11117,4,94,0,809,NULL),(11118,4,77,0,809,NULL),(11119,4,78,0,809,NULL),(11120,4,93,0,810,NULL),(11121,4,94,0,810,NULL),(11122,4,77,0,810,NULL),(11123,4,78,0,810,NULL),(11124,4,93,0,811,NULL),(11125,4,94,0,811,NULL),(11126,4,77,0,811,NULL),(11127,4,78,0,811,NULL),(11128,4,93,0,812,NULL),(11129,4,94,0,812,NULL),(11130,4,77,0,812,NULL),(11131,4,78,0,812,NULL),(11132,4,93,0,813,NULL),(11133,4,94,0,813,NULL),(11134,4,77,0,813,NULL),(11135,4,78,0,813,NULL),(11136,4,93,0,814,NULL),(11137,4,94,0,814,NULL),(11138,4,77,0,814,NULL),(11139,4,78,0,814,NULL),(11140,4,93,0,815,NULL),(11141,4,94,0,815,NULL),(11142,4,77,0,815,NULL),(11143,4,78,0,815,NULL),(11144,4,93,0,816,NULL),(11145,4,94,0,816,NULL),(11146,4,77,0,816,NULL),(11147,4,78,0,816,NULL),(11148,4,93,0,817,NULL),(11149,4,94,0,817,NULL),(11150,4,77,0,817,NULL),(11151,4,78,0,817,NULL),(11152,4,93,0,818,NULL),(11153,4,94,0,818,NULL),(11154,4,77,0,818,NULL),(11155,4,78,0,818,NULL),(11156,4,93,0,819,NULL),(11157,4,94,0,819,NULL),(11158,4,77,0,819,NULL),(11159,4,78,0,819,NULL),(11160,4,93,0,820,NULL),(11161,4,94,0,820,NULL),(11162,4,77,0,820,NULL),(11163,4,78,0,820,NULL),(11164,4,93,0,821,NULL),(11165,4,94,0,821,NULL),(11166,4,77,0,821,NULL),(11167,4,78,0,821,NULL),(11168,4,93,0,822,NULL),(11169,4,94,0,822,NULL),(11170,4,77,0,822,NULL),(11171,4,78,0,822,NULL),(11172,4,93,0,823,NULL),(11173,4,94,0,823,NULL),(11174,4,77,0,823,NULL),(11175,4,78,0,823,NULL),(11176,4,93,0,824,NULL),(11177,4,94,0,824,NULL),(11178,4,77,0,824,NULL),(11179,4,78,0,824,NULL),(11180,4,93,0,825,NULL),(11181,4,94,0,825,NULL),(11182,4,77,0,825,NULL),(11183,4,78,0,825,NULL),(11184,4,93,0,826,NULL),(11185,4,94,0,826,NULL),(11186,4,77,0,826,NULL),(11187,4,78,0,826,NULL),(11188,4,93,0,827,NULL),(11189,4,94,0,827,NULL),(11190,4,77,0,827,NULL),(11191,4,78,0,827,NULL),(11192,4,93,0,828,NULL),(11193,4,94,0,828,NULL),(11194,4,77,0,828,NULL),(11195,4,78,0,828,NULL),(11196,4,93,0,829,NULL),(11197,4,94,0,829,NULL),(11198,4,77,0,829,NULL),(11199,4,78,0,829,NULL),(11200,4,93,0,830,NULL),(11201,4,94,0,830,NULL),(11202,4,77,0,830,NULL),(11203,4,78,0,830,NULL),(11204,4,93,0,831,NULL),(11205,4,94,0,831,NULL),(11206,4,77,0,831,NULL),(11207,4,78,0,831,NULL),(11208,4,93,0,832,NULL),(11209,4,94,0,832,NULL),(11210,4,77,0,832,NULL),(11211,4,78,0,832,NULL),(11212,4,93,0,833,NULL),(11213,4,94,0,833,NULL),(11214,4,77,0,833,NULL),(11215,4,78,0,833,NULL),(11216,4,93,0,834,NULL),(11217,4,94,0,834,NULL),(11218,4,77,0,834,NULL),(11219,4,78,0,834,NULL),(11220,4,93,0,835,NULL),(11221,4,94,0,835,NULL),(11222,4,77,0,835,NULL),(11223,4,78,0,835,NULL),(11224,4,93,0,836,NULL),(11225,4,94,0,836,NULL),(11226,4,77,0,836,NULL),(11227,4,78,0,836,NULL),(11228,4,93,0,837,NULL),(11229,4,94,0,837,NULL),(11230,4,77,0,837,NULL),(11231,4,78,0,837,NULL),(11232,4,93,0,838,NULL),(11233,4,94,0,838,NULL),(11234,4,77,0,838,NULL),(11235,4,78,0,838,NULL),(11464,4,93,0,863,NULL),(11465,4,94,0,863,NULL),(11466,4,77,0,863,NULL),(11467,4,78,0,863,NULL),(11704,4,93,0,864,NULL),(11705,4,94,0,864,NULL),(11706,4,77,0,864,NULL),(11707,4,78,0,864,NULL),(11708,4,93,0,865,NULL),(11709,4,94,0,865,NULL),(11710,4,77,0,865,NULL),(11711,4,78,0,865,NULL),(11712,4,93,0,866,NULL),(11713,4,94,0,866,NULL),(11714,4,77,0,866,NULL),(11715,4,78,0,866,NULL),(11716,4,93,0,867,NULL),(11717,4,94,0,867,NULL),(11718,4,77,0,867,NULL),(11719,4,78,0,867,NULL),(11720,4,93,0,868,NULL),(11721,4,94,0,868,NULL),(11722,4,77,0,868,NULL),(11723,4,78,0,868,NULL),(11724,4,93,0,869,NULL),(11725,4,94,0,869,NULL),(11726,4,77,0,869,NULL),(11727,4,78,0,869,NULL),(11728,4,93,0,870,NULL),(11729,4,94,0,870,NULL),(11730,4,77,0,870,NULL),(11731,4,78,0,870,NULL),(11732,4,93,0,871,NULL),(11733,4,94,0,871,NULL),(11734,4,77,0,871,NULL),(11735,4,78,0,871,NULL),(11736,4,93,0,872,NULL),(11737,4,94,0,872,NULL),(11738,4,77,0,872,NULL),(11739,4,78,0,872,NULL),(11740,4,93,0,873,NULL),(11741,4,94,0,873,NULL),(11742,4,77,0,873,NULL),(11743,4,78,0,873,NULL),(11744,4,93,0,874,NULL),(11745,4,94,0,874,NULL),(11746,4,77,0,874,NULL),(11747,4,78,0,874,NULL),(11748,4,93,0,875,NULL),(11749,4,94,0,875,NULL),(11750,4,77,0,875,NULL),(11751,4,78,0,875,NULL),(11894,4,104,0,811,NULL),(11895,4,105,0,811,NULL),(11900,4,104,0,808,NULL),(11901,4,105,0,808,NULL),(11906,4,104,0,826,NULL),(11907,4,105,0,826,NULL),(11912,4,104,0,823,NULL),(11913,4,105,0,823,NULL),(11939,4,104,0,875,NULL),(11940,4,105,0,875,NULL),(11975,4,104,0,833,NULL),(11976,4,105,0,833,NULL),(12014,4,104,0,837,NULL),(12015,4,105,0,837,NULL),(12020,4,104,0,874,NULL),(12021,4,105,0,874,NULL),(12032,4,104,0,873,NULL),(12033,4,105,0,873,NULL),(12038,4,104,0,872,NULL),(12039,4,105,0,872,NULL),(12044,4,104,0,870,NULL),(12045,4,105,0,870,NULL),(12050,4,104,0,871,NULL),(12051,4,105,0,871,NULL),(12056,4,104,0,869,NULL),(12057,4,105,0,869,NULL),(12062,4,104,0,868,NULL),(12063,4,105,0,868,NULL),(12068,4,104,0,867,NULL),(12069,4,105,0,867,NULL),(12074,4,104,0,866,NULL),(12075,4,105,0,866,NULL),(12086,4,104,0,865,NULL),(12087,4,105,0,865,NULL),(12092,4,104,0,864,NULL),(12093,4,105,0,864,NULL),(12110,4,77,1,875,NULL),(12111,4,77,2,875,NULL),(12112,4,77,3,875,NULL),(12113,4,78,1,875,NULL),(12114,4,78,2,875,NULL),(12115,4,78,3,875,NULL),(12116,4,93,1,875,NULL),(12117,4,93,2,875,NULL),(12118,4,93,3,875,NULL),(12119,4,94,1,875,NULL),(12120,4,94,2,875,NULL),(12121,4,94,3,875,NULL),(12122,4,104,1,875,NULL),(12123,4,105,1,875,NULL),(12130,4,77,1,808,NULL),(12131,4,77,2,808,NULL),(12132,4,77,3,808,NULL),(12133,4,78,1,808,NULL),(12134,4,78,2,808,NULL),(12135,4,78,3,808,NULL),(12136,4,93,1,808,NULL),(12137,4,93,2,808,NULL),(12138,4,93,3,808,NULL),(12139,4,94,1,808,NULL),(12140,4,94,2,808,NULL),(12141,4,94,3,808,NULL),(12142,4,104,1,808,NULL),(12143,4,105,1,808,NULL),(12144,4,104,2,808,NULL),(12145,4,105,2,808,NULL),(12158,4,104,3,808,NULL),(12159,4,105,3,808,NULL),(12190,4,77,1,874,NULL),(12191,4,77,2,874,NULL),(12192,4,77,3,874,NULL),(12193,4,78,1,874,NULL),(12194,4,78,2,874,NULL),(12195,4,78,3,874,NULL),(12196,4,93,1,874,NULL),(12197,4,93,2,874,NULL),(12198,4,93,3,874,NULL),(12199,4,94,1,874,NULL),(12200,4,94,2,874,NULL),(12201,4,94,3,874,NULL),(12202,4,104,1,874,NULL),(12203,4,105,1,874,NULL),(12204,4,104,2,874,NULL),(12205,4,105,2,874,NULL),(12218,4,104,3,874,NULL),(12219,4,105,3,874,NULL),(12274,4,93,0,877,NULL),(12275,4,94,0,877,NULL),(12276,4,77,0,877,'2013-05-08 00:00:00'),(12277,4,78,0,877,NULL),(12278,4,104,0,877,'2013-05-08 00:00:00'),(12279,4,105,0,877,NULL),(12280,4,93,0,878,'2013-05-08 00:00:00'),(12281,4,94,0,878,NULL),(12282,4,77,0,878,'2013-05-08 00:00:00'),(12283,4,78,0,878,NULL),(12284,4,104,0,878,'2013-05-08 00:00:00'),(12285,4,105,0,878,NULL),(12328,4,93,0,879,NULL),(12329,4,94,0,879,NULL),(12330,4,77,0,879,'2013-03-20 00:00:00'),(12331,4,78,0,879,NULL),(12332,4,104,0,879,NULL),(12333,4,105,0,879,NULL),(12339,4,93,0,880,'2013-05-08 00:00:00'),(12340,4,94,0,880,NULL),(12341,4,77,0,880,'2013-05-08 00:00:00'),(12342,4,78,0,880,NULL),(12343,4,104,0,880,'2013-05-08 00:00:00'),(12344,4,105,0,880,NULL),(12345,4,93,0,881,'2013-05-08 00:00:00'),(12346,4,94,0,881,NULL),(12347,4,77,0,881,'2013-05-08 00:00:00'),(12348,4,78,0,881,NULL),(12349,4,104,0,881,'2013-05-08 00:00:00'),(12350,4,105,0,881,NULL),(13073,4,104,0,821,NULL),(13074,4,105,0,821,NULL),(13079,4,104,0,630,NULL),(13080,4,105,0,630,NULL),(13085,4,104,0,642,NULL),(13086,4,105,0,642,NULL),(13097,4,104,0,673,NULL),(13098,4,105,0,673,NULL),(13103,4,104,0,674,NULL),(13104,4,105,0,674,NULL),(13109,4,104,0,675,NULL),(13110,4,105,0,675,NULL),(13115,4,104,0,676,NULL),(13116,4,105,0,676,NULL),(13121,4,104,0,677,NULL),(13122,4,105,0,677,NULL),(13127,4,104,0,678,NULL),(13128,4,105,0,678,NULL),(13133,4,104,0,679,NULL),(13134,4,105,0,679,NULL),(13139,4,104,0,763,NULL),(13140,4,105,0,763,NULL),(13145,4,104,0,764,NULL),(13146,4,105,0,764,NULL),(13151,4,104,0,765,NULL),(13152,4,105,0,765,NULL),(13157,4,104,0,766,NULL),(13158,4,105,0,766,NULL),(13163,4,104,0,767,NULL),(13164,4,105,0,767,NULL),(13225,4,93,0,888,'2013-03-01 00:00:00'),(13226,4,94,0,888,NULL),(13227,4,77,0,888,'2013-03-01 00:00:00'),(13228,4,78,0,888,NULL),(13229,4,104,0,888,NULL),(13230,4,105,0,888,NULL),(13231,4,93,0,889,'2013-03-01 00:00:00'),(13232,4,94,0,889,NULL),(13233,4,77,0,889,'2013-03-01 00:00:00'),(13234,4,78,0,889,NULL),(13235,4,104,0,889,NULL),(13236,4,105,0,889,NULL),(13237,4,93,0,890,'2013-03-01 00:00:00'),(13238,4,94,0,890,NULL),(13239,4,77,0,890,'2013-03-01 00:00:00'),(13240,4,78,0,890,NULL),(13241,4,104,0,890,NULL),(13242,4,105,0,890,NULL),(13243,4,93,0,891,'2013-03-01 00:00:00'),(13244,4,94,0,891,NULL),(13245,4,77,0,891,'2013-03-01 00:00:00'),(13246,4,78,0,891,NULL),(13247,4,104,0,891,NULL),(13248,4,105,0,891,NULL),(13249,4,93,0,892,'2013-03-01 00:00:00'),(13250,4,94,0,892,NULL),(13251,4,77,0,892,'2013-03-01 00:00:00'),(13252,4,78,0,892,NULL),(13253,4,104,0,892,NULL),(13254,4,105,0,892,NULL),(13255,4,93,0,893,'2013-03-01 00:00:00'),(13256,4,94,0,893,NULL),(13257,4,77,0,893,'2013-03-01 00:00:00'),(13258,4,78,0,893,NULL),(13259,4,104,0,893,NULL),(13260,4,105,0,893,NULL),(13261,4,93,0,894,'2013-03-01 00:00:00'),(13262,4,94,0,894,NULL),(13263,4,77,0,894,'2013-03-01 00:00:00'),(13264,4,78,0,894,NULL),(13265,4,104,0,894,NULL),(13266,4,105,0,894,NULL),(13267,4,93,0,895,'2013-03-01 00:00:00'),(13268,4,94,0,895,NULL),(13269,4,77,0,895,'2013-03-01 00:00:00'),(13270,4,78,0,895,NULL),(13271,4,104,0,895,NULL),(13272,4,105,0,895,NULL),(13273,4,93,0,896,'2013-03-01 00:00:00'),(13274,4,94,0,896,NULL),(13275,4,77,0,896,'2013-03-01 00:00:00'),(13276,4,78,0,896,NULL),(13277,4,104,0,896,NULL),(13278,4,105,0,896,NULL),(13287,4,93,0,897,NULL),(13288,4,94,0,897,NULL),(13289,4,77,0,897,NULL),(13290,4,78,0,897,NULL),(13291,4,104,0,897,NULL),(13292,4,105,0,897,NULL),(13293,4,93,0,898,NULL),(13294,4,94,0,898,NULL),(13295,4,77,0,898,NULL),(13296,4,78,0,898,NULL),(13297,4,104,0,898,NULL),(13298,4,105,0,898,NULL),(13299,4,93,0,899,NULL),(13300,4,94,0,899,NULL),(13301,4,77,0,899,NULL),(13302,4,78,0,899,NULL),(13303,4,104,0,899,NULL),(13304,4,105,0,899,NULL),(13305,4,93,0,900,NULL),(13306,4,94,0,900,NULL),(13307,4,77,0,900,NULL),(13308,4,78,0,900,NULL),(13309,4,104,0,900,NULL),(13310,4,105,0,900,NULL),(13311,4,93,0,901,NULL),(13312,4,94,0,901,NULL),(13313,4,77,0,901,NULL),(13314,4,78,0,901,NULL),(13315,4,104,0,901,NULL),(13316,4,105,0,901,NULL),(13317,4,93,0,902,NULL),(13318,4,94,0,902,NULL),(13319,4,77,0,902,NULL),(13320,4,78,0,902,NULL),(13321,4,104,0,902,NULL),(13322,4,105,0,902,NULL),(13323,4,93,0,903,NULL),(13324,4,94,0,903,NULL),(13325,4,77,0,903,NULL),(13326,4,78,0,903,NULL),(13327,4,104,0,903,NULL),(13328,4,105,0,903,NULL),(13329,4,93,0,904,NULL),(13330,4,94,0,904,NULL),(13331,4,77,0,904,NULL),(13332,4,78,0,904,NULL),(13333,4,104,0,904,NULL),(13334,4,105,0,904,NULL),(13335,4,93,0,905,NULL),(13336,4,94,0,905,NULL),(13337,4,77,0,905,NULL),(13338,4,78,0,905,NULL),(13339,4,104,0,905,NULL),(13340,4,105,0,905,NULL);
/*!40000 ALTER TABLE `catalog_product_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_entity_decimal`
--

DROP TABLE IF EXISTS `catalog_product_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10616 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_entity_gallery`
--

DROP TABLE IF EXISTS `catalog_product_entity_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_group_price`
--

DROP TABLE IF EXISTS `catalog_product_entity_group_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_group_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CC12C83765B562314470A24F2BDD0F36` (`entity_id`,`all_groups`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DF909D22C11B60B1E5E3EE64AB220ECE` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_int`
--

DROP TABLE IF EXISTS `catalog_product_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21435 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_entity_media_gallery`
--

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2802 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_media_gallery_value`
--

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_text`
--

DROP TABLE IF EXISTS `catalog_product_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7950 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_entity_text`
--

LOCK TABLES `catalog_product_entity_text` WRITE;
/*!40000 ALTER TABLE `catalog_product_entity_text` DISABLE KEYS */;
INSERT INTO `catalog_product_entity_text` VALUES (1464,4,72,0,231,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(1465,4,83,0,231,NULL),(1466,4,73,0,231,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(1467,4,106,0,231,NULL),(1468,4,72,0,232,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(1469,4,83,0,232,NULL),(1470,4,73,0,232,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(1471,4,106,0,232,NULL),(1472,4,72,0,233,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(1473,4,83,0,233,NULL),(1474,4,73,0,233,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(1475,4,106,0,233,NULL),(1476,4,72,0,234,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(1477,4,83,0,234,NULL),(1478,4,73,0,234,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(1479,4,106,0,234,NULL),(1480,4,72,0,235,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(1481,4,83,0,235,NULL),(1482,4,73,0,235,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(1483,4,106,0,235,NULL),(1484,4,72,0,236,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(1485,4,83,0,236,NULL),(1486,4,73,0,236,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(1487,4,106,0,236,NULL),(1488,4,72,0,237,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(1489,4,83,0,237,NULL),(1490,4,73,0,237,'This everyday shirt is equally stylish with jeans or trousers.'),(1491,4,106,0,237,NULL),(1492,4,72,0,238,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(1493,4,83,0,238,NULL),(1494,4,73,0,238,'This everyday shirt is equally stylish with jeans or trousers.'),(1495,4,106,0,238,NULL),(1496,4,72,0,239,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(1497,4,83,0,239,NULL),(1498,4,73,0,239,'This everyday shirt is equally stylish with jeans or trousers.'),(1499,4,106,0,239,NULL),(1500,4,72,0,240,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(1501,4,83,0,240,NULL),(1502,4,73,0,240,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(1503,4,106,0,240,NULL),(1504,4,72,0,241,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(1505,4,83,0,241,NULL),(1506,4,73,0,241,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(1507,4,106,0,241,NULL),(1508,4,72,0,242,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(1509,4,83,0,242,NULL),(1510,4,73,0,242,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(1511,4,106,0,242,NULL),(1512,4,72,0,243,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(1513,4,83,0,243,NULL),(1514,4,73,0,243,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(1515,4,106,0,243,NULL),(1516,4,72,0,244,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(1517,4,83,0,244,NULL),(1518,4,73,0,244,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(1519,4,106,0,244,NULL),(1520,4,72,0,245,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(1521,4,83,0,245,NULL),(1522,4,73,0,245,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(1523,4,106,0,245,NULL),(1524,4,72,0,246,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(1525,4,83,0,246,NULL),(1526,4,73,0,246,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(1527,4,106,0,246,NULL),(1528,4,72,0,247,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(1529,4,83,0,247,NULL),(1530,4,73,0,247,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(1531,4,106,0,247,NULL),(1532,4,72,0,248,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(1533,4,83,0,248,NULL),(1534,4,73,0,248,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(1535,4,106,0,248,NULL),(1536,4,72,0,249,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1537,4,83,0,249,NULL),(1538,4,73,0,249,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1539,4,106,0,249,NULL),(1540,4,72,0,250,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1541,4,83,0,250,NULL),(1542,4,73,0,250,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1543,4,106,0,250,NULL),(1544,4,72,0,251,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1545,4,83,0,251,NULL),(1546,4,73,0,251,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1547,4,106,0,251,NULL),(1548,4,72,0,252,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1549,4,83,0,252,NULL),(1550,4,73,0,252,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1551,4,106,0,252,NULL),(1552,4,72,0,253,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1553,4,83,0,253,NULL),(1554,4,73,0,253,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1555,4,106,0,253,NULL),(1556,4,72,0,254,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(1557,4,83,0,254,NULL),(1558,4,73,0,254,'Minimalist style and maximum comfort meet in this lightweight tee.'),(1559,4,106,0,254,NULL),(1560,4,72,0,255,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(1561,4,83,0,255,NULL),(1562,4,73,0,255,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(1563,4,106,0,255,NULL),(1564,4,72,0,256,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(1565,4,83,0,256,NULL),(1566,4,73,0,256,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(1567,4,106,0,256,NULL),(1568,4,72,0,257,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(1569,4,83,0,257,NULL),(1570,4,73,0,257,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(1571,4,106,0,257,NULL),(1572,4,72,0,258,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(1573,4,83,0,258,NULL),(1574,4,73,0,258,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(1575,4,106,0,258,NULL),(1576,4,72,0,259,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(1577,4,83,0,259,NULL),(1578,4,73,0,259,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(1579,4,106,0,259,NULL),(1580,4,72,0,260,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(1581,4,83,0,260,NULL),(1582,4,73,0,260,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(1583,4,106,0,260,NULL),(1584,4,72,0,261,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(1585,4,83,0,261,NULL),(1586,4,73,0,261,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(1587,4,106,0,261,NULL),(1588,4,72,0,262,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(1589,4,83,0,262,NULL),(1590,4,73,0,262,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(1591,4,106,0,262,NULL),(1592,4,72,0,263,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(1593,4,83,0,263,NULL),(1594,4,73,0,263,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(1595,4,106,0,263,NULL),(1608,4,72,0,267,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(1609,4,83,0,267,NULL),(1610,4,73,0,267,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(1611,4,106,0,267,NULL),(1612,4,72,0,268,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(1613,4,83,0,268,NULL),(1614,4,73,0,268,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(1615,4,106,0,268,NULL),(1616,4,72,0,269,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(1617,4,83,0,269,NULL),(1618,4,73,0,269,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(1619,4,106,0,269,NULL),(1620,4,72,0,270,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1621,4,83,0,270,NULL),(1622,4,73,0,270,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1623,4,106,0,270,NULL),(1624,4,72,0,271,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1625,4,83,0,271,NULL),(1626,4,73,0,271,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1627,4,106,0,271,NULL),(1628,4,72,0,272,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1629,4,83,0,272,NULL),(1630,4,73,0,272,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1631,4,106,0,272,NULL),(1632,4,72,0,273,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1633,4,83,0,273,NULL),(1634,4,73,0,273,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1635,4,106,0,273,NULL),(1636,4,72,0,274,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1637,4,83,0,274,NULL),(1638,4,73,0,274,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1639,4,106,0,274,NULL),(1640,4,72,0,275,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(1641,4,83,0,275,NULL),(1642,4,73,0,275,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(1643,4,106,0,275,NULL),(1644,4,72,0,276,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1645,4,83,0,276,NULL),(1646,4,73,0,276,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1647,4,106,0,276,NULL),(1648,4,72,0,277,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1649,4,83,0,277,NULL),(1650,4,73,0,277,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1651,4,106,0,277,NULL),(1652,4,72,0,278,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1653,4,83,0,278,NULL),(1654,4,73,0,278,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1655,4,106,0,278,NULL),(1656,4,72,0,279,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1657,4,83,0,279,NULL),(1658,4,73,0,279,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1659,4,106,0,279,NULL),(1660,4,72,0,280,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1661,4,83,0,280,NULL),(1662,4,73,0,280,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1663,4,106,0,280,NULL),(1664,4,72,0,281,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(1665,4,83,0,281,NULL),(1666,4,73,0,281,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(1667,4,106,0,281,NULL),(1668,4,72,0,282,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(1669,4,83,0,282,NULL),(1670,4,73,0,282,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(1671,4,106,0,282,NULL),(1672,4,72,0,283,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(1673,4,83,0,283,NULL),(1674,4,73,0,283,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(1675,4,106,0,283,NULL),(1676,4,72,0,284,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(1677,4,83,0,284,NULL),(1678,4,73,0,284,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(1679,4,106,0,284,NULL),(1680,4,72,0,285,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(1681,4,83,0,285,NULL),(1682,4,73,0,285,'A simple ribbed cotton tank. Great for layering.'),(1683,4,106,0,285,NULL),(1684,4,72,0,286,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(1685,4,83,0,286,NULL),(1686,4,73,0,286,'A simple ribbed cotton tank. Great for layering.'),(1687,4,106,0,286,NULL),(1688,4,72,0,287,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(1689,4,83,0,287,NULL),(1690,4,73,0,287,'A simple ribbed cotton tank. Great for layering.'),(1691,4,106,0,287,NULL),(1692,4,72,0,288,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(1693,4,83,0,288,NULL),(1694,4,73,0,288,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(1695,4,106,0,288,NULL),(1696,4,72,0,289,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(1697,4,83,0,289,NULL),(1698,4,73,0,289,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(1699,4,106,0,289,NULL),(1700,4,72,0,290,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(1701,4,83,0,290,NULL),(1702,4,73,0,290,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(1703,4,106,0,290,NULL),(1704,4,72,0,291,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(1705,4,83,0,291,NULL),(1706,4,73,0,291,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(1707,4,106,0,291,NULL),(1708,4,72,0,292,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(1709,4,83,0,292,NULL),(1710,4,73,0,292,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(1711,4,106,0,292,NULL),(1712,4,72,0,293,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(1713,4,83,0,293,NULL),(1714,4,73,0,293,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(1715,4,106,0,293,NULL),(1716,4,72,0,294,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(1717,4,83,0,294,NULL),(1718,4,73,0,294,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(1719,4,106,0,294,NULL),(1720,4,72,0,295,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(1721,4,83,0,295,NULL),(1722,4,73,0,295,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(1723,4,106,0,295,NULL),(1724,4,72,0,296,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(1725,4,83,0,296,NULL),(1726,4,73,0,296,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(1727,4,106,0,296,NULL),(1728,4,72,0,297,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(1729,4,83,0,297,NULL),(1730,4,73,0,297,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(1731,4,106,0,297,NULL),(1732,4,72,0,298,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(1733,4,83,0,298,NULL),(1734,4,73,0,298,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(1735,4,106,0,298,NULL),(1736,4,72,0,299,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(1737,4,83,0,299,NULL),(1738,4,73,0,299,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(1739,4,106,0,299,NULL),(1740,4,72,0,300,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(1741,4,83,0,300,NULL),(1742,4,73,0,300,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(1743,4,106,0,300,NULL),(1744,4,72,0,301,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(1745,4,83,0,301,NULL),(1746,4,73,0,301,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(1747,4,106,0,301,NULL),(1748,4,72,0,302,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(1749,4,83,0,302,NULL),(1750,4,73,0,302,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(1751,4,106,0,302,NULL),(1752,4,72,0,303,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(1753,4,83,0,303,NULL),(1754,4,73,0,303,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(1755,4,106,0,303,NULL),(1756,4,72,0,304,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(1757,4,83,0,304,NULL),(1758,4,73,0,304,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(1759,4,106,0,304,NULL),(1760,4,72,0,305,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(1761,4,83,0,305,NULL),(1762,4,73,0,305,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(1763,4,106,0,305,NULL),(1764,4,72,0,306,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(1765,4,83,0,306,NULL),(1766,4,73,0,306,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(1767,4,106,0,306,NULL),(1768,4,72,0,307,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(1769,4,83,0,307,NULL),(1770,4,73,0,307,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(1771,4,106,0,307,NULL),(1772,4,72,0,308,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(1773,4,83,0,308,NULL),(1774,4,73,0,308,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(1775,4,106,0,308,NULL),(1776,4,72,0,309,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(1777,4,83,0,309,NULL),(1778,4,73,0,309,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(1779,4,106,0,309,NULL),(1780,4,72,0,310,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(1781,4,83,0,310,NULL),(1782,4,73,0,310,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(1783,4,106,0,310,NULL),(1784,4,72,0,311,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(1785,4,83,0,311,NULL),(1786,4,73,0,311,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(1787,4,106,0,311,NULL),(1788,4,72,0,312,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(1789,4,83,0,312,NULL),(1790,4,73,0,312,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(1791,4,106,0,312,NULL),(1792,4,72,0,313,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(1793,4,83,0,313,NULL),(1794,4,73,0,313,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(1795,4,106,0,313,NULL),(1796,4,72,0,314,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(1797,4,83,0,314,NULL),(1798,4,73,0,314,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(1799,4,106,0,314,NULL),(1840,4,72,0,325,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(1841,4,83,0,325,NULL),(1842,4,73,0,325,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(1843,4,106,0,325,NULL),(1844,4,72,0,326,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(1845,4,83,0,326,NULL),(1846,4,73,0,326,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(1847,4,106,0,326,NULL),(1848,4,72,0,327,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(1849,4,83,0,327,NULL),(1850,4,73,0,327,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(1851,4,106,0,327,NULL),(1852,4,72,0,328,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(1853,4,83,0,328,NULL),(1854,4,73,0,328,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(1855,4,106,0,328,NULL),(1856,4,72,0,329,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(1857,4,83,0,329,NULL),(1858,4,73,0,329,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(1859,4,106,0,329,NULL),(1902,4,72,0,337,'Gunmetal frame with crystal gradient polycarbonate lenses in grey. '),(1903,4,83,0,337,NULL),(1904,4,73,0,337,'A timeless accessory staple, the unmistakable teardrop lenses of our Aviator sunglasses appeal to everyone from suits to rock stars to citizens of the world.'),(1905,4,106,0,337,NULL),(1906,4,205,0,337,'Eyewear'),(1907,4,204,0,337,NULL),(1908,4,72,0,338,'Acetate frame. Polycarbonate lenses.'),(1909,4,83,0,338,NULL),(1910,4,73,0,338,'These distinct, feminine frames balance a classic Jackie-O styling with a modern look. '),(1911,4,106,0,338,NULL),(1912,4,205,0,338,'Eyewear'),(1913,4,204,0,338,NULL),(1914,4,72,0,339,'Acetate frame. Polycarbonate lenses.'),(1915,4,83,0,339,NULL),(1916,4,73,0,339,'Madison Island Retro chic lenses are stylish on both men and women.'),(1917,4,106,0,339,NULL),(1918,4,205,0,339,'Eyewear'),(1919,4,204,0,339,NULL),(1920,4,72,0,340,'Leather. 3.5\" heel. Peep toe and anknle strap. Leather insole and lining.'),(1921,4,83,0,340,NULL),(1922,4,185,0,340,'M'),(1923,4,73,0,340,'Step forward with a fresh and neutral hued finish.'),(1924,4,106,0,340,NULL),(1925,4,72,0,341,'Leather. 3.5\" heel. Peep toe and anknle strap. Leather insole and lining.'),(1926,4,83,0,341,NULL),(1927,4,185,0,341,'M'),(1928,4,73,0,341,'Step forward with a fresh and neutral hued finish.'),(1929,4,106,0,341,NULL),(1930,4,72,0,342,'Leather. 3.5\" heel. Peep toe and anknle strap. Leather insole and lining.'),(1931,4,83,0,342,NULL),(1932,4,185,0,342,'M'),(1933,4,73,0,342,'Step forward with a fresh and neutral hued finish.'),(1934,4,106,0,342,NULL),(1935,4,72,0,343,'Leather. 3.5\" heel. Peep toe and anknle strap. Leather insole and lining.'),(1936,4,83,0,343,NULL),(1937,4,185,0,343,'M'),(1938,4,73,0,343,'Step forward with a fresh and neutral hued finish.'),(1939,4,106,0,343,NULL),(1940,4,72,0,344,'Leather. 3.5\" heel. Peep toe and anknle strap. Leather insole and lining.'),(1941,4,83,0,344,NULL),(1942,4,185,0,344,'M'),(1943,4,73,0,344,'Step forward with a fresh and neutral hued finish.'),(1944,4,106,0,344,NULL),(1945,4,72,0,345,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(1946,4,83,0,345,NULL),(1947,4,185,0,345,'M'),(1948,4,73,0,345,'A stylish companion to your LBD or skinny jeans.'),(1949,4,106,0,345,NULL),(1950,4,72,0,346,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(1951,4,83,0,346,NULL),(1952,4,185,0,346,'M'),(1953,4,73,0,346,'A stylish companion to your LBD or skinny jeans.'),(1954,4,106,0,346,NULL),(1955,4,72,0,347,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(1956,4,83,0,347,NULL),(1957,4,185,0,347,'M'),(1958,4,73,0,347,'A stylish companion to your LBD or skinny jeans.'),(1959,4,106,0,347,NULL),(1960,4,72,0,348,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(1961,4,83,0,348,NULL),(1962,4,185,0,348,'M'),(1963,4,73,0,348,'A stylish companion to your LBD or skinny jeans.'),(1964,4,106,0,348,NULL),(1965,4,72,0,349,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(1966,4,83,0,349,NULL),(1967,4,185,0,349,'M'),(1968,4,73,0,349,'A stylish companion to your LBD or skinny jeans.'),(1969,4,106,0,349,NULL),(1970,4,72,0,350,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(1971,4,83,0,350,NULL),(1972,4,185,0,350,'M'),(1973,4,73,0,350,'The slip on style is ideal for everyday use.'),(1974,4,106,0,350,NULL),(1975,4,72,0,351,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(1976,4,83,0,351,NULL),(1977,4,185,0,351,'M'),(1978,4,73,0,351,'The slip on style is ideal for everyday use.'),(1979,4,106,0,351,NULL),(1980,4,72,0,352,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(1981,4,83,0,352,NULL),(1982,4,185,0,352,'M'),(1983,4,73,0,352,'The slip on style is ideal for everyday use.'),(1984,4,106,0,352,NULL),(1985,4,72,0,353,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(1986,4,83,0,353,NULL),(1987,4,185,0,353,'M'),(1988,4,73,0,353,'The slip on style is ideal for everyday use.'),(1989,4,106,0,353,NULL),(1990,4,72,0,354,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(1991,4,83,0,354,NULL),(1992,4,185,0,354,'M'),(1993,4,73,0,354,'The slip on style is ideal for everyday use.'),(1994,4,106,0,354,NULL),(1995,4,72,0,355,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(1996,4,83,0,355,NULL),(1997,4,185,0,355,'M'),(1998,4,73,0,355,'Crafted from premium polished leather, unrivaled in design.'),(1999,4,106,0,355,NULL),(2000,4,72,0,356,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(2001,4,83,0,356,NULL),(2002,4,185,0,356,'M'),(2003,4,73,0,356,'Crafted from premium polished leather, unrivaled in design.'),(2004,4,106,0,356,NULL),(2005,4,72,0,357,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(2006,4,83,0,357,NULL),(2007,4,185,0,357,'M'),(2008,4,73,0,357,'Crafted from premium polished leather, unrivaled in design.'),(2009,4,106,0,357,NULL),(2010,4,72,0,358,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(2011,4,83,0,358,NULL),(2012,4,185,0,358,'M'),(2013,4,73,0,358,'Crafted from premium polished leather, unrivaled in design.'),(2014,4,106,0,358,NULL),(2015,4,72,0,359,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(2016,4,83,0,359,NULL),(2017,4,185,0,359,'M'),(2018,4,73,0,359,'Crafted from premium polished leather, unrivaled in design.'),(2019,4,106,0,359,NULL),(2020,4,72,0,360,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2021,4,83,0,360,NULL),(2022,4,185,0,360,'M'),(2023,4,73,0,360,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2024,4,106,0,360,NULL),(2025,4,72,0,361,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2026,4,83,0,361,NULL),(2027,4,185,0,361,'M'),(2028,4,73,0,361,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2029,4,106,0,361,NULL),(2030,4,72,0,362,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2031,4,83,0,362,NULL),(2032,4,185,0,362,'M'),(2033,4,73,0,362,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2034,4,106,0,362,NULL),(2035,4,72,0,363,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2036,4,83,0,363,NULL),(2037,4,185,0,363,'M'),(2038,4,73,0,363,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2039,4,106,0,363,NULL),(2040,4,72,0,364,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2041,4,83,0,364,NULL),(2042,4,185,0,364,'M'),(2043,4,73,0,364,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2044,4,106,0,364,NULL),(2045,4,72,0,365,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2046,4,83,0,365,NULL),(2047,4,185,0,365,'M'),(2048,4,73,0,365,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2049,4,106,0,365,NULL),(2050,4,72,0,366,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2051,4,83,0,366,NULL),(2052,4,185,0,366,'M'),(2053,4,73,0,366,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2054,4,106,0,366,NULL),(2055,4,72,0,367,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2056,4,83,0,367,NULL),(2057,4,185,0,367,'M'),(2058,4,73,0,367,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2059,4,106,0,367,NULL),(2060,4,72,0,368,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2061,4,83,0,368,NULL),(2062,4,185,0,368,'M'),(2063,4,73,0,368,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2064,4,106,0,368,NULL),(2065,4,72,0,369,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2066,4,83,0,369,NULL),(2067,4,185,0,369,'M'),(2068,4,73,0,369,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2069,4,106,0,369,NULL),(2070,4,72,0,370,'Pebbled leather. Contrast stitching. Fold over flap with Fasten closure. Crossbody strap. 6\" x 8\" x 0.75\".'),(2071,4,83,0,370,NULL),(2072,4,73,0,370,'Form follows function with this decidedly chic mini bag. '),(2073,4,106,0,370,NULL),(2074,4,205,0,370,'Bags & Luggage'),(2075,4,204,0,370,'Frequent'),(2076,4,72,0,371,'Leather. Silver hardware. Inside open pocket. Fasten closure, fabric lining. Handles with 7\" drop. 14\" x 3.5\" x 9\". Imported.'),(2077,4,83,0,371,NULL),(2078,4,73,0,371,'Carry it all with the spacious and stylishFlorentine Satchel.'),(2079,4,106,0,371,NULL),(2080,4,205,0,371,'Bags & Luggage'),(2081,4,204,0,371,'Frequent'),(2082,4,72,0,372,'Pebble textured leather tabled case. Top zip closure. Exterior zipper pocket. Fully lined with back wall slip pocket. 8.75\" x 11\" x .5\". Imported.'),(2083,4,83,0,372,NULL),(2084,4,73,0,372,'Protect your tablet with our minimal tablet sleeve.'),(2085,4,106,0,372,NULL),(2086,4,205,0,372,'Bags & Luggage'),(2087,4,204,0,372,'Business'),(2088,4,72,0,373,'Leather, with flap closure. Padded carrying handles. Main compartment has padded laptop pocket, file section and organizer panel. Quick access back pocket. Padded adjustable shoulder strap. 16\" x 12\" x 3.5\". Domestic.'),(2089,4,83,0,373,NULL),(2090,4,73,0,373,'Make an impression at overseas business meetings.'),(2091,4,106,0,373,NULL),(2092,4,205,0,373,'Bags & Luggage'),(2093,4,204,0,373,'Business'),(2094,4,72,0,374,'Leather. 4\" x 6.5\" x 0.5\"'),(2095,4,83,0,374,NULL),(2096,4,73,0,374,'Just the right size for your passport, tickets and other essentials, this leather wallet is the perfect travel carry all.'),(2097,4,106,0,374,NULL),(2098,4,205,0,374,'Bags & Luggage'),(2099,4,204,0,374,'Frequent'),(2100,4,72,0,375,'Zip closure. Water resistant hard polycarbonate shell. All direction spinner wheels. Retractable plastic handle. Cross strap interior. 29\" x 20\" x 13\".'),(2101,4,83,0,375,NULL),(2102,4,73,0,375,'No more baggage claim mixups! Our Roller in bold cobalt blue is sure to standout in a sea of suitcases.'),(2103,4,106,0,375,NULL),(2104,4,205,0,375,'Bags & Luggage'),(2105,4,204,0,375,'Weekend'),(2106,4,72,0,376,'Water resistant hard polycarbonate shell. All direction spinner wheels. Zip closure. Locking, retractable metal handle. Cross strap and self repairing zipper interior. Padded side handle for lateral carry. 21\" x 17\" x 10\".'),(2107,4,83,0,376,NULL),(2108,4,73,0,376,'Some like it classic. This luggage provides ample room for multiday trips.'),(2109,4,106,0,376,NULL),(2110,4,205,0,376,'Bags & Luggage'),(2111,4,204,0,376,'Business'),(2112,4,72,0,377,'Water resistant hard polycarbonate shell. All direction spinner wheels. Zip closure. Locking, retractable metal handle. Cross strap and self repairing zipper interior. Padded side handle for lateral carry. 29\" x 20\" x 13\".'),(2113,4,83,0,377,NULL),(2114,4,73,0,377,'Some like it classic. This luggage provides ample room for multiday trips.'),(2115,4,106,0,377,NULL),(2116,4,205,0,377,'Bags & Luggage'),(2117,4,204,0,377,'Business'),(2118,4,72,0,378,'Lemon flower and Aloe Vera extract. Super moisturizing. '),(2119,4,83,0,378,NULL),(2120,4,73,0,378,'A rich lather, infused with lemon flower awakens the senses.'),(2121,4,106,0,378,NULL),(2122,4,72,0,379,'100% pure Dead Sea salts. Fragrance.'),(2123,4,83,0,379,NULL),(2124,4,73,0,379,'Just what your body needs after a long day on the road. Soak, relax and reenergize with 100% natural Dead Sea salt crystals and minerals.'),(2125,4,106,0,379,NULL),(2126,4,72,0,380,'Milk and shea extracts. Long lasting moisturizer. 100% natural and gentle enough for sensitive skin. Fast absorbing. Non greasy. 250mL/8.4oz. Domestic.'),(2127,4,83,0,380,NULL),(2128,4,73,0,380,'Experience the perfect escape with this irresistable blend of milk extract and shea.'),(2129,4,106,0,380,NULL),(2130,4,72,0,381,'20\" x 20\". Raw Silk. Hidden zipper closure. Interior pillow included. 100% polyester fill. Dry clean. Imported.'),(2131,4,83,0,381,NULL),(2132,4,73,0,381,'An exquisite home accent, our bazaar inspired raw silk square pillow is a statement in luxury. Interior pillow included.'),(2133,4,106,0,381,NULL),(2134,4,72,0,382,'20\" x 20\". Printed polyester. Hidden zipper closure. Interior pillow included. 100% polyester fill. Spot clean. Imported.'),(2135,4,83,0,382,NULL),(2136,4,73,0,382,'A distinctive printed pillow that fills any room with classic appeal.'),(2137,4,106,0,382,NULL),(2138,4,72,0,383,'Woven alpaca wool. 4\" fringe detail. Dry clean. Imported.'),(2139,4,83,0,383,NULL),(2140,4,73,0,383,'A luxuriously soft throw made of long-fiber lambs wool woven into a Chevron twill.'),(2141,4,106,0,383,NULL),(2142,4,72,0,384,'Woven acrylic/wool/cotton. 50\" x 75\". Spot clean.'),(2143,4,83,0,384,NULL),(2144,4,73,0,384,'A rustic wool blend leaves our Park Row Throw feeling lofty and warm. Packs perfectly into carry-ons.'),(2145,4,106,0,384,NULL),(2146,4,72,0,385,'Woven cotton. 60\" x 72\". Machine wash.'),(2147,4,83,0,385,NULL),(2148,4,73,0,385,'Wrap yourself in this incredibly soft and luxurious blanket for all climate comfort. '),(2149,4,106,0,385,NULL),(2150,4,72,0,386,'Blown glass. 10\" diameter. 17\" high. Imported.'),(2151,4,83,0,386,NULL),(2152,4,73,0,386,'The uniquely shaped Herand Glass Vase packs easily and adds instant impact.'),(2153,4,106,0,386,NULL),(2154,4,72,0,387,'Ceramic. 5.5\" diameter, 12\" high. '),(2155,4,83,0,387,NULL),(2156,4,73,0,387,'Modern, edgy, distinct. Choose from two colors.'),(2157,4,106,0,387,NULL),(2158,4,72,0,388,'Ceramic. 5.5\" diameter, 12\" high. Domestic.'),(2159,4,83,0,388,NULL),(2160,4,73,0,388,'Modern, edgy, distinct. Choose from two colors.'),(2161,4,106,0,388,NULL),(2162,4,72,0,389,'Glazed stoneware. 2\" diam. 5.5\" x 5.5\" coaster. Set of 2. Domestic.'),(2163,4,83,0,389,NULL),(2164,4,73,0,389,'A subtle nod to Old World antiquity.'),(2165,4,106,0,389,NULL),(2166,4,72,0,390,'8\" diffuser reeds. 2oz fragrance oil. Decorative wood container.'),(2167,4,83,0,390,NULL),(2168,4,73,0,390,'A clean and effective delivery of continuous flameless fragrance to enhance your home.'),(2169,4,106,0,390,NULL),(2170,4,72,0,391,'Painted glass. Geometric pattern. Set of 3. Domestic.'),(2171,4,83,0,391,NULL),(2172,4,73,0,391,'A simple and stylish way to add warmth and dimension to any room. Perfect for gifting.'),(2173,4,106,0,391,NULL),(2174,4,72,0,392,'10x Optical Zoom with 24mm Wide-angle and close up.10.7-megapixel backside illuminated CMOS sensor for low light shooting.  3\" Multi-angle LCD. SD/SDXC slot. Full HD Video. High speed continuous shooting (up to 5 shots in approx one second) Built in GPS. Easy Panorama. Rechargable Li-ion battery. File formats: Still-JPEG, Audio- WAV, Movies-MOV. Image size: up to 4600x3400. Built in flash. 3.5\" x 5\" x 4\". 20oz.'),(2175,4,83,0,392,NULL),(2176,4,73,0,392,'The compact travel friendly solution for sightseers.'),(2177,4,106,0,392,NULL),(2178,4,72,0,393,'18-55mm zoom lens. 3.0\" LCD display with image editing features.  Built in flash with flash modes and pop up. SD/SDXC slot. Full 1080p HD video. Rechargable Lithium-Ion battery. File formats: NEF (RAW), JPEG, MOV. 5\" x 3\" x 4\", 15oz.'),(2179,4,83,0,393,NULL),(2180,4,73,0,393,'For budding photo connoisseurs.'),(2181,4,106,0,393,NULL),(2182,4,72,0,394,'16GB SD memory card. Shock, water, and xray resistant.'),(2183,4,83,0,394,NULL),(2184,4,73,0,394,'Keeping all your travel memories compact. 16GB.'),(2185,4,106,0,394,NULL),(2186,4,72,0,395,'8GB SD memory card. Shock, water, and xray resistant.'),(2187,4,83,0,395,NULL),(2188,4,73,0,395,'Keeping all your travel memories compact. 8GB.'),(2189,4,106,0,395,NULL),(2190,4,72,0,396,'Flap closure. Microfiber. 8.5\" x 5\" x 6\". Domestic.'),(2191,4,83,0,396,NULL),(2192,4,73,0,396,'Keep your camera safe and secure in our Large Camera case.'),(2193,4,106,0,396,NULL),(2194,4,72,0,397,'Balanced audio. Enhanced bass.  Includes cable clip, diaphragm guard, cleaning tool, travel pouch and airline adapter.'),(2195,4,83,0,397,NULL),(2196,4,73,0,397,'Why not play the Amelie Soundtrack while parading through Parisian rues? Madison earbuds deliver crisp clear sound with minimal distortion.'),(2197,4,106,0,397,NULL),(2198,4,72,0,398,'Steel and aluminum. Soft leather pivoting earcups and adjustable headband.  Enhanced bass. Aggressive noise cancellation.'),(2199,4,83,0,398,NULL),(2200,4,73,0,398,'Escape the sleepless city buzz with robust sound and aggressive noise cancellation.'),(2201,4,106,0,398,NULL),(2202,4,72,0,399,'2.5-inch LCD screen for crisp, colorful video. Compatible with multiple audio formats. Available in 8GB. Earbuds not included.'),(2203,4,83,0,399,NULL),(2204,4,73,0,399,'Expidite a long flight by getting into the groove with our plug and play mp3 player. Download movies, pictures or up to 3000 songs with the included USB cable.'),(2205,4,106,0,399,NULL),(2206,4,72,0,400,'Ultra Compact. Up to 4GB built in flash memory. The microSD slot supports up to a 16GB microSDHC card for expanded storage options. Music and radio. Lithium-ion battery that runs up to 8 hours when fully charged. USB cable included. Earbuds not included.'),(2207,4,83,0,400,NULL),(2208,4,73,0,400,'Save space without sacrificing sound quality.'),(2209,4,106,0,400,NULL),(2216,4,72,0,402,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(2217,4,83,0,402,NULL),(2218,4,73,0,402,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(2219,4,106,0,402,NULL),(2220,4,72,0,403,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(2221,4,83,0,403,NULL),(2222,4,73,0,403,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(2223,4,106,0,403,NULL),(2224,4,72,0,404,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(2225,4,83,0,404,NULL),(2226,4,73,0,404,'This everyday shirt is equally stylish with jeans or trousers.'),(2227,4,106,0,404,NULL),(2228,4,72,0,405,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(2229,4,83,0,405,NULL),(2230,4,73,0,405,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(2231,4,106,0,405,NULL),(2232,4,72,0,406,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(2233,4,83,0,406,NULL),(2234,4,73,0,406,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(2235,4,106,0,406,NULL),(2236,4,72,0,407,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(2237,4,83,0,407,NULL),(2238,4,73,0,407,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(2239,4,106,0,407,NULL),(2240,4,72,0,408,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(2241,4,83,0,408,NULL),(2242,4,73,0,408,'Minimalist style and maximum comfort meet in this lightweight tee.'),(2243,4,106,0,408,NULL),(2244,4,72,0,409,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(2245,4,83,0,409,NULL),(2246,4,73,0,409,'Minimalist style and maximum comfort meet in this lightweight tee.'),(2247,4,106,0,409,NULL),(2248,4,72,0,410,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(2249,4,83,0,410,NULL),(2250,4,73,0,410,'Minimalist style and maximum comfort meet in this lightweight tee.'),(2251,4,106,0,410,NULL),(2252,4,72,0,411,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(2253,4,83,0,411,NULL),(2254,4,73,0,411,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(2255,4,106,0,411,NULL),(2256,4,72,0,412,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(2257,4,83,0,412,NULL),(2258,4,73,0,412,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(2259,4,106,0,412,NULL),(2260,4,72,0,413,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(2261,4,83,0,413,NULL),(2262,4,73,0,413,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(2263,4,106,0,413,NULL),(2264,4,72,0,414,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(2265,4,83,0,414,NULL),(2266,4,73,0,414,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(2267,4,106,0,414,NULL),(2268,4,72,0,415,'Lightly faded cotton denim. Sits below waist. Slim through hip and thigh. 15\" leg opening. Zip fly. Machine wash. '),(2269,4,83,0,415,NULL),(2270,4,73,0,415,'The new standard in denim, this jean is the rightful favorite among our designers. Made from lightly distressed denim to achieve that perfectly broken-in feel.'),(2271,4,106,0,415,NULL),(2272,4,72,0,416,'Flat front trouser. Slim through the hip thigh and ankle. Zip fly. Lined. 100% wool. Dry clean.'),(2273,4,83,0,416,NULL),(2274,4,73,0,416,'Thanks to its timeless versatility, these flat front trousers are perfectly suited to wear wherever and still stand apart.'),(2275,4,106,0,416,NULL),(2276,4,72,0,417,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(2277,4,83,0,417,NULL),(2278,4,73,0,417,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(2279,4,106,0,417,NULL),(2280,4,72,0,418,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(2281,4,83,0,418,NULL),(2282,4,73,0,418,'A simple ribbed cotton tank. Great for layering.'),(2283,4,106,0,418,NULL),(2284,4,72,0,419,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(2285,4,83,0,419,NULL),(2286,4,73,0,419,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(2287,4,106,0,419,NULL),(2288,4,72,0,420,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(2289,4,83,0,420,NULL),(2290,4,73,0,420,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(2291,4,106,0,420,NULL),(2292,4,72,0,421,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(2293,4,83,0,421,NULL),(2294,4,73,0,421,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(2295,4,106,0,421,NULL),(2296,4,72,0,422,'Knee length skirt. Sits on natural waist. Fitted through the hip. Exposed waist belt loops. Hidden zip and hook and eye closure in back. Full lining. Wool/cotton/polyester. Machine wash.'),(2297,4,83,0,422,NULL),(2298,4,73,0,422,'A classic pencil skirt that feels refreshingly modern. Crafted from our lighweight refined wool, the Jane skirt is an essential piece for on-the-go professionals.'),(2299,4,106,0,422,NULL),(2300,4,72,0,423,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(2301,4,83,0,423,NULL),(2302,4,73,0,423,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(2303,4,106,0,423,NULL),(2304,4,72,0,424,'Sleeveless, jewel neckline with deep Vee in back. Fitted through waist and hip. 100% polyester lining. Cotton/wool. Dry clean.'),(2305,4,83,0,424,NULL),(2306,4,73,0,424,'Our feminine wool-blend frock transitions seamlessly from day to night. We suggest wearing with classic heels and a standout strand necklace.'),(2307,4,106,0,424,NULL),(2308,4,72,0,425,'Two sash, convertible neckline with front ruffle detail. Unhemmed, visisble seams. Hidden side zipper. Unlined. Wool/elastane. Hand wash.'),(2309,4,83,0,425,NULL),(2310,4,73,0,425,'This all day dress has a flattering silhouette and a convertible neckline to suit your mood. Wear tied and tucked in a sailor knot, or reverse it for a high tied feminine bow.'),(2311,4,106,0,425,NULL),(2312,4,72,0,426,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(2313,4,83,0,426,NULL),(2314,4,73,0,426,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(2315,4,106,0,426,NULL),(2316,4,72,0,427,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(2317,4,83,0,427,NULL),(2318,4,73,0,427,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(2319,4,106,0,427,NULL),(2320,4,72,0,428,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(2321,4,83,0,428,NULL),(2322,4,73,0,428,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(2323,4,106,0,428,NULL),(2328,4,72,0,430,'Leather. 3.5\" heel. Peep toe and ankle strap. Leather insole and lining.'),(2329,4,83,0,430,NULL),(2330,4,185,0,430,'Medium'),(2331,4,73,0,430,'Step forward with a fresh and neutral hued finish.'),(2332,4,106,0,430,NULL),(2333,4,72,0,431,'Leather. Inside zipper. 3-button outside detail. 4.5\" heel, 1\" platform, 3.5\" equiv. Leather insole and lining. Red sole. Made in Italy.'),(2334,4,83,0,431,NULL),(2335,4,185,0,431,'Medium'),(2336,4,73,0,431,'A stylish companion to your LBD or skinny jeans.'),(2337,4,106,0,431,NULL),(2338,4,72,0,432,'Suede. Square toe. 1/4\" flat heel. Padded leather insole and lining. Rubber outsole provides traction.'),(2339,4,83,0,432,NULL),(2340,4,185,0,432,'Narrow'),(2341,4,73,0,432,'The slip on style is ideal for everyday use.'),(2342,4,106,0,432,NULL),(2343,4,72,0,433,'Polished leather upper. Perforated detail on toe. Oxford lace-up front. Leather lining and footbed. 1\" rubber heel. Imported.'),(2344,4,83,0,433,NULL),(2345,4,185,0,433,'Medium'),(2346,4,73,0,433,'Crafted from premium polished leather, unrivaled in design.'),(2347,4,106,0,433,NULL),(2348,4,72,0,434,'Wingtip medallion toe oxford with contrast waxed cotton laces.  Leather upper and lining. Leather sole. Made in Italy.'),(2349,4,83,0,434,NULL),(2350,4,185,0,434,'Medium'),(2351,4,73,0,434,'Classic cognac wingtip with a modern silhouette--it only gets better with wear.'),(2352,4,106,0,434,NULL),(2353,4,72,0,435,'Suede loafer. Contrast stitching. Leather lined. Imported.'),(2354,4,83,0,435,NULL),(2355,4,185,0,435,'Medium'),(2356,4,73,0,435,'Make a statement, even when relaxed and casual. The classic loafer design elevates even the most dressed down look.'),(2357,4,106,0,435,NULL),(2358,4,72,0,436,'Water resistant hard polycarbonate shell. All direction spinner wheels. Zip closure. Locking, retractable metal handle. Cross strap and self repairing zipper interior. Padded side handle for lateral carry. 21\" x 17\" x 10\".'),(2359,4,83,0,436,NULL),(2360,4,73,0,436,'Some like it classic. This luggage provides ample room for multiday trips.'),(2361,4,106,0,436,NULL),(2362,4,205,0,436,'Bags & Luggage'),(2363,4,204,0,436,'Business'),(2364,4,72,0,437,'Ceramic. 5.5\" diameter, 12\" high. '),(2365,4,83,0,437,NULL),(2366,4,73,0,437,'Modern, edgy, distinct. Choose from two colors.'),(2367,4,106,0,437,NULL),(2374,4,72,0,439,'Water resistant hard polycarbonate shell. All direction spinner wheels. Zip closure. Locking, retractable metal handle. Cross strap and self repairing zipper interior. Padded side handle for lateral carry. 21\" x 17\" x 10\" and/or 29\" x 20\" x 13\".'),(2375,4,83,0,439,NULL),(2376,4,73,0,439,'Heavy duty, hard shell Luggage'),(2377,4,106,0,439,NULL),(2378,4,205,0,439,'Bags & Luggage'),(2379,4,204,0,439,'Luggage'),(2380,4,72,0,440,'Ceramic. 5.5\" diameter, 12\" high. Domestic.'),(2381,4,83,0,440,NULL),(2382,4,73,0,440,'Murray modern vase set'),(2383,4,106,0,440,NULL),(2384,4,72,0,441,'3-Year coverage from date of purchase on hardware failures. Fixed or receive full replacement cost in 5 days or less - guaranteed. Free 2-way shipping for repairs. 100% parts and labor covered with no deductables. Fully transferable with gifts. Cancel anytime for a full refund within the first 30 days.'),(2385,4,83,0,441,NULL),(2386,4,73,0,441,'Madison Island 3-Year Camera Warrenty'),(2387,4,106,0,441,NULL),(2388,4,72,0,442,'5-Year coverage from date of purchase on hardware failures. Fixed or receive full replacement cost in 5 days or less - guaranteed. Free 2-way shipping for repairs. 100% parts and labor covered with no deductables. Fully transferable with gifts. Cancel anytime for a full refund within the first 30 days.'),(2389,4,83,0,442,NULL),(2390,4,73,0,442,'Madison Island 5-Year Camera Warrenty'),(2391,4,106,0,442,NULL),(2408,4,72,0,445,'Includes our Camera Case, and your choice between our Digital Camera or our DSLR, 16GB or 8GB memory card, and 3-year or 5-year warranty.\r\n'),(2409,4,73,0,445,'Conveniently pick up your Camera, Memory, Warranty and Camera Case all at once.\r\n'),(2410,4,83,0,445,NULL),(2411,4,106,0,445,NULL),(2412,4,72,0,446,'Includes a choice between our Compact MP3 player or our Digital Media Player and Earbuds or Headphones.\r\n'),(2413,4,73,0,446,'Pick up your Media Player and Audio Output together.\r\n'),(2414,4,83,0,446,NULL),(2415,4,106,0,446,NULL),(2416,4,72,0,447,'Includes a choice between Titian Raw Silk Pillow or Shay Printed Pillow and our Carnegia Alpaca Throw or Park Row Throw or Gramercy Throw.\r\n'),(2417,4,73,0,447,'A conveniently packaged pairing of our pillows and throws.\r\n'),(2418,4,83,0,447,NULL),(2419,4,106,0,447,NULL),(2420,4,72,0,448,'Novel by Charles Dickens, published both serially and in book form in 1859. The story is set in the late 18th century against the background of the French Revolution.While political events drive the story, Dickens takes a decidedly antipolitical tone, lambasting both aristocratic tyranny and revolutionary excess--the latter memorably caricatured in Madame Defarge, who knits beside the guillotine. The book is perhaps best known for its opening lines, \"It was the best of times, it was the worst of times,\" and for Carton\'s last speech, in which he says of his replacing Darnay in a prison cell, \"It is a far, far better thing that I do, than I have ever done; it is a far, far better rest that I go to, than I have ever known.\"'),(2421,4,73,0,448,'Against the backdrop of the French Revolution, Charles Dickens unfolds a masterpiece of drama, adventure, and courage.'),(2422,4,83,0,448,NULL),(2423,4,106,0,448,NULL),(2424,4,202,0,448,'Vahram Muratyan\r\n'),(2425,4,203,0,448,'Non-Fiction\r\n'),(2426,4,72,0,449,'Olvidalo. Written and performed by Brownout. 4:02min. Downloadable as mp3 file.\r\n'),(2427,4,73,0,449,'Songs for the trip.'),(2428,4,83,0,449,NULL),(2429,4,106,0,449,NULL),(2430,4,202,0,449,'Pilate\r\n'),(2431,4,203,0,449,'Alternative Rock\r\n'),(2432,4,72,0,450,'After a tumble down the rabbit hole, Alice finds herself far away from home in the absurd world of Wonderland. As mind-bending as it is delightful, Lewis Carroll’s 1865 novel is pure magic for young and old alike. 96pp. Downloadable as pdf.'),(2433,4,73,0,450,'Adventures of a young girl in a fantasy world.'),(2434,4,83,0,450,NULL),(2435,4,106,0,450,NULL),(2436,4,202,0,450,'Oliver Berry, Anthony Ham, Neil Wilson and Craig McLachlan\r\n'),(2437,4,203,0,450,'Literature\r\n'),(2571,4,72,0,456,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(2572,4,73,0,456,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(2573,4,83,0,456,NULL),(2574,4,106,0,456,NULL),(2633,4,72,0,457,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(2634,4,73,0,457,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(2635,4,83,0,457,NULL),(2636,4,101,0,457,NULL),(2637,4,106,0,457,NULL),(2638,4,72,0,458,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(2639,4,73,0,458,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(2640,4,83,0,458,NULL),(2641,4,101,0,458,NULL),(2642,4,106,0,458,NULL),(2643,4,72,0,459,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(2644,4,73,0,459,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(2645,4,83,0,459,NULL),(2646,4,101,0,459,NULL),(2647,4,106,0,459,NULL),(3329,4,72,0,475,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3330,4,73,0,475,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3331,4,83,0,475,NULL),(3332,4,101,0,475,NULL),(3333,4,106,0,475,NULL),(3334,4,72,0,476,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3335,4,73,0,476,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3336,4,83,0,476,NULL),(3337,4,101,0,476,NULL),(3338,4,106,0,476,NULL),(3343,4,72,0,477,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3344,4,73,0,477,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3345,4,83,0,477,NULL),(3346,4,101,0,477,NULL),(3347,4,106,0,477,NULL),(3348,4,72,0,478,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3349,4,73,0,478,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3350,4,83,0,478,NULL),(3351,4,101,0,478,NULL),(3352,4,106,0,478,NULL),(3359,4,72,0,479,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3360,4,73,0,479,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3361,4,83,0,479,NULL),(3362,4,101,0,479,NULL),(3363,4,106,0,479,NULL),(3364,4,72,0,480,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3365,4,73,0,480,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3366,4,83,0,480,NULL),(3367,4,101,0,480,NULL),(3368,4,106,0,480,NULL),(3369,4,72,0,481,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3370,4,73,0,481,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3371,4,83,0,481,NULL),(3372,4,101,0,481,NULL),(3373,4,106,0,481,NULL),(3374,4,72,0,482,'Straight leg chino. Back pockets with button closure. 14\" leg opening. Zip fly. 100% cotton.'),(3375,4,73,0,482,'The slim and trim Bowery is a wear-to-work pant you\'ll actually want to wear. A clean style in our crisp, compact cotton twill, it\'s perfectly polished (but also comfortable enough for hanging out after hours).'),(3376,4,83,0,482,NULL),(3377,4,101,0,482,NULL),(3378,4,106,0,482,NULL),(3409,4,72,0,483,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3410,4,73,0,483,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3411,4,83,0,483,NULL),(3412,4,101,0,483,NULL),(3413,4,106,0,483,NULL),(3414,4,72,0,484,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3415,4,73,0,484,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3416,4,83,0,484,NULL),(3417,4,101,0,484,NULL),(3418,4,106,0,484,NULL),(3425,4,72,0,485,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3426,4,73,0,485,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3427,4,83,0,485,NULL),(3428,4,101,0,485,NULL),(3429,4,106,0,485,NULL),(3430,4,72,0,486,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3431,4,73,0,486,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3432,4,83,0,486,NULL),(3433,4,101,0,486,NULL),(3434,4,106,0,486,NULL),(3435,4,72,0,487,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3436,4,73,0,487,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3437,4,83,0,487,NULL),(3438,4,101,0,487,NULL),(3439,4,106,0,487,NULL),(3442,4,72,0,488,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3443,4,73,0,488,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3444,4,83,0,488,NULL),(3445,4,101,0,488,NULL),(3446,4,106,0,488,NULL),(3457,4,72,0,489,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3458,4,73,0,489,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3459,4,83,0,489,NULL),(3460,4,101,0,489,NULL),(3461,4,106,0,489,NULL),(3462,4,72,0,490,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3463,4,73,0,490,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3464,4,83,0,490,NULL),(3465,4,101,0,490,NULL),(3466,4,106,0,490,NULL),(3467,4,72,0,491,'Ultrasoft, lightweight V-neck tee. 100% cotton. Machine wash.'),(3468,4,73,0,491,'Minimalist style and maximum comfort meet in this lightweight tee.'),(3469,4,83,0,491,NULL),(3470,4,101,0,491,NULL),(3471,4,106,0,491,NULL),(3484,4,72,0,492,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(3485,4,73,0,492,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(3486,4,83,0,492,NULL),(3487,4,101,0,492,NULL),(3488,4,106,0,492,NULL),(3489,4,72,0,493,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. 100% Merino wool. Dry clean.'),(3490,4,73,0,493,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(3491,4,83,0,493,NULL),(3492,4,101,0,493,NULL),(3493,4,106,0,493,NULL),(3500,4,72,0,494,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(3501,4,73,0,494,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(3502,4,83,0,494,NULL),(3503,4,101,0,494,NULL),(3504,4,106,0,494,NULL),(3505,4,72,0,495,'V-neck cardigan. Mother of pearl front button closure. Two dart pockets. Ribbed cuff and hem. 100% cotton. Hand wash.'),(3506,4,73,0,495,'A lean, raglan sleeve cardigan with cosmopolitan appeal.'),(3507,4,83,0,495,NULL),(3508,4,101,0,495,NULL),(3509,4,106,0,495,NULL),(3516,4,72,0,496,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(3517,4,73,0,496,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(3518,4,83,0,496,NULL),(3519,4,101,0,496,NULL),(3520,4,106,0,496,NULL),(3521,4,72,0,497,'Slim fit. Two chest pockets. Silver grommet detail. Grinding and nicking at hems. 100% cotton. '),(3522,4,73,0,497,'This grommet closure sports shirt is wrinkle free straight from the dryer. '),(3523,4,83,0,497,NULL),(3524,4,101,0,497,NULL),(3525,4,106,0,497,NULL),(3530,4,72,0,498,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(3531,4,73,0,498,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(3532,4,83,0,498,NULL),(3533,4,101,0,498,NULL),(3534,4,106,0,498,NULL),(3535,4,72,0,499,'Button front. Long sleeves. Tapered collar, chest pocket, french cuffs.'),(3536,4,73,0,499,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(3537,4,83,0,499,NULL),(3538,4,101,0,499,NULL),(3539,4,106,0,499,NULL),(3546,4,72,0,500,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(3547,4,73,0,500,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(3548,4,83,0,500,NULL),(3549,4,101,0,500,NULL),(3550,4,106,0,500,NULL),(3551,4,72,0,501,'Tailored/Slim fit. Long sleeves. Button cuff. Cotton. Imported.'),(3552,4,73,0,501,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(3553,4,83,0,501,NULL),(3554,4,101,0,501,NULL),(3555,4,106,0,501,NULL),(3562,4,72,0,502,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(3563,4,73,0,502,'This everyday shirt is equally stylish with jeans or trousers.'),(3564,4,83,0,502,NULL),(3565,4,101,0,502,NULL),(3566,4,106,0,502,NULL),(3567,4,72,0,503,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(3568,4,73,0,503,'This everyday shirt is equally stylish with jeans or trousers.'),(3569,4,83,0,503,NULL),(3570,4,101,0,503,NULL),(3571,4,106,0,503,NULL),(3578,4,72,0,504,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(3579,4,73,0,504,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(3580,4,83,0,504,NULL),(3581,4,101,0,504,NULL),(3582,4,106,0,504,NULL),(3583,4,72,0,505,'Two button, single vented, notched lapels. Three buttons at cuff. Interior buttoned welt pockets. Full polyester lining. 100% wool. Dry clean.'),(3584,4,73,0,505,'This modern, slim-fit sport jacket is crafted from ultralight refined wool and tailored to a two-button silhouete. Corresponding trousers form a spring-season suit that you can wear whereever.'),(3585,4,83,0,505,NULL),(3586,4,101,0,505,NULL),(3587,4,106,0,505,NULL),(3594,4,72,0,506,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(3595,4,73,0,506,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(3596,4,83,0,506,NULL),(3597,4,101,0,506,NULL),(3598,4,106,0,506,NULL),(3599,4,72,0,507,'Single vented, notched lapels. Flap pockets. Tonal stitching. Fully lined. Linen. Dry clean.'),(3600,4,73,0,507,'In airy lightweight linen, this blazer is classic tailoring with a warm weather twist.'),(3601,4,83,0,507,NULL),(3602,4,101,0,507,NULL),(3603,4,106,0,507,NULL),(3610,4,72,0,508,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(3611,4,73,0,508,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(3612,4,83,0,508,NULL),(3613,4,101,0,508,NULL),(3614,4,106,0,508,NULL),(3615,4,72,0,509,'Two button, single vented, notched lapels. Slim cut through the shoulders chest and waist. Flap pockets, welt inside chest pockets. Cotton/lycra. Dry clean.'),(3616,4,73,0,509,'Sleek and modern, our form flattering blazer carries a slightly relaxed, yet structured shape. Timeless in any time zone.'),(3617,4,83,0,509,NULL),(3618,4,101,0,509,NULL),(3619,4,106,0,509,NULL),(3626,4,72,0,510,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(3627,4,73,0,510,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(3628,4,83,0,510,NULL),(3629,4,101,0,510,NULL),(3630,4,106,0,510,NULL),(3631,4,72,0,511,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(3632,4,73,0,511,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(3633,4,83,0,511,NULL),(3634,4,101,0,511,NULL),(3635,4,106,0,511,NULL),(3642,4,72,0,512,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(3643,4,73,0,512,'A simple ribbed cotton tank. Great for layering.'),(3644,4,83,0,512,NULL),(3645,4,101,0,512,NULL),(3646,4,106,0,512,NULL),(3647,4,72,0,513,'Ribbed scoop neck tank. 100% cotton.Machine wash.'),(3648,4,73,0,513,'A simple ribbed cotton tank. Great for layering.'),(3649,4,83,0,513,NULL),(3650,4,101,0,513,NULL),(3651,4,106,0,513,NULL),(3658,4,72,0,514,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(3659,4,73,0,514,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(3660,4,83,0,514,NULL),(3661,4,101,0,514,NULL),(3662,4,106,0,514,NULL),(3663,4,72,0,515,'Oversized knitted silk blend cardigan. Front button closure. Ribbed hem. Silk/rayon. Dry clean.'),(3664,4,73,0,515,'Refresh your knitwear collection with our silk blend top. Layer over a bold hue for maximum contrast.'),(3665,4,83,0,515,NULL),(3666,4,101,0,515,NULL),(3667,4,106,0,515,NULL),(3674,4,72,0,516,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(3675,4,73,0,516,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(3676,4,83,0,516,NULL),(3677,4,101,0,516,NULL),(3678,4,106,0,516,NULL),(3679,4,72,0,517,'Oxford, fitted through the waist. V-neck, front button closure.100% cotton. Machine wash.'),(3680,4,73,0,517,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(3681,4,83,0,517,NULL),(3682,4,101,0,517,NULL),(3683,4,106,0,517,NULL),(3690,4,72,0,518,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(3691,4,73,0,518,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(3692,4,83,0,518,NULL),(3693,4,101,0,518,NULL),(3694,4,106,0,518,NULL),(3695,4,72,0,519,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(3696,4,73,0,519,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(3697,4,83,0,519,NULL),(3698,4,101,0,519,NULL),(3699,4,106,0,519,NULL),(3706,4,72,0,520,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3707,4,73,0,520,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3708,4,83,0,520,NULL),(3709,4,101,0,520,NULL),(3710,4,106,0,520,NULL),(3711,4,72,0,521,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3712,4,73,0,521,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3713,4,83,0,521,NULL),(3714,4,101,0,521,NULL),(3715,4,106,0,521,NULL),(3716,4,72,0,522,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3717,4,73,0,522,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3718,4,83,0,522,NULL),(3719,4,101,0,522,NULL),(3720,4,106,0,522,NULL),(3721,4,72,0,523,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3722,4,73,0,523,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3723,4,83,0,523,NULL),(3724,4,101,0,523,NULL),(3725,4,106,0,523,NULL),(3726,4,72,0,524,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3727,4,73,0,524,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3728,4,83,0,524,NULL),(3729,4,101,0,524,NULL),(3730,4,106,0,524,NULL),(3731,4,72,0,525,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3732,4,73,0,525,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3733,4,83,0,525,NULL),(3734,4,101,0,525,NULL),(3735,4,106,0,525,NULL),(3736,4,72,0,526,'Straight leg boyfriend-fit. Distressed denim. 5 pockets. Contrast stitch detailing. Large to size, choose size down. Machine wash.'),(3737,4,73,0,526,'Our straight leg jeans combine the comfort of a boyfriend-fit with the clean look of tailoring. Wear yours cuffed with a collar blouse and feminine flats to look fresh even after a long flight'),(3738,4,83,0,526,NULL),(3739,4,101,0,526,NULL),(3740,4,106,0,526,NULL),(3743,4,72,0,527,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3744,4,73,0,527,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3745,4,83,0,527,NULL),(3746,4,101,0,527,NULL),(3747,4,106,0,527,NULL),(3748,4,72,0,528,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3749,4,73,0,528,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3750,4,83,0,528,NULL),(3751,4,101,0,528,NULL),(3752,4,106,0,528,NULL),(3753,4,72,0,529,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3754,4,73,0,529,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3755,4,83,0,529,NULL),(3756,4,101,0,529,NULL),(3757,4,106,0,529,NULL),(3758,4,72,0,530,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3759,4,73,0,530,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3760,4,83,0,530,NULL),(3761,4,101,0,530,NULL),(3762,4,106,0,530,NULL),(3763,4,72,0,531,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3764,4,73,0,531,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3765,4,83,0,531,NULL),(3766,4,101,0,531,NULL),(3767,4,106,0,531,NULL),(3768,4,72,0,532,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3769,4,73,0,532,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3770,4,83,0,532,NULL),(3771,4,101,0,532,NULL),(3772,4,106,0,532,NULL),(3773,4,72,0,533,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching,. Cotton. Machine wash.'),(3774,4,73,0,533,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(3775,4,83,0,533,NULL),(3776,4,101,0,533,NULL),(3777,4,106,0,533,NULL),(3810,4,72,0,534,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(3811,4,73,0,534,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(3812,4,83,0,534,NULL),(3813,4,101,0,534,NULL),(3814,4,106,0,534,NULL),(3815,4,72,0,535,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(3816,4,73,0,535,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(3817,4,83,0,535,NULL),(3818,4,101,0,535,NULL),(3819,4,106,0,535,NULL),(3820,4,72,0,536,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(3821,4,73,0,536,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(3822,4,83,0,536,NULL),(3823,4,101,0,536,NULL),(3824,4,106,0,536,NULL),(3825,4,72,0,537,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(3826,4,73,0,537,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(3827,4,83,0,537,NULL),(3828,4,101,0,537,NULL),(3829,4,106,0,537,NULL),(3830,4,72,0,538,'Wide leg pant, front pleat detail. Sits on natural waist. Wool, unlined. Dry clean.'),(3831,4,73,0,538,'Break away from the trend with these elegant pleat front pants. The high waistline and wide leg creates a feminine sihouette that\'s flattering on any figure. Pair with d\'Orsay pumps and a waist belt.'),(3832,4,83,0,538,NULL),(3833,4,101,0,538,NULL),(3834,4,106,0,538,NULL),(3847,4,72,0,539,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(3848,4,73,0,539,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(3849,4,83,0,539,NULL),(3850,4,101,0,539,NULL),(3851,4,106,0,539,NULL),(3852,4,72,0,540,'Racer back maxi dress. Pull over style. Loose fitting. Straight skirt falls to floor. Viscose. '),(3853,4,73,0,540,'This classic maxi dress drapes beautifully throughout body and sweeps in a light A-line to the floor. Keep a casual chic look by pairing with a jean jacket or go glam with a statement necklace.'),(3854,4,83,0,540,NULL),(3855,4,101,0,540,NULL),(3856,4,106,0,540,NULL),(3905,4,72,0,541,'Water resistant hard polycarbonate shell. All direction spinner wheels. Zip closure. Locking, retractable metal handle. Cross strap and self repairing zipper interior. Padded side handle for lateral carry. 21\" x 17\" x 10\".'),(3906,4,73,0,541,'Some like it classic. This luggage provides ample room for multiday trips.'),(3907,4,83,0,541,NULL),(3908,4,101,0,541,NULL),(3909,4,106,0,541,NULL),(3910,4,205,0,541,'Bags & Luggage'),(3911,4,204,0,541,'Business'),(4040,4,72,0,542,'Exclusive discounts on high end designer goods and services for member shoppers.  Sales are held only on the Madison Island website and are first come first serve. Full inventory is available at the start of the sale.'),(4041,4,73,0,542,'Insider access to top designer labels at warehouse prices--everyday.'),(4042,4,83,0,542,NULL),(4043,4,106,0,542,NULL),(4123,4,72,0,546,'AA& quality 6.0-6.5mm pearls. Double knotted on silk thread. 24\" strand. 14K gold hook-and-eye clasp. Made in Indonesia.'),(4124,4,73,0,546,'For a discreet display of pure elegance. Layer multi strands or compliment with pearl or diamond studs. 18\" or 24\"'),(4125,4,83,0,546,NULL),(4126,4,106,0,546,NULL),(4135,4,72,0,547,'AA& quality 6.0-6.5mm pearls. Double knotted on silk thread. 24\" strand. 14K gold hook-and-eye clasp. Made in Indonesia.'),(4136,4,73,0,547,'For a discreet display of pure elegance. Layer multi strands or compliment with pearl or diamond studs. 18\" or 24\"'),(4137,4,83,0,547,NULL),(4138,4,101,0,547,NULL),(4139,4,106,0,547,NULL),(4140,4,72,0,548,'AA& quality 6.0-6.5mm pearls. Double knotted on silk thread. 24\" strand. 14K gold hook-and-eye clasp. Made in Indonesia.'),(4141,4,73,0,548,'For a discreet display of pure elegance. Layer multi strands or compliment with pearl or diamond studs. 18\" or 24\"'),(4142,4,83,0,548,NULL),(4143,4,101,0,548,NULL),(4144,4,106,0,548,NULL),(4157,4,72,0,549,'Set of 3. Glass beads on metal band. 2.75\" diameter. Made in India.'),(4158,4,73,0,549,'Add a pop of color with these handmade bangles from India.'),(4159,4,83,0,549,NULL),(4160,4,106,0,549,NULL),(4175,4,72,0,551,'AA& quality 6.5mm pearl. 14K gold post. Made in Indonesia.'),(4176,4,73,0,551,'Prim and demure, pearl studs are a cross cultural symbol of style and refinement.'),(4177,4,83,0,551,NULL),(4178,4,106,0,551,NULL),(4189,4,72,0,552,'Carved horn. Sterling silver hook. 2.25\". Made in Haiti.'),(4190,4,73,0,552,'Artisans from nonprofit Comite Artisanal Haitien in Port-au-Prince fashion these tasteful earrings from shaped horn. Each pair possesses its own unique natural beauty.'),(4191,4,83,0,552,NULL),(4192,4,106,0,552,NULL),(4197,4,72,0,553,'Traditional Tuareg design on hand-hammered and chiseled silver. The Tuareg of Saharan Africa are known for their decorative jewelry craft. 16\". Silver, stone beads. Made in Niger.'),(4198,4,73,0,553,'Wear your passport by adding an edgy and artistic statement necklace. Ethnic design on hand-hammered and chiseled silver.'),(4199,4,83,0,553,NULL),(4200,4,106,0,553,NULL),(4207,4,72,0,554,'Swiss quartz movement. Date function. 3-hands. Notch markers. Round, stainless steel case (42 mm x 15 x 13) and link strap (19mm x 8.25\"); Traditional clasp. Pull-out crown. Water resistant 125 feet.'),(4208,4,73,0,554,'A traditional timepiece with edgy detailing.'),(4209,4,83,0,554,NULL),(4210,4,106,0,554,NULL),(4215,4,72,0,555,'AA& quality 6.0-6.5mm pearls. Double knotted on silk thread. 24\" strand. 14K gold hook-and-eye clasp. Made in Indonesia.'),(4216,4,73,0,555,'Fresh Water Pearl Necklaces'),(4217,4,83,0,555,NULL),(4218,4,106,0,555,NULL),(4513,4,72,0,557,'For a bet, Phileas Fogg sets out with his servant Passeportout to achieve an incredible journey - from London to Paris, Brindisi, Suez, Bombay, Calcutta, Singapore, Hong Kong, San Francisco, New York and back to London again, all in just eighty days. There are many alarms and surprises along the way - and a last minute setback that makes all the difference between winning and losing.'),(4514,4,73,0,557,'A classic adventure novel in which a Londoner and his French valet take a bet to circumnavigate the world in 80 days.'),(4515,4,83,0,557,NULL),(4516,4,106,0,557,NULL),(4517,4,202,0,557,'Jules Verne'),(4518,4,203,0,557,'Adventure'),(4545,4,72,0,558,'Falling by  I Am Not Lefthanded. Album: Yes Means No. Running time 3:16. Downloadable as mp3.'),(4546,4,73,0,558,'Single off the album Yes Means No.'),(4547,4,83,0,558,NULL),(4548,4,106,0,558,NULL),(4549,4,202,0,558,'I Am Not Lefthanded'),(4550,4,203,0,558,'Rock'),(4555,4,72,0,559,'If You Were by Keshco. Album: Trolley Crash. Duration: 3:31. Downloadable as mp3.'),(4556,4,73,0,559,'Tunes for the trip.'),(4557,4,83,0,559,NULL),(4558,4,106,0,559,NULL),(4559,4,202,0,559,'Keshco'),(4560,4,203,0,559,'Folk'),(4563,4,72,0,560,'Can\'t Stop It by Shearer. Album: Eve. Duration: 2:49. Downloadable as mp3.'),(4564,4,73,0,560,'Tunes for the trip.'),(4565,4,83,0,560,NULL),(4566,4,106,0,560,NULL),(4567,4,202,0,560,'Shearer'),(4568,4,203,0,560,'Rock'),(4569,4,72,0,561,'Love is an Eternal Lie by The Sleeping Tree. Album: Music to Accompany the World Traveller. Duration: 3:11. Downloadable as mp3.'),(4570,4,73,0,561,'Music to Accompany the World Traveller.'),(4571,4,83,0,561,NULL),(4572,4,106,0,561,NULL),(4573,4,202,0,561,'Shearer'),(4574,4,203,0,561,'Rock'),(4578,4,72,0,562,'Goin Down to the Bus Stop by TBird. Album: Best of Breitband. Duration: 2:23. Downloadable as mp3.'),(4579,4,73,0,562,'Off the Best of Breitband album.'),(4580,4,83,0,562,NULL),(4581,4,106,0,562,NULL),(4582,4,202,0,562,'t Bird'),(4583,4,203,0,562,'Funk'),(4586,4,72,0,563,'Fire [Kalima remix] by Unannounced Guest. Duration: 2:48. Downloadable as mp3.'),(4587,4,73,0,563,'Tunes for the trip.'),(4588,4,83,0,563,NULL),(4589,4,106,0,563,NULL),(4590,4,202,0,563,'Unannounced Guest'),(4591,4,203,0,563,'Hip Hop\r\nFunk'),(4636,4,72,0,564,'Membership is valid for ONE YEAR from the date of purchase. Members are allowed unlimited purchases with VIP pricing, however purchases are not for resale. Madison Island may, in its sole discretion, choose not to process or to cancel your order in certain circumstances. This may occur, for example, when the product you wish to purchase is out of stock, mispriced, or if we suspect the request is fraudulent.\r\n'),(4637,4,73,0,564,'Gain insider access to the best styles for fashion and home at up to 40% off. Join and discover some fabulous finds. \r\n\r\nMembership will be reviewed and approved by a Sales Associate.\r\n'),(4638,4,83,0,564,NULL),(4639,4,106,0,564,NULL),(4867,4,72,0,566,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(4868,4,83,0,566,NULL),(4869,4,73,0,566,'Sharply tailored and perfect for spring season.'),(4870,4,106,0,566,NULL),(4889,4,72,0,567,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(4890,4,83,0,567,NULL),(4891,4,73,0,567,'Sharply tailored and perfect for spring season.'),(4892,4,72,0,568,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(4893,4,83,0,568,NULL),(4894,4,73,0,568,'Sharply tailored and perfect for spring season.'),(4895,4,72,0,569,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(4896,4,83,0,569,NULL),(4897,4,73,0,569,'Sharply tailored and perfect for spring season.'),(4898,4,72,0,570,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(4899,4,83,0,570,NULL),(4900,4,73,0,570,'Sharply tailored and perfect for spring season.'),(4901,4,72,0,571,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(4902,4,83,0,571,NULL),(4903,4,73,0,571,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(4904,4,72,0,572,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(4905,4,83,0,572,NULL),(4906,4,73,0,572,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(4907,4,72,0,573,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(4908,4,83,0,573,NULL),(4909,4,73,0,573,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(4910,4,72,0,574,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(4911,4,83,0,574,NULL),(4912,4,73,0,574,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(4913,4,72,0,575,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(4914,4,83,0,575,NULL),(4915,4,73,0,575,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(4916,4,72,0,576,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(4917,4,83,0,576,NULL),(4918,4,73,0,576,'A classic business style finished in subtle pinstripe.'),(4919,4,72,0,577,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(4920,4,83,0,577,NULL),(4921,4,73,0,577,'A classic business style finished in subtle pinstripe.'),(4922,4,72,0,578,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(4923,4,83,0,578,NULL),(4924,4,73,0,578,'A classic business style finished in subtle pinstripe.'),(4925,4,72,0,579,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(4926,4,83,0,579,NULL),(4927,4,73,0,579,'A classic business style finished in subtle pinstripe.'),(4928,4,72,0,580,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(4929,4,83,0,580,NULL),(4930,4,73,0,580,'A classic business style finished in subtle pinstripe.'),(4931,4,72,0,581,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4932,4,83,0,581,NULL),(4933,4,73,0,581,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4934,4,72,0,582,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4935,4,83,0,582,NULL),(4936,4,73,0,582,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4937,4,72,0,583,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4938,4,83,0,583,NULL),(4939,4,73,0,583,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4940,4,72,0,584,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4941,4,83,0,584,NULL),(4942,4,73,0,584,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4943,4,72,0,585,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4944,4,83,0,585,NULL),(4945,4,73,0,585,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4946,4,72,0,586,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4947,4,83,0,586,NULL),(4948,4,73,0,586,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4949,4,72,0,587,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4950,4,83,0,587,NULL),(4951,4,73,0,587,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4952,4,72,0,588,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4953,4,83,0,588,NULL),(4954,4,73,0,588,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4955,4,72,0,589,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4956,4,83,0,589,NULL),(4957,4,73,0,589,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4958,4,72,0,590,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4959,4,83,0,590,NULL),(4960,4,73,0,590,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4961,4,72,0,591,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4962,4,83,0,591,NULL),(4963,4,73,0,591,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4964,4,72,0,592,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4965,4,83,0,592,NULL),(4966,4,73,0,592,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4967,4,72,0,593,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4968,4,83,0,593,NULL),(4969,4,73,0,593,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4970,4,72,0,594,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(4971,4,83,0,594,NULL),(4972,4,73,0,594,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(4973,4,72,0,595,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4974,4,83,0,595,NULL),(4975,4,73,0,595,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4976,4,72,0,596,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4977,4,83,0,596,NULL),(4978,4,73,0,596,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4979,4,72,0,597,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4980,4,83,0,597,NULL),(4981,4,73,0,597,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4985,4,72,0,598,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4986,4,83,0,598,NULL),(4987,4,73,0,598,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4988,4,72,0,599,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4989,4,83,0,599,NULL),(4990,4,73,0,599,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4991,4,72,0,600,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4992,4,83,0,600,NULL),(4993,4,73,0,600,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4994,4,72,0,601,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(4995,4,83,0,601,NULL),(4996,4,73,0,601,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(4997,4,72,0,602,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(4998,4,83,0,602,NULL),(4999,4,73,0,602,'Premium cottion and classically informed tailoring.'),(5000,4,72,0,603,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(5001,4,83,0,603,NULL),(5002,4,73,0,603,'Premium cottion and classically informed tailoring.'),(5003,4,72,0,604,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(5004,4,83,0,604,NULL),(5005,4,73,0,604,'Premium cottion and classically informed tailoring.'),(5006,4,72,0,605,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(5007,4,83,0,605,NULL),(5008,4,73,0,605,'Premium cottion and classically informed tailoring.'),(5009,4,72,0,606,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(5010,4,83,0,606,NULL),(5011,4,73,0,606,'Premium cottion and classically informed tailoring.'),(5012,4,72,0,607,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(5013,4,83,0,607,NULL),(5014,4,73,0,607,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(5015,4,72,0,608,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(5016,4,83,0,608,NULL),(5017,4,73,0,608,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(5018,4,72,0,609,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(5019,4,83,0,609,NULL),(5020,4,73,0,609,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(5021,4,72,0,610,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(5022,4,83,0,610,NULL),(5023,4,73,0,610,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(5024,4,72,0,611,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(5025,4,83,0,611,NULL),(5026,4,73,0,611,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(5027,4,72,0,612,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(5028,4,83,0,612,NULL),(5029,4,73,0,612,'Check print on a refined cotton dress shirt.'),(5030,4,72,0,613,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(5031,4,83,0,613,NULL),(5032,4,73,0,613,'Check print on a refined cotton dress shirt.'),(5033,4,72,0,614,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(5034,4,83,0,614,NULL),(5035,4,73,0,614,'Check print on a refined cotton dress shirt.'),(5036,4,72,0,615,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(5037,4,83,0,615,NULL),(5038,4,73,0,615,'Check print on a refined cotton dress shirt.'),(5039,4,72,0,616,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(5040,4,83,0,616,NULL),(5041,4,73,0,616,'Check print on a refined cotton dress shirt.'),(5042,4,72,0,617,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(5043,4,83,0,617,NULL),(5044,4,73,0,617,'A must-have item for the well-dressed man.'),(5045,4,72,0,618,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(5046,4,83,0,618,NULL),(5047,4,73,0,618,'A must-have item for the well-dressed man.'),(5048,4,72,0,619,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(5049,4,83,0,619,NULL),(5050,4,73,0,619,'A must-have item for the well-dressed man.'),(5051,4,72,0,620,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(5052,4,83,0,620,NULL),(5053,4,73,0,620,'A must-have item for the well-dressed man.'),(5054,4,72,0,621,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(5055,4,83,0,621,NULL),(5056,4,73,0,621,'A must-have item for the well-dressed man.'),(5057,4,72,0,622,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(5058,4,83,0,622,NULL),(5059,4,73,0,622,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(5060,4,72,0,623,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(5061,4,83,0,623,NULL),(5062,4,73,0,623,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(5063,4,72,0,624,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(5064,4,83,0,624,NULL),(5065,4,73,0,624,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(5066,4,72,0,625,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(5067,4,83,0,625,NULL),(5068,4,73,0,625,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(5069,4,72,0,626,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(5070,4,83,0,626,NULL),(5071,4,73,0,626,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(5072,4,72,0,627,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5073,4,83,0,627,NULL),(5074,4,73,0,627,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5075,4,72,0,628,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5076,4,83,0,628,NULL),(5077,4,73,0,628,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5078,4,72,0,629,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5079,4,83,0,629,NULL),(5080,4,73,0,629,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5081,4,72,0,630,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5082,4,83,0,630,NULL),(5083,4,73,0,630,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5084,4,72,0,631,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5085,4,83,0,631,NULL),(5086,4,73,0,631,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5087,4,72,0,632,'Ultrasoft, lightweight V-neck tee. Available in Blue stripe. 100% cotton. Machine wash.'),(5088,4,83,0,632,NULL),(5089,4,73,0,632,'Minimalist style and maximum comfort in a lightweight striped tee.'),(5090,4,72,0,633,'Ultrasoft, lightweight V-neck tee. Available in Blue stripe. 100% cotton. Machine wash.'),(5091,4,83,0,633,NULL),(5092,4,73,0,633,'Minimalist style and maximum comfort in a lightweight striped tee.'),(5093,4,72,0,634,'Ultrasoft, lightweight V-neck tee. Available in Blue stripe. 100% cotton. Machine wash.'),(5094,4,83,0,634,NULL),(5095,4,73,0,634,'Minimalist style and maximum comfort in a lightweight striped tee.'),(5096,4,72,0,635,'Ultrasoft, lightweight V-neck tee. Available in Blue stripe. 100% cotton. Machine wash.'),(5097,4,83,0,635,NULL),(5098,4,73,0,635,'Minimalist style and maximum comfort in a lightweight striped tee.'),(5099,4,72,0,636,'Ultrasoft, lightweight V-neck tee. Available in Blue stripe. 100% cotton. Machine wash.'),(5100,4,83,0,636,NULL),(5101,4,73,0,636,'Minimalist style and maximum comfort in a lightweight striped tee.'),(5102,4,72,0,637,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5103,4,83,0,637,NULL),(5104,4,73,0,637,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5105,4,72,0,638,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5106,4,83,0,638,NULL),(5107,4,73,0,638,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5108,4,72,0,639,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5109,4,83,0,639,NULL),(5110,4,73,0,639,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5111,4,72,0,640,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5112,4,83,0,640,NULL),(5113,4,73,0,640,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5114,4,72,0,641,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5115,4,83,0,641,NULL),(5116,4,73,0,641,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5117,4,72,0,642,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5118,4,83,0,642,NULL),(5119,4,73,0,642,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5120,4,72,0,643,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5121,4,83,0,643,NULL),(5122,4,73,0,643,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5123,4,72,0,644,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5124,4,83,0,644,NULL),(5125,4,73,0,644,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5126,4,72,0,645,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5127,4,83,0,645,NULL),(5128,4,73,0,645,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5129,4,72,0,646,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(5130,4,83,0,646,NULL),(5131,4,73,0,646,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(5132,4,72,0,647,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5133,4,83,0,647,NULL),(5134,4,73,0,647,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5135,4,72,0,648,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5136,4,83,0,648,NULL),(5137,4,73,0,648,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5138,4,72,0,649,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5139,4,83,0,649,NULL),(5140,4,73,0,649,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5141,4,72,0,650,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5142,4,83,0,650,NULL),(5143,4,73,0,650,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5144,4,72,0,651,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(5145,4,83,0,651,NULL),(5146,4,73,0,651,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(5147,4,72,0,652,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5148,4,83,0,652,NULL),(5149,4,73,0,652,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5150,4,72,0,653,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5151,4,83,0,653,NULL),(5152,4,73,0,653,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5153,4,72,0,654,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5154,4,83,0,654,NULL),(5155,4,73,0,654,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5156,4,72,0,655,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5157,4,83,0,655,NULL),(5158,4,73,0,655,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5159,4,72,0,656,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5160,4,83,0,656,NULL),(5161,4,73,0,656,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5162,4,72,0,657,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5163,4,83,0,657,NULL),(5164,4,73,0,657,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5165,4,72,0,658,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(5166,4,83,0,658,NULL),(5167,4,73,0,658,'The perfect jean for travel. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern silhouette.'),(5168,4,72,0,659,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5169,4,83,0,659,NULL),(5170,4,73,0,659,'Complete ease of movement for anything from beachcombing to city touring.'),(5171,4,72,0,660,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5172,4,83,0,660,NULL),(5173,4,73,0,660,'Complete ease of movement for anything from beachcombing to city touring.'),(5174,4,72,0,661,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5175,4,83,0,661,NULL),(5176,4,73,0,661,'Complete ease of movement for anything from beachcombing to city touring.'),(5177,4,72,0,662,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5178,4,83,0,662,NULL),(5179,4,73,0,662,'Complete ease of movement for anything from beachcombing to city touring.'),(5180,4,72,0,663,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5181,4,83,0,663,NULL),(5182,4,73,0,663,'Complete ease of movement for anything from beachcombing to city touring.'),(5183,4,72,0,664,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5184,4,83,0,664,NULL),(5185,4,73,0,664,'Complete ease of movement for anything from beachcombing to city touring.'),(5186,4,72,0,665,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(5187,4,83,0,665,NULL),(5188,4,73,0,665,'Complete ease of movement for anything from beachcombing to city touring.'),(5189,4,72,0,666,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5190,4,83,0,666,NULL),(5191,4,73,0,666,'Durable yet stylish for around the world adventures.'),(5192,4,72,0,667,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5193,4,83,0,667,NULL),(5194,4,73,0,667,'Durable yet stylish for around the world adventures.'),(5195,4,72,0,668,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5196,4,83,0,668,NULL),(5197,4,73,0,668,'Durable yet stylish for around the world adventures.'),(5198,4,72,0,669,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5199,4,83,0,669,NULL),(5200,4,73,0,669,'Durable yet stylish for around the world adventures.'),(5201,4,72,0,670,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5202,4,83,0,670,NULL),(5203,4,73,0,670,'Durable yet stylish for around the world adventures.'),(5204,4,72,0,671,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5205,4,83,0,671,NULL),(5206,4,73,0,671,'Durable yet stylish for around the world adventures.'),(5207,4,72,0,672,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(5208,4,83,0,672,NULL),(5209,4,73,0,672,'Durable yet stylish for around the world adventures.'),(5210,4,72,0,673,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5211,4,83,0,673,NULL),(5212,4,73,0,673,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5213,4,72,0,674,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5214,4,83,0,674,NULL),(5215,4,73,0,674,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5216,4,72,0,675,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5217,4,83,0,675,NULL),(5218,4,73,0,675,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5219,4,72,0,676,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5220,4,83,0,676,NULL),(5221,4,73,0,676,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5222,4,72,0,677,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5223,4,83,0,677,NULL),(5224,4,73,0,677,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5225,4,72,0,678,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5226,4,83,0,678,NULL),(5227,4,73,0,678,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5228,4,72,0,679,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(5229,4,83,0,679,NULL),(5230,4,73,0,679,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(5231,4,72,0,680,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5232,4,83,0,680,NULL),(5233,4,73,0,680,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5234,4,72,0,681,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5235,4,83,0,681,NULL),(5236,4,73,0,681,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5237,4,72,0,682,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5238,4,83,0,682,NULL),(5239,4,73,0,682,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5240,4,72,0,683,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5241,4,83,0,683,NULL),(5242,4,73,0,683,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5243,4,72,0,684,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5244,4,83,0,684,NULL),(5245,4,73,0,684,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5246,4,72,0,685,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5247,4,83,0,685,NULL),(5248,4,73,0,685,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5249,4,72,0,686,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(5250,4,83,0,686,NULL),(5251,4,73,0,686,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(5252,4,72,0,687,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5253,4,83,0,687,NULL),(5254,4,73,0,687,'Cashmere and cotton marry in our figure forgiving day dress.'),(5255,4,72,0,688,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5256,4,83,0,688,NULL),(5257,4,73,0,688,'Cashmere and cotton marry in our figure forgiving day dress.'),(5258,4,72,0,689,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5259,4,83,0,689,NULL),(5260,4,73,0,689,'Cashmere and cotton marry in our figure forgiving day dress.'),(5261,4,72,0,690,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5262,4,83,0,690,NULL),(5263,4,73,0,690,'Cashmere and cotton marry in our figure forgiving day dress.'),(5264,4,72,0,691,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5265,4,83,0,691,NULL),(5266,4,73,0,691,'Cashmere and cotton marry in our figure forgiving day dress.'),(5267,4,72,0,692,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5268,4,83,0,692,NULL),(5269,4,73,0,692,'Cashmere and cotton marry in our figure forgiving day dress.'),(5270,4,72,0,693,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(5271,4,83,0,693,NULL),(5272,4,73,0,693,'Cashmere and cotton marry in our figure forgiving day dress.'),(5273,4,72,0,694,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5274,4,83,0,694,NULL),(5275,4,73,0,694,'Leather panels add a tuff touch to a classic LBD.'),(5276,4,72,0,695,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5277,4,83,0,695,NULL),(5278,4,73,0,695,'Leather panels add a tuff touch to a classic LBD.'),(5279,4,72,0,696,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5280,4,83,0,696,NULL),(5281,4,73,0,696,'Leather panels add a tuff touch to a classic LBD.'),(5282,4,72,0,697,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5283,4,83,0,697,NULL),(5284,4,73,0,697,'Leather panels add a tuff touch to a classic LBD.'),(5285,4,72,0,698,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5286,4,83,0,698,NULL),(5287,4,73,0,698,'Leather panels add a tuff touch to a classic LBD.'),(5288,4,72,0,699,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5289,4,83,0,699,NULL),(5290,4,73,0,699,'Leather panels add a tuff touch to a classic LBD.'),(5291,4,72,0,700,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(5292,4,83,0,700,NULL),(5293,4,73,0,700,'Leather panels add a tuff touch to a classic LBD.'),(5294,4,72,0,701,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5295,4,83,0,701,NULL),(5296,4,73,0,701,'A demure selection for any occasion.'),(5297,4,72,0,702,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5298,4,83,0,702,NULL),(5299,4,73,0,702,'A demure selection for any occasion.'),(5300,4,72,0,703,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5301,4,83,0,703,NULL),(5302,4,73,0,703,'A demure selection for any occasion.'),(5303,4,72,0,704,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5304,4,83,0,704,NULL),(5305,4,73,0,704,'A demure selection for any occasion.'),(5306,4,72,0,705,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5307,4,83,0,705,NULL),(5308,4,73,0,705,'A demure selection for any occasion.'),(5309,4,72,0,706,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5310,4,83,0,706,NULL),(5311,4,73,0,706,'A demure selection for any occasion.'),(5312,4,72,0,707,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(5313,4,83,0,707,NULL),(5314,4,73,0,707,'A demure selection for any occasion.'),(5315,4,72,0,708,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(5316,4,83,0,708,NULL),(5317,4,73,0,708,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(5318,4,72,0,709,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(5319,4,83,0,709,NULL),(5320,4,73,0,709,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(5321,4,72,0,710,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(5322,4,83,0,710,NULL),(5323,4,73,0,710,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(5324,4,72,0,711,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(5325,4,83,0,711,NULL),(5326,4,73,0,711,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(5327,4,72,0,712,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(5328,4,83,0,712,NULL),(5329,4,73,0,712,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(5330,4,72,0,713,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(5331,4,83,0,713,NULL),(5332,4,73,0,713,'Sharply tailored and perfect for spring season.'),(5333,4,72,0,714,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(5334,4,83,0,714,NULL),(5335,4,73,0,714,'Sharply tailored and perfect for spring season.'),(5336,4,72,0,715,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(5337,4,83,0,715,NULL),(5338,4,73,0,715,'Sharply tailored and perfect for spring season.'),(5339,4,72,0,716,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(5340,4,83,0,716,NULL),(5341,4,73,0,716,'Sharply tailored and perfect for spring season.'),(5342,4,72,0,717,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(5343,4,83,0,717,NULL),(5344,4,73,0,717,'Sharply tailored and perfect for spring season.'),(5345,4,72,0,718,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5346,4,83,0,718,NULL),(5347,4,73,0,718,'A relaxed and wrinkle resistant travel shirt. '),(5348,4,72,0,719,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5349,4,83,0,719,NULL),(5350,4,73,0,719,'A relaxed and wrinkle resistant travel shirt. '),(5351,4,72,0,720,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5352,4,83,0,720,NULL),(5353,4,73,0,720,'A relaxed and wrinkle resistant travel shirt. '),(5354,4,72,0,721,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5355,4,83,0,721,NULL),(5356,4,73,0,721,'A relaxed and wrinkle resistant travel shirt. '),(5357,4,72,0,722,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5358,4,83,0,722,NULL),(5359,4,73,0,722,'A relaxed and wrinkle resistant travel shirt. '),(5360,4,72,0,723,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5361,4,83,0,723,NULL),(5362,4,73,0,723,'A relaxed and wrinkle resistant travel shirt. '),(5363,4,72,0,724,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5364,4,83,0,724,NULL),(5365,4,73,0,724,'A relaxed and wrinkle resistant travel shirt. '),(5366,4,72,0,725,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5367,4,83,0,725,NULL),(5368,4,73,0,725,'A relaxed and wrinkle resistant travel shirt. '),(5369,4,72,0,726,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5370,4,83,0,726,NULL),(5371,4,73,0,726,'A relaxed and wrinkle resistant travel shirt. '),(5372,4,72,0,727,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(5373,4,83,0,727,NULL),(5374,4,73,0,727,'A relaxed and wrinkle resistant travel shirt. '),(5375,4,72,0,728,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(5376,4,83,0,728,NULL),(5377,4,73,0,728,'Polished femininity in this cover-up of choice.'),(5378,4,72,0,729,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(5379,4,83,0,729,NULL),(5380,4,73,0,729,'Polished femininity in this cover-up of choice.'),(5381,4,72,0,730,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(5382,4,83,0,730,NULL),(5383,4,73,0,730,'Polished femininity in this cover-up of choice.'),(5384,4,72,0,731,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(5385,4,83,0,731,NULL),(5386,4,73,0,731,'Polished femininity in this cover-up of choice.'),(5387,4,72,0,732,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(5388,4,83,0,732,NULL),(5389,4,73,0,732,'Polished femininity in this cover-up of choice.'),(5390,4,72,0,733,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(5391,4,83,0,733,NULL),(5392,4,73,0,733,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(5393,4,72,0,734,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(5394,4,83,0,734,NULL),(5395,4,73,0,734,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(5396,4,72,0,735,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(5397,4,83,0,735,NULL),(5398,4,73,0,735,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(5399,4,72,0,736,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(5400,4,83,0,736,NULL),(5401,4,73,0,736,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(5402,4,72,0,737,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(5403,4,83,0,737,NULL),(5404,4,73,0,737,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(5405,4,72,0,738,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(5406,4,83,0,738,NULL),(5407,4,73,0,738,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(5408,4,72,0,739,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(5409,4,83,0,739,NULL),(5410,4,73,0,739,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(5411,4,72,0,740,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(5412,4,83,0,740,NULL),(5413,4,73,0,740,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(5414,4,72,0,741,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(5415,4,83,0,741,NULL),(5416,4,73,0,741,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(5417,4,72,0,742,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(5418,4,83,0,742,NULL),(5419,4,73,0,742,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(5420,4,72,0,743,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(5421,4,83,0,743,NULL),(5422,4,73,0,743,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(5423,4,72,0,744,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(5424,4,83,0,744,NULL),(5425,4,73,0,744,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(5426,4,72,0,745,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(5427,4,83,0,745,NULL),(5428,4,73,0,745,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(5429,4,72,0,746,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(5430,4,83,0,746,NULL),(5431,4,73,0,746,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(5432,4,72,0,747,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(5433,4,83,0,747,NULL),(5434,4,73,0,747,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(5435,4,72,0,748,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(5436,4,83,0,748,NULL),(5437,4,185,0,748,'M'),(5438,4,73,0,748,'Sophisticated meets practical with our rubber-soled leather loafer.'),(5439,4,72,0,749,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(5440,4,83,0,749,NULL),(5441,4,185,0,749,'M'),(5442,4,73,0,749,'Sophisticated meets practical with our rubber-soled leather loafer.'),(5443,4,72,0,750,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(5444,4,83,0,750,NULL),(5445,4,185,0,750,'M'),(5446,4,73,0,750,'Sophisticated meets practical with our rubber-soled leather loafer.'),(5447,4,72,0,751,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(5448,4,83,0,751,NULL),(5449,4,185,0,751,'M'),(5450,4,73,0,751,'Sophisticated meets practical with our rubber-soled leather loafer.'),(5451,4,72,0,752,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(5452,4,83,0,752,NULL),(5453,4,185,0,752,'M'),(5454,4,73,0,752,'Sophisticated meets practical with our rubber-soled leather loafer.'),(5455,4,72,0,753,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(5456,4,83,0,753,NULL),(5457,4,185,0,753,'M'),(5458,4,73,0,753,'A stylish saddle shoe in supple suede.'),(5459,4,72,0,754,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(5460,4,83,0,754,NULL),(5461,4,185,0,754,'M'),(5462,4,73,0,754,'A stylish saddle shoe in supple suede.'),(5463,4,72,0,755,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(5464,4,83,0,755,NULL),(5465,4,185,0,755,'M'),(5466,4,73,0,755,'A stylish saddle shoe in supple suede.'),(5467,4,72,0,756,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(5468,4,83,0,756,NULL),(5469,4,185,0,756,'M'),(5470,4,73,0,756,'A stylish saddle shoe in supple suede.'),(5471,4,72,0,757,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(5472,4,83,0,757,NULL),(5473,4,185,0,757,'M'),(5474,4,73,0,757,'A stylish saddle shoe in supple suede.'),(5475,4,72,0,758,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(5476,4,83,0,758,NULL),(5477,4,185,0,758,'M'),(5478,4,73,0,758,'Our classic captoe dress shoe in smooth calfskin.'),(5479,4,72,0,759,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(5480,4,83,0,759,NULL),(5481,4,185,0,759,'M'),(5482,4,73,0,759,'Our classic captoe dress shoe in smooth calfskin.'),(5483,4,72,0,760,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(5484,4,83,0,760,NULL),(5485,4,185,0,760,'M'),(5486,4,73,0,760,'Our classic captoe dress shoe in smooth calfskin.'),(5487,4,72,0,761,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(5488,4,83,0,761,NULL),(5489,4,185,0,761,'M'),(5490,4,73,0,761,'Our classic captoe dress shoe in smooth calfskin.'),(5491,4,72,0,762,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(5492,4,83,0,762,NULL),(5493,4,185,0,762,'M'),(5494,4,73,0,762,'Our classic captoe dress shoe in smooth calfskin.'),(5495,4,72,0,763,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(5496,4,83,0,763,NULL),(5497,4,185,0,763,'M'),(5498,4,73,0,763,'Blending classic Euro style with uptown elegance.'),(5499,4,72,0,764,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(5500,4,83,0,764,NULL),(5501,4,185,0,764,'M'),(5502,4,73,0,764,'Blending classic Euro style with uptown elegance.'),(5503,4,72,0,765,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(5504,4,83,0,765,NULL),(5505,4,185,0,765,'M'),(5506,4,73,0,765,'Blending classic Euro style with uptown elegance.'),(5507,4,72,0,766,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(5508,4,83,0,766,NULL),(5509,4,185,0,766,'M'),(5510,4,73,0,766,'Blending classic Euro style with uptown elegance.'),(5511,4,72,0,767,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(5512,4,83,0,767,NULL),(5513,4,185,0,767,'M'),(5514,4,73,0,767,'Blending classic Euro style with uptown elegance.'),(5515,4,72,0,768,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(5516,4,83,0,768,NULL),(5517,4,185,0,768,'M'),(5518,4,73,0,768,'A contemporary lace up with intentional color wash effect.'),(5519,4,72,0,769,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(5520,4,83,0,769,NULL),(5521,4,185,0,769,'M'),(5522,4,73,0,769,'A contemporary lace up with intentional color wash effect.'),(5523,4,72,0,770,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(5524,4,83,0,770,NULL),(5525,4,185,0,770,'M'),(5526,4,73,0,770,'A contemporary lace up with intentional color wash effect.'),(5527,4,72,0,771,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(5528,4,83,0,771,NULL),(5529,4,185,0,771,'M'),(5530,4,73,0,771,'A contemporary lace up with intentional color wash effect.'),(5531,4,72,0,772,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(5532,4,83,0,772,NULL),(5533,4,185,0,772,'M'),(5534,4,73,0,772,'A contemporary lace up with intentional color wash effect.'),(5535,4,72,0,773,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(5536,4,83,0,773,NULL),(5537,4,185,0,773,'M'),(5538,4,73,0,773,'Cool. Casual. Retro urban.'),(5539,4,72,0,774,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(5540,4,83,0,774,NULL),(5541,4,185,0,774,'M'),(5542,4,73,0,774,'Cool. Casual. Retro urban.'),(5543,4,72,0,775,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(5544,4,83,0,775,NULL),(5545,4,185,0,775,'M'),(5546,4,73,0,775,'Cool. Casual. Retro urban.'),(5547,4,72,0,776,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(5548,4,83,0,776,NULL),(5549,4,185,0,776,'M'),(5550,4,73,0,776,'Cool. Casual. Retro urban.'),(5551,4,72,0,777,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(5552,4,83,0,777,NULL),(5553,4,185,0,777,'M'),(5554,4,73,0,777,'Cool. Casual. Retro urban.'),(5555,4,72,0,778,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(5556,4,83,0,778,NULL),(5557,4,185,0,778,'M'),(5558,4,73,0,778,'Snakeskin leather brings a charming effect to the classic pump.'),(5559,4,72,0,779,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(5560,4,83,0,779,NULL),(5561,4,185,0,779,'M'),(5562,4,73,0,779,'Snakeskin leather brings a charming effect to the classic pump.'),(5563,4,72,0,780,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(5564,4,83,0,780,NULL),(5565,4,185,0,780,'M'),(5566,4,73,0,780,'Snakeskin leather brings a charming effect to the classic pump.'),(5567,4,72,0,781,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(5568,4,83,0,781,NULL),(5569,4,185,0,781,'M'),(5570,4,73,0,781,'Snakeskin leather brings a charming effect to the classic pump.'),(5571,4,72,0,782,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(5572,4,83,0,782,NULL),(5573,4,185,0,782,'M'),(5574,4,73,0,782,'Snakeskin leather brings a charming effect to the classic pump.'),(5575,4,72,0,783,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(5576,4,83,0,783,NULL),(5577,4,185,0,783,'M'),(5578,4,73,0,783,'Proper elegance with a modern approach. '),(5579,4,72,0,784,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(5580,4,83,0,784,NULL),(5581,4,185,0,784,'M'),(5582,4,73,0,784,'Proper elegance with a modern approach. '),(5583,4,72,0,785,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(5584,4,83,0,785,NULL),(5585,4,185,0,785,'M'),(5586,4,73,0,785,'Proper elegance with a modern approach. '),(5587,4,72,0,786,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(5588,4,83,0,786,NULL),(5589,4,185,0,786,'M'),(5590,4,73,0,786,'Proper elegance with a modern approach. '),(5591,4,72,0,787,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(5592,4,83,0,787,NULL),(5593,4,185,0,787,'M'),(5594,4,73,0,787,'Proper elegance with a modern approach. '),(5595,4,72,0,788,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(5596,4,83,0,788,NULL),(5597,4,185,0,788,'M'),(5598,4,73,0,788,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(5599,4,72,0,789,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(5600,4,83,0,789,NULL),(5601,4,185,0,789,'M'),(5602,4,73,0,789,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(5603,4,72,0,790,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(5604,4,83,0,790,NULL),(5605,4,185,0,790,'M'),(5606,4,73,0,790,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(5607,4,72,0,791,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(5608,4,83,0,791,NULL),(5609,4,185,0,791,'M'),(5610,4,73,0,791,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(5611,4,72,0,792,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(5612,4,83,0,792,NULL),(5613,4,185,0,792,'M'),(5614,4,73,0,792,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(5615,4,72,0,793,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(5616,4,83,0,793,NULL),(5617,4,185,0,793,'M'),(5618,4,73,0,793,'Add a spicy punch to new season looks.'),(5619,4,72,0,794,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(5620,4,83,0,794,NULL),(5621,4,185,0,794,'M'),(5622,4,73,0,794,'Add a spicy punch to new season looks.'),(5623,4,72,0,795,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(5624,4,83,0,795,NULL),(5625,4,185,0,795,'M'),(5626,4,73,0,795,'Add a spicy punch to new season looks.'),(5627,4,72,0,796,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(5628,4,83,0,796,NULL),(5629,4,185,0,796,'M'),(5630,4,73,0,796,'Add a spicy punch to new season looks.'),(5631,4,72,0,797,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(5632,4,83,0,797,NULL),(5633,4,185,0,797,'M'),(5634,4,73,0,797,'Add a spicy punch to new season looks.'),(5635,4,72,0,798,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(5636,4,83,0,798,NULL),(5637,4,185,0,798,'M'),(5638,4,73,0,798,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(5639,4,72,0,799,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(5640,4,83,0,799,NULL),(5641,4,185,0,799,'M'),(5642,4,73,0,799,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(5643,4,72,0,800,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(5644,4,83,0,800,NULL),(5645,4,185,0,800,'M'),(5646,4,73,0,800,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(5647,4,72,0,801,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(5648,4,83,0,801,NULL),(5649,4,185,0,801,'M'),(5650,4,73,0,801,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(5651,4,72,0,802,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(5652,4,83,0,802,NULL),(5653,4,185,0,802,'M'),(5654,4,73,0,802,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(5655,4,72,0,803,'Suede upper. Rubber 0.5\" heel. Domestic.'),(5656,4,83,0,803,NULL),(5657,4,185,0,803,'M'),(5658,4,73,0,803,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(5659,4,72,0,804,'Suede upper. Rubber 0.5\" heel. Domestic.'),(5660,4,83,0,804,NULL),(5661,4,185,0,804,'M'),(5662,4,73,0,804,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(5663,4,72,0,805,'Suede upper. Rubber 0.5\" heel. Domestic.'),(5664,4,83,0,805,NULL),(5665,4,185,0,805,'M'),(5666,4,73,0,805,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(5667,4,72,0,806,'Suede upper. Rubber 0.5\" heel. Domestic.'),(5668,4,83,0,806,NULL),(5669,4,185,0,806,'M'),(5670,4,73,0,806,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(5671,4,72,0,807,'Suede upper. Rubber 0.5\" heel. Domestic.'),(5672,4,83,0,807,NULL),(5673,4,185,0,807,'M'),(5674,4,73,0,807,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(6485,4,106,0,769,NULL),(6487,4,72,0,808,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(6488,4,83,0,808,NULL),(6489,4,73,0,808,'Sharply tailored and perfect for spring season.'),(6490,4,72,0,809,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Single vent. Fully lined with interior pockets. Available in Black. Made in Italy. Wool. Dry clean.'),(6491,4,83,0,809,NULL),(6492,4,73,0,809,'A smart suit coat made from refined wool and shaped with a classic sihouette.'),(6493,4,72,0,810,'Two-button closure. Notch lapels. Front welt pockets and chest pocket. Double vent. Fully lined with interior pockets. Available in pinstripe. Made in Italy. Wool. Dry clean.'),(6494,4,83,0,810,NULL),(6495,4,73,0,810,'A classic business style finished in subtle pinstripe.'),(6496,4,72,0,811,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(6497,4,83,0,811,NULL),(6498,4,73,0,811,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(6499,4,72,0,812,'Classic-fit dress trousers. Quarter top pockets, back welt pockets and button fly. 10\" rise. 36\" inseam. 16\" leg opening. Available in Black. Wool. Dry clean.'),(6500,4,83,0,812,NULL),(6501,4,73,0,812,'A wardrobe staple and the perfect companion to the Draper Suit Coat.'),(6502,4,72,0,813,'Cotton skinny leg jean with five pockets. 9.5\" rise. 34.5\" inseam. 13\" leg opening. Imported. Available in Black and Olive. Cotton/elastane. Machine wash.'),(6503,4,83,0,813,NULL),(6504,4,73,0,813,'An ultra slim jean made from stretch denim to achieve a comfortable Eurpoean street style.'),(6505,4,72,0,814,'Button-front with spread collar. Imported. Available in Blue. Cotton. Machine wash.'),(6506,4,83,0,814,NULL),(6507,4,73,0,814,'Premium cottion and classically informed tailoring.'),(6508,4,72,0,815,'Button-front. Imported. Available in Blue.Cotton.  Machine wash.'),(6509,4,83,0,815,NULL),(6510,4,73,0,815,'A bold hue and understated dobby detail bring refined nuance to this modern dress shirt. '),(6511,4,72,0,816,'Button-front. Imported. Available in checkered Blue. Cotton. Machine wash.'),(6512,4,83,0,816,NULL),(6513,4,73,0,816,'Check print on a refined cotton dress shirt.'),(6514,4,72,0,817,'Button-front. Imported. Available in Blue. Cotton. Machine wash.'),(6515,4,83,0,817,NULL),(6516,4,73,0,817,'A must-have item for the well-dressed man.'),(6517,4,72,0,818,'French cuff button-front shirt with tapered collar. Imported. Available in Blue and White. Cotton twill. Machine wash.'),(6518,4,83,0,818,NULL),(6519,4,73,0,818,'Made with wrinkle resistant cotton twill, this French-cuffed luxury dress shirt is perfect for Business Class frequent flyers.'),(6520,4,72,0,819,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(6521,4,83,0,819,NULL),(6522,4,73,0,819,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(6523,4,72,0,820,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(6524,4,83,0,820,NULL),(6525,4,73,0,820,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(6526,4,72,0,821,'Ultrasoft, lightweight V-neck tee. Available in Oatmeal and Grey. 100% cotton. Machine wash.'),(6527,4,83,0,821,NULL),(6528,4,73,0,821,'Minimalist style and maximum comfort in a lightweight cotton henley.'),(6529,4,72,0,822,'Long sleeve, pull over style. V-neck. Relaxed fit through the chest. Ribbed neckline, cuff and hem. Available in Grey and Charcoal. 100% Merino wool. Dry clean.'),(6530,4,83,0,822,NULL),(6531,4,73,0,822,'A classy V-neck sweater crafted from smooth refined Merino wool. Essential for layering when changing climates.'),(6532,4,72,0,823,'Ultra slim-fit, stretch denim. Mid rise. 5 pockets, tonal stitching. Cotton. Machine wash.'),(6533,4,83,0,823,NULL),(6534,4,73,0,823,'The perfect jean for packing. Extra strech for a comfortable and flattering fit. Pair with a loose fit top and nude pumps for a modern, travel friendly outfit.'),(6535,4,72,0,824,'Bermuda shorts with side slit pockets and back pockets. Unlined. Available in Charcoal. Cotton/Polyester. Hand Wash, Dry Clean for best results.'),(6536,4,83,0,824,NULL),(6537,4,73,0,824,'Complete ease of movement for anything from beachcombing to city touring.'),(6538,4,72,0,825,'Cotton canvas a-line skirt with front button detail. 20\" length. Available in Grey. Imported. Cotton. Machine Wash, Dry clean for best results.'),(6539,4,83,0,825,NULL),(6540,4,73,0,825,'Durable yet stylish for around the world adventures.'),(6541,4,72,0,826,'Slim straight denim. Mid rise. 5 pockets, contrast stitching. Available in Indigo. Cotton. Machine wash.'),(6542,4,83,0,826,NULL),(6543,4,73,0,826,'A classic in denim, our over-dyed straight-cut jean easily dresses up or down.'),(6544,4,72,0,827,'Crepe flat front straight leg trouser. Cropped ankle length. Side slit pockets and single rear welt pocket. Available in Ivory. Acetate/viscose. Dry clean.'),(6545,4,83,0,827,NULL),(6546,4,73,0,827,'Hester Pants are a sophisticated way to work the ankle length trend this season.'),(6547,4,72,0,828,'Wrap dress with deep Vee. Knee length. Available in Blue. Cotton/Cashmere. Hand wash, dry clean for best results.'),(6548,4,83,0,828,NULL),(6549,4,73,0,828,'Cashmere and cotton marry in our figure forgiving day dress.'),(6550,4,72,0,829,'Leather sheath dress with jersey panels. Sleeveless. Lined. Available in Black. Cotton/Leather. Dry clean.'),(6551,4,83,0,829,NULL),(6552,4,73,0,829,'Leather panels add a tuff touch to a classic LBD.'),(6553,4,72,0,830,'Sheath dress with gold medallion detail and slightly flaired skirt. Knee length. Fully lined. Available in Ivory. Polyester. Dry clean.'),(6554,4,83,0,830,NULL),(6555,4,73,0,830,'A demure selection for any occasion.'),(6556,4,72,0,831,'Oxford, fitted through the waist. V-neck, front button closure. Available in White and Seersucker. 100% cotton. Machine wash.'),(6557,4,83,0,831,NULL),(6558,4,73,0,831,'No matter where you are in the world, a crisp, clean oxford is always in style.'),(6559,4,72,0,832,'Trench coat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Lined. Imported. Available in Royal Blue. Polyester. Dry clean.'),(6560,4,83,0,832,NULL),(6561,4,73,0,832,'Sharply tailored and perfect for spring season.'),(6562,4,72,0,833,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(6563,4,83,0,833,NULL),(6564,4,73,0,833,'A relaxed and wrinkle resistant shirt, perfect for packing and travel. '),(6565,4,72,0,834,'Ultralightweight cotton collar shirt. Fitted through the waist. Front button closure. Ribbed side panels. Available in Grey and Charcoal. 100% cotton. Machine wash.'),(6566,4,83,0,834,NULL),(6567,4,73,0,834,'A relaxed and wrinkle resistant travel shirt. '),(6568,4,72,0,835,'Crew cardigan. Mother of pearl front button closure. Ribbed cuff and hem. 100% cotton. Hand wash.'),(6569,4,83,0,835,NULL),(6570,4,73,0,835,'Polished femininity in this cover-up of choice.'),(6571,4,72,0,836,'Scoop neck camisole. Hidden shelf bra. Available in Royal Blue. Cotton/elastane. Machine wash.'),(6572,4,83,0,836,NULL),(6573,4,73,0,836,'A simple stretch cotton camisole with hidden shelf bra. Great for layering.'),(6574,4,72,0,837,'Semi sheer, sleeveless collar shirt. Back pleat. Front button closure. Available in Black. Polyester. Machine wash.'),(6575,4,83,0,837,NULL),(6576,4,73,0,837,'A play on professional wear, our modern Noa Blouse has a semi sheer appearance.'),(6577,4,72,0,838,'Stretch denim jacket with contrast stitching. Two front flap pockets with button closure. 20\" length from back of collar. Available in Indigo. Machine wash.'),(6578,4,83,0,838,NULL),(6579,4,73,0,838,'Our timeless mid blue jean jacket enhances the laidback look of this season\'s sundresses. '),(6773,4,72,0,863,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(6774,4,83,0,863,NULL),(6775,4,185,0,863,'M'),(6776,4,73,0,863,'A contemporary lace up with intentional color wash effect.'),(7013,4,72,0,864,'Polished leather upper. Slip on style with padded top edge for comfort. Leather lining and footbed. 1\" rubber heel. Imported.'),(7014,4,83,0,864,NULL),(7015,4,185,0,864,'M'),(7016,4,73,0,864,'Sophisticated meets practical with our rubber-soled leather loafer.'),(7017,4,72,0,865,'Suede upper. Contrast wheeling, sole and laces. Stacked 1\" heel. Imported.'),(7018,4,83,0,865,NULL),(7019,4,185,0,865,'M'),(7020,4,73,0,865,'A stylish saddle shoe in supple suede.'),(7021,4,72,0,866,'Polished leather upper. Cap toe. Oxford lace up front. Imported.'),(7022,4,83,0,866,NULL),(7023,4,185,0,866,'M'),(7024,4,73,0,866,'Our classic captoe dress shoe in smooth calfskin.'),(7025,4,72,0,867,'Polished leather upper. Tonal stitching. Faux Oxford lace up front. Inside zip. Rubber 1\" heel. Domestic.'),(7026,4,83,0,867,NULL),(7027,4,185,0,867,'M'),(7028,4,73,0,867,'Blending classic Euro style with uptown elegance.'),(7029,4,72,0,868,'Color wash leather upper. Oxford lace up front. Contemporary square toe. Contrast laces. 1\" heel. Imported.'),(7030,4,83,0,868,NULL),(7031,4,185,0,868,'M'),(7032,4,73,0,868,'A contemporary lace up with intentional color wash effect.'),(7033,4,72,0,869,'Perforated leather upper. Faded color wash effect.  Padded insole for comfort, manmade. Rubber sole. Domestic. '),(7034,4,83,0,869,NULL),(7035,4,185,0,869,'M'),(7036,4,73,0,869,'Cool. Casual. Retro urban.'),(7037,4,72,0,870,'Snakeskin leather. Tonal bow detail on toe. 3.5\" heel and 0.5\" platform, 3\" equiv. Leather insole and lining. Made in Italy.'),(7038,4,83,0,870,NULL),(7039,4,185,0,870,'M'),(7040,4,73,0,870,'Snakeskin leather brings a charming effect to the classic pump.'),(7041,4,72,0,871,'Polished leather. Tonal bow and seam details on toe. 3.5\" heel. Leather insole and lining. Imported.'),(7042,4,83,0,871,NULL),(7043,4,185,0,871,'M'),(7044,4,73,0,871,'Proper elegance with a modern approach. '),(7045,4,72,0,872,'Two strap leather with perforation and rhinestone details. Contrast leather lining. Gold and brown dyed espadrille and leather wedge 4.5\" heel, 1.5\" platform, 3\" equiv. Domestic.'),(7046,4,83,0,872,NULL),(7047,4,185,0,872,'M'),(7048,4,73,0,872,'With a 1\" platform, our towering sandal wedges make walking in heels just a little easier.'),(7049,4,72,0,873,'Snakeskin leather. Cut out vamp detail. Contrast leather lining. 2.5\" heel. Made in Italy.'),(7050,4,83,0,873,NULL),(7051,4,185,0,873,'M'),(7052,4,73,0,873,'Add a spicy punch to new season looks.'),(7053,4,72,0,874,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(7054,4,83,0,874,NULL),(7055,4,185,0,874,'M'),(7056,4,73,0,874,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(7057,4,72,0,875,'Suede upper. Rubber 0.5\" heel. Domestic.'),(7058,4,83,0,875,NULL),(7059,4,185,0,875,'M'),(7060,4,73,0,875,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(7160,4,106,0,811,NULL),(7162,4,106,0,808,NULL),(7164,4,106,0,826,NULL),(7166,4,106,0,823,NULL),(7173,4,106,0,875,NULL),(7187,4,106,0,833,NULL),(7202,4,106,0,837,NULL),(7204,4,106,0,874,NULL),(7208,4,106,0,873,NULL),(7210,4,106,0,872,NULL),(7212,4,106,0,870,NULL),(7214,4,106,0,871,NULL),(7216,4,106,0,869,NULL),(7218,4,106,0,868,NULL),(7220,4,106,0,867,NULL),(7222,4,106,0,866,NULL),(7226,4,106,0,865,NULL),(7228,4,106,0,864,NULL),(7234,4,72,1,875,'Suede upper. Rubber 0.5\" heel. Domestic.'),(7235,4,73,1,875,'A pop of green is a fantastic to lift your favorite outfit. Wear with everything from skinny jeans to day dresses.'),(7236,4,83,1,875,NULL),(7237,4,106,1,875,NULL),(7240,4,72,1,808,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(7241,4,73,1,808,'Sharply tailored and perfect for spring season.'),(7242,4,83,1,808,NULL),(7243,4,106,1,808,NULL),(7244,4,72,2,808,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(7245,4,73,2,808,'Sharply tailored and perfect for spring season.'),(7246,4,83,2,808,NULL),(7247,4,106,2,808,NULL),(7248,4,72,3,808,'Double breasted overcoat with front button front closure and belt.Two side slit pockets and vented back. Two interior patch pockets. Available in Black. Imported. Poly/cotton/polyurethane. Dry clean.'),(7249,4,73,3,808,'Sharply tailored and perfect for spring season.'),(7250,4,83,3,808,NULL),(7251,4,106,3,808,NULL),(7258,4,72,1,874,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(7259,4,73,1,874,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(7260,4,83,1,874,NULL),(7261,4,106,1,874,NULL),(7262,4,72,2,874,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(7263,4,73,2,874,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(7264,4,83,2,874,NULL),(7265,4,106,2,874,NULL),(7266,4,72,3,874,'Dyed mohair upper. 3.5\" heel. Leather insole and lining. Imported.'),(7267,4,73,3,874,'Be after-dark chic with our contemporary mohair creation. The attention grabbing pair fits well with the season\'s trend of neutral hues.'),(7268,4,83,3,874,NULL),(7269,4,106,3,874,NULL),(7288,4,72,0,877,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(7289,4,73,0,877,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(7290,4,83,0,877,NULL),(7291,4,106,0,877,NULL),(7292,4,72,0,878,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(7293,4,73,0,878,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(7294,4,83,0,878,NULL),(7295,4,101,0,878,NULL),(7296,4,106,0,878,NULL),(7319,4,72,0,879,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(7320,4,73,0,879,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(7321,4,83,0,879,NULL),(7322,4,101,0,879,NULL),(7323,4,106,0,879,NULL),(7326,4,72,0,880,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(7327,4,73,0,880,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(7328,4,83,0,880,NULL),(7329,4,101,0,880,NULL),(7330,4,106,0,880,NULL),(7331,4,72,0,881,'Silk cami. Tie front detail, with hook and eye. Ruched neckline. Loose through the chest and bodice. 100% Silk. Dry clean.'),(7332,4,73,0,881,'Cut from tissue-weight silk crepe de chine, this airy style features a ruched neckline with tie and an unfinished hem for a contrastinly rugged feel. Compliment yours with skinny jeans.'),(7333,4,83,0,881,NULL),(7334,4,101,0,881,NULL),(7335,4,106,0,881,NULL),(7479,4,101,0,564,'a:13:{s:22:\"start_date_is_editable\";s:1:\"1\";s:20:\"schedule_description\";s:0:\"\";s:20:\"suspension_threshold\";s:0:\"\";s:17:\"bill_failed_later\";s:1:\"0\";s:11:\"period_unit\";s:4:\"year\";s:16:\"period_frequency\";s:1:\"1\";s:17:\"period_max_cycles\";s:1:\"1\";s:17:\"trial_period_unit\";s:0:\"\";s:22:\"trial_period_frequency\";s:0:\"\";s:23:\"trial_period_max_cycles\";s:0:\"\";s:20:\"trial_billing_amount\";s:0:\"\";s:11:\"init_amount\";s:0:\"\";s:13:\"init_may_fail\";s:1:\"0\";}'),(7762,4,106,0,821,NULL),(7764,4,106,0,630,NULL),(7766,4,106,0,642,NULL),(7770,4,106,0,673,NULL),(7772,4,106,0,674,NULL),(7774,4,106,0,675,NULL),(7776,4,106,0,676,NULL),(7778,4,106,0,677,NULL),(7780,4,106,0,678,NULL),(7782,4,106,0,679,NULL),(7784,4,106,0,763,NULL),(7786,4,106,0,764,NULL),(7788,4,106,0,765,NULL),(7790,4,106,0,766,NULL),(7792,4,106,0,767,NULL),(7830,4,72,0,888,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7831,4,73,0,888,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7832,4,83,0,888,NULL),(7833,4,101,0,888,NULL),(7834,4,106,0,888,NULL),(7835,4,72,0,889,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7836,4,73,0,889,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7837,4,83,0,889,NULL),(7838,4,101,0,889,NULL),(7839,4,106,0,889,NULL),(7840,4,72,0,890,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7841,4,73,0,890,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7842,4,83,0,890,NULL),(7843,4,101,0,890,NULL),(7844,4,106,0,890,NULL),(7845,4,72,0,891,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7846,4,73,0,891,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7847,4,83,0,891,NULL),(7848,4,101,0,891,NULL),(7849,4,106,0,891,NULL),(7850,4,72,0,892,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7851,4,73,0,892,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7852,4,83,0,892,NULL),(7853,4,101,0,892,NULL),(7854,4,106,0,892,NULL),(7855,4,72,0,893,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7856,4,73,0,893,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7857,4,83,0,893,NULL),(7858,4,101,0,893,NULL),(7859,4,106,0,893,NULL),(7860,4,72,0,894,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7861,4,73,0,894,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7862,4,83,0,894,NULL),(7863,4,101,0,894,NULL),(7864,4,106,0,894,NULL),(7865,4,72,0,895,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7866,4,73,0,895,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7867,4,83,0,895,NULL),(7868,4,101,0,895,NULL),(7869,4,106,0,895,NULL),(7870,4,72,0,896,'Loose fitting from the shoulders, open weave knit top. Semi sheer.  Slips on. Faux button closure detail on the back. Linen/Cotton. Machine wash.'),(7871,4,73,0,896,'The demure Elizabeth Knit features a semi sheer open weave and a forgiving silhouette. A nude camisole underneath keeps a stylish but conservative look.'),(7872,4,83,0,896,NULL),(7873,4,101,0,896,NULL),(7874,4,106,0,896,NULL),(7879,4,72,0,897,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7880,4,73,0,897,'This everyday shirt is equally stylish with jeans or trousers.'),(7881,4,83,0,897,NULL),(7882,4,101,0,897,NULL),(7883,4,106,0,897,NULL),(7884,4,72,0,898,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7885,4,73,0,898,'This everyday shirt is equally stylish with jeans or trousers.'),(7886,4,83,0,898,NULL),(7887,4,101,0,898,NULL),(7888,4,106,0,898,NULL),(7889,4,72,0,899,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7890,4,73,0,899,'This everyday shirt is equally stylish with jeans or trousers.'),(7891,4,83,0,899,NULL),(7892,4,101,0,899,NULL),(7893,4,106,0,899,NULL),(7894,4,72,0,900,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7895,4,73,0,900,'This everyday shirt is equally stylish with jeans or trousers.'),(7896,4,83,0,900,NULL),(7897,4,101,0,900,NULL),(7898,4,106,0,900,NULL),(7899,4,72,0,901,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7900,4,73,0,901,'This everyday shirt is equally stylish with jeans or trousers.'),(7901,4,83,0,901,NULL),(7902,4,101,0,901,NULL),(7903,4,106,0,901,NULL),(7904,4,72,0,902,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7905,4,73,0,902,'This everyday shirt is equally stylish with jeans or trousers.'),(7906,4,83,0,902,NULL),(7907,4,101,0,902,NULL),(7908,4,106,0,902,NULL),(7909,4,72,0,903,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7910,4,73,0,903,'This everyday shirt is equally stylish with jeans or trousers.'),(7911,4,83,0,903,NULL),(7912,4,101,0,903,NULL),(7913,4,106,0,903,NULL),(7914,4,72,0,904,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7915,4,73,0,904,'This everyday shirt is equally stylish with jeans or trousers.'),(7916,4,83,0,904,NULL),(7917,4,101,0,904,NULL),(7918,4,106,0,904,NULL),(7919,4,72,0,905,'Available in Sharp fit. Refined collar. Button cuff. Cotton. Machine wash. Made in US.'),(7920,4,73,0,905,'This everyday shirt is equally stylish with jeans or trousers.'),(7921,4,83,0,905,NULL),(7922,4,101,0,905,NULL),(7923,4,106,0,905,NULL);
/*!40000 ALTER TABLE `catalog_product_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_entity_tier_price`
--

DROP TABLE IF EXISTS `catalog_product_entity_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `E8AB433B9ACB00343ABB312AD2FAB087` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_6E08D719F0501DD1D8E6D4EFF2511C85` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_entity_varchar`
--

DROP TABLE IF EXISTS `catalog_product_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40529 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_flat_1`
--

DROP TABLE IF EXISTS `catalog_product_flat_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_flat_1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type Id',
  `allow_open_amount` int(11) DEFAULT NULL COMMENT 'Allow Open Amount',
  `cost` decimal(12,4) DEFAULT NULL COMMENT 'Cost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `email_template` varchar(255) DEFAULT NULL COMMENT 'Email Template',
  `enable_googlecheckout` smallint(6) DEFAULT NULL COMMENT 'Enable Googlecheckout',
  `giftcard_amounts` decimal(12,4) DEFAULT NULL COMMENT 'Giftcard Amounts',
  `giftcard_type` smallint(5) unsigned DEFAULT NULL COMMENT 'Giftcard Type',
  `gift_message_available` smallint(6) DEFAULT NULL COMMENT 'Gift Message Available',
  `gift_wrapping_available` smallint(6) DEFAULT NULL COMMENT 'Gift Wrapping Available',
  `gift_wrapping_price` decimal(12,4) DEFAULT NULL COMMENT 'Gift Wrapping Price',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `image_label` varchar(255) DEFAULT NULL COMMENT 'Image Label',
  `is_recurring` smallint(6) DEFAULT NULL COMMENT 'Is Recurring',
  `is_redeemable` int(11) DEFAULT NULL COMMENT 'Is Redeemable',
  `lifetime` int(11) DEFAULT NULL COMMENT 'Lifetime',
  `links_exist` int(11) DEFAULT NULL COMMENT 'Links Exist',
  `links_purchased_separately` int(11) DEFAULT NULL COMMENT 'Links Purchased Separately',
  `links_title` varchar(255) DEFAULT NULL COMMENT 'Links Title',
  `msrp` decimal(12,4) DEFAULT NULL COMMENT 'Msrp',
  `msrp_display_actual_price_type` varchar(255) DEFAULT NULL COMMENT 'Msrp Display Actual Price Type',
  `msrp_enabled` smallint(6) DEFAULT NULL COMMENT 'Msrp Enabled',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `news_from_date` datetime DEFAULT NULL COMMENT 'News From Date',
  `news_to_date` datetime DEFAULT NULL COMMENT 'News To Date',
  `open_amount_max` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Max',
  `open_amount_min` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Min',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `price_type` int(11) DEFAULT NULL COMMENT 'Price Type',
  `price_view` int(11) DEFAULT NULL COMMENT 'Price View',
  `recurring_profile` text COMMENT 'Recurring Profile',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `shipment_type` int(11) DEFAULT NULL COMMENT 'Shipment Type',
  `short_description` text COMMENT 'Short Description',
  `sku` varchar(64) DEFAULT NULL COMMENT 'Sku',
  `sku_type` int(11) DEFAULT NULL COMMENT 'Sku Type',
  `small_image` varchar(255) DEFAULT NULL COMMENT 'Small Image',
  `small_image_label` varchar(255) DEFAULT NULL COMMENT 'Small Image Label',
  `special_from_date` datetime DEFAULT NULL COMMENT 'Special From Date',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `special_to_date` datetime DEFAULT NULL COMMENT 'Special To Date',
  `tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Tax Class Id',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail',
  `thumbnail_label` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Label',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'Url Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  `use_config_email_template` int(11) DEFAULT NULL COMMENT 'Use Config Email Template',
  `use_config_is_redeemable` int(11) DEFAULT NULL COMMENT 'Use Config Is Redeemable',
  `use_config_lifetime` int(11) DEFAULT NULL COMMENT 'Use Config Lifetime',
  `visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Visibility',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `weight_type` int(11) DEFAULT NULL COMMENT 'Weight Type',
  `necklace_length` int(11) DEFAULT NULL COMMENT 'Necklace Length',
  `necklace_length_value` varchar(255) DEFAULT NULL COMMENT 'Necklace Length Value',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_1_TYPE_ID` (`type_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_1_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_1_NAME` (`name`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_1_PRICE` (`price`),
  CONSTRAINT `FK_CAT_PRD_FLAT_1_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Flat (Store 1)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_flat_2`
--

DROP TABLE IF EXISTS `catalog_product_flat_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_flat_2` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type Id',
  `allow_open_amount` int(11) DEFAULT NULL COMMENT 'Allow Open Amount',
  `cost` decimal(12,4) DEFAULT NULL COMMENT 'Cost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `email_template` varchar(255) DEFAULT NULL COMMENT 'Email Template',
  `enable_googlecheckout` smallint(6) DEFAULT NULL COMMENT 'Enable Googlecheckout',
  `giftcard_amounts` decimal(12,4) DEFAULT NULL COMMENT 'Giftcard Amounts',
  `giftcard_type` smallint(5) unsigned DEFAULT NULL COMMENT 'Giftcard Type',
  `gift_message_available` smallint(6) DEFAULT NULL COMMENT 'Gift Message Available',
  `gift_wrapping_available` smallint(6) DEFAULT NULL COMMENT 'Gift Wrapping Available',
  `gift_wrapping_price` decimal(12,4) DEFAULT NULL COMMENT 'Gift Wrapping Price',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `image_label` varchar(255) DEFAULT NULL COMMENT 'Image Label',
  `is_recurring` smallint(6) DEFAULT NULL COMMENT 'Is Recurring',
  `is_redeemable` int(11) DEFAULT NULL COMMENT 'Is Redeemable',
  `lifetime` int(11) DEFAULT NULL COMMENT 'Lifetime',
  `links_exist` int(11) DEFAULT NULL COMMENT 'Links Exist',
  `links_purchased_separately` int(11) DEFAULT NULL COMMENT 'Links Purchased Separately',
  `links_title` varchar(255) DEFAULT NULL COMMENT 'Links Title',
  `msrp` decimal(12,4) DEFAULT NULL COMMENT 'Msrp',
  `msrp_display_actual_price_type` varchar(255) DEFAULT NULL COMMENT 'Msrp Display Actual Price Type',
  `msrp_enabled` smallint(6) DEFAULT NULL COMMENT 'Msrp Enabled',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `news_from_date` datetime DEFAULT NULL COMMENT 'News From Date',
  `news_to_date` datetime DEFAULT NULL COMMENT 'News To Date',
  `open_amount_max` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Max',
  `open_amount_min` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Min',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `price_type` int(11) DEFAULT NULL COMMENT 'Price Type',
  `price_view` int(11) DEFAULT NULL COMMENT 'Price View',
  `recurring_profile` text COMMENT 'Recurring Profile',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `shipment_type` int(11) DEFAULT NULL COMMENT 'Shipment Type',
  `short_description` text COMMENT 'Short Description',
  `sku` varchar(64) DEFAULT NULL COMMENT 'Sku',
  `sku_type` int(11) DEFAULT NULL COMMENT 'Sku Type',
  `small_image` varchar(255) DEFAULT NULL COMMENT 'Small Image',
  `small_image_label` varchar(255) DEFAULT NULL COMMENT 'Small Image Label',
  `special_from_date` datetime DEFAULT NULL COMMENT 'Special From Date',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `special_to_date` datetime DEFAULT NULL COMMENT 'Special To Date',
  `tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Tax Class Id',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail',
  `thumbnail_label` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Label',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'Url Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  `use_config_email_template` int(11) DEFAULT NULL COMMENT 'Use Config Email Template',
  `use_config_is_redeemable` int(11) DEFAULT NULL COMMENT 'Use Config Is Redeemable',
  `use_config_lifetime` int(11) DEFAULT NULL COMMENT 'Use Config Lifetime',
  `visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Visibility',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `weight_type` int(11) DEFAULT NULL COMMENT 'Weight Type',
  `necklace_length` int(11) DEFAULT NULL COMMENT 'Necklace Length',
  `necklace_length_value` varchar(255) DEFAULT NULL COMMENT 'Necklace Length Value',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_2_TYPE_ID` (`type_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_2_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_2_NAME` (`name`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_2_PRICE` (`price`),
  CONSTRAINT `FK_CAT_PRD_FLAT_2_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Flat (Store 2)';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_flat_3`
--

DROP TABLE IF EXISTS `catalog_product_flat_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_flat_3` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type Id',
  `allow_open_amount` int(11) DEFAULT NULL COMMENT 'Allow Open Amount',
  `cost` decimal(12,4) DEFAULT NULL COMMENT 'Cost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `email_template` varchar(255) DEFAULT NULL COMMENT 'Email Template',
  `enable_googlecheckout` smallint(6) DEFAULT NULL COMMENT 'Enable Googlecheckout',
  `giftcard_amounts` decimal(12,4) DEFAULT NULL COMMENT 'Giftcard Amounts',
  `giftcard_type` smallint(5) unsigned DEFAULT NULL COMMENT 'Giftcard Type',
  `gift_message_available` smallint(6) DEFAULT NULL COMMENT 'Gift Message Available',
  `gift_wrapping_available` smallint(6) DEFAULT NULL COMMENT 'Gift Wrapping Available',
  `gift_wrapping_price` decimal(12,4) DEFAULT NULL COMMENT 'Gift Wrapping Price',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `image_label` varchar(255) DEFAULT NULL COMMENT 'Image Label',
  `is_recurring` smallint(6) DEFAULT NULL COMMENT 'Is Recurring',
  `is_redeemable` int(11) DEFAULT NULL COMMENT 'Is Redeemable',
  `lifetime` int(11) DEFAULT NULL COMMENT 'Lifetime',
  `links_exist` int(11) DEFAULT NULL COMMENT 'Links Exist',
  `links_purchased_separately` int(11) DEFAULT NULL COMMENT 'Links Purchased Separately',
  `links_title` varchar(255) DEFAULT NULL COMMENT 'Links Title',
  `msrp` decimal(12,4) DEFAULT NULL COMMENT 'Msrp',
  `msrp_display_actual_price_type` varchar(255) DEFAULT NULL COMMENT 'Msrp Display Actual Price Type',
  `msrp_enabled` smallint(6) DEFAULT NULL COMMENT 'Msrp Enabled',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `news_from_date` datetime DEFAULT NULL COMMENT 'News From Date',
  `news_to_date` datetime DEFAULT NULL COMMENT 'News To Date',
  `open_amount_max` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Max',
  `open_amount_min` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Min',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `price_type` int(11) DEFAULT NULL COMMENT 'Price Type',
  `price_view` int(11) DEFAULT NULL COMMENT 'Price View',
  `recurring_profile` text COMMENT 'Recurring Profile',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `shipment_type` int(11) DEFAULT NULL COMMENT 'Shipment Type',
  `short_description` text COMMENT 'Short Description',
  `sku` varchar(64) DEFAULT NULL COMMENT 'Sku',
  `sku_type` int(11) DEFAULT NULL COMMENT 'Sku Type',
  `small_image` varchar(255) DEFAULT NULL COMMENT 'Small Image',
  `small_image_label` varchar(255) DEFAULT NULL COMMENT 'Small Image Label',
  `special_from_date` datetime DEFAULT NULL COMMENT 'Special From Date',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `special_to_date` datetime DEFAULT NULL COMMENT 'Special To Date',
  `tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Tax Class Id',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail',
  `thumbnail_label` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Label',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'Url Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  `use_config_email_template` int(11) DEFAULT NULL COMMENT 'Use Config Email Template',
  `use_config_is_redeemable` int(11) DEFAULT NULL COMMENT 'Use Config Is Redeemable',
  `use_config_lifetime` int(11) DEFAULT NULL COMMENT 'Use Config Lifetime',
  `visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Visibility',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `weight_type` int(11) DEFAULT NULL COMMENT 'Weight Type',
  `necklace_length` int(11) DEFAULT NULL COMMENT 'Necklace Length',
  `necklace_length_value` varchar(255) DEFAULT NULL COMMENT 'Necklace Length Value',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_3_TYPE_ID` (`type_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_3_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_3_NAME` (`name`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_3_PRICE` (`price`),
  CONSTRAINT `FK_CAT_PRD_FLAT_3_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Flat (Store 3)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_flat_4`
--

DROP TABLE IF EXISTS `catalog_product_flat_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_flat_4` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type Id',
  `allow_open_amount` int(11) DEFAULT NULL COMMENT 'Allow Open Amount',
  `cost` decimal(12,4) DEFAULT NULL COMMENT 'Cost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `email_template` varchar(255) DEFAULT NULL COMMENT 'Email Template',
  `enable_googlecheckout` smallint(6) DEFAULT NULL COMMENT 'Enable Googlecheckout',
  `giftcard_amounts` decimal(12,4) DEFAULT NULL COMMENT 'Giftcard Amounts',
  `giftcard_type` smallint(5) unsigned DEFAULT NULL COMMENT 'Giftcard Type',
  `gift_message_available` smallint(6) DEFAULT NULL COMMENT 'Gift Message Available',
  `gift_wrapping_available` smallint(6) DEFAULT NULL COMMENT 'Gift Wrapping Available',
  `gift_wrapping_price` decimal(12,4) DEFAULT NULL COMMENT 'Gift Wrapping Price',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `image_label` varchar(255) DEFAULT NULL COMMENT 'Image Label',
  `is_recurring` smallint(6) DEFAULT NULL COMMENT 'Is Recurring',
  `is_redeemable` int(11) DEFAULT NULL COMMENT 'Is Redeemable',
  `lifetime` int(11) DEFAULT NULL COMMENT 'Lifetime',
  `links_exist` int(11) DEFAULT NULL COMMENT 'Links Exist',
  `links_purchased_separately` int(11) DEFAULT NULL COMMENT 'Links Purchased Separately',
  `links_title` varchar(255) DEFAULT NULL COMMENT 'Links Title',
  `msrp` decimal(12,4) DEFAULT NULL COMMENT 'Msrp',
  `msrp_display_actual_price_type` varchar(255) DEFAULT NULL COMMENT 'Msrp Display Actual Price Type',
  `msrp_enabled` smallint(6) DEFAULT NULL COMMENT 'Msrp Enabled',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `news_from_date` datetime DEFAULT NULL COMMENT 'News From Date',
  `news_to_date` datetime DEFAULT NULL COMMENT 'News To Date',
  `open_amount_max` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Max',
  `open_amount_min` decimal(12,4) DEFAULT NULL COMMENT 'Open Amount Min',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `price_type` int(11) DEFAULT NULL COMMENT 'Price Type',
  `price_view` int(11) DEFAULT NULL COMMENT 'Price View',
  `recurring_profile` text COMMENT 'Recurring Profile',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `shipment_type` int(11) DEFAULT NULL COMMENT 'Shipment Type',
  `short_description` text COMMENT 'Short Description',
  `sku` varchar(64) DEFAULT NULL COMMENT 'Sku',
  `sku_type` int(11) DEFAULT NULL COMMENT 'Sku Type',
  `small_image` varchar(255) DEFAULT NULL COMMENT 'Small Image',
  `small_image_label` varchar(255) DEFAULT NULL COMMENT 'Small Image Label',
  `special_from_date` datetime DEFAULT NULL COMMENT 'Special From Date',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `special_to_date` datetime DEFAULT NULL COMMENT 'Special To Date',
  `tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Tax Class Id',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail',
  `thumbnail_label` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Label',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'Url Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  `use_config_email_template` int(11) DEFAULT NULL COMMENT 'Use Config Email Template',
  `use_config_is_redeemable` int(11) DEFAULT NULL COMMENT 'Use Config Is Redeemable',
  `use_config_lifetime` int(11) DEFAULT NULL COMMENT 'Use Config Lifetime',
  `visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Visibility',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `weight_type` int(11) DEFAULT NULL COMMENT 'Weight Type',
  `necklace_length` int(11) DEFAULT NULL COMMENT 'Necklace Length',
  `necklace_length_value` varchar(255) DEFAULT NULL COMMENT 'Necklace Length Value',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_4_TYPE_ID` (`type_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_4_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_4_NAME` (`name`),
  KEY `IDX_CATALOG_PRODUCT_FLAT_4_PRICE` (`price`),
  CONSTRAINT `FK_CAT_PRD_FLAT_4_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Flat (Store 4)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_eav`
--

DROP TABLE IF EXISTS `catalog_product_index_eav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`),
  CONSTRAINT `FK_CATALOG_PRODUCT_INDEX_EAV_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_eav_decimal`
--

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`),
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_eav_decimal_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_eav_decimal_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_index_eav_decimal_tmp`
--

LOCK TABLES `catalog_product_index_eav_decimal_tmp` WRITE;
/*!40000 ALTER TABLE `catalog_product_index_eav_decimal_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_product_index_eav_decimal_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_index_eav_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_eav_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_index_eav_idx`
--

LOCK TABLES `catalog_product_index_eav_idx` WRITE;
/*!40000 ALTER TABLE `catalog_product_index_eav_idx` DISABLE KEYS */;
INSERT INTO `catalog_product_index_eav_idx` VALUES (337,92,1,15),(337,92,2,15),(337,92,3,15),(338,92,1,28),(338,92,2,28),(338,92,3,28),(339,92,1,20),(339,92,2,20),(339,92,3,20),(370,92,1,20),(370,92,2,20),(370,92,3,20),(372,92,1,20),(372,92,2,20),(372,92,3,20),(373,92,1,20),(373,92,2,20),(373,92,3,20),(375,92,1,27),(375,92,2,27),(375,92,3,27),(378,92,1,23),(378,92,2,23),(378,92,3,23),(380,92,1,22),(380,92,2,22),(380,92,3,22),(381,92,1,19),(381,92,2,19),(381,92,3,19),(382,92,1,13),(382,92,2,13),(382,92,3,13),(383,92,1,14),(383,92,2,14),(383,92,3,14),(384,92,1,27),(384,92,2,27),(384,92,3,27),(385,92,1,15),(385,92,2,15),(385,92,3,15),(389,92,1,17),(389,92,2,17),(389,92,3,17),(390,92,1,17),(390,92,2,17),(390,92,3,17),(391,92,1,20),(391,92,2,20),(391,92,3,20),(392,92,1,20),(392,92,2,20),(392,92,3,20),(393,92,1,20),(393,92,2,20),(393,92,3,20),(394,92,1,20),(394,92,2,20),(394,92,3,20),(395,92,1,20),(395,92,2,20),(395,92,3,20),(396,92,1,17),(396,92,2,17),(396,92,3,17),(397,92,1,20),(397,92,2,20),(397,92,3,20),(398,92,1,20),(398,92,2,20),(398,92,3,20),(399,92,1,20),(399,92,2,20),(399,92,3,20),(402,92,1,22),(402,92,2,22),(402,92,3,22),(403,92,1,27),(403,92,2,27),(403,92,3,27),(404,92,1,17),(404,92,2,17),(404,92,3,17),(405,92,1,15),(405,92,2,15),(405,92,3,15),(406,92,1,22),(406,92,2,22),(406,92,3,22),(407,92,1,27),(407,92,2,27),(407,92,3,27),(408,92,1,20),(408,92,1,22),(408,92,1,27),(408,92,2,20),(408,92,2,22),(408,92,2,27),(408,92,3,20),(408,92,3,22),(408,92,3,27),(409,92,1,20),(409,92,1,22),(409,92,1,27),(409,92,2,20),(409,92,2,22),(409,92,2,27),(409,92,3,20),(409,92,3,22),(409,92,3,27),(410,92,1,20),(410,92,1,22),(410,92,1,27),(410,92,2,20),(410,92,2,22),(410,92,2,27),(410,92,3,20),(410,92,3,22),(410,92,3,27),(411,92,1,28),(411,92,2,28),(411,92,3,28),(412,92,1,26),(412,92,2,26),(412,92,3,26),(413,92,1,26),(413,92,2,26),(413,92,3,26),(414,92,1,17),(414,92,1,25),(414,92,2,17),(414,92,2,25),(414,92,3,17),(414,92,3,25),(415,92,1,26),(415,92,2,26),(415,92,3,26),(416,92,1,15),(416,92,2,15),(416,92,3,15),(417,92,1,20),(417,92,1,21),(417,92,2,20),(417,92,2,21),(417,92,3,20),(417,92,3,21),(418,92,1,26),(418,92,2,26),(418,92,3,26),(419,92,1,14),(419,92,2,14),(419,92,3,14),(420,92,1,22),(420,92,2,22),(420,92,3,22),(421,92,1,22),(421,92,2,22),(421,92,3,22),(422,92,1,17),(422,92,2,17),(422,92,3,17),(423,92,1,18),(423,92,2,18),(423,92,3,18),(424,92,1,15),(424,92,2,15),(424,92,3,15),(425,92,1,27),(425,92,2,27),(425,92,3,27),(426,92,1,20),(426,92,2,20),(426,92,3,20),(427,92,1,27),(427,92,2,27),(427,92,3,27),(428,92,1,14),(428,92,2,14),(428,92,3,14),(430,92,1,14),(430,92,2,14),(430,92,3,14),(431,92,1,20),(431,92,2,20),(431,92,3,20),(432,92,1,17),(432,92,2,17),(432,92,3,17),(433,92,1,20),(433,92,2,20),(433,92,3,20),(434,92,1,19),(434,92,2,19),(434,92,3,19),(435,92,1,27),(435,92,2,27),(435,92,3,27),(436,92,1,20),(436,92,2,20),(436,92,3,20),(437,92,1,20),(437,92,1,22),(437,92,2,20),(437,92,2,22),(437,92,3,20),(437,92,3,22),(439,92,1,20),(439,92,2,20),(439,92,3,20),(440,92,1,20),(440,92,1,22),(440,92,2,20),(440,92,2,22),(440,92,3,20),(440,92,3,22),(445,92,1,17),(445,92,1,20),(445,92,2,17),(445,92,2,20),(445,92,3,17),(445,92,3,20),(446,92,1,20),(446,92,2,20),(446,92,3,20),(447,92,1,13),(447,92,1,14),(447,92,1,15),(447,92,1,19),(447,92,1,27),(447,92,2,13),(447,92,2,14),(447,92,2,15),(447,92,2,19),(447,92,2,27),(447,92,3,13),(447,92,3,14),(447,92,3,15),(447,92,3,19),(447,92,3,27),(456,92,1,17),(456,92,1,25),(456,92,2,17),(456,92,2,25),(456,92,3,17),(456,92,3,25),(549,92,1,27),(549,92,2,27),(549,92,3,27),(551,92,1,13),(551,92,2,13),(551,92,3,13),(552,92,1,26),(552,92,2,26),(552,92,3,26),(553,92,1,15),(553,92,2,15),(553,92,3,15),(554,92,1,15),(554,92,2,15),(554,92,3,15),(555,92,1,13),(555,92,2,13),(555,92,3,13),(877,92,1,20),(877,92,1,21),(877,92,2,20),(877,92,2,21),(877,92,3,20),(877,92,3,21),(402,175,1,30),(402,175,2,30),(402,175,3,30),(403,175,1,29),(403,175,2,29),(403,175,3,29),(404,175,1,31),(404,175,2,31),(404,175,3,31),(405,175,1,30),(405,175,2,30),(405,175,3,30),(406,175,1,31),(406,175,2,31),(406,175,3,31),(407,175,1,29),(407,175,2,29),(407,175,3,29),(408,175,1,31),(408,175,2,31),(408,175,3,31),(409,175,1,31),(409,175,2,31),(409,175,3,31),(410,175,1,31),(410,175,2,31),(410,175,3,31),(411,175,1,30),(411,175,2,30),(411,175,3,30),(412,175,1,29),(412,175,2,29),(412,175,3,29),(413,175,1,31),(413,175,2,31),(413,175,3,31),(414,175,1,31),(414,175,2,31),(414,175,3,31),(415,175,1,31),(415,175,2,31),(415,175,3,31),(416,175,1,30),(416,175,2,30),(416,175,3,30),(417,175,1,29),(417,175,2,29),(417,175,3,29),(418,175,1,31),(418,175,2,31),(418,175,3,31),(419,175,1,31),(419,175,2,31),(419,175,3,31),(420,175,1,30),(420,175,2,30),(420,175,3,30),(421,175,1,31),(421,175,2,31),(421,175,3,31),(422,175,1,30),(422,175,2,30),(422,175,3,30),(423,175,1,31),(423,175,2,31),(423,175,3,31),(424,175,1,30),(424,175,2,30),(424,175,3,30),(425,175,1,29),(425,175,2,29),(425,175,3,29),(427,175,1,31),(427,175,2,31),(427,175,3,31),(428,175,1,29),(428,175,2,29),(428,175,3,29),(430,175,1,31),(430,175,2,31),(430,175,3,31),(431,175,1,29),(431,175,2,29),(431,175,3,29),(432,175,1,30),(432,175,2,30),(432,175,3,30),(433,175,1,30),(433,175,2,30),(433,175,3,30),(434,175,1,31),(434,175,2,31),(434,175,3,31),(435,175,1,29),(435,175,2,29),(435,175,3,29),(456,175,1,31),(456,175,2,31),(456,175,3,31),(877,175,1,29),(877,175,2,29),(877,175,3,29),(402,176,1,41),(402,176,2,41),(402,176,3,41),(403,176,1,41),(403,176,2,41),(403,176,3,41),(404,176,1,41),(404,176,2,41),(404,176,3,41),(405,176,1,35),(405,176,1,211),(405,176,2,35),(405,176,2,211),(405,176,3,35),(405,176,3,211),(406,176,1,35),(406,176,1,211),(406,176,2,35),(406,176,2,211),(406,176,3,35),(406,176,3,211),(407,176,1,35),(407,176,1,211),(407,176,2,35),(407,176,2,211),(407,176,3,35),(407,176,3,211),(408,176,1,40),(408,176,2,40),(408,176,3,40),(409,176,1,40),(409,176,2,40),(409,176,3,40),(410,176,1,40),(410,176,2,40),(410,176,3,40),(411,176,1,39),(411,176,2,39),(411,176,3,39),(412,176,1,39),(412,176,2,39),(412,176,3,39),(413,176,1,38),(413,176,2,38),(413,176,3,38),(414,176,1,37),(414,176,2,37),(414,176,3,37),(415,176,1,36),(415,176,2,36),(415,176,3,36),(416,176,1,37),(416,176,2,37),(416,176,3,37),(417,176,1,34),(417,176,1,35),(417,176,2,34),(417,176,2,35),(417,176,3,34),(417,176,3,35),(418,176,1,35),(418,176,2,35),(418,176,3,35),(419,176,1,39),(419,176,2,39),(419,176,3,39),(420,176,1,34),(420,176,2,34),(420,176,3,34),(421,176,1,39),(421,176,2,39),(421,176,3,39),(422,176,1,32),(422,176,2,32),(422,176,3,32),(423,176,1,33),(423,176,2,33),(423,176,3,33),(424,176,1,33),(424,176,2,33),(424,176,3,33),(425,176,1,33),(425,176,2,33),(425,176,3,33),(426,176,1,36),(426,176,2,36),(426,176,3,36),(427,176,1,36),(427,176,2,36),(427,176,3,36),(428,176,1,37),(428,176,2,37),(428,176,3,37),(456,176,1,37),(456,176,2,37),(456,176,3,37),(877,176,1,34),(877,176,1,35),(877,176,2,34),(877,176,2,35),(877,176,3,34),(877,176,3,35),(549,177,1,201),(549,177,2,201),(549,177,3,201),(551,177,1,200),(551,177,2,200),(551,177,3,200),(552,177,1,198),(552,177,2,198),(552,177,3,198),(553,177,1,206),(553,177,2,206),(553,177,3,206),(554,177,1,42),(554,177,2,42),(554,177,3,42),(555,177,1,200),(555,177,2,200),(555,177,3,200),(402,178,1,47),(402,178,2,47),(402,178,3,47),(403,178,1,47),(403,178,2,47),(403,178,3,47),(404,178,1,47),(404,178,2,47),(404,178,3,47),(405,178,1,47),(405,178,2,47),(405,178,3,47),(406,178,1,47),(406,178,2,47),(406,178,3,47),(407,178,1,47),(407,178,2,47),(407,178,3,47),(408,178,1,46),(408,178,2,46),(408,178,3,46),(409,178,1,46),(409,178,2,46),(409,178,3,46),(410,178,1,46),(410,178,2,46),(410,178,3,46),(411,178,1,47),(411,178,2,47),(411,178,3,47),(412,178,1,47),(412,178,2,47),(412,178,3,47),(413,178,1,46),(413,178,2,46),(413,178,3,46),(417,178,1,45),(417,178,2,45),(417,178,3,45),(418,178,1,45),(418,178,2,45),(418,178,3,45),(419,178,1,47),(419,178,2,47),(419,178,3,47),(420,178,1,47),(420,178,2,47),(420,178,3,47),(421,178,1,46),(421,178,2,46),(421,178,3,46),(423,178,1,45),(423,178,2,45),(423,178,3,45),(424,178,1,45),(424,178,2,45),(424,178,3,45),(425,178,1,45),(425,178,2,45),(425,178,3,45),(877,178,1,45),(877,178,2,45),(877,178,3,45),(402,179,1,51),(402,179,2,51),(402,179,3,51),(403,179,1,50),(403,179,2,50),(403,179,3,50),(404,179,1,49),(404,179,1,51),(404,179,2,49),(404,179,2,51),(404,179,3,49),(404,179,3,51),(405,179,1,50),(405,179,2,50),(405,179,3,50),(406,179,1,49),(406,179,2,49),(406,179,3,49),(407,179,1,50),(407,179,2,50),(407,179,3,50),(408,179,1,50),(408,179,1,51),(408,179,2,50),(408,179,2,51),(408,179,3,50),(408,179,3,51),(409,179,1,50),(409,179,2,50),(409,179,3,50),(410,179,1,50),(410,179,2,50),(410,179,3,50),(411,179,1,51),(411,179,2,51),(411,179,3,51),(412,179,1,50),(412,179,2,50),(412,179,3,50),(413,179,1,50),(413,179,1,51),(413,179,2,50),(413,179,2,51),(413,179,3,50),(413,179,3,51),(414,179,1,51),(414,179,2,51),(414,179,3,51),(415,179,1,56),(415,179,2,56),(415,179,3,56),(416,179,1,50),(416,179,2,50),(416,179,3,50),(426,179,1,54),(426,179,2,54),(426,179,3,54),(427,179,1,51),(427,179,2,51),(427,179,3,51),(428,179,1,49),(428,179,2,49),(428,179,3,49),(456,179,1,51),(456,179,2,51),(456,179,3,51),(402,180,1,77),(402,180,1,78),(402,180,1,79),(402,180,1,80),(402,180,1,81),(402,180,2,77),(402,180,2,78),(402,180,2,79),(402,180,2,80),(402,180,2,81),(402,180,3,77),(402,180,3,78),(402,180,3,79),(402,180,3,80),(402,180,3,81),(403,180,1,77),(403,180,1,81),(403,180,2,77),(403,180,2,81),(403,180,3,77),(403,180,3,81),(404,180,1,77),(404,180,1,78),(404,180,1,79),(404,180,1,80),(404,180,1,81),(404,180,2,77),(404,180,2,78),(404,180,2,79),(404,180,2,80),(404,180,2,81),(404,180,3,77),(404,180,3,78),(404,180,3,79),(404,180,3,80),(404,180,3,81),(405,180,1,77),(405,180,1,78),(405,180,1,79),(405,180,1,81),(405,180,2,77),(405,180,2,78),(405,180,2,79),(405,180,2,81),(405,180,3,77),(405,180,3,78),(405,180,3,79),(405,180,3,81),(406,180,1,77),(406,180,1,78),(406,180,1,79),(406,180,1,80),(406,180,1,81),(406,180,2,77),(406,180,2,78),(406,180,2,79),(406,180,2,80),(406,180,2,81),(406,180,3,77),(406,180,3,78),(406,180,3,79),(406,180,3,80),(406,180,3,81),(407,180,1,77),(407,180,1,78),(407,180,1,79),(407,180,1,80),(407,180,1,81),(407,180,2,77),(407,180,2,78),(407,180,2,79),(407,180,2,80),(407,180,2,81),(407,180,3,77),(407,180,3,78),(407,180,3,79),(407,180,3,80),(407,180,3,81),(408,180,1,77),(408,180,1,78),(408,180,1,79),(408,180,1,80),(408,180,1,81),(408,180,2,77),(408,180,2,78),(408,180,2,79),(408,180,2,80),(408,180,2,81),(408,180,3,77),(408,180,3,78),(408,180,3,79),(408,180,3,80),(408,180,3,81),(409,180,1,77),(409,180,1,78),(409,180,1,79),(409,180,1,80),(409,180,1,81),(409,180,2,77),(409,180,2,78),(409,180,2,79),(409,180,2,80),(409,180,2,81),(409,180,3,77),(409,180,3,78),(409,180,3,79),(409,180,3,80),(409,180,3,81),(410,180,1,77),(410,180,1,78),(410,180,1,79),(410,180,1,80),(410,180,1,81),(410,180,2,77),(410,180,2,78),(410,180,2,79),(410,180,2,80),(410,180,2,81),(410,180,3,77),(410,180,3,78),(410,180,3,79),(410,180,3,80),(410,180,3,81),(411,180,1,77),(411,180,1,78),(411,180,1,79),(411,180,1,80),(411,180,1,81),(411,180,2,77),(411,180,2,78),(411,180,2,79),(411,180,2,80),(411,180,2,81),(411,180,3,77),(411,180,3,78),(411,180,3,79),(411,180,3,80),(411,180,3,81),(412,180,1,77),(412,180,1,78),(412,180,1,79),(412,180,1,80),(412,180,1,81),(412,180,2,77),(412,180,2,78),(412,180,2,79),(412,180,2,80),(412,180,2,81),(412,180,3,77),(412,180,3,78),(412,180,3,79),(412,180,3,80),(412,180,3,81),(413,180,1,77),(413,180,1,78),(413,180,1,79),(413,180,1,80),(413,180,1,81),(413,180,2,77),(413,180,2,78),(413,180,2,79),(413,180,2,80),(413,180,2,81),(413,180,3,77),(413,180,3,78),(413,180,3,79),(413,180,3,80),(413,180,3,81),(414,180,1,58),(414,180,1,59),(414,180,1,61),(414,180,1,63),(414,180,1,64),(414,180,1,65),(414,180,1,67),(414,180,2,58),(414,180,2,59),(414,180,2,61),(414,180,2,63),(414,180,2,64),(414,180,2,65),(414,180,2,67),(414,180,3,58),(414,180,3,59),(414,180,3,61),(414,180,3,63),(414,180,3,64),(414,180,3,65),(414,180,3,67),(415,180,1,59),(415,180,1,61),(415,180,1,62),(415,180,1,63),(415,180,1,64),(415,180,1,65),(415,180,2,59),(415,180,2,61),(415,180,2,62),(415,180,2,63),(415,180,2,64),(415,180,2,65),(415,180,3,59),(415,180,3,61),(415,180,3,62),(415,180,3,63),(415,180,3,64),(415,180,3,65),(416,180,1,59),(416,180,1,61),(416,180,1,62),(416,180,1,63),(416,180,1,64),(416,180,1,65),(416,180,2,59),(416,180,2,61),(416,180,2,62),(416,180,2,63),(416,180,2,64),(416,180,2,65),(416,180,3,59),(416,180,3,61),(416,180,3,62),(416,180,3,63),(416,180,3,64),(416,180,3,65),(417,180,1,77),(417,180,1,78),(417,180,1,79),(417,180,1,80),(417,180,1,81),(417,180,2,77),(417,180,2,78),(417,180,2,79),(417,180,2,80),(417,180,2,81),(417,180,3,77),(417,180,3,78),(417,180,3,79),(417,180,3,80),(417,180,3,81),(418,180,1,77),(418,180,1,78),(418,180,1,79),(418,180,2,77),(418,180,2,78),(418,180,2,79),(418,180,3,77),(418,180,3,78),(418,180,3,79),(419,180,1,78),(419,180,1,79),(419,180,1,80),(419,180,2,78),(419,180,2,79),(419,180,2,80),(419,180,3,78),(419,180,3,79),(419,180,3,80),(420,180,1,77),(420,180,1,78),(420,180,1,79),(420,180,1,80),(420,180,1,81),(420,180,2,77),(420,180,2,78),(420,180,2,79),(420,180,2,80),(420,180,2,81),(420,180,3,77),(420,180,3,78),(420,180,3,79),(420,180,3,80),(420,180,3,81),(421,180,1,77),(421,180,1,78),(421,180,1,79),(421,180,1,80),(421,180,1,81),(421,180,2,77),(421,180,2,78),(421,180,2,79),(421,180,2,80),(421,180,2,81),(421,180,3,77),(421,180,3,78),(421,180,3,79),(421,180,3,80),(421,180,3,81),(422,180,1,72),(422,180,1,73),(422,180,1,74),(422,180,1,75),(422,180,1,76),(422,180,2,72),(422,180,2,73),(422,180,2,74),(422,180,2,75),(422,180,2,76),(422,180,3,72),(422,180,3,73),(422,180,3,74),(422,180,3,75),(422,180,3,76),(423,180,1,77),(423,180,1,78),(423,180,1,79),(423,180,1,80),(423,180,1,81),(423,180,2,77),(423,180,2,78),(423,180,2,79),(423,180,2,80),(423,180,2,81),(423,180,3,77),(423,180,3,78),(423,180,3,79),(423,180,3,80),(423,180,3,81),(424,180,1,72),(424,180,1,73),(424,180,1,74),(424,180,1,75),(424,180,1,76),(424,180,2,72),(424,180,2,73),(424,180,2,74),(424,180,2,75),(424,180,2,76),(424,180,3,72),(424,180,3,73),(424,180,3,74),(424,180,3,75),(424,180,3,76),(425,180,1,72),(425,180,1,73),(425,180,1,74),(425,180,1,76),(425,180,2,72),(425,180,2,73),(425,180,2,74),(425,180,2,76),(425,180,3,72),(425,180,3,73),(425,180,3,74),(425,180,3,76),(426,180,1,63),(426,180,1,64),(426,180,1,65),(426,180,1,66),(426,180,1,67),(426,180,1,68),(426,180,1,69),(426,180,2,63),(426,180,2,64),(426,180,2,65),(426,180,2,66),(426,180,2,67),(426,180,2,68),(426,180,2,69),(426,180,3,63),(426,180,3,64),(426,180,3,65),(426,180,3,66),(426,180,3,67),(426,180,3,68),(426,180,3,69),(427,180,1,63),(427,180,1,64),(427,180,1,65),(427,180,1,66),(427,180,1,67),(427,180,1,68),(427,180,1,69),(427,180,2,63),(427,180,2,64),(427,180,2,65),(427,180,2,66),(427,180,2,67),(427,180,2,68),(427,180,2,69),(427,180,3,63),(427,180,3,64),(427,180,3,65),(427,180,3,66),(427,180,3,67),(427,180,3,68),(427,180,3,69),(428,180,1,71),(428,180,1,72),(428,180,1,73),(428,180,1,74),(428,180,1,75),(428,180,1,76),(428,180,2,71),(428,180,2,72),(428,180,2,73),(428,180,2,74),(428,180,2,75),(428,180,2,76),(428,180,3,71),(428,180,3,72),(428,180,3,73),(428,180,3,74),(428,180,3,75),(428,180,3,76),(456,180,1,58),(456,180,1,59),(456,180,1,61),(456,180,1,63),(456,180,1,64),(456,180,1,65),(456,180,1,67),(456,180,2,58),(456,180,2,59),(456,180,2,61),(456,180,2,63),(456,180,2,64),(456,180,2,65),(456,180,2,67),(456,180,3,58),(456,180,3,59),(456,180,3,61),(456,180,3,63),(456,180,3,64),(456,180,3,65),(456,180,3,67),(877,180,1,77),(877,180,1,78),(877,180,1,79),(877,180,1,80),(877,180,1,81),(877,180,2,77),(877,180,2,78),(877,180,2,79),(877,180,2,80),(877,180,2,81),(877,180,3,77),(877,180,3,78),(877,180,3,79),(877,180,3,80),(877,180,3,81),(422,181,1,82),(422,181,2,82),(422,181,3,82),(423,181,1,84),(423,181,2,84),(423,181,3,84),(424,181,1,82),(424,181,2,82),(424,181,3,82),(425,181,1,82),(425,181,2,82),(425,181,3,82),(337,184,1,93),(337,184,2,93),(337,184,3,93),(338,184,1,94),(338,184,2,94),(338,184,3,94),(339,184,1,93),(339,184,2,93),(339,184,3,93),(370,184,1,94),(370,184,2,94),(370,184,3,94),(372,184,1,220),(372,184,2,220),(372,184,3,220),(373,184,1,93),(373,184,2,93),(373,184,3,93),(375,184,1,220),(375,184,2,220),(375,184,3,220),(402,184,1,93),(402,184,2,93),(402,184,3,93),(403,184,1,93),(403,184,2,93),(403,184,3,93),(404,184,1,93),(404,184,2,93),(404,184,3,93),(405,184,1,93),(405,184,2,93),(405,184,3,93),(406,184,1,93),(406,184,2,93),(406,184,3,93),(407,184,1,93),(407,184,2,93),(407,184,3,93),(408,184,1,93),(408,184,2,93),(408,184,3,93),(409,184,1,93),(409,184,2,93),(409,184,3,93),(410,184,1,93),(410,184,2,93),(410,184,3,93),(411,184,1,93),(411,184,2,93),(411,184,3,93),(412,184,1,93),(412,184,2,93),(412,184,3,93),(413,184,1,93),(413,184,2,93),(413,184,3,93),(414,184,1,93),(414,184,2,93),(414,184,3,93),(415,184,1,93),(415,184,2,93),(415,184,3,93),(416,184,1,93),(416,184,2,93),(416,184,3,93),(417,184,1,94),(417,184,2,94),(417,184,3,94),(418,184,1,94),(418,184,2,94),(418,184,3,94),(419,184,1,94),(419,184,2,94),(419,184,3,94),(420,184,1,94),(420,184,2,94),(420,184,3,94),(421,184,1,94),(421,184,2,94),(421,184,3,94),(422,184,1,94),(422,184,2,94),(422,184,3,94),(423,184,1,94),(423,184,2,94),(423,184,3,94),(424,184,1,94),(424,184,2,94),(424,184,3,94),(425,184,1,94),(425,184,2,94),(425,184,3,94),(426,184,1,94),(426,184,2,94),(426,184,3,94),(427,184,1,94),(427,184,2,94),(427,184,3,94),(428,184,1,94),(428,184,2,94),(428,184,3,94),(436,184,1,220),(436,184,2,220),(436,184,3,220),(439,184,1,220),(439,184,2,220),(439,184,3,220),(456,184,1,93),(456,184,2,93),(456,184,3,93),(551,184,1,94),(551,184,2,94),(551,184,3,94),(552,184,1,94),(552,184,2,94),(552,184,3,94),(553,184,1,94),(553,184,2,94),(553,184,3,94),(554,184,1,93),(554,184,2,93),(554,184,3,93),(555,184,1,94),(555,184,2,94),(555,184,3,94),(877,184,1,94),(877,184,2,94),(877,184,3,94),(430,186,1,98),(430,186,1,99),(430,186,1,100),(430,186,1,101),(430,186,1,102),(430,186,2,98),(430,186,2,99),(430,186,2,100),(430,186,2,101),(430,186,2,102),(430,186,3,98),(430,186,3,99),(430,186,3,100),(430,186,3,101),(430,186,3,102),(431,186,1,98),(431,186,1,99),(431,186,1,100),(431,186,1,101),(431,186,1,102),(431,186,2,98),(431,186,2,99),(431,186,2,100),(431,186,2,101),(431,186,2,102),(431,186,3,98),(431,186,3,99),(431,186,3,100),(431,186,3,101),(431,186,3,102),(432,186,1,98),(432,186,1,99),(432,186,1,100),(432,186,1,101),(432,186,1,102),(432,186,2,98),(432,186,2,99),(432,186,2,100),(432,186,2,101),(432,186,2,102),(432,186,3,98),(432,186,3,99),(432,186,3,100),(432,186,3,101),(432,186,3,102),(433,186,1,96),(433,186,1,97),(433,186,1,98),(433,186,1,99),(433,186,1,100),(433,186,2,96),(433,186,2,97),(433,186,2,98),(433,186,2,99),(433,186,2,100),(433,186,3,96),(433,186,3,97),(433,186,3,98),(433,186,3,99),(433,186,3,100),(434,186,1,96),(434,186,1,97),(434,186,1,98),(434,186,1,99),(434,186,1,100),(434,186,2,96),(434,186,2,97),(434,186,2,98),(434,186,2,99),(434,186,2,100),(434,186,3,96),(434,186,3,97),(434,186,3,98),(434,186,3,99),(434,186,3,100),(435,186,1,96),(435,186,1,97),(435,186,1,98),(435,186,1,99),(435,186,1,100),(435,186,2,96),(435,186,2,97),(435,186,2,98),(435,186,2,99),(435,186,2,100),(435,186,3,96),(435,186,3,97),(435,186,3,98),(435,186,3,99),(435,186,3,100),(430,187,1,112),(430,187,2,112),(430,187,3,112),(431,187,1,105),(431,187,1,115),(431,187,2,105),(431,187,2,115),(431,187,3,105),(431,187,3,115),(432,187,1,113),(432,187,2,113),(432,187,3,113),(433,187,1,110),(433,187,2,110),(433,187,3,110),(434,187,1,108),(434,187,2,108),(434,187,3,108),(435,187,1,109),(435,187,2,109),(435,187,3,109),(337,189,1,130),(337,189,2,130),(337,189,3,130),(338,189,1,130),(338,189,2,130),(338,189,3,130),(339,189,1,130),(339,189,2,130),(339,189,3,130),(370,189,1,138),(370,189,2,138),(370,189,3,138),(372,189,1,138),(372,189,2,138),(372,189,3,138),(373,189,1,138),(373,189,2,138),(373,189,3,138),(374,189,1,138),(374,189,2,138),(374,189,3,138),(375,189,1,130),(375,189,2,130),(375,189,3,130),(380,189,1,215),(380,189,2,215),(380,189,3,215),(381,189,1,126),(381,189,2,126),(381,189,3,126),(382,189,1,130),(382,189,2,130),(382,189,3,130),(383,189,1,129),(383,189,2,129),(383,189,3,129),(384,189,1,129),(384,189,2,129),(384,189,3,129),(385,189,1,125),(385,189,2,125),(385,189,3,125),(386,189,1,134),(386,189,2,134),(386,189,3,134),(389,189,1,131),(389,189,2,131),(389,189,3,131),(390,189,1,137),(390,189,2,137),(390,189,3,137),(391,189,1,134),(391,189,2,134),(391,189,3,134),(436,189,1,130),(436,189,2,130),(436,189,3,130),(437,189,1,131),(437,189,1,136),(437,189,2,131),(437,189,2,136),(437,189,3,131),(437,189,3,136),(439,189,1,130),(439,189,2,130),(439,189,3,130),(440,189,1,131),(440,189,1,136),(440,189,2,131),(440,189,2,136),(440,189,3,131),(440,189,3,136),(447,189,1,125),(447,189,1,126),(447,189,1,129),(447,189,1,130),(447,189,2,125),(447,189,2,126),(447,189,2,129),(447,189,2,130),(447,189,3,125),(447,189,3,126),(447,189,3,129),(447,189,3,130),(370,192,1,157),(370,192,2,157),(370,192,3,157),(372,192,1,154),(372,192,2,154),(372,192,3,154),(373,192,1,155),(373,192,2,155),(373,192,3,155),(374,192,1,153),(374,192,2,153),(374,192,3,153),(375,192,1,156),(375,192,2,156),(375,192,3,156),(436,192,1,156),(436,192,2,156),(436,192,3,156),(439,192,1,156),(439,192,2,156),(439,192,3,156),(549,193,1,160),(549,193,2,160),(549,193,3,160),(551,193,1,164),(551,193,2,164),(551,193,3,164),(552,193,1,164),(552,193,2,164),(552,193,3,164),(553,193,1,159),(553,193,2,159),(553,193,3,159),(554,193,1,162),(554,193,2,162),(554,193,3,162),(555,193,1,164),(555,193,2,164),(555,193,3,164),(392,197,1,218),(392,197,2,218),(392,197,3,218),(393,197,1,218),(393,197,2,218),(393,197,3,218),(394,197,1,219),(394,197,2,219),(394,197,3,219),(395,197,1,219),(395,197,2,219),(395,197,3,219),(396,197,1,219),(396,197,2,219),(396,197,3,219),(397,197,1,181),(397,197,2,181),(397,197,3,181),(398,197,1,181),(398,197,2,181),(398,197,3,181),(399,197,1,182),(399,197,2,182),(399,197,3,182),(445,197,1,218),(445,197,1,219),(445,197,2,218),(445,197,2,219),(445,197,3,218),(445,197,3,219),(446,197,1,181),(446,197,1,182),(446,197,2,181),(446,197,2,182),(446,197,3,181),(446,197,3,182),(378,198,1,185),(378,198,2,185),(378,198,3,185),(380,198,1,185),(380,198,2,185),(380,198,3,185),(381,198,1,184),(381,198,2,184),(381,198,3,184),(382,198,1,184),(382,198,2,184),(382,198,3,184),(383,198,1,184),(383,198,2,184),(383,198,3,184),(384,198,1,184),(384,198,2,184),(384,198,3,184),(385,198,1,184),(385,198,2,184),(385,198,3,184),(447,198,1,184),(447,198,2,184),(447,198,3,184),(378,199,1,214),(378,199,2,214),(378,199,3,214),(380,199,1,214),(380,199,2,214),(380,199,3,214),(381,199,1,217),(381,199,2,217),(381,199,3,217),(382,199,1,217),(382,199,2,217),(382,199,3,217),(383,199,1,217),(383,199,2,217),(383,199,3,217),(384,199,1,217),(384,199,2,217),(384,199,3,217),(385,199,1,217),(385,199,2,217),(385,199,3,217),(386,199,1,186),(386,199,2,186),(386,199,3,186),(437,199,1,186),(437,199,2,186),(437,199,3,186),(440,199,1,186),(440,199,2,186),(440,199,3,186),(447,199,1,217),(447,199,2,217),(447,199,3,217),(378,200,1,191),(378,200,2,191),(378,200,3,191),(380,200,1,191),(380,200,2,191),(380,200,3,191),(381,200,1,191),(381,200,2,191),(381,200,3,191),(382,200,1,191),(382,200,2,191),(382,200,3,191),(383,200,1,191),(383,200,2,191),(383,200,3,191),(384,200,1,191),(384,200,2,191),(384,200,3,191),(385,200,1,191),(385,200,2,191),(385,200,3,191),(386,200,1,192),(386,200,2,192),(386,200,3,192),(389,200,1,192),(389,200,2,192),(389,200,3,192),(390,200,1,192),(390,200,2,192),(390,200,3,192),(391,200,1,192),(391,200,2,192),(391,200,3,192),(437,200,1,192),(437,200,2,192),(437,200,3,192),(440,200,1,192),(440,200,2,192),(440,200,3,192),(447,200,1,191),(447,200,2,191),(447,200,3,191),(448,201,1,195),(448,201,2,195),(448,201,3,195),(450,201,1,195),(450,201,2,195),(450,201,3,195),(557,201,1,195),(557,201,2,195),(557,201,3,195),(558,201,1,193),(558,201,2,193),(558,201,3,193),(559,201,1,193),(559,201,2,193),(559,201,3,193),(560,201,1,193),(560,201,2,193),(560,201,3,193),(561,201,1,193),(561,201,2,193),(561,201,3,193),(563,201,1,193),(563,201,2,193),(563,201,3,193),(553,209,1,213),(553,209,2,213),(553,209,3,213);
/*!40000 ALTER TABLE `catalog_product_index_eav_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_index_eav_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_eav_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_group_price`
--

DROP TABLE IF EXISTS `catalog_product_index_group_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_group_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_195DF97C81B0BDD6A2EEC50F870E16D1` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price`
--

DROP TABLE IF EXISTS `catalog_product_index_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `IDX_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`),
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_bundle_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_bundle_opt_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_bundle_opt_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_bundle_sel_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_bundle_sel_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_bundle_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_cfg_opt_agr_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_cfg_opt_agr_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_cfg_opt_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_cfg_opt_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_downlod_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_downlod_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_downlod_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_downlod_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_final_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_final_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_final_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_final_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_opt_agr_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_opt_agr_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_opt_idx`
--

DROP TABLE IF EXISTS `catalog_product_index_price_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_price_opt_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_price_tmp`
--

DROP TABLE IF EXISTS `catalog_product_index_price_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_index_tier_price`
--

DROP TABLE IF EXISTS `catalog_product_index_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_index_website`
--

DROP TABLE IF EXISTS `catalog_product_index_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `FK_CAT_PRD_IDX_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_link`
--

DROP TABLE IF EXISTS `catalog_product_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_link_attribute`
--

DROP TABLE IF EXISTS `catalog_product_link_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_link_attribute_decimal`
--

DROP TABLE IF EXISTS `catalog_product_link_attribute_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_AB2EFA9A14F7BCF1D5400056203D14B6` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_link_attribute_int`
--

DROP TABLE IF EXISTS `catalog_product_link_attribute_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_PRODUCT_LINK_ATTRIBUTE_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_D6D878F8BA2A4282F8DDED7E6E3DE35C` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=933 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_link_attribute_varchar`
--

DROP TABLE IF EXISTS `catalog_product_link_attribute_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DEE9C4DA61CFCC01DFCF50F0D79CEA51` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_link_type`
--

DROP TABLE IF EXISTS `catalog_product_link_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_option`
--

DROP TABLE IF EXISTS `catalog_product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_option_price`
--

DROP TABLE IF EXISTS `catalog_product_option_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalog_product_option_title`
--

DROP TABLE IF EXISTS `catalog_product_option_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_option_type_price`
--

DROP TABLE IF EXISTS `catalog_product_option_type_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B523E3378E8602F376CC415825576B7F` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_option_type_title`
--

DROP TABLE IF EXISTS `catalog_product_option_type_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_C085B9CF2C2A302E8043FDEA1937D6A2` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_TTL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_option_type_value`
--

DROP TABLE IF EXISTS `catalog_product_option_type_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_relation`
--

DROP TABLE IF EXISTS `catalog_product_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `FK_CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_super_attribute`
--

DROP TABLE IF EXISTS `catalog_product_super_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_super_attribute_label`
--

DROP TABLE IF EXISTS `catalog_product_super_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_309442281DF7784210ED82B2CC51E5D5` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_LBL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_super_attribute_pricing`
--

DROP TABLE IF EXISTS `catalog_product_super_attribute_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRICING_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CDE8813117106CFAA3AD209358F66332` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_super_link`
--

DROP TABLE IF EXISTS `catalog_product_super_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=938 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalog_product_website`
--

DROP TABLE IF EXISTS `catalog_product_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_WS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cataloginventory_stock`
--

DROP TABLE IF EXISTS `cataloginventory_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cataloginventory_stock_item`
--

DROP TABLE IF EXISTS `cataloginventory_stock_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `FK_CATINV_STOCK_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1885 DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cataloginventory_stock_status`
--

DROP TABLE IF EXISTS `cataloginventory_stock_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATINV_STOCK_STS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cataloginventory_stock_status_idx`
--

DROP TABLE IF EXISTS `cataloginventory_stock_status_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cataloginventory_stock_status_tmp`
--

DROP TABLE IF EXISTS `cataloginventory_stock_status_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule`
--

DROP TABLE IF EXISTS `catalogrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From Date',
  `to_date` date DEFAULT NULL COMMENT 'To Date',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `sub_is_enable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Rule Enable For Subitems',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='CatalogRule';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule_affected_product`
--

DROP TABLE IF EXISTS `catalogrule_affected_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_affected_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Affected Product';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule_customer_group`
--

DROP TABLE IF EXISTS `catalogrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule_group_website`
--

DROP TABLE IF EXISTS `catalogrule_group_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_GROUP_WS_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule_product`
--

DROP TABLE IF EXISTS `catalogrule_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `EAA51B56FF092A0DCB795D1CEF812B7B` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `IDX_CATALOGRULE_PRODUCT_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogrule_product_price`
--

DROP TABLE IF EXISTS `catalogrule_product_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `UNQ_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1602 DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catalogrule_website`
--

DROP TABLE IF EXISTS `catalogrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogsearch_fulltext`
--

DROP TABLE IF EXISTS `catalogsearch_fulltext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM AUTO_INCREMENT=26240 DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogsearch_query`
--

DROP TABLE IF EXISTS `catalogsearch_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_NUM_RESULTS` (`num_results`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT` (`query_text`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_NUM_RESULTS` (`query_text`,`store_id`,`num_results`),
  KEY `IDX_CATALOGSEARCH_QUERY_SYNONYM_FOR` (`synonym_for`),
  CONSTRAINT `FK_CATALOGSEARCH_QUERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8 COMMENT='Catalog search query table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `catalogsearch_result`
--

DROP TABLE IF EXISTS `catalogsearch_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGSEARCH_RESULT_QUERY_ID_CATALOGSEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATSRCH_RESULT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `checkout_agreement`
--

DROP TABLE IF EXISTS `checkout_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `checkout_agreement_store`
--

DROP TABLE IF EXISTS `checkout_agreement_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chronopay_api_debug`
--

DROP TABLE IF EXISTS `chronopay_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chronopay_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cms_block`
--

DROP TABLE IF EXISTS `cms_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cms_block_store`
--

DROP TABLE IF EXISTS `cms_block_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_BLOCK_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cms_page`
--

DROP TABLE IF EXISTS `cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  `published_revision_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Published Revision Id',
  `website_root` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Website Root',
  `under_version_control` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Under Version Control Flag',
  PRIMARY KEY (`page_id`),
  KEY `IDX_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cms_page_store`
--

DROP TABLE IF EXISTS `cms_page_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_PAGE_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_cache`
--

DROP TABLE IF EXISTS `core_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_cache_option`
--

DROP TABLE IF EXISTS `core_cache_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_cache_option`
--

LOCK TABLES `core_cache_option` WRITE;
/*!40000 ALTER TABLE `core_cache_option` DISABLE KEYS */;
INSERT INTO `core_cache_option` VALUES ('block_html',0),('collections',1),('config',0),('config_api',1),('config_api2',1),('eav',0),('layout',0),('translate',1);
/*!40000 ALTER TABLE `core_cache_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_cache_tag`
--

DROP TABLE IF EXISTS `core_cache_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_cache_tag`
--

LOCK TABLES `core_cache_tag` WRITE;
/*!40000 ALTER TABLE `core_cache_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_cache_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_config_data`
--

DROP TABLE IF EXISTS `core_config_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB AUTO_INCREMENT=1518 DEFAULT CHARSET=utf8 COMMENT='Config Data';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_email_queue`
--

DROP TABLE IF EXISTS `core_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_email_queue` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Id',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity ID',
  `entity_type` varchar(128) DEFAULT NULL COMMENT 'Entity Type',
  `event_type` varchar(128) DEFAULT NULL COMMENT 'Event Type',
  `message_body_hash` varchar(64) NOT NULL COMMENT 'Message Body Hash',
  `message_body` mediumtext NOT NULL COMMENT 'Message Body',
  `message_parameters` text NOT NULL COMMENT 'Message Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT 'Finish Time',
  PRIMARY KEY (`message_id`),
  KEY `0ADECE62FD629241C147389ADF20706E` (`entity_id`,`entity_type`,`event_type`,`message_body_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_email_queue_recipients`
--

DROP TABLE IF EXISTS `core_email_queue_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_email_queue_recipients` (
  `recipient_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Recipient Id',
  `message_id` int(10) unsigned NOT NULL COMMENT 'Message ID',
  `recipient_email` varchar(128) NOT NULL COMMENT 'Recipient Email',
  `recipient_name` varchar(255) NOT NULL COMMENT 'Recipient Name',
  `email_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Email Type',
  PRIMARY KEY (`recipient_id`),
  UNIQUE KEY `19BDB9C5FE4BD685FCF992A71E976CD0` (`message_id`,`recipient_email`,`email_type`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_RECIPIENT_EMAIL` (`recipient_email`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_EMAIL_TYPE` (`email_type`),
  CONSTRAINT `FK_6F4948F3ABF97DE12127EF14B140802A` FOREIGN KEY (`message_id`) REFERENCES `core_email_queue` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_email_template`
--

DROP TABLE IF EXISTS `core_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_email_template`
--

LOCK TABLES `core_email_template` WRITE;
/*!40000 ALTER TABLE `core_email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_flag`
--

DROP TABLE IF EXISTS `core_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Flag';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_layout_link`
--

DROP TABLE IF EXISTS `core_layout_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_CORE_LAYOUT_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_LYT_LNK_LYT_UPDATE_ID_CORE_LYT_UPDATE_LYT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Layout Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `core_layout_update`
--

DROP TABLE IF EXISTS `core_layout_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='Layout Updates';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_resource`
--

DROP TABLE IF EXISTS `core_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_session`
--

DROP TABLE IF EXISTS `core_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_store`
--

DROP TABLE IF EXISTS `core_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_CORE_STORE_CODE` (`code`),
  KEY `IDX_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_CORE_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_ID_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_STORE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_store_group`
--

DROP TABLE IF EXISTS `core_store_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Store Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `core_translate`
--

DROP TABLE IF EXISTS `core_translate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_CORE_TRANSLATE_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  KEY `IDX_CORE_TRANSLATE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_TRANSLATE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_url_rewrite`
--

DROP TABLE IF EXISTS `core_url_rewrite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` (`product_id`),
  CONSTRAINT `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113482 DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `core_variable`
--

DROP TABLE IF EXISTS `core_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `core_variable_value`
--

DROP TABLE IF EXISTS `core_variable_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_VARIABLE_ID_CORE_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_variable_value`
--

LOCK TABLES `core_variable_value` WRITE;
/*!40000 ALTER TABLE `core_variable_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_variable_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_website`
--

DROP TABLE IF EXISTS `core_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  `is_staging` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is Staging Flag',
  `master_login` varchar(40) DEFAULT NULL COMMENT 'Master Login',
  `master_password` varchar(100) DEFAULT NULL COMMENT 'Master Password',
  `visibility` varchar(40) DEFAULT NULL COMMENT 'Visibility',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Websites';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `coupon_aggregated`
--

DROP TABLE IF EXISTS `coupon_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `coupon_aggregated_order`
--

DROP TABLE IF EXISTS `coupon_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `coupon_aggregated_updated`
--

DROP TABLE IF EXISTS `coupon_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cron_schedule`
--

DROP TABLE IF EXISTS `cron_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_address_entity`
--

DROP TABLE IF EXISTS `customer_address_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_address_entity_datetime`
--

DROP TABLE IF EXISTS `customer_address_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_address_entity_decimal`
--

DROP TABLE IF EXISTS `customer_address_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_address_entity_int`
--

DROP TABLE IF EXISTS `customer_address_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `customer_address_entity_text`
--

DROP TABLE IF EXISTS `customer_address_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_address_entity_varchar`
--

DROP TABLE IF EXISTS `customer_address_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1893 DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_eav_attribute`
--

DROP TABLE IF EXISTS `customer_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  `is_used_for_customer_segment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Segment',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_eav_attribute_website`
--

DROP TABLE IF EXISTS `customer_eav_attribute_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_entity`
--

DROP TABLE IF EXISTS `customer_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CUSTOMER_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COMMENT='Customer Entity';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_entity_datetime`
--

DROP TABLE IF EXISTS `customer_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_entity_decimal`
--

DROP TABLE IF EXISTS `customer_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_entity_int`
--

DROP TABLE IF EXISTS `customer_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1156 DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_entity_text`
--

DROP TABLE IF EXISTS `customer_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CSTR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_entity_varchar`
--

DROP TABLE IF EXISTS `customer_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2301 DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_form_attribute`
--

DROP TABLE IF EXISTS `customer_form_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CSTR_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer_group`
--

DROP TABLE IF EXISTS `customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Customer Group';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cybermut_api_debug`
--

DROP TABLE IF EXISTS `cybermut_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cybermut_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_batch`
--

DROP TABLE IF EXISTS `dataflow_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_DATAFLOW_BATCH_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_DATAFLOW_BATCH_PROFILE_ID_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DATAFLOW_BATCH_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_batch_export`
--

DROP TABLE IF EXISTS `dataflow_batch_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_EXPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_batch_import`
--

DROP TABLE IF EXISTS `dataflow_batch_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_IMPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_import_data`
--

DROP TABLE IF EXISTS `dataflow_import_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`),
  CONSTRAINT `FK_DATAFLOW_IMPORT_DATA_SESSION_ID_DATAFLOW_SESSION_SESSION_ID` FOREIGN KEY (`session_id`) REFERENCES `dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataflow_import_data`
--

LOCK TABLES `dataflow_import_data` WRITE;
/*!40000 ALTER TABLE `dataflow_import_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataflow_import_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataflow_profile`
--

DROP TABLE IF EXISTS `dataflow_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_profile_history`
--

DROP TABLE IF EXISTS `dataflow_profile_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`),
  CONSTRAINT `FK_AEA06B0C500063D3CE6EA671AE776645` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dataflow_session`
--

DROP TABLE IF EXISTS `dataflow_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `design_change`
--

DROP TABLE IF EXISTS `design_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DESIGN_CHANGE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `directory_country`
--

DROP TABLE IF EXISTS `directory_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `directory_country_format`
--

DROP TABLE IF EXISTS `directory_country_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `directory_country_region`
--

DROP TABLE IF EXISTS `directory_country_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `directory_country_region_name`
--

DROP TABLE IF EXISTS `directory_country_region_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_D7CFDEB379F775328EB6F62695E2B3E1` FOREIGN KEY (`region_id`) REFERENCES `directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `directory_currency_rate`
--

DROP TABLE IF EXISTS `directory_currency_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `downloadable_link`
--

DROP TABLE IF EXISTS `downloadable_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `downloadable_link_price`
--

DROP TABLE IF EXISTS `downloadable_link_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `downloadable_link_purchased`
--

DROP TABLE IF EXISTS `downloadable_link_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_DL_LNK_PURCHASED_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `downloadable_link_purchased_item`
--

DROP TABLE IF EXISTS `downloadable_link_purchased_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_46CC8E252307CE62F00A8F1887512A39` FOREIGN KEY (`purchased_id`) REFERENCES `downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B219BF25756700DEE44550B21220ECCE` FOREIGN KEY (`order_item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `downloadable_link_title`
--

DROP TABLE IF EXISTS `downloadable_link_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Link Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `downloadable_sample`
--

DROP TABLE IF EXISTS `downloadable_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_DL_SAMPLE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloadable_sample`
--

LOCK TABLES `downloadable_sample` WRITE;
/*!40000 ALTER TABLE `downloadable_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloadable_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloadable_sample_title`
--

DROP TABLE IF EXISTS `downloadable_sample_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloadable_sample_title`
--

LOCK TABLES `downloadable_sample_title` WRITE;
/*!40000 ALTER TABLE `downloadable_sample_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloadable_sample_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eav_attribute`
--

DROP TABLE IF EXISTS `eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_attribute_group`
--

DROP TABLE IF EXISTS `eav_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_attribute_label`
--

DROP TABLE IF EXISTS `eav_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_attribute_option`
--

DROP TABLE IF EXISTS `eav_attribute_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_attribute_option_value`
--

DROP TABLE IF EXISTS `eav_attribute_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2260 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eav_attribute_set`
--

DROP TABLE IF EXISTS `eav_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_SET_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eav_entity`
--

DROP TABLE IF EXISTS `eav_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_entity_attribute`
--

DROP TABLE IF EXISTS `eav_entity_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4505 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_entity_datetime`
--

DROP TABLE IF EXISTS `eav_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eav_entity_datetime`
--

LOCK TABLES `eav_entity_datetime` WRITE;
/*!40000 ALTER TABLE `eav_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `eav_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eav_entity_decimal`
--

DROP TABLE IF EXISTS `eav_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eav_entity_int`
--

DROP TABLE IF EXISTS `eav_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eav_entity_int`
--

LOCK TABLES `eav_entity_int` WRITE;
/*!40000 ALTER TABLE `eav_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `eav_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eav_entity_store`
--

DROP TABLE IF EXISTS `eav_entity_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTITY_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_entity_text`
--

DROP TABLE IF EXISTS `eav_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eav_entity_text`
--

LOCK TABLES `eav_entity_text` WRITE;
/*!40000 ALTER TABLE `eav_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `eav_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eav_entity_type`
--

DROP TABLE IF EXISTS `eav_entity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eav_entity_varchar`
--

DROP TABLE IF EXISTS `eav_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eav_entity_varchar`
--

LOCK TABLES `eav_entity_varchar` WRITE;
/*!40000 ALTER TABLE `eav_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `eav_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eav_form_element`
--

DROP TABLE IF EXISTS `eav_form_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_form_fieldset`
--

DROP TABLE IF EXISTS `eav_form_fieldset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eav_form_fieldset_label`
--

DROP TABLE IF EXISTS `eav_form_fieldset_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_FIELDSET_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `eav_form_type`
--

DROP TABLE IF EXISTS `eav_form_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eav_form_type_entity`
--

DROP TABLE IF EXISTS `eav_form_type_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `eway_api_debug`
--

DROP TABLE IF EXISTS `eway_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eway_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eway_api_debug`
--

LOCK TABLES `eway_api_debug` WRITE;
/*!40000 ALTER TABLE `eway_api_debug` DISABLE KEYS */;
/*!40000 ALTER TABLE `eway_api_debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flo2cash_api_debug`
--

DROP TABLE IF EXISTS `flo2cash_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flo2cash_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  `exception` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flo2cash_api_debug`
--

LOCK TABLES `flo2cash_api_debug` WRITE;
/*!40000 ALTER TABLE `flo2cash_api_debug` DISABLE KEYS */;
/*!40000 ALTER TABLE `flo2cash_api_debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_message`
--

DROP TABLE IF EXISTS `gift_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Gift Message';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `googlecheckout_notification`
--

DROP TABLE IF EXISTS `googlecheckout_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googlecheckout_notification` (
  `serial_number` varchar(64) NOT NULL COMMENT 'Serial Number',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Checkout Notification Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googlecheckout_notification`
--

LOCK TABLES `googlecheckout_notification` WRITE;
/*!40000 ALTER TABLE `googlecheckout_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `googlecheckout_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `googleoptimizer_code`
--

DROP TABLE IF EXISTS `googleoptimizer_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googleoptimizer_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Google optimizer code id',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Optimized entity id product id or catalog id',
  `entity_type` varchar(50) DEFAULT NULL COMMENT 'Optimized entity type',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store id',
  `control_script` text COMMENT 'Google optimizer control script',
  `tracking_script` text COMMENT 'Google optimizer tracking script',
  `conversion_script` text COMMENT 'Google optimizer conversion script',
  `conversion_page` varchar(255) DEFAULT NULL COMMENT 'Google optimizer conversion page',
  `additional_data` text COMMENT 'Google optimizer additional data',
  PRIMARY KEY (`code_id`),
  KEY `IDX_GOOGLEOPTIMIZER_CODE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_GOOGLEOPTIMIZER_CODE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Googleoptimizer code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googleoptimizer_code`
--

LOCK TABLES `googleoptimizer_code` WRITE;
/*!40000 ALTER TABLE `googleoptimizer_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `googleoptimizer_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `googleshopping_attributes`
--

DROP TABLE IF EXISTS `googleshopping_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googleshopping_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `gcontent_attribute` varchar(255) NOT NULL COMMENT 'Google Content Attribute',
  `type_id` int(10) unsigned NOT NULL COMMENT 'Type Id',
  PRIMARY KEY (`id`),
  KEY `FK_GOOGLESHOPPING_ATTRS_ATTR_ID_EAV_ATTR_ATTR_ID` (`attribute_id`),
  KEY `FK_GOOGLESHOPPING_ATTRS_TYPE_ID_GOOGLESHOPPING_TYPES_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_GOOGLESHOPPING_ATTRS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_GOOGLESHOPPING_ATTRS_TYPE_ID_GOOGLESHOPPING_TYPES_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `googleshopping_types` (`type_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Content Attributes link Product Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googleshopping_attributes`
--

LOCK TABLES `googleshopping_attributes` WRITE;
/*!40000 ALTER TABLE `googleshopping_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `googleshopping_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `googleshopping_items`
--

DROP TABLE IF EXISTS `googleshopping_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googleshopping_items` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `gcontent_item_id` varchar(255) NOT NULL COMMENT 'Google Content Item Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `published` datetime DEFAULT NULL COMMENT 'Published date',
  `expires` datetime DEFAULT NULL COMMENT 'Expires date',
  PRIMARY KEY (`item_id`),
  KEY `IDX_GOOGLESHOPPING_ITEMS_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  KEY `FK_GOOGLESHOPPING_ITEMS_STORE_ID_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_GOOGLESHOPPING_ITEMS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_GOOGLESHOPPING_ITEMS_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Content Items Products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googleshopping_items`
--

LOCK TABLES `googleshopping_items` WRITE;
/*!40000 ALTER TABLE `googleshopping_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `googleshopping_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `googleshopping_types`
--

DROP TABLE IF EXISTS `googleshopping_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googleshopping_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Set Id',
  `target_country` varchar(2) NOT NULL DEFAULT 'US' COMMENT 'Target country',
  `category` varchar(40) DEFAULT NULL COMMENT 'Google product category',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_GOOGLESHOPPING_TYPES_ATTRIBUTE_SET_ID_TARGET_COUNTRY` (`attribute_set_id`,`target_country`),
  CONSTRAINT `FK_GOOGLESHOPPING_TYPES_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Content Item Types link Attribute Sets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googleshopping_types`
--

LOCK TABLES `googleshopping_types` WRITE;
/*!40000 ALTER TABLE `googleshopping_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `googleshopping_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideal_api_debug`
--

DROP TABLE IF EXISTS `ideal_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ideal_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideal_api_debug`
--

LOCK TABLES `ideal_api_debug` WRITE;
/*!40000 ALTER TABLE `ideal_api_debug` DISABLE KEYS */;
/*!40000 ALTER TABLE `ideal_api_debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `importexport_importdata`
--

DROP TABLE IF EXISTS `importexport_importdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8 COMMENT='Import Data Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `index_event`
--

DROP TABLE IF EXISTS `index_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=2407 DEFAULT CHARSET=utf8 COMMENT='Index Event';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `index_process`
--

DROP TABLE IF EXISTS `index_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Index Process';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `index_process_event`
--

DROP TABLE IF EXISTS `index_process_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_EVENT_ID_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_PROCESS_ID_INDEX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_customer`
--

DROP TABLE IF EXISTS `log_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Customers Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_quote`
--

DROP TABLE IF EXISTS `log_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `log_summary`
--

DROP TABLE IF EXISTS `log_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_summary_type`
--

DROP TABLE IF EXISTS `log_summary_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_url`
--

DROP TABLE IF EXISTS `log_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Visit Time',
  KEY `IDX_LOG_URL_VISITOR_ID` (`visitor_id`),
  KEY `url_id` (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_url_info`
--

DROP TABLE IF EXISTS `log_url_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_visitor`
--

DROP TABLE IF EXISTS `log_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_visitor_info`
--

DROP TABLE IF EXISTS `log_visitor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` bigint(20) DEFAULT NULL COMMENT 'Server Address',
  `remote_addr` bigint(20) DEFAULT NULL COMMENT 'Remote Address',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_visitor_online`
--

DROP TABLE IF EXISTS `log_visitor_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` bigint(20) NOT NULL COMMENT 'Remote Address',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletter_problem`
--

DROP TABLE IF EXISTS `newsletter_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `FK_NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletter_queue`
--

DROP TABLE IF EXISTS `newsletter_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `newsletter_queue_link`
--

DROP TABLE IF EXISTS `newsletter_queue_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `newsletter_queue_store_link`
--

DROP TABLE IF EXISTS `newsletter_queue_store_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `newsletter_subscriber`
--

DROP TABLE IF EXISTS `newsletter_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NEWSLETTER_SUBSCRIBER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletter_template`
--

DROP TABLE IF EXISTS `newsletter_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_consumer`
--

DROP TABLE IF EXISTS `oauth_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_nonce`
--

DROP TABLE IF EXISTS `oauth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='oauth_nonce';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_token`
--

DROP TABLE IF EXISTS `oauth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paybox_api_debug`
--

DROP TABLE IF EXISTS `paybox_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paybox_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `real_order_id` varchar(50) NOT NULL DEFAULT '',
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paybox_question_number`
--

DROP TABLE IF EXISTS `paybox_question_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paybox_question_number` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_hash` varchar(50) NOT NULL DEFAULT '',
  `increment_value` int(10) unsigned NOT NULL DEFAULT '1',
  `reset_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_cert`
--

DROP TABLE IF EXISTS `paypal_cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PAYPAL_CERT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_payment_transaction`
--

DROP TABLE IF EXISTS `paypal_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_settlement_report`
--

DROP TABLE IF EXISTS `paypal_settlement_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_settlement_report_row`
--

DROP TABLE IF EXISTS `paypal_settlement_report_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_E183E488F593E0DE10C6EBFFEBAC9B55` FOREIGN KEY (`report_id`) REFERENCES `paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persistent_session`
--

DROP TABLE IF EXISTS `persistent_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_POLL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Poll';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_answer`
--

DROP TABLE IF EXISTS `poll_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_POLL_ANSWER_POLL_ID` (`poll_id`),
  CONSTRAINT `FK_POLL_ANSWER_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Poll Answers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_store`
--

DROP TABLE IF EXISTS `poll_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_POLL_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_POLL_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `poll_vote`
--

DROP TABLE IF EXISTS `poll_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` bigint(20) DEFAULT NULL COMMENT 'Poll answer id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`),
  CONSTRAINT `FK_POLL_VOTE_POLL_ANSWER_ID_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Poll Vote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_alert_price`
--

DROP TABLE IF EXISTS `product_alert_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRD_ALERT_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_alert_stock`
--

DROP TABLE IF EXISTS `product_alert_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRD_ALERT_STOCK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protx_api_debug`
--

DROP TABLE IF EXISTS `protx_api_debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protx_api_debug` (
  `debug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(255) NOT NULL DEFAULT '',
  `debug_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_body` text,
  `response_body` text,
  PRIMARY KEY (`debug_id`),
  KEY `debug_at` (`debug_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Ratings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_entity`
--

DROP TABLE IF EXISTS `rating_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Rating entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_option`
--

DROP TABLE IF EXISTS `rating_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `FK_RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Rating options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_option_vote`
--

DROP TABLE IF EXISTS `rating_option_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 COMMENT='Rating option values';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_option_vote_aggregated`
--

DROP TABLE IF EXISTS `rating_option_vote_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_store`
--

DROP TABLE IF EXISTS `rating_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_RATING_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_title`
--

DROP TABLE IF EXISTS `rating_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_compared_product_index`
--

DROP TABLE IF EXISTS `report_compared_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_event`
--

DROP TABLE IF EXISTS `report_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_EVENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7432 DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_event_types`
--

DROP TABLE IF EXISTS `report_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_viewed_product_aggregated_daily`
--

DROP TABLE IF EXISTS `report_viewed_product_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_viewed_product_aggregated_monthly`
--

DROP TABLE IF EXISTS `report_viewed_product_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_viewed_product_aggregated_yearly`
--

DROP TABLE IF EXISTS `report_viewed_product_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_viewed_product_index`
--

DROP TABLE IF EXISTS `report_viewed_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5686 DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `FK_REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='Review base information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_detail`
--

DROP TABLE IF EXISTS `review_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='Review detail information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_entity`
--

DROP TABLE IF EXISTS `review_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_entity_summary`
--

DROP TABLE IF EXISTS `review_entity_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_ENTITY_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 COMMENT='Review aggregates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_status`
--

DROP TABLE IF EXISTS `review_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_store`
--

DROP TABLE IF EXISTS `review_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_bestsellers_aggregated_daily`
--

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_bestsellers_aggregated_monthly`
--

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_bestsellers_aggregated_yearly`
--

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_billing_agreement`
--

DROP TABLE IF EXISTS `sales_billing_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_billing_agreement`
--

LOCK TABLES `sales_billing_agreement` WRITE;
/*!40000 ALTER TABLE `sales_billing_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_billing_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_billing_agreement_order`
--

DROP TABLE IF EXISTS `sales_billing_agreement_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_AGRT_ID_SALES_BILLING_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_billing_agreement_order`
--

LOCK TABLES `sales_billing_agreement_order` WRITE;
/*!40000 ALTER TABLE `sales_billing_agreement_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_billing_agreement_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_flat_creditmemo`
--

DROP TABLE IF EXISTS `sales_flat_creditmemo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `bs_customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Bs Customer Bal Total Refunded',
  `customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Bal Total Refunded',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `reward_points_balance_refund` int(11) DEFAULT NULL COMMENT 'Reward Points Balance Refund',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `cybersource_token` varchar(255) DEFAULT NULL COMMENT 'Cybersource Token',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_creditmemo_comment`
--

DROP TABLE IF EXISTS `sales_flat_creditmemo_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_B0FCB0B5467075BE63D474F2CD5F7804` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_flat_creditmemo_comment`
--

LOCK TABLES `sales_flat_creditmemo_comment` WRITE;
/*!40000 ALTER TABLE `sales_flat_creditmemo_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_flat_creditmemo_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_flat_creditmemo_grid`
--

DROP TABLE IF EXISTS `sales_flat_creditmemo_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_78C711B225167A11CC077B03D1C8E1CC` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_creditmemo_item`
--

DROP TABLE IF EXISTS `sales_flat_creditmemo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_306DAC836C699F0B5E13BE486557AC8A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_invoice`
--

DROP TABLE IF EXISTS `sales_flat_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `cybersource_token` varchar(255) DEFAULT NULL COMMENT 'Cybersource Token',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_invoice_comment`
--

DROP TABLE IF EXISTS `sales_flat_invoice_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_5C4B36BBE5231A76AB8018B281ED50BC` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_flat_invoice_comment`
--

LOCK TABLES `sales_flat_invoice_comment` WRITE;
/*!40000 ALTER TABLE `sales_flat_invoice_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_flat_invoice_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_flat_invoice_grid`
--

DROP TABLE IF EXISTS `sales_flat_invoice_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_ENTT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_invoice_item`
--

DROP TABLE IF EXISTS `sales_flat_invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ITEM_PARENT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order`
--

DROP TABLE IF EXISTS `sales_flat_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `base_customer_balance_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Invoiced',
  `customer_balance_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Invoiced',
  `base_customer_balance_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Refunded',
  `customer_balance_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Refunded',
  `bs_customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Bs Customer Bal Total Refunded',
  `customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Bal Total Refunded',
  `gift_cards` text COMMENT 'Gift Cards',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Invoiced',
  `gift_cards_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Invoiced',
  `base_gift_cards_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Refunded',
  `gift_cards_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Refunded',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `gw_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Invoiced',
  `gw_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Invoiced',
  `gw_items_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Invoiced',
  `gw_items_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Invoiced',
  `gw_card_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Invoiced',
  `gw_card_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Invoiced',
  `gw_base_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Invoiced',
  `gw_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Invoiced',
  `gw_items_base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Invoiced',
  `gw_items_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Invoiced',
  `gw_card_base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Invoiced',
  `gw_card_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Invoiced',
  `gw_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Refunded',
  `gw_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Refunded',
  `gw_items_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Refunded',
  `gw_items_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Refunded',
  `gw_card_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Refunded',
  `gw_card_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Refunded',
  `gw_base_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Refunded',
  `gw_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Refunded',
  `gw_items_base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Refunded',
  `gw_items_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Refunded',
  `gw_card_base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Refunded',
  `gw_card_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Refunded',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `base_rwrd_crrncy_amt_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Rwrd Crrncy Amt Invoiced',
  `rwrd_currency_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Rwrd Currency Amount Invoiced',
  `base_rwrd_crrncy_amnt_refnded` decimal(12,4) DEFAULT NULL COMMENT 'Base Rwrd Crrncy Amnt Refnded',
  `rwrd_crrncy_amnt_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Rwrd Crrncy Amnt Refunded',
  `reward_points_balance_refund` int(11) DEFAULT NULL COMMENT 'Reward Points Balance Refund',
  `reward_points_balance_refunded` int(11) DEFAULT NULL COMMENT 'Reward Points Balance Refunded',
  `reward_salesrule_points` int(11) DEFAULT NULL COMMENT 'Reward Salesrule Points',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order_address`
--

DROP TABLE IF EXISTS `sales_flat_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ADDRESS_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order_grid`
--

DROP TABLE IF EXISTS `sales_flat_order_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_ENTITY_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order_item`
--

DROP TABLE IF EXISTS `sales_flat_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `event_id` int(11) DEFAULT NULL COMMENT 'Event Id',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Invoiced',
  `gw_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Invoiced',
  `gw_base_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Invoiced',
  `gw_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Invoiced',
  `gw_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Refunded',
  `gw_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Refunded',
  `gw_base_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Refunded',
  `gw_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Refunded',
  `qty_returned` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty of returned items',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=596 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order_payment`
--

DROP TABLE IF EXISTS `sales_flat_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  `cybersource_token` varchar(255) DEFAULT NULL COMMENT 'Cybersource Token',
  `flo2cash_account_id` varchar(255) DEFAULT NULL COMMENT 'Flo2cash Account Id',
  `ideal_issuer_id` varchar(255) DEFAULT NULL COMMENT 'Ideal Issuer Id',
  `ideal_issuer_title` varchar(255) DEFAULT NULL COMMENT 'Ideal Issuer Title',
  `ideal_transaction_checked` int(11) DEFAULT NULL COMMENT 'Ideal Transaction Checked',
  `paybox_question_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Question Number',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_PAYMENT_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_order_status_history`
--

DROP TABLE IF EXISTS `sales_flat_order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_CE7C71E74CB74DDACED337CEE6753D5E` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote`
--

DROP TABLE IF EXISTS `sales_flat_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  `customer_balance_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount Used',
  `base_customer_bal_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Bal Amount Used',
  `use_customer_balance` int(11) DEFAULT NULL COMMENT 'Use Customer Balance',
  `gift_cards` text COMMENT 'Gift Cards',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount Used',
  `base_gift_cards_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount Used',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `use_reward_points` int(11) DEFAULT NULL COMMENT 'Use Reward Points',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_SALES_FLAT_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_address`
--

DROP TABLE IF EXISTS `sales_flat_quote_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards` text COMMENT 'Gift Cards',
  `used_gift_cards` text COMMENT 'Used Gift Cards',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  PRIMARY KEY (`address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2584 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_address_item`
--

DROP TABLE IF EXISTS `sales_flat_quote_address_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `FK_2EF8E28181D666D94D4E30DC2B0F80BF` FOREIGN KEY (`quote_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A345FC758F20C314169CE27DCE53477F` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B521389746C00700D1B2B76EBBE53854` FOREIGN KEY (`quote_address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_item`
--

DROP TABLE IF EXISTS `sales_flat_quote_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `event_id` int(11) DEFAULT NULL COMMENT 'Event Id',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B201DEB5DE51B791AF5C5BF87053C5A7` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2473 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_item_option`
--

DROP TABLE IF EXISTS `sales_flat_quote_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_5F20E478CA64B6891EA8A9D6C2735739` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7304 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_payment`
--

DROP TABLE IF EXISTS `sales_flat_quote_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  `cybersource_token` varchar(255) DEFAULT NULL COMMENT 'Cybersource Token',
  `ideal_issuer_id` varchar(255) DEFAULT NULL COMMENT 'Ideal Issuer Id',
  `ideal_issuer_list` text COMMENT 'Ideal Issuer List',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=822 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_quote_shipping_rate`
--

DROP TABLE IF EXISTS `sales_flat_quote_shipping_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `FK_B1F177EFB73D3EDF5322BA64AC48D150` FOREIGN KEY (`address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16364 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_shipment`
--

DROP TABLE IF EXISTS `sales_flat_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_shipment_comment`
--

DROP TABLE IF EXISTS `sales_flat_shipment_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_C2D69CC1FB03D2B2B794B0439F6650CF` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_shipment_grid`
--

DROP TABLE IF EXISTS `sales_flat_shipment_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_ENTT_ID_SALES_FLAT_SHIPMENT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_shipment_item`
--

DROP TABLE IF EXISTS `sales_flat_shipment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_3AECE5007D18F159231B87E8306FC02A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_flat_shipment_track`
--

DROP TABLE IF EXISTS `sales_flat_shipment_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_BCD2FA28717D29F37E10A153E6F2F841` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_flat_shipment_track`
--

LOCK TABLES `sales_flat_shipment_track` WRITE;
/*!40000 ALTER TABLE `sales_flat_shipment_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_flat_shipment_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoiced_aggregated`
--

DROP TABLE IF EXISTS `sales_invoiced_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_invoiced_aggregated_order`
--

DROP TABLE IF EXISTS `sales_invoiced_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_aggregated_created`
--

DROP TABLE IF EXISTS `sales_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_aggregated_updated`
--

DROP TABLE IF EXISTS `sales_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_status`
--

DROP TABLE IF EXISTS `sales_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_status_label`
--

DROP TABLE IF EXISTS `sales_order_status_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_status_label`
--

LOCK TABLES `sales_order_status_label` WRITE;
/*!40000 ALTER TABLE `sales_order_status_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_status_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_status_state`
--

DROP TABLE IF EXISTS `sales_order_status_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_tax`
--

DROP TABLE IF EXISTS `sales_order_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_tax_item`
--

DROP TABLE IF EXISTS `sales_order_tax_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_FLAT_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_payment_transaction`
--

DROP TABLE IF EXISTS `sales_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_B99FF1A06402D725EBDB0F3A7ECD47A2` FOREIGN KEY (`parent_id`) REFERENCES `sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DA51A10B2405B64A4DAEF77A64F0DAAD` FOREIGN KEY (`payment_id`) REFERENCES `sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_payment_transaction`
--

LOCK TABLES `sales_payment_transaction` WRITE;
/*!40000 ALTER TABLE `sales_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_recurring_profile`
--

DROP TABLE IF EXISTS `sales_recurring_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_recurring_profile_order`
--

DROP TABLE IF EXISTS `sales_recurring_profile_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_7FF85741C66DCD37A4FBE3E3255A5A01` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B8A7A5397B67455786E55461748C59F4` FOREIGN KEY (`profile_id`) REFERENCES `sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_recurring_profile_order`
--

LOCK TABLES `sales_recurring_profile_order` WRITE;
/*!40000 ALTER TABLE `sales_recurring_profile_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_recurring_profile_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_refunded_aggregated`
--

DROP TABLE IF EXISTS `sales_refunded_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_refunded_aggregated_order`
--

DROP TABLE IF EXISTS `sales_refunded_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_shipping_aggregated`
--

DROP TABLE IF EXISTS `sales_shipping_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_shipping_aggregated_order`
--

DROP TABLE IF EXISTS `sales_shipping_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `C05FAE47282EEA68654D0924E946761F` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule`
--

DROP TABLE IF EXISTS `salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='Salesrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_coupon`
--

DROP TABLE IF EXISTS `salesrule_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_coupon_usage`
--

DROP TABLE IF EXISTS `salesrule_coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_customer`
--

DROP TABLE IF EXISTS `salesrule_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `FK_SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_customer_group`
--

DROP TABLE IF EXISTS `salesrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_label`
--

DROP TABLE IF EXISTS `salesrule_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_SALESRULE_LABEL_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesrule_label`
--

LOCK TABLES `salesrule_label` WRITE;
/*!40000 ALTER TABLE `salesrule_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesrule_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesrule_product_attribute`
--

DROP TABLE IF EXISTS `salesrule_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesrule_website`
--

DROP TABLE IF EXISTS `salesrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sendfriend_log`
--

DROP TABLE IF EXISTS `sendfriend_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sendfriend_log`
--

LOCK TABLES `sendfriend_log` WRITE;
/*!40000 ALTER TABLE `sendfriend_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sendfriend_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_tablerate`
--

DROP TABLE IF EXISTS `shipping_tablerate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `D60821CDB2AFACEE1566CFC02D0D4CAA` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_tablerate`
--

LOCK TABLES `shipping_tablerate` WRITE;
/*!40000 ALTER TABLE `shipping_tablerate` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_tablerate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitemap`
--

DROP TABLE IF EXISTS `sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SITEMAP_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitemap`
--

LOCK TABLES `sitemap` WRITE;
/*!40000 ALTER TABLE `sitemap` DISABLE KEYS */;
/*!40000 ALTER TABLE `sitemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_facebook_actions`
--

DROP TABLE IF EXISTS `social_facebook_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_facebook_actions` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `facebook_id` varchar(100) NOT NULL COMMENT 'Facebook User Id',
  `facebook_name` varchar(100) NOT NULL COMMENT 'Facebook User Name',
  `facebook_action` varchar(100) NOT NULL COMMENT 'User Action',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Social Facebook Actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_facebook_actions`
--

LOCK TABLES `social_facebook_actions` WRITE;
/*!40000 ALTER TABLE `social_facebook_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_facebook_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strikeiron_tax_rate`
--

DROP TABLE IF EXISTS `strikeiron_tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strikeiron_tax_rate` (
  `tax_rate_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tax_country_id` varchar(6) DEFAULT NULL,
  `tax_region_id` mediumint(9) unsigned DEFAULT NULL,
  `tax_postcode` varchar(12) DEFAULT NULL,
  `rate_value` decimal(12,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`tax_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Strikeiron tax rates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strikeiron_tax_rate`
--

LOCK TABLES `strikeiron_tax_rate` WRITE;
/*!40000 ALTER TABLE `strikeiron_tax_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `strikeiron_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` (`first_store_id`),
  CONSTRAINT `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_properties`
--

DROP TABLE IF EXISTS `tag_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_PROPERTIES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_PROPERTIES_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_PROPERTIES_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_properties`
--

LOCK TABLES `tag_properties` WRITE;
/*!40000 ALTER TABLE `tag_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_relation`
--

DROP TABLE IF EXISTS `tag_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_TAG_RELATION_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_RELATION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='Tag Relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_summary`
--

DROP TABLE IF EXISTS `tag_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_TAG_SUMMARY_TAG_ID` (`tag_id`),
  CONSTRAINT `FK_TAG_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_SUMMARY_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_calculation`
--

DROP TABLE IF EXISTS `tax_calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `IDX_TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `FK_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_calculation_rate`
--

DROP TABLE IF EXISTS `tax_calculation_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `CA799F1E2CB843495F601E56C84A626D` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_calculation_rate_title`
--

DROP TABLE IF EXISTS `tax_calculation_rate_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_37FB965F786AD5897BB3AE90470C42AB` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALCULATION_RATE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_calculation_rate_title`
--

LOCK TABLES `tax_calculation_rate_title` WRITE;
/*!40000 ALTER TABLE `tax_calculation_rate_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_calculation_rate_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_calculation_rule`
--

DROP TABLE IF EXISTS `tax_calculation_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_class`
--

DROP TABLE IF EXISTS `tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Tax Class';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_order_aggregated_created`
--

DROP TABLE IF EXISTS `tax_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `FCA5E2C02689EB2641B30580D7AACF12` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_order_aggregated_updated`
--

DROP TABLE IF EXISTS `tax_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `DB0AF14011199AA6CD31D5078B90AA8D` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weee_discount`
--

DROP TABLE IF EXISTS `weee_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_WEEE_DISCOUNT_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weee_discount`
--

LOCK TABLES `weee_discount` WRITE;
/*!40000 ALTER TABLE `weee_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `weee_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weee_tax`
--

DROP TABLE IF EXISTS `weee_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weee_tax`
--

LOCK TABLES `weee_tax` WRITE;
/*!40000 ALTER TABLE `weee_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `weee_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget_instance`
--

DROP TABLE IF EXISTS `widget_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widget_instance_page`
--

DROP TABLE IF EXISTS `widget_instance_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widget_instance_page_layout`
--

DROP TABLE IF EXISTS `widget_instance_page_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_0A5D06DCEC6A6845F50E5FAAC5A1C96D` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_LYT_PAGE_ID_WIDGET_INSTANCE_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget_instance_page_layout`
--

LOCK TABLES `widget_instance_page_layout` WRITE;
/*!40000 ALTER TABLE `widget_instance_page_layout` DISABLE KEYS */;
INSERT INTO `widget_instance_page_layout` VALUES (3,63);
/*!40000 ALTER TABLE `widget_instance_page_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  `name` varchar(255) DEFAULT NULL COMMENT 'Wishlist name',
  `visibility` smallint(6) DEFAULT '0' COMMENT 'Wish list visibility type',
  PRIMARY KEY (`wishlist_id`),
  KEY `IDX_WISHLIST_SHARED` (`shared`),
  KEY `IDX_WISHLIST_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wishlist_item`
--

DROP TABLE IF EXISTS `wishlist_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_WISHLIST_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COMMENT='Wishlist items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wishlist_item_option`
--

DROP TABLE IF EXISTS `wishlist_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_A014B30B04B72DD0EAB3EECD779728D6` (`wishlist_item_id`),
  CONSTRAINT `FK_A014B30B04B72DD0EAB3EECD779728D6` FOREIGN KEY (`wishlist_item_id`) REFERENCES `wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xmlconnect_application`
--

DROP TABLE IF EXISTS `xmlconnect_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_application` (
  `application_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Application Id',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  `type` varchar(32) NOT NULL COMMENT 'Device Type',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `active_from` date DEFAULT NULL COMMENT 'Active From',
  `active_to` date DEFAULT NULL COMMENT 'Active To',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `browsing_mode` smallint(5) unsigned DEFAULT '0' COMMENT 'Browsing Mode',
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `UNQ_XMLCONNECT_APPLICATION_CODE` (`code`),
  KEY `FK_XMLCONNECT_APPLICATION_STORE_ID_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_XMLCONNECT_APPLICATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Application';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_application`
--

LOCK TABLES `xmlconnect_application` WRITE;
/*!40000 ALTER TABLE `xmlconnect_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xmlconnect_config_data`
--

DROP TABLE IF EXISTS `xmlconnect_config_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_config_data` (
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `category` varchar(60) NOT NULL DEFAULT 'default' COMMENT 'Category',
  `path` varchar(250) NOT NULL COMMENT 'Path',
  `value` text NOT NULL COMMENT 'Value',
  UNIQUE KEY `UNQ_XMLCONNECT_CONFIG_DATA_APPLICATION_ID_CATEGORY_PATH` (`application_id`,`category`,`path`),
  CONSTRAINT `FK_31EE36D814216200D7C0723145AC510E` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Configuration Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_config_data`
--

LOCK TABLES `xmlconnect_config_data` WRITE;
/*!40000 ALTER TABLE `xmlconnect_config_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_config_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xmlconnect_history`
--

DROP TABLE IF EXISTS `xmlconnect_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `params` blob COMMENT 'Params',
  `title` varchar(200) NOT NULL COMMENT 'Title',
  `activation_key` varchar(255) NOT NULL COMMENT 'Activation Key',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  PRIMARY KEY (`history_id`),
  KEY `FK_8F08B9513373BC19F49EE3EF8340E270` (`application_id`),
  CONSTRAINT `FK_8F08B9513373BC19F49EE3EF8340E270` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_history`
--

LOCK TABLES `xmlconnect_history` WRITE;
/*!40000 ALTER TABLE `xmlconnect_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xmlconnect_images`
--

DROP TABLE IF EXISTS `xmlconnect_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_images` (
  `image_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Image Id',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `image_file` varchar(255) NOT NULL COMMENT 'Image File',
  `image_type` varchar(255) NOT NULL COMMENT 'Image Type',
  `order` int(10) unsigned NOT NULL COMMENT 'Order',
  PRIMARY KEY (`image_id`),
  KEY `FK_6C55A623A089E4FEA9201FFE01693167` (`application_id`),
  CONSTRAINT `FK_6C55A623A089E4FEA9201FFE01693167` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Images';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_images`
--

LOCK TABLES `xmlconnect_images` WRITE;
/*!40000 ALTER TABLE `xmlconnect_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xmlconnect_notification_template`
--

DROP TABLE IF EXISTS `xmlconnect_notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_notification_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `name` varchar(255) NOT NULL COMMENT 'Template Name',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) NOT NULL COMMENT 'Message Title',
  `content` text NOT NULL COMMENT 'Message Content',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  PRIMARY KEY (`template_id`),
  KEY `FK_F9927C7518A907CF5C350942FD296DC3` (`application_id`),
  CONSTRAINT `FK_F9927C7518A907CF5C350942FD296DC3` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_notification_template`
--

LOCK TABLES `xmlconnect_notification_template` WRITE;
/*!40000 ALTER TABLE `xmlconnect_notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xmlconnect_queue`
--

DROP TABLE IF EXISTS `xmlconnect_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlconnect_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `exec_time` timestamp NULL DEFAULT NULL COMMENT 'Scheduled Execution Time',
  `template_id` int(10) unsigned NOT NULL COMMENT 'Template Id',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) DEFAULT '' COMMENT 'Message Title',
  `content` text COMMENT 'Message Content',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `type` varchar(12) NOT NULL COMMENT 'Type of Notification',
  PRIMARY KEY (`queue_id`),
  KEY `FK_2019AEC5FC55A516965583447CA26B14` (`template_id`),
  CONSTRAINT `FK_2019AEC5FC55A516965583447CA26B14` FOREIGN KEY (`template_id`) REFERENCES `xmlconnect_notification_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xmlconnect_queue`
--

LOCK TABLES `xmlconnect_queue` WRITE;
/*!40000 ALTER TABLE `xmlconnect_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `xmlconnect_queue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-24 13:47:09
