<?php
$Module = array('name' => 'ezsearch');

$ViewList = array();

/*
 * Valeurs du groupe
 */
$ViewList['home'] = array(
		'functions' => array( 'view' ),
		'script' => 'home.php',
        'params' => array( 'action', 'home'),
        'unordered_params' => array()
);

$FunctionList = array();
$FunctionList['view'] = array();