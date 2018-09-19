/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.21-log : Database - bookmanage
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bookmanage` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bookmanage`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add user',2,'add_user'),(5,'Can change user',2,'change_user'),(6,'Can delete user',2,'delete_user'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add user',7,'add_user'),(20,'Can change user',7,'change_user'),(21,'Can delete user',7,'delete_user'),(22,'Can add book',8,'add_book'),(23,'Can change book',8,'change_book'),(24,'Can delete book',8,'delete_book'),(25,'Can add book type',9,'add_booktype'),(26,'Can change book type',9,'change_booktype'),(27,'Can delete book type',9,'delete_booktype'),(28,'Can add userborrow',10,'add_userborrow'),(29,'Can change userborrow',10,'change_userborrow'),(30,'Can delete userborrow',10,'delete_userborrow');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$36000$NflVWxrQkFPq$qQJk82hcOsIl5pmPVXAobHhYKdirK8ukqUzEXmO2DuQ=','2018-09-18 06:09:37.372000',1,'admin','','','',1,1,'2018-09-18 06:09:20.763000');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (1,'2018-09-18 06:09:48.784000','1','数学',1,'[{\"added\": {}}]',9,1),(2,'2018-09-18 06:09:50.239000','2','语文',1,'[{\"added\": {}}]',9,1),(3,'2018-09-18 06:09:51.704000','3','外遇',1,'[{\"added\": {}}]',9,1),(4,'2018-09-18 06:09:59.415000','3','外语',2,'[{\"changed\": {\"fields\": [\"tname\"]}}]',9,1),(5,'2018-09-18 06:10:02.143000','4','历史',1,'[{\"added\": {}}]',9,1),(6,'2018-09-18 06:10:04.309000','5','地理',1,'[{\"added\": {}}]',9,1),(7,'2018-09-18 06:10:08.086000','6','生物',1,'[{\"added\": {}}]',9,1),(8,'2018-09-18 06:10:10.247000','7','物理',1,'[{\"added\": {}}]',9,1),(9,'2018-09-18 06:10:12.414000','8','政治',1,'[{\"added\": {}}]',9,1),(10,'2018-09-18 06:10:13.904000','9','化学',1,'[{\"added\": {}}]',9,1),(11,'2018-09-18 06:16:56.029000','100001','盗墓笔记',1,'[{\"added\": {}}]',8,1),(12,'2018-09-18 06:21:06.556000','100003','斗破苍穹',1,'[{\"added\": {}}]',8,1),(13,'2018-09-18 06:21:51.924000','10005','斗罗大陆',1,'[{\"added\": {}}]',8,1),(14,'2018-09-18 06:22:24.706000','10006','天火大道',1,'[{\"added\": {}}]',8,1),(15,'2018-09-18 06:22:47.598000','10009','大主宰',1,'[{\"added\": {}}]',8,1),(16,'2018-09-18 06:23:23.428000','10051','武动乾坤',1,'[{\"added\": {}}]',8,1),(17,'2018-09-18 06:23:49.926000','10215','诛仙',1,'[{\"added\": {}}]',8,1),(18,'2018-09-18 06:24:36.003000','100215','完美世界',1,'[{\"added\": {}}]',8,1),(19,'2018-09-18 06:24:46.908000','1','张青峰',1,'[{\"added\": {}}]',7,1),(20,'2018-09-18 06:24:51.521000','2','迪丽热巴',1,'[{\"added\": {}}]',7,1),(21,'2018-09-18 06:24:58.217000','3','admin',1,'[{\"added\": {}}]',7,1),(22,'2018-09-18 06:28:53.531000','14125','我是来凑数的',1,'[{\"added\": {}}]',8,1),(23,'2018-09-18 06:29:11.566000','141215','我是来凑数的',1,'[{\"added\": {}}]',8,1),(24,'2018-09-18 06:29:35.519000','161235','我是来凑数的',1,'[{\"added\": {}}]',8,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(4,'auth','group'),(3,'auth','permission'),(2,'auth','user'),(8,'BookManage','book'),(9,'BookManage','booktype'),(7,'BookManage','user'),(10,'BookManage','userborrow'),(5,'contenttypes','contenttype'),(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'BookManage','0001_initial','2018-09-18 06:08:51.343000'),(2,'contenttypes','0001_initial','2018-09-18 06:08:51.389000'),(3,'auth','0001_initial','2018-09-18 06:08:51.984000'),(4,'admin','0001_initial','2018-09-18 06:08:52.119000'),(5,'admin','0002_logentry_remove_auto_add','2018-09-18 06:08:52.135000'),(6,'contenttypes','0002_remove_content_type_name','2018-09-18 06:08:52.238000'),(7,'auth','0002_alter_permission_name_max_length','2018-09-18 06:08:52.306000'),(8,'auth','0003_alter_user_email_max_length','2018-09-18 06:08:52.364000'),(9,'auth','0004_alter_user_username_opts','2018-09-18 06:08:52.378000'),(10,'auth','0005_alter_user_last_login_null','2018-09-18 06:08:52.430000'),(11,'auth','0006_require_contenttypes_0002','2018-09-18 06:08:52.435000'),(12,'auth','0007_alter_validators_add_error_messages','2018-09-18 06:08:52.448000'),(13,'auth','0008_alter_user_username_max_length','2018-09-18 06:08:52.507000'),(14,'sessions','0001_initial','2018-09-18 06:08:52.550000');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('9v5qrl0m7uoj3ulmbcn2x9an0tr6t30y','YmVjZTY0MDU2YWQ3ZThiOGViODdjZTQwYWE0NDBiNzcyMTZiNjM2OTp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg1NTZhNWFmMDZlZjYzOTkzZjNiOTI3ZDE1N2E3NmM2NzE4ODMxZTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-10-02 06:09:37.377000');

/*Table structure for table `t_book` */

DROP TABLE IF EXISTS `t_book`;

CREATE TABLE `t_book` (
  `bid` int(10) unsigned NOT NULL,
  `bname` varchar(30) NOT NULL,
  `bimage` varchar(100) NOT NULL,
  `buser` varchar(20) NOT NULL,
  `bcontent` varchar(100) NOT NULL,
  `btype_id` int(11) NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `t_book_btype_id_b8a72178_fk_t_booktype_id` (`btype_id`),
  CONSTRAINT `t_book_btype_id_b8a72178_fk_t_booktype_id` FOREIGN KEY (`btype_id`) REFERENCES `t_booktype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_book` */

insert  into `t_book`(`bid`,`bname`,`bimage`,`buser`,`bcontent`,`btype_id`) values (10005,'斗罗大陆','images/150_2_ePyKl6c.jpg','唐家三少','txts/斗罗大陆.txt',8),(10006,'天火大道','images/150_2_LQt75jx.jpg','唐家三少','txts/天火大道.txt',2),(10009,'大主宰','images/90_2qlofjp.jpg','唐家三少','txts/大主宰.txt',7),(10051,'武动乾坤','images/90_2_yoA8anR.jpg','天蚕土豆','txts/武动乾坤.txt',1),(10215,'诛仙','images/90_THJK8I0.jpg','萧鼎','txts/诛仙.txt',8),(14125,'我是来凑数的','images/150_2_DTTG8yQ.jpg','我是来凑数的','txts/正则练习.txt',4),(100001,'盗墓笔记','images/90_6.jpg','男派三叔','txts/盗墓笔记1-8.txt',5),(100003,'斗破苍穹','images/90_KJqImxm.jpg','天蚕土豆','txts/斗破苍穹.txt',9),(100215,'完美世界','images/90_w8arwVc.jpg','辰东','txts/完美世界.txt',2),(141215,'我是来凑数的','images/150_1.jpg','我是来凑数的','txts/个人页面传参.txt',7),(161235,'我是来凑数的','images/150_1_TLOnpnn.jpg','我是来凑数的','txts/BMS需求分析.doc',4);

/*Table structure for table `t_booktype` */

DROP TABLE IF EXISTS `t_booktype`;

CREATE TABLE `t_booktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tname` (`tname`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_booktype` */

insert  into `t_booktype`(`id`,`tname`) values (9,'化学'),(4,'历史'),(5,'地理'),(3,'外语'),(8,'政治'),(1,'数学'),(7,'物理'),(6,'生物'),(2,'语文');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(30) NOT NULL,
  `upwd` varchar(20) NOT NULL,
  `created` date NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`uid`,`uname`,`upwd`,`created`) values (1,'张青峰','123','2018-09-18'),(2,'迪丽热巴','111','2018-09-18'),(3,'admin','admin123','2018-09-18');

/*Table structure for table `t_userborrow` */

DROP TABLE IF EXISTS `t_userborrow`;

CREATE TABLE `t_userborrow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `borrow` tinyint(1) NOT NULL,
  `bname_id` int(10) unsigned NOT NULL,
  `uname_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `t_userborrow_bname_id_2802517f_fk_t_book_bid` (`bname_id`),
  KEY `t_userborrow_uname_id_805b0e0a_fk_t_user_uid` (`uname_id`),
  CONSTRAINT `t_userborrow_bname_id_2802517f_fk_t_book_bid` FOREIGN KEY (`bname_id`) REFERENCES `t_book` (`bid`),
  CONSTRAINT `t_userborrow_uname_id_805b0e0a_fk_t_user_uid` FOREIGN KEY (`uname_id`) REFERENCES `t_user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_userborrow` */

insert  into `t_userborrow`(`id`,`created`,`borrow`,`bname_id`,`uname_id`) values (1,'2018-09-18 06:29:59.949000',0,10215,1),(2,'2018-09-18 06:29:59.957000',0,14125,1),(3,'2018-09-18 06:29:59.962000',0,100001,1),(4,'2018-09-18 06:36:13.506000',1,10005,1),(5,'2018-09-19 01:39:27.405000',0,100003,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
