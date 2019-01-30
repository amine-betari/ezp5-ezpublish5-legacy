<?php


$Module = array('name' => 'mea-search');

$ViewList = array();


/*
 * Gestion mots-clés MEA du site 
 */
$ViewList['edit'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'edit.php',
	'params'					=> array( 'obj_id','id'),
	'single_post_actions'		=>  array(  'CreateButton'	=> 'CreateButton',
										    'UpdateButton' => 'UpdateButton',
											'SelectButton' => 'SelectButton',
											'BrowseForObject' => 'BrowseForObject',
											'AddKeyWordButton' => 'AddKeyWordButton',
											'UpdKeyWordButton' => 'UpdKeyWordButton',
											'RemoveKeywordButton' => 'RemoveKeywordButton'
											
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'measearchnavigationpart',
);


/*
 * Loiste des mots-clés MEA du site 
 */
$ViewList['list'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'list.php',
	'params'					=> array(),
	'single_post_actions'		=>  array(  'RemoveButton' => 'RemoveButton',
											
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'measearchnavigationpart',
);


$FunctionList = array();
$FunctionList['edit'] = array();

