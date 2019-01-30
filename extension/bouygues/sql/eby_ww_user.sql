-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Ven 04 Septembre 2009 à 16:52
-- Version du serveur: 5.1.37
-- Version de PHP: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `bouygues`
--

-- --------------------------------------------------------

--
-- Structure de la table `eby_ww_user`
--

CREATE TABLE IF NOT EXISTS `eby_ww_user` (
  `user_id` int(11) NOT NULL,
  `fonction` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `direction` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `service` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pro_adresse` text COLLATE utf8_unicode_ci NOT NULL,
  `emplacement` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pro_tel` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_mobile` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_fax` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `assistante_nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `assistante_tel` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_entree` date DEFAULT NULL,
  `diplome` text COLLATE utf8_unicode_ci NOT NULL,
  `parcours_pro` text COLLATE utf8_unicode_ci NOT NULL,
  `mission_actuelle` text COLLATE utf8_unicode_ci NOT NULL,
  `mission_precedente` text COLLATE utf8_unicode_ci NOT NULL,
  `competences` text COLLATE utf8_unicode_ci NOT NULL,
  `centres_interet` text COLLATE utf8_unicode_ci NOT NULL,
  `entreprise` int(11) DEFAULT NULL,
  `filiale` int(11) DEFAULT NULL,
  `secteur` int(11) DEFAULT NULL,
  `filiale_autre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
