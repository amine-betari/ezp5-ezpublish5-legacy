<?php


$Module = array('name' => 'param');

$ViewList = array();


/*
 * Gestion paramètres du site 
 */
$ViewList['edit'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'edit.php',
	'params'					=> array( 'id'),
	'single_post_actions'		=>  array(  'CreateButton'	=> 'CreateButton',
										    'UpdateButton' => 'UpdateButton',
											'RemoveButton' => 'RemoveButton',
											
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'paramnavigationpart',
);


/*
 * Gestion des traductions statiques 
 */
$ViewList['langue'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'langue.php',
	'params'					=> 	array(),
	'single_post_actions'		=>  array(  'CreateButton'	=> 'CreateButton',
										    'UpdateButton' => 'UpdateButton',
											
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'paramnavigationpart',
);


$FunctionList = array();
$FunctionList['edit'] = array();

