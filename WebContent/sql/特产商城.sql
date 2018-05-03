/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.24 : Database - shopping
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shopping` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shopping`;

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '书名',
  `descr` varchar(200) DEFAULT NULL COMMENT '图书描述',
  `normalprice` varchar(10) DEFAULT NULL COMMENT '市场价格',
  `memberprice` varchar(10) DEFAULT NULL COMMENT '会员价格',
  `pdate` datetime DEFAULT NULL COMMENT '商家日期',
  `categoryid` int(11) DEFAULT NULL COMMENT '类别',
  `picpath` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*Data for the table `book` */

insert  into `book`(`id`,`name`,`descr`,`normalprice`,`memberprice`,`pdate`,`categoryid`,`picpath`) values (24,'红皮花生米大粒生花生仁200g','净含量: 500g包装方式: 食用农产品品牌: other/其他系列: 花生米产地: 中国大陆省份: 山东省城市: 临沂市','10','9.8','2017-09-20 15:27:06',42,'upload\\img01.jpg'),(25,'农家六鳌沙地红心蜜薯板栗','农家六鳌沙地红心蜜薯板栗 ','28.8','25','2017-09-20 15:29:59',42,'upload\\201708141526388843_352_352.jpg'),(26,'大理乳扇','大理乳扇','40','38','2017-09-20 15:38:09',42,'upload\\201707121047215485_352_352.jpg'),(27,'金龙鱼生态稻大米 10kg','金龙鱼生态稻大米 10kg','78','76','2017-09-20 15:45:36',42,'upload\\201707051449086172_500_500.jpg'),(28,'柴火大院 五常稻花香大米 5kg','柴火大院 五常稻花香大米 5kg','79','70','2017-09-20 15:46:29',42,'upload\\201707051040498759_500_500.jpg'),(29,'薏苡仁薏仁米五谷杂粮 400gx2袋','薏苡仁薏仁米五谷杂粮 400gx2袋','30','29','2017-09-20 15:48:19',42,'upload\\201506161651147871_352_352.jpg'),(30,'黄山烧饼','宏继梅干菜肉黄山烧饼特产美食300金华小酥饼传统糕点心零食小吃','13.5','9.9','2017-09-21 10:42:47',78,'upload\\4596804550_1051074080.220x220.jpg'),(31,'葵花籽原香食用调','【天猫超市】福临门 葵花籽原香食用调和油 5L/桶 健康食用油','39.9','35','2017-09-21 10:53:03',66,'upload\\1.jpg'),(32,'姚粮广西大米','口感嫩滑，以此米为食者能歌善舞，聪慧漂亮，且能长生不老','49','45','2017-09-21 10:54:25',42,'upload\\11111.jpg'),(33,'一级花生油5.436L','【天猫超市】鲁花5S一级花生油5.436L 赠送900ml 食用油 健康','199.9','185','2017-09-21 10:55:08',0,'upload\\2.jpg'),(34,'香菜籽油','【天猫超市】鲁花 非转基因 特香菜籽油5L 物理压榨 食用油 食品','99.9','95','2017-09-21 10:57:15',66,'upload\\3.jpg'),(35,'常德酱板鸭','正宗湖南特产常德酱板鸭零食小吃 鸭肉熟食 微辣特辣带嚼劲 包邮','19.9','16.9','2017-09-21 10:58:05',80,'upload\\22222.jpg'),(36,'黑龙江猪蹄','不一样的味道，不一样的美味，给你初恋的感觉。','27.8','25','2017-09-21 10:59:03',86,'upload\\TB1_!!0-item_pic.jpg'),(37,'金龙鱼 食用油 ','【天猫超市】金龙鱼 黄金比例食用调和油5L/瓶 食用油 人气爆款','60','50','2017-09-21 10:59:08',66,'upload\\4.jpg'),(38,'麻花','老北京蜜麻花美味佳小麻花脆麻花小零食手工特产整箱500g特价包邮','9.9','8.9','2017-09-21 11:01:54',86,'upload\\466359.jpg'),(39,'玉米油+葵花籽油 ','【天猫超市】福临门黄金产地玉米油+葵花籽油 3.68*2桶食用油','79.9','70','2017-09-21 11:03:10',66,'upload\\5.jpg'),(40,'手撕缠丝兔','包邮四川广汉特产 农家兔肉干川味美食 熊家婆手撕缠丝兔350g/袋','58.00','56.79','2017-09-21 11:06:03',80,'upload\\TB2.lq90.jpg'),(41,'四川特产卤味熟食五香牛肉干80','四川特产卤味熟食五香牛肉干80g 厂家直销休闲零食批发oem代加工','10','7','2017-09-21 11:06:40',80,'upload\\6.jpg'),(42,'葡萄干','新疆吐鲁番特产 特级绿香妃葡萄干500g 超大颗粒青提子干零食包邮','27.5','26','2017-09-21 11:07:30',81,'upload\\TB2VU8.png'),(43,'真空卤味凤爪子','闻着让你飞天，吃着让你升仙。','33.99','33','2017-09-21 11:07:44',80,'upload\\TB2CLKKq1.jpg'),(44,'金华火腿','江南村金华火腿 净重2.5kg 精美年货礼盒火腿中秋送礼','218','199','2017-09-21 11:09:47',78,'upload\\TB14u.ui.jpg'),(45,'新疆枣圈','批发新疆枣圈250g 大红枣片 灰枣枣干 无核干枣子散装 酥脆香甜','5','3.8','2017-09-21 11:11:52',79,'upload\\8.jpg'),(47,'灯芯糕','灯芯糕 湖南地方特产传统糕点点心80后怀旧休闲办公零食特色小吃','19','17.9','2017-09-21 11:13:41',83,'upload\\TB11qDf.jpg'),(48,'新疆大枣','新疆大枣子新货新疆枣若羌枣500g特级大枣且末红枣两包包邮小红枣','9.9','8.9','2017-09-21 11:15:36',81,'upload\\TB2.jpg'),(49,'泰国进口芒果干','让你忘不掉的味道，忘不掉的感觉。','28.8','28','2017-09-21 11:16:51',76,'upload\\TB2JLToacP.jpg');

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `cart` */

insert  into `cart`(`id`,`userid`,`pid`,`count`,`price`) values (29,43,27,1,'76.0'),(30,43,49,1,'28.0'),(36,63,25,1,'25.0'),(37,63,27,1,'76.0'),(38,63,49,1,'28.0');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL COMMENT '分类名',
  `descr` varchar(200) DEFAULT NULL COMMENT '分类描述',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `isleaf` varchar(2) DEFAULT NULL COMMENT '是否为叶子节点',
  `grade` varchar(10) DEFAULT NULL COMMENT '级别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`name`,`descr`,`pid`,`isleaf`,`grade`) values (39,'米面粮油','211',0,'1','1'),(42,'米面杂粮','21',39,'0','2'),(43,'南北干货','22',39,'0','2'),(44,'肉禽水产','11',0,'1','1'),(45,'精品水果','1',44,'0','2'),(47,'茗茶酒饮','1',0,'1','1'),(48,'养生保健','1',0,'1','1'),(49,'蜂蜜','1',48,'0','2'),(50,'灵芝','2',48,'0','2'),(52,'酒','2',47,'0','2'),(56,'水果蔬菜','22',0,'1','1'),(60,'海鲜水产','1',44,'0','2'),(63,'地方特产','1',0,'1','1'),(64,'各地小吃','211',0,'1','1'),(66,'食用油','11',39,'0','2'),(67,'厨房调料','111',39,'0','2'),(68,'蛋禽肉类','222',44,'0','2'),(69,'茶叶','11',47,'0','2'),(70,'冲调饮品','122',47,'0','2'),(71,'牛奶乳品','222',47,'0','2'),(72,'补气类','123',48,'0','2'),(73,'补血类','111',48,'0','2'),(74,'滋阴类','123',48,'0','2'),(75,'补阳类','233',48,'0','2'),(76,'水果','123',56,'0','2'),(77,'蔬菜','123',56,'0','2'),(78,'华东特产','11',63,'0','2'),(79,'华北特产','123',63,'0','2'),(80,'西南特产','11',63,'0','2'),(81,'西北特产','123',63,'0','2'),(83,'长沙','11',64,'0','2'),(84,'西藏','22',64,'0','2'),(86,'汉中风味','221',64,'0','2'),(87,'全国名菜','121',0,'1','1'),(88,'川菜','121',87,'0','2'),(89,'鲁菜','2',87,'0','2'),(90,'粤菜','211',87,'0','2'),(91,'闽菜','12',87,'0','2'),(92,'苏菜','21',87,'0','2'),(93,'浙菜','21',87,'0','2'),(94,'湘菜','21',87,'0','2');

/*Table structure for table `orderstatus` */

DROP TABLE IF EXISTS `orderstatus`;

CREATE TABLE `orderstatus` (
  `status` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `orderstatus` */

insert  into `orderstatus`(`status`,`name`) values (0,'未处理'),(1,'处理成功'),(2,'废单');

/*Table structure for table `salesitem` */

DROP TABLE IF EXISTS `salesitem`;

CREATE TABLE `salesitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookid` int(11) DEFAULT NULL COMMENT '图书id',
  `uniprice` varchar(10) DEFAULT NULL COMMENT '单价',
  `bcount` int(11) DEFAULT NULL COMMENT '图书数量',
  `orderedid` int(11) DEFAULT NULL COMMENT '订单id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `salesitem` */

insert  into `salesitem`(`id`,`bookid`,`uniprice`,`bcount`,`orderedid`) values (21,25,'25.0',1,14),(22,24,'9.8',1,15),(23,24,'9.8',3,16),(24,24,'9.8',2,17),(25,27,'76.0',1,18),(26,26,'38.0',2,18),(27,24,'9.8',4,19),(28,27,'76.0',1,20),(29,28,'70.0',1,20),(30,29,'29.0',1,21),(32,25,'25.0',3,23),(33,25,'25.0',4,24);

/*Table structure for table `salesorder` */

DROP TABLE IF EXISTS `salesorder`;

CREATE TABLE `salesorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `addr` varchar(100) DEFAULT NULL COMMENT '送货地址',
  `odate` datetime DEFAULT NULL COMMENT '下单日期',
  `status` int(11) DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `salesorder` */

insert  into `salesorder`(`id`,`userid`,`addr`,`odate`,`status`) values (14,43,'1232  华东交大都   18279151111','2017-09-20 15:36:36',2),(15,43,'1232  华东交大都   18279151111','2017-09-20 16:14:52',0),(16,43,'1232  华东交大都   18279151111','2017-09-20 16:17:38',2),(17,43,'张涛  华东交通大学15栋  110','2017-09-21 09:05:49',2),(18,43,'1232  华东交大   18279151111','2017-09-21 09:07:42',0),(19,43,'1232  华东交大   18279151111','2017-09-21 09:16:29',0),(20,43,'1232  华东交大   18279151111','2017-09-21 09:47:39',0),(21,43,'1232  华东交大   18279151111','2017-09-21 10:30:49',0),(23,43,'1232  华东交大   18279151111','2017-09-21 10:32:14',0),(24,43,'1232  华东交大   18279151111','2017-09-21 10:32:35',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `addr` varchar(100) DEFAULT NULL COMMENT '地址',
  `status` varchar(10) NOT NULL DEFAULT '0' COMMENT '状态',
  `rdate` datetime DEFAULT NULL COMMENT '注册日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`phone`,`addr`,`status`,`rdate`) values (43,'1232','111','18279151111','华东交大','2','2017-05-07 02:22:01'),(60,'22222','222222','222222','华东交通大学','2','2017-05-31 08:55:53'),(61,'admin','111111','18279159611','华东交通大学15栋老用户','0','2017-09-19 08:09:24'),(62,'zhc','admin','111','华东交通大学','0','2017-09-20 10:40:11'),(63,'yzz','123456789','123456789','华东交通大学','0','2017-09-21 10:23:09'),(64,'2222','22','222222','5','0','2017-09-21 10:23:49'),(65,'abc','123456','123456','华东交通大学','0','2017-09-21 10:33:11');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
