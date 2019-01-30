<?php


$Module = array('name' => 'ebynewsletter');

/**
 * Téléchargement des newsletter au format HTML
 */

$ViewList = array();
$ViewList['download'] = array(
	'functions'        => array( 'download' ),
	'script'           =>	'function.php',
	'params'           => array( 'newsletterid' )
);

$FunctionList = array();
$FunctionList['download'] = array();