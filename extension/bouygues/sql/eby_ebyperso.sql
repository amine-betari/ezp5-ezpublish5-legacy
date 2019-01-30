/**
 * Database objects creation script for the EbyPerso module
 * @package eZPublish 4.1.3
 * @author J. Leger
 * @copyright (c) 2009
 */
CREATE TABLE `eby_ebyperso` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `bloc_type` tinyint(4) NOT NULL,
  `bloc_col` tinyint(4) NOT NULL,
  `bloc_row` tinyint(4) NOT NULL,
  `bloc_config` blob NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
