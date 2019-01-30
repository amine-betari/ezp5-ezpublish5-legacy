<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );


$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

if ( $Offset )
    $Offset = (int) $Offset;
    
if ( !is_numeric( $Offset ) )
    $Offset = 0;    
    
$viewParameters = array( 'offset' => $Offset);   

$INI = eZINI::instance('bouygues.ini');
$limit = $INI->variable( 'WWAdminSettings','NbPagesMax');
$tpl->setVariable( 'item_limit', $limit );

$oUsr = new ebyUserAccess();
$arrWw = $oUsr->getListWw();
$tpl->setVariable( 'arr_ww', $arrWw );
$arrSection = $oUsr->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );


if ( $http->hasPostVariable( 'WhosWhoID' )  && trim($http->postVariable( 'WhosWhoID' ))!='' ){
		
		$wwID = $http->postVariable( 'WhosWhoID' );
}	
if ( $http->hasPostVariable( 'WwID' )  && trim($http->postVariable( 'WwID' ))!='' ){
		
		$wwID = $http->postVariable( 'WwID' );
}	



if ( $Module->isCurrentAction( 'AjouterButton' ) && isset($wwID) )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ))
	{
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		if(!$oWw->setListeUserWw($actionIDArray,$wwID,ebyWhoswho::WW_USER_LIST_SELECTED)){
			eZDebug::writeNotice( 'Erreur ', 'bouygues:whoswho/filter.php');	
		}
		
		$Module->setCurrentAction('AfficherButton');
		
	}
}


if ( $Module->isCurrentAction( 'RetirerButton' ) && isset($wwID) )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ))
	{
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		if(!$oWw->setListeUserWw($actionIDArray,$wwID,ebyWhoswho::WW_USER_LIST_REMOVED)){
			eZDebug::writeNotice( 'Erreur ', 'bouygues:whoswho/filter.php');	
		}
		
		$Module->setCurrentAction('AfficherButton');
		
	}
}


if ( $Module->isCurrentAction( 'AfficherButton' ) && isset($wwID) )
{
    			
		$userList = ebyWhoswho::getWwUsersList($etat=1,$wwIds=array($wwID),$arrPagination=null,$total=null,$liste=1);
		$userListCount = ebyWhoswho::getWwUsersList($etat=1,$wwIds=array($wwID),$arrPagination=null,$total='count',$liste=1);
		
		$userWw = ebyWhoswho::getWwUsersList($etat=1,$wwIds=array($wwID),$arrPagination=array('offset'=> $Offset,'limit'=> $limit));
		$userWwCount = ebyWhoswho::getWwUsersList($etat=1,$wwIds=array($wwID),$arrPagination=null,$total='count');
		
		
		$tpl->setVariable( 'ww_id', $wwID );
		$tpl->setVariable( 'user_list', $userList );
		$tpl->setVariable( 'user_list_count', $userListCount );
		
		$tpl->setVariable( 'user_ww', $userWw );
		$tpl->setVariable( 'user_ww_count', $userWwCount );
    	
	
	
}




//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );

$Result['content'] = $tpl->fetch( "design:whoswho/filter.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who Liste' ) );

