USE sample_db;


-- Adminer 4.8.0 MySQL 8.0.32 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `short_message` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `text` text COLLATE utf8mb4_bin NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `article` (`id`, `user_name`, `title`, `short_message`, `text`, `created`, `modified`) VALUES
(1,	'aaa',	'aaa',	'aaa',	'aaaa',	'2023-03-20 01:35:39',	'2023-03-20 01:35:39'),
(2,	'sasasa',	'sasa',	'sasa',	'sasasasa;:l;.,x.x,vx:v',	'2023-03-20 01:56:28',	'2023-03-20 01:56:28');

-- 2023-03-21 15:43:10