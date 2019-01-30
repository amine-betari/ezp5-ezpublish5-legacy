<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php");

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$Offset = $Params['Offset'];
if ( $Offset )
    $Offset = (int) $Offset;
    
if ( !is_numeric( $Offset ) )
    $Offset = 0;    
    
$viewParameters = array( 'offset' => $Offset);   
 
$INI = eZINI::instance('bouygues.ini');
$limit = $INI->variable( 'WWAdminSettings','NbPagesMax');

if ( $Module->isCurrentAction( 'AcceptButton' ) )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ) )
	{

		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		if(!$oWw->setStatusUserWw($actionIDArray,ebyWhoswho::WW_USER_STATUS_ACCEPTED)){
			eZDebug::writeNotice( 'Erreur s', 'bouygues:whoswho/userstate.php');	
		}
		
	}
}	

if ( $Module->isCurrentAction( 'RefuseButton' ) )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ) ){
		
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		if(!$oWw->setStatusUserWw($actionIDArray,ebyWhoswho::WW_USER_STATUS_REFUSED)){
			eZDebug::writeNotice( 'Erreur s', 'bouygues:whoswho/userstate.php');	
		}
		
	}
}	

$oUsr = new ebyUserAccess();
$arrWw = $oUsr->getListWw();

//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );

if ( isset($Params['Sort']) &&  !empty($Params['Sort']))
{
	$sort_type = $Params['Sort'];
}
else {
  $sort_type = 0;
}

if ( isset($Params['Value']) &&  !empty($Params['Value']))
{
	$sort_val = $Params['Value'];
}

if ( isset($Params['Column']) &&  !empty($Params['Column']))
{
	$sort_col = $Params['Column'];
}

$tpl->setVariable( 'sort_type', $sort_type );
$Offset_accepted = 0;
$Offset_pending = 0;
$Offset_refused = 0;

if(isset($sort_type))
{
	switch($sort_type)
	{
		case ebyWhoswho::WW_USER_STATUS_ACCEPTED :
			
			$Offset_accepted = $Offset; 	
			
		break;	
		
		case ebyWhoswho::WW_USER_STATUS_PENDING :
			
			$Offset_pending = $Offset;
			
		break;	
		
		case ebyWhoswho::WW_USER_STATUS_REFUSED :
			
			$Offset_refused = $Offset;
			
		break;	
	}
} 

$userAcceptedList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_ACCEPTED,$arrWw,array('offset'=> $Offset_accepted,'limit'=> $limit));
$userPendingList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_PENDING,$arrWw,array('offset'=> $Offset_pending,'limit'=> $limit));
$itemCountRefused = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_REFUSED,$arrWw,$arrPagination=null,$total='count');
$userRefusedList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_REFUSED,$arrWw,array('offset'=> $Offset_refused,'limit'=> $limit));	

//eZDebug::writeNotice( '$userRefusedList=>' . print_r($userRefusedList,1), 'eby:whoswho/userstate.php');

if(isset($sort_type) && isset($sort_val) && isset($sort_col) )
{
//eZDebug::writeNotice( '$$sort_type:' . $sort_type, 'eby:whoswho/userstate.php');
	$oWw = new ebyWhoswho();
	
	switch($sort_type)
	{
		case ebyWhoswho::WW_USER_STATUS_ACCEPTED :
			
			$userAcceptedList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_ACCEPTED,$arrWw);
			$userAcceptedList = $oWw->tri($userAcceptedList, $sort_col, $sort_val);
			$userAcceptedList = $oWw->pagination($userAcceptedList, $Offset, $limit);
			
			
		break;	
		
		case ebyWhoswho::WW_USER_STATUS_PENDING :
			
			$userPendingList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_PENDING,$arrWw);
			$userPendingList = $oWw->tri($userPendingList, $sort_col, $sort_val);
			$userPendingList = $oWw->pagination($userPendingList, $Offset, $limit);
			
			
		break;	
		
		case ebyWhoswho::WW_USER_STATUS_REFUSED :
			
			$itemCountRefused = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_REFUSED,$arrWw,$arrPagination=null,$total='count');
			$userRefusedList = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_REFUSED,$arrWw);
			$userRefusedList = $oWw->tri($userRefusedList, $sort_col, $sort_val);
			$userRefusedList = $oWw->pagination($userRefusedList, $Offset, $limit);
			
			
		break;	
		
	}
	
	
	$tpl->setVariable( 'sort_val', $sort_val );
	$tpl->setVariable( 'sort_col', $sort_col );
	
		
}





$tpl->setVariable( 'ww_user_status_accepted', ebyWhoswho::WW_USER_STATUS_ACCEPTED );
$tpl->setVariable( 'ww_user_status_pending', ebyWhoswho::WW_USER_STATUS_PENDING );
$tpl->setVariable( 'ww_user_status_refused', ebyWhoswho::WW_USER_STATUS_REFUSED );

$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'item_limit', $limit );
$tpl->setVariable( 'user_pending_list', $userPendingList );
$tpl->setVariable( 'user_accepted_list', $userAcceptedList );
$tpl->setVariable( 'item_count_refused', $itemCountRefused );
$tpl->setVariable( 'user_refused_list', $userRefusedList );

$Result['content'] = $tpl->fetch( "design:whoswho/userstate.tpl" );
$Result['left_menu'] = "design:whoswho/menu.tpl";
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Whos Who demandes d\'inscription ' ) );

