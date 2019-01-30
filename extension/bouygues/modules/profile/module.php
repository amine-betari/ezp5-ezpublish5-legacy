<?php


$Module = array('name' => 'profile');

$ViewList = array();

/*
 * Votre fiche whoswho
 */
$ViewList['yourwhoswho'] = array(
		'functions' => array( 'view' ),
		'script' => 'yourwhoswho.php',
        'params' => array( 'action', 'whoswho', 'final'),
        'unordered_params' => array()
);

$ViewList['yourwhoswhodata'] = array(
		'functions' => array( 'view' ),
		'script' => 'yourwhoswhodata.php'
);

$ViewList['yourwhoswhodataconfirm'] = array(
		'functions' => array( 'view' ),
		'script' => 'yourwhoswhodataconfirm.php'
);

/*Vos newsletter*/
$ViewList['yournewsletter'] = array(
		'functions' => array( 'view' ),
		'script' => 'yournewsletter.php',
        'params' => array( 'action', 'newsletter'),
        'unordered_params' => array()
);

$ViewList['yournewslettersubscribed'] = array(
		'functions' => array( 'view' ),
		'script' => 'yournewslettersubscribed.php'
);

$ViewList['yournewsletterunsubscribed'] = array(
		'functions' => array( 'view' ),
		'script' => 'yournewsletterunsubscribed.php'
);

/*Vos notifications*/
$ViewList['yournotification'] = array(
		'functions' => array( 'view' ),
		'script' => 'yournotification.php',
        'params' => array( 'action', 'notification', 'final'),
        'unordered_params' => array()
);

$ViewList['yournotificationunsubscribed'] = array(
		'functions' => array( 'view' ),
		'script' => 'yournotificationunsubscribed.php'
);

$FunctionList = array();
$FunctionList['view'] = array();