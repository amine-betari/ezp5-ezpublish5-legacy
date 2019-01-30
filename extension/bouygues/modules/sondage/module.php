<?php


$Module = array('name' => 'sondage');

$ViewList = array();




/*
 * Liste des sondage
 */
$ViewList['list'] = array(
	'functions' 				=> array( 'administrate' ),
	'script'					=>	'list.php',
	'params'					=> 	array(),
	'unordered_params'			=> 	array('offset' => 'Offset'),
	'single_post_actions'		=>  array(  'UpdateButton'	=> 'UpdateButton',
											'DeleteButton' => 'DeleteButton',
											'ExportUsers' => 'ExportUsers' ),
	'post_action_parameters'	=> array(),
	'default_navigation_part'	=> 'sondagenavigationpart',
);


/*
 * Gestion d'un sondage
 */
$ViewList['edit'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'edit.php',
	'ui_context' 				=> 'edit',
	'params'					=> 	array('id'),
	'single_post_actions'		=>  array(  'ValidateButton'	=> 'ValidateButton',
											'CancelButton'	=> 'CancelButton'		),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'sondagenavigationpart',
);

/*
 * Annuaire
 */
$ViewList['reponse'] = array(
		'functions' => array( 'view' ),
		'script' => 'reponse.php',
        'params' => array(),
        'unordered_params' => array()
);




$FunctionList = array();
$FunctionList['administrate'] = array();
$FunctionList['edit'] = array();
$FunctionList['view'] = array();

