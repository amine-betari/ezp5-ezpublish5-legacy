<?php


$Module = array('name' => 'restricted-access');

$ViewList = array();


/*
 * Gestion des dossiers restreints
 */
$ViewList['dossier'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'dossier.php',
	'params'					=> 	array('id'),
	'single_post_actions'		=>  array(  'CreateButton'	=> 'CreateButton',
										    'UpdateButton' => 'UpdateButton',
											'RemoveButton' => 'RemoveButton',
											'AddDossierButton'=>'AddDossierButton',
											'BrowseForNodes' =>'BrowseForNodes',
											'SelectButton' => 'SelectButton'
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'restrictedaccessnavigationpart',
);


/*
 * Gestion des groupes restreints
 */
$ViewList['group'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'group.php',
	'params'					=> 	array('id'),
	'single_post_actions'		=>  array(  'CreateButton'	=> 'CreateButton',
										    'UpdateButton' => 'UpdateButton',
											'BrowseForUsers' => 'BrowseForUsers',
											'SelectButton' => 'SelectButton',
											'ValiderButton'=> 'ValiderButton',
											'RemoveUserButton' => 'RemoveUserButton',
											'RemoveButton' => 'RemoveButton',
											
											),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'restrictedaccessnavigationpart',
);



$FunctionList = array();
$FunctionList['edit'] = array();
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
