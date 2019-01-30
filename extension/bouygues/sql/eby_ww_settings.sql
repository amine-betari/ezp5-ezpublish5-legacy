-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-7
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Jeudi 03 Septembre 2009 à 22:15
-- Version du serveur: 5.0.32
-- Version de PHP: 5.2.0-8+etch11
-- 
-- Base de données: `bouygues`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `eby_ww_settings`
-- 

CREATE TABLE `eby_ww_settings` (
  `id` int(11) NOT NULL auto_increment,
  `ww_id` int(11) NOT NULL default '0',
  `type` varchar(50) NOT NULL,
  `cle` varchar(50) NOT NULL,
  `config` blob NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `ww_id` (`ww_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
