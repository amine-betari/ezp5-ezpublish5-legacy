<?php


$Module = array('name' => 'Liste de diffusion');

$ViewList = array();


$ViewList['list'] = array(
	'functions' 				=> array( 'edit' ),
	'script'					=>	'list.php',
	'params'					=> array( 'type'),
	'unordered_params'			=> 	array( 'offset' => 'Offset'
										),
	'single_post_actions'		=>  array('ExportWwButton'			=> 'ExportWwButton', 
										  'ExportNlButton' 			=> 'ExportNlButton',
										  'ExportRaButton' 			=> 'ExportRaButton',
										  'ExportAllButton' 		=> 'ExportAllButton',
										  'ImportWwButton'			=> 'ImportWwButton',
										  'ImportNlButton'			=> 'ImportNlButton',
										  'ImportRaButton'			=> 'ImportRaButton',
										  'ImportValidationButton'	=> 'ImportValidationButton',
										  'AnnulerButton'			=> 'AnnulerButton',	
										),
	'post_action_parameters'	=> 	array(),
	'default_navigation_part'	=> 'listdiffusionnavigationpart',
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

