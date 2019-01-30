<?php

$Module = array('name' => 'faq');
$ViewList = array();

/*
 * Gestion paramètres du site 
 */
$ViewList['list'] = array(
	'functions' 				=> array( 'list' ),
	'script'					=>	'list.php',
	'default_navigation_part'	=> 'faqnavigationpart'
);


$FunctionList = array();
$FunctionList['list'] = array();

