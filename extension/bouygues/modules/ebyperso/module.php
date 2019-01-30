<?php

$Module = array( 'name' => 'Module eby perso' );



$ViewList = array();
$ViewList['home'] =  array( 
		'functions' => array( 'view' ),
		'script' => 'home.php',
        'params' => array(),
        'unordered_params' => array() 
);

$ViewList['action'] =  array( 
		'functions' => array( 'view' ),
		'script' => 'action.php',
        'params' => array(),
        'single_post_actions'		=> array( 'LayoutUpdAjax' 			=> 'LayoutUpd',
 									  		  'WidgetAddAjax' 			=> 'WidgetAdd',
 									  		  'WidgetUpdAjax' 			=> 'WidgetUpd',
											  'WidgetGetVilleAjax' 		=> 'WidgetGetVille',
											  'WidgetGetContactAjax'	=> 'WidgetGetContact',
											),
									
		'post_action_parameters'	=> array(
			'LayoutUpd'				=> array( 'MyLayout'		=> 'MyLayout' ),
 			'WidgetAdd'				=> array( 'WidgetSel'		=> 'WidgetSel' ),
			'WidgetUpd'				=> array( 'WidgetId'		=> 'WidgetId',
											  'WidgetConf'		=> 'WidgetConf'),
			'WidgetGetVille'		=> array( 'q'				=> 'q' ),																   			
			'WidgetGetContact'		=> array( 'q'				=> 'q' ),								
		)
);

$FunctionList = array();
$FunctionList['view'] = array();
?>