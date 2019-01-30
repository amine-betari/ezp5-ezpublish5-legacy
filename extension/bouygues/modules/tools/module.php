<?php


$Module = array('name' => 'tools');

$ViewList = array();

/*
 * Vos Send a friend functionnality
 */
$ViewList['sendtofriend'] = array(
		'functions' => array( 'view' ),
		'script' => 'sendtofriend.php',
        'params' => array( ),
        'unordered_params' => array()
);

/*
 * Vos Send a friend functionnality
 */
$ViewList['print'] = array(
		'functions' => array( 'view' ),
		'script' => 'print.php',
        'params' => array('action','id'),
        'unordered_params' => array()
);

/*
 * Annuaire
 */
$ViewList['annuaire'] = array(
		'functions' => array( 'view' ),
		'script' => 'annuaire.php',
        'params' => array('action'),
        'unordered_params' => array()
);

/*
 * export Excel...
 */
$ViewList['export'] = array(
		'functions' => array( 'export' ),
		'script' => 'export.php',
        'params' => array('action'),
        'unordered_params' => array()
);

/*
 * Annuaire : make call
 */
$ViewList['makecall'] = array(
		'functions' => array( 'view' ),
		'script' => 'makecall.php',
        'params' => array(),
        'unordered_params' => array()
);

/*
 * Annuaire : make call
 */
$ViewList['isctc'] = array(
		'functions' => array( 'view' ),
		'script' => 'isctc.php',
        'params' => array(),
        'unordered_params' => array()
);

$FunctionList = array();
$FunctionList['view'] = array();
$FunctionList['export'] = array();