USE database_sample_01;
DROP TABLE IF EXISTS `table_sample_01`;
CREATE TABLE `table_sample_01` (
  `col_01` int(11) NOT NULL AUTO_INCREMENT,
  `col_02` varchar(10) DEFAULT NULL,
  KEY `col_01` (`col_01`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
