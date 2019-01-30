<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

eZDebug::writeDebug( 'debut vue useremail ...', 'bouygues:whoswho/useremail.php');

$oUsr = new ebyUserAccess();
$arrSection = $oUsr->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );

$Offset = $Params['Offset'];
if ( $Offset )
    $Offset = (int) $Offset;
    
if ( !is_numeric( $Offset ) )
    $Offset = 0;    
    
$viewParameters = array( 'offset' => $Offset);   

$INI = eZINI::instance('bouygues.ini');
$limit = $INI->variable( 'WWAdminSettings','NbPagesMax');

$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'item_limit', $limit );
$oWw = new ebyWhoswho();

if ( $Module->isCurrentAction( 'EnvoyerButton' ) )
{
	$sujetFr ='';
	$sujetEn = '';
	$corpsFr = '';
	$corpsEn = '';
	$wwIds = array();

    if ( $http->hasPostVariable( 'sujetFr' ) )
    	$sujetFr = $http->postVariable( 'sujetFr' );
    
    if ( $http->hasPostVariable( 'sujetEn' ) )
    	$sujetEn = $http->postVariable( 'sujetEn' );
    	
    if ( $http->hasPostVariable( 'corpsFr' ) )
    	$corpsFr = $http->postVariable( 'corpsFr' );

    if ( $http->hasPostVariable( 'corpsEn' ) )
    	$corpsEn = $http->postVariable( 'corpsEn' );	
	
    if ( $http->hasPostVariable( 'wwIds' ))
    	$wwIds = $http->postVariable( 'wwIds' );

	if ( $http->hasPostVariable( 'id' ) && $http->postVariable( 'id' ) > 0)
    	$id = $http->postVariable( 'id' );
    	
    $hasValidationError = false;
    require 'kernel/settings/validation.php';
    $validationResult = validate( array( 'Sujet en Français'  => $sujetFr, 
    									 'Sujet en Anglais'  => $sujetEn ,
    									 'Corps du message en Français'  => $corpsFr ,
    									 'Corps du message en Anglais'  => $corpsEn 
    									),
                                  array( 'string', 
                                  		 'string',
                                  		 'string',
                                  		 'string'
                                  		), 
                                  true );
     if(count($wwIds)==0 && !$validationResult['hasValidationError']){
     	$validationResult = array( 'hasValidationError' => true,
				                  'fieldContainingError' => 'Groupe à qui envoyer',
				                  'type' => 'empty',
				                  'message' => 'Sélectionner un groupe' );	
     }                             
     
                                  
    if ( $validationResult['hasValidationError'] )
    {
        $tpl->setVariable( 'validation_field', $validationResult['fieldContainingError'] );
       	$hasValidationError = true;
    }		
    	
    	
    if ( !$hasValidationError )
    {	
	    $data = array('sujetFr'=>$sujetFr,
	    			  'sujetEn'=>$sujetEn,
	    			  'corpsFr'=>$corpsFr,
	    			  'corpsEn'=>$corpsEn,
	    			  'wwIds'=>$wwIds,
					  'id'=>$id);

	    
    	if(!$oWw->setWwEmail($data)){
    		eZDebug::writeDebug( 'Erreur : Création Message WW stoppé ', 'bouygues:whoswho/useremail.php');
    	}	
	
    }else{
    	$tpl->setVariable( 'validation_error', true );
        $tpl->setVariable( 'validation_error_type', $validationResult['type'] );
        $tpl->setVariable( 'validation_error_message', $validationResult['message'] );
    }

		
}



if ( $http->hasPostVariable( "DeleteButton" ) )
{

    
 	if ( $http->hasPostVariable( 'ActionIDArray' ) )
    {

    		$actionIDArray = $http->postVariable( 'ActionIDArray' );
    		foreach($actionIDArray as $wwId){
				$oWw->delWwEmail($wwId);
    		}
    	
    	
    }
    
    	
}

if($http->hasVariable( "id" )){
	$messageWw = $oWw->getWwEmail($http->variable( "id" ));
	$tpl->setVariable( 'messageWw',  $messageWw);

	$wwSelected = array();
	foreach($messageWw[0]['ww'] as $ww)
		$wwSelected[] = $ww['ww_id'];
		
	$tpl->setVariable( 'wwSelected',  $wwSelected);
}

$tpl->setVariable( 'messages', $oWw->getWwEmail() );


//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );

eZDebug::writeDebug( 'fin vue useremail ...', 'bouygues:whoswho/useremail.php');

$Result['content'] = $tpl->fetch( "design:whoswho/useremail.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who Mail relance' ) );

