-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-7
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Jeudi 03 Septembre 2009 à 19:14
-- Version du serveur: 5.0.32
-- Version de PHP: 5.2.0-8+etch11
-- 
-- Base de données: `bouygues`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `eby_settings`
-- 

CREATE TABLE `eby_settings` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(50) NOT NULL,
  `cle` varchar(50) default NULL,
  `valeur` blob,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- 
-- Contenu de la table `eby_settings`
-- 

INSERT INTO `eby_settings` (`id`, `type`, `cle`, `valeur`) VALUES 
(1, 'entreprise', 'bt', 0x733a31383a22426f7579677565732054c3a96cc3a9636f6d223b),
(2, 'entreprise', 'bc', 0x733a32313a22426f75796775657320636f6e737472756374696f6e223b),
(3, 'entreprise', 'bsa', 0x733a31313a22426f757967756573205341223b),
(4, 'entreprise', 'bi', 0x733a31393a22426f75796775657320496d6d6f62696c696572223b),
(5, 'entreprise', 'tf1', 0x733a333a22544631223b),
(6, 'entreprise', 'colas', 0x733a353a22436f6c6173223b),
(7, 'entreprise', 'c2s', 0x733a333a22433253223b),
(8, 'entreprise', 'fin', 0x733a31313a2246696e6167657374696f6e223b),
(9, 'ww_field', 'civilite', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a393a22436976696c6974c3a9223b7d),
(10, 'ww_field', 'first_name', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a373a225072c3a96e6f6d223b7d),
(11, 'ww_field', 'last_name', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a333a224e6f6d223b7d),
(12, 'ww_field', 'image', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a31313a22566f7472652070686f746f223b7d),
(13, 'ww_field', 'fonction', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a383a22466f6e6374696f6e223b7d),
(14, 'ww_field', 'direction', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a393a22446972656374696f6e223b7d),
(15, 'ww_field', 'service', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a31373a2253657276696365202d20456e746974c3a9223b7d),
(16, 'ww_field', 'entreprise', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a31303a22456e7472657072697365223b7d),
(17, 'ww_field', 'filiale', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a373a2246696c69616c65223b7d),
(18, 'ww_field', 'secteur', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a33343a22536563746575722873292064e2809961637469766974c3a92061637475656c287329223b7d),
(19, 'ww_field', 'pro_adresse', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32333a22416472657373652070726f66657373696f6e6e656c6c65223b7d),
(20, 'ww_field', 'emplacement', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a31313a22456d706c6163656d656e74223b7d),
(21, 'ww_field', 'user_account', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a33303a224164726573736520652d6d61696c2070726f66657373696f6e6e656c6c65223b7d),
(22, 'ww_field', 'pro_tel', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32353a2254c3a96cc3a970686f6e652070726f66657373696f6e6e656c223b7d),
(23, 'ww_field', 'pro_mobile', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32303a224d6f62696c652070726f66657373696f6e6e656c223b7d),
(24, 'ww_field', 'pro_fax', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a333a22466178223b7d),
(25, 'ww_field', 'assistante_nom', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32363a225072c3a96e6f6d202d204e6f6d20617373697374616e74286529223b7d),
(26, 'ww_field', 'assistante_tel', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a33303a2254c3a96cc3a970686f6e65206465206c27617373697374616e74286529223b7d),
(27, 'ww_field', 'date_naissance', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a22636c617373223b733a31303a22706172656e745f6e6f6d223b733a343a2275736572223b733a353a227469747265223b733a31373a2244617465206465206e61697373616e6365223b7d),
(28, 'ww_field', 'date_entree', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a33303a2244617465206427656e7472c3a9652064616e73206c652047726f757065223b7d),
(29, 'ww_field', 'diplome', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32363a224469706cc3b46d65287329202d20466f726d6174696f6e287329223b7d),
(30, 'ww_field', 'parcours_pro', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32323a22506172636f7572732070726f66657373696f6e6e656c223b7d),
(31, 'ww_field', 'mission_actuelle', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32323a224d697373696f6e2873292061637475656c6c65287329223b7d),
(32, 'ww_field', 'mission_precedente', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32343a2250726f6a6574287329207072c3a963c3a964656e74287329223b7d),
(33, 'ww_field', 'competences', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32343a22446f6d61696e657320646520636f6d70c3a974656e636573223b7d),
(34, 'ww_field', 'centres_interet', 0x613a333a7b733a31313a22706172656e745f74797065223b733a353a227461626c65223b733a31303a22706172656e745f6e6f6d223b733a31313a226562795f77775f75736572223b733a353a227469747265223b733a32313a2243656e747265732064e28099696e74c3a972c3aa74223b7d);