-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-7
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Mercredi 02 Septembre 2009 à 02:46
-- Version du serveur: 5.0.32
-- Version de PHP: 5.2.0-8+etch11
-- 
-- Base de données: `bouygues`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `eby_ww_user_link`
-- 

CREATE TABLE `eby_ww_user_link` (
  `user_id` int(11) NOT NULL default '0',
  `ww_id` int(11) NOT NULL default '0',
  `etat` tinyint(4) NOT NULL,
  PRIMARY KEY  (`user_id`,`ww_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
