-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-7
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Mardi 28 Juillet 2009 à 19:11
-- Version du serveur: 5.0.32
-- Version de PHP: 5.2.0-8+etch11
-- 
-- Base de données: `bouygues`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `eby_weather`
-- 

CREATE TABLE `eby_weather` (
  `id` varchar(20) collate utf8_unicode_ci NOT NULL,
  `city` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Contenu de la table `eby_weather`
-- 

INSERT INTO `eby_weather` (`id`, `city`) VALUES 
('FRXX0169', 'Périgueux'),
('FRXX0018', 'Bourges');
