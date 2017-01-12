-- Adminer 4.2.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_on` datetime NOT NULL,
  `candidate_id` int(10) unsigned DEFAULT NULL,
  `created_by_user_id` int(10) unsigned NOT NULL,
  `modified_by-user_id` int(10) unsigned NOT NULL,
  `kind` int(11) NOT NULL COMMENT 'usage, aim',
  `extension` varchar(7) NOT NULL COMMENT 'pdf, docx, ',
  `original_path` varchar(127) NOT NULL,
  `original_name` varchar(63) NOT NULL COMMENT 'without extension',
  `file_binary` mediumblob NOT NULL COMMENT 'binary',
  `text_raw` mediumtext NOT NULL COMMENT 'pandoc output',
  `text_md` mediumtext NOT NULL COMMENT 'markdown format',
  `comment` varchar(127) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by_user_id` (`created_by_user_id`),
  KEY `modified_by-user_id` (`modified_by-user_id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`created_by_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `attachment_ibfk_2` FOREIGN KEY (`modified_by-user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `attachment_ibfk_3` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `attachment` (`id`, `is_active`, `is_deleted`, `created_on`, `modified_on`, `candidate_id`, `created_by_user_id`, `modified_by-user_id`, `kind`, `extension`, `original_path`, `original_name`, `file_binary`, `text_raw`, `text_md`, `comment`) VALUES
(1,	1,	0,	'2016-12-30 18:39:26',	'0000-00-00 00:00:00',	2,	1,	1,	0,	'docx',	'/users',	'cv',	'',	'sadasdasd',	'asdasdasd',	'mooi hoor');

DROP TABLE IF EXISTS `candidate`;
CREATE TABLE `candidate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_on` datetime NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned DEFAULT NULL,
  `first_names` varchar(31) NOT NULL DEFAULT 'as in passport',
  `birth_year` smallint(6) DEFAULT NULL,
  `birth_month` tinyint(4) DEFAULT NULL,
  `birth_day_of_month` tinyint(4) DEFAULT NULL,
  `lives_in_region_id` int(10) unsigned DEFAULT NULL,
  `wants_work_in_region_id` int(10) unsigned DEFAULT NULL,
  `last_job_title` varchar(63) DEFAULT NULL,
  `introduction` text,
  `skills` text,
  `relevant_experience_since` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `lives_in_region_id` (`lives_in_region_id`),
  KEY `wants_work_in_region_id` (`wants_work_in_region_id`),
  CONSTRAINT `candidate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `candidate_ibfk_2` FOREIGN KEY (`lives_in_region_id`) REFERENCES `region` (`id`),
  CONSTRAINT `candidate_ibfk_3` FOREIGN KEY (`wants_work_in_region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `candidate` (`id`, `created_on`, `modified_on`, `is_active`, `is_deleted`, `user_id`, `first_names`, `birth_year`, `birth_month`, `birth_day_of_month`, `lives_in_region_id`, `wants_work_in_region_id`, `last_job_title`, `introduction`, `skills`, `relevant_experience_since`) VALUES
(2,	'2016-12-21 22:21:05',	'2016-12-21 23:20:41',	1,	0,	1,	'Pieter Willem',	1976,	9,	12,	NULL,	NULL,	'Sr Java Developer',	'asdadsasdsadasdasd',	'java, c++, php, it\'ll-prince',	NULL),
(3,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	'2016-12-21 22:19:34',	'0000-00-00 00:00:00',	1,	0,	NULL,	'as in passport',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `key_value`;
CREATE TABLE `key_value` (
  `key` varchar(63) NOT NULL,
  `value` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `help_text_en` text NOT NULL,
  `rank` smallint(6) NOT NULL DEFAULT '10',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `organisation`;
CREATE TABLE `organisation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `short_code` varchar(15) NOT NULL DEFAULT 'no spaces?',
  `full_name` varchar(63) NOT NULL,
  `kind` varchar(3) NOT NULL DEFAULT 'CL' COMMENT 'see conf file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `path` varchar(63) NOT NULL,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `region` (`id`, `is_active`, `is_deleted`, `path`, `name`) VALUES
(1,	1,	0,	'/',	''),
(2,	1,	0,	'/',	'Nederland'),
(3,	1,	0,	'/Nederland/',	'Drenthe');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `code` char(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `description` tinytext NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by_user_id` int(10) unsigned NOT NULL,
  `may_create_users_of_roles` varchar(31) NOT NULL,
  `may_create_candidates` tinyint(4) NOT NULL DEFAULT '0',
  KEY `modified_by_user_id` (`modified_by_user_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`modified_by_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `roles` (`code`, `is_active`, `is_deleted`, `name`, `description`, `modified_on`, `modified_by_user_id`, `may_create_users_of_roles`, `may_create_candidates`) VALUES
('A',	1,	0,	'Admin',	'admins maintain the database, create users.',	'2016-12-17 16:28:59',	1,	'C, S, R, H, E',	1);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) unsigned NOT NULL COMMENT '1',
  `is_deleted` tinyint(1) unsigned NOT NULL COMMENT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_on` datetime NOT NULL,
  `created_by_user_id` int(10) unsigned NOT NULL,
  `modified_by_user_id` int(10) unsigned NOT NULL,
  `email_address` varchar(63) NOT NULL,
  `password_bcrypt` char(64) NOT NULL COMMENT 'see https://crackstation.net/hashing-security.htm',
  `short_name` varchar(15) NOT NULL COMMENT 'e..g Bob, not William Frederic',
  `last_name` varchar(31) NOT NULL,
  `gender` char(4) DEFAULT NULL,
  `telephone_mobile` char(12) DEFAULT NULL,
  `has_role` char(1) NOT NULL DEFAULT 'U',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user` (`id`, `is_active`, `is_deleted`, `created_on`, `modified_on`, `created_by_user_id`, `modified_by_user_id`, `email_address`, `password_bcrypt`, `short_name`, `last_name`, `gender`, `telephone_mobile`, `has_role`) VALUES
(1,	0,	0,	'2016-12-17 15:20:17',	'2016-12-17 16:18:24',	0,	0,	'admin@gmail.com',	'qweqweqwe',	'admin',	'n.v.t.',	NULL,	NULL,	'A'),
(2,	0,	0,	'2016-12-17 15:40:31',	'2016-12-17 16:40:31',	1,	1,	'testkandidaat@gmail.com',	'dasdasdasd',	'Piet',	'Vries, de',	'M',	'+31611329999',	'C');

-- 2017-01-08 00:08:52

