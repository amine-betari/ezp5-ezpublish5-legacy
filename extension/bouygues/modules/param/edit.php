<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyparam.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oParam = new ebyParam();


if ( isset($Params['id']) )
{
	$field = $oParam->getEntryById($Params['id']);//print_r($field);
	$tpl->setVariable( 'id', $Params['id'] );
	$tpl->setVariable( 'field', $field );
	
}

if ( $Module->isCurrentAction( 'UpdateButton' ) && $http->hasPostVariable( 'Id' ) ){
	
	$SectionID = null;
	if($http->postVariable( 'SectionID' )!='') $SectionID = $http->postVariable( 'SectionID' );
	
	if(!$oParam->setEntry($http->postVariable( 'Id' ),$http->postVariable( 'type' ),$http->postVariable( 'cle' ),$http->postVariable( 'valeur' ),$SectionID)){
		eZDebug::writeDebug( "Erreur method setEntry UpdateButton", 'bouygues:param/edit.php'); 
	}
		
}


if ( $Module->isCurrentAction( 'CreateButton' ) )
{
	$SectionID = null;
	if($http->postVariable( 'SectionID' )!='') $SectionID = $http->postVariable( 'SectionID' );
	
	if ( $http->hasPostVariable( 'cle' ) && $http->hasPostVariable( 'valeur' )){
		if(!$oParam->setEntry($id=null,$http->postVariable( 'type' ),$http->postVariable( 'cle' ),$http->postVariable( 'valeur' ),$SectionID)){
			eZDebug::writeDebug( "Erreur method setEntry CreateButton", 'bouygues:param/edit.php'); 
		}
	}	
}

if ( $Module->isCurrentAction( 'RemoveButton' )  )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ))
	{
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		
		if(!$oParam->delEntry($actionIDArray))
		{
			eZDebug::writeNotice( 'Erreur RemoveButton', 'bouygues:param/edit.php'); 	
		}
		
	}
}



$allFields = $oParam->getListEntry(null,"type");
$tpl->setVariable( 'type_ini', $oParam->typeINI );
$tpl->setVariable( 'entry_list', $allFields );



$Result['content'] = $tpl->fetch( "design:param/edit.tpl" );
$Result['left_menu'] = 'design:param/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Paramètres Généraux' ) );

