<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oUsr = new ebyUserAccess();
$arrSection = $oUsr->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );

if ( $Module->isCurrentAction( 'CreateButton' ) )
{			
	if ( $http->hasPostVariable( 'SectionID' ) )
    	$sectionID = $http->postVariable( 'SectionID' );
    	
	if ( $http->hasPostVariable( 'wwFr' ) )
    	$wwFr = trim($http->postVariable( 'wwFr' ));

    if ( $http->hasPostVariable( 'wwEn' ) )
    	$wwEn = trim($http->postVariable( 'wwEn' ));	
    	
    	
	$hasValidationError = false;
    require 'kernel/settings/validation.php';
    $validationResult = validate( array( 'Nom en Français'  => $wwFr, 'Nom en Anglais'  => $wwEn ),
                                  array( 'string', 'string' ), 
                                  true );
    if ( $validationResult['hasValidationError'] )
    {
        $tpl->setVariable( 'validation_field', $validationResult['fieldContainingError'] );
       	$hasValidationError = true;
    }	
    
    if ( !$hasValidationError )
    {	
		$userId = eZUser::currentUserID();
		
		$params = array();
	
		$params['class_identifier'] = 'bouygues_whoswho';
		$params['creator_id'] = $userId;
		$params['section_id'] = $sectionID; // section 
		$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 1,
																   	'ClassFilterType' => 'include',
															       	'ClassFilterArray' => array( 'bouygues_master_page' ),
																	
																), 2 );
																
		foreach ( $nodes as $node ){
			$MPContentObject = $node->attribute( 'object' );
			if($MPContentObject->attribute( 'section_id' )==$sectionID){
				$params['parent_node_id'] = $node->attribute( 'node_id' );
				break;
			}
		}
			
	
		
		$attributesData = array();
		$attributesData['titre'] = $wwFr;
		$attributesData['titre_en'] = $wwEn;
		$params['attributes'] = $attributesData;
	
		$contentObject = eZContentFunctions::createAndPublishObject( $params );
				
    }else{
    	$tpl->setVariable( 'validation_error', true );
        $tpl->setVariable( 'validation_error_type', $validationResult['type'] );
        $tpl->setVariable( 'validation_error_message', $validationResult['message'] );
    }
	
	
}


if ( $Module->isCurrentAction( 'UpdateButton' ) )
{
	if ( $http->hasPostVariable( 'WwID' ) ){
    	$WwID = $http->postVariable( 'WwID' );
    	$wwFr ='';
    	$wwEn ='';
    	
    	if ( $http->hasPostVariable( 'wwFr' ) )
    		$wwFr = trim($http->postVariable( 'wwFr' ));

    	if ( $http->hasPostVariable( 'wwEn' ) )
    		$wwEn = trim($http->postVariable( 'wwEn' ));
    	
		$object = eZContentObject::fetch($WwID);
		
		if(trim($wwFr)!=''){

			
			
			
			// Create the new draft version
			$version = $object->createNewVersionIn( 'fre-FR', false, false, true, eZContentObjectVersion::STATUS_INTERNAL_DRAFT );
		
			// Store the attributes
			$datamap = $version->datamap();
			$datamap['titre']->fromString($wwFr);
			$datamap['titre']->store();
			$datamap['titre_en']->fromString($wwEn);
			$datamap['titre_en']->store();
				
				
			// Now publish the content
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $object->attribute( 'id' ),
                                                                               'version'   => $version->attribute( 'version' ) ) );			
			
			if(!$result) eZDebug::writeDebug( 'erreur maj ww ', 'bouygues:whoswho/list.php');				
			
				
		}		
	
	}
	
	
}



if ( isset($Params['wwid']) && $Params['wwid']!='' )
{
	$tpl->setVariable( 'ww_id', $Params['wwid'] );
}



if ( $http->hasPostVariable( "RemoveButton" ) )
{
    
 	if ( $http->hasPostVariable( 'WwID' ) )
    {
    	$WwID = $http->postVariable( 'WwID' );
    	if(!ebyWhoswho::removeWw($WwID)){
    		eZDebug::writeNotice( "Erreur suppression Ww : ".$WwID, 'bouygues:whoswho/list.php');
    	}
    	
    	
    }
    
    	
}

//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );



$Result['content'] = $tpl->fetch( "design:whoswho/list.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who Gestion') );

