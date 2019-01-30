<?php


$Module = array('name' => 'whoswho');

$ViewList = array();




/*
 * Gestion des WW
 */
$ViewList['list'] = array(
	'functions' 				=> array( 'administrate' ),
	'script'					=>	'list.php',
	'params'					=> 	array( 'wwid'),
	'single_post_actions'		=>  array(  'createbutton'	=> 'CreateButton',
										    'cancelsetting'	=> 'CancelSetting',
										    'UpdateButton'	=> 'UpdateButton' ),
	'post_action_parameters'	=> array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * Configuration du WW
 */
$ViewList['edit'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'edit.php',
	'params'					=> 	array(),
	'single_post_actions'		=>  array(  'AfficherButton'	=> 'AfficherButton',
										    'ModifierFieldsButton' => 'ModifierFieldsButton',
											'ModifierSearchButton' => 'ModifierSearchButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * demande d'inscription au WW
 */
$ViewList['userstate'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'userstate.php',
	'params'					=> 	array(),
	'unordered_params'			=> 	array(	'offset' => 'Offset',
											'sort'	=> 'Sort',
											'column'=> 'Column',
										   	'value'	=> 'Value'
											),
	'single_post_actions'		=> 	array(  'AcceptButton' => 'AcceptButton',
											'RefuseButton' => 'RefuseButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * Liste des inscrits au WW
 */
$ViewList['userlist'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'userlist.php',
	'params'					=> array(),
	'unordered_params'			=> 	array('offset' => 'Offset',
											'column'=> 'Column',
										   	'value'	=> 'Value'
										),
	'single_post_actions'		=> 	array(  'AddUsers' => 'AddUsers',
											'DeleteUsers' => 'DeleteUsers',
											'ExportUsers' => 'ExportUsers',
											'SearchButton' => 'SearchButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * Email de relance  aux collaborateurs
 */
$ViewList['useremail'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'useremail.php',
	'params'					=> 	array(),
	'unordered_params'			=> 	array('offset' => 'Offset'),
	'single_post_actions'		=> 	array('EnvoyerButton' => 'EnvoyerButton'),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * Fiche d'un membre WW
 */
$ViewList['userform'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'userform.php',
	'ui_context' 				=> 'edit',
	'params'					=> array( 'userid'),
	'unordered_params'			=> 	array(),
	'single_post_actions'		=> 	array( 	'ModifierButton' => 'ModifierButton',
											'CancelButton'=> 'CancelButton',
											'ActionButtonDeleteImage' => 'ActionButtonDeleteImage' ),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/*
 * Gestion WW Liste
 */
$ViewList['filter'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'filter.php',
	'params'					=> array(),
	'unordered_params'			=> 	array('offset' => 'Offset'),
	'single_post_actions'		=> 	array(  'AfficherButton'	=> 'AfficherButton',
										    'AjouterButton' 	=> 'AjouterButton',
											'RetirerButton' 	=> 'RetirerButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);



/*
 * Alerte sur les retours de Galby
 */
$ViewList['alertgalby'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'alertgalby.php',
	'params'					=> 	array(),
	'unordered_params'			=> 	array('offset' => 'Offset'),
	'single_post_actions'		=> 	array(  'DeleteButton' => 'DeleteButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'whoswhonavigationpart',
);


/**
 * User inscription check
 */
$ViewList['usercheck'] = array(
    'functions'               => array( 'edit' ),
    'script'                  => 'usercheck.php',
    'params'                  => array(),
    'unordered_params'        => array(),
    'single_post_actions'     => array(),
    'post_action_parameters'  => array(),
    'default_navigation_part' => 'whoswhonavigationpart'
);



$FunctionList = array();
$FunctionList['administrate'] = array();
$SectionID = array(
    'name'=> 'Section',
    'values'=> array(),
    'path' => 'classes/',
    'file' => 'ezsection.php',
    'class' => 'eZSection',
    'function' => 'fetchList',
    'parameter' => array( false )
    );

$FunctionList['edit'] = array(
                               'Section' => $SectionID
                               );

