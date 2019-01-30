<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );

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
$pageLimit = $INI->variable( 'WWAdminSettings','NbPagesMax');

$oUsr = new ebyUserAccess();
$arrSection = $oUsr->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );
$arrWw = $oUsr->getListWw();
$tpl->setVariable( 'arr_ww', $arrWw );

$SearchUser = '';

if ( $Module->isCurrentAction( 'AddUsers' ) )
{
	
	if ( $http->hasPostVariable( 'ActionIDArray' ) &&  $http->hasPostVariable( 'WwID' )){

		$wwID = $http->postVariable( 'WwID' );
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		
		if(!$oWw->setUserWw($actionIDArray,ebyWhoswho::WW_USER_STATUS_ACCEPTED,$wwID)){
			eZDebug::writeNotice( 'Erreur setUserWw', 'bouygues:whoswho/userlist.php');	
		}
		
	}
	
}	

if ( $Module->isCurrentAction( 'DeleteUsers' ) )
{
	
	if ( $http->hasPostVariable( 'ActionIDArray' ) ){
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		$oWw = new ebyWhoswho();
		if(!$oWw->deleteUserWw($actionIDArray)){
			eZDebug::writeNotice( 'Erreur deleteUserWw', 'bouygues:whoswho/userlist.php');	
		}
		
	}
}


if ( $http->hasVariable( "SearchUser" ) )
{
    $rechercheTexte = $http->variable( "SearchUser" );
	$searchText = '';
	$originalSearchText = '';
	$phraseSearchText = '';			
	if ( !is_numeric( $Offset ) )
	    $Offset = 0;
	
	$fullSearchText = '';
	if ( $rechercheTexte!='' )
	{
	    if ( $searchText != '' )
	        $searchText .= ' ';
	    $originalSearchText = $rechercheTexte;
	    $searchText .= $originalSearchText;
	    $fullSearchText = $rechercheTexte;
	}
				
	$searchContentClassID = -1;
	$searchContentClassAttributes = 0;
	$searchContentClassAttributeArray = array();
	
	$searchContentClassID = 4;
	if ( (int) $searchContentClassID > 0 )
	{
		$searchContentClass = eZContentClass::fetch( (int) $searchContentClassID );
	    if ( is_object( $searchContentClass ) )
	            $searchContentClassAttributeArray = $searchContentClass->fetchSearchableAttributes();
	}
	
	//$searchContentClassAttributeID = array(8,9,12);
	$searchContentClassAttributeID = array(9);
	
	$searchSectionID = 2;


	$searchArray = eZSearch::buildSearchArray();
	
    $searchResult = eZSearch::search( $searchText, array( 'SearchContentClassID' => $searchContentClassID,
    													  'SearchContentClassAttributeID' => $searchContentClassAttributeID,
    														'SearchLimit' => 5000,
    														'SearchOffset' => 0	
    													   ),
                                       $searchArray );

                                       
    if($searchResult['SearchCount']>0)
    {
    	$oWw = new ebyWhoswho();
    	
		$wwSearchUserList = ebyWhoswho::getSearchWwUsersList($searchResult['SearchResult'],$arrWw);
			
		if ( isset($Params['Value']) &&  !empty($Params['Value']))
		{
			$sort_val = $Params['Value'];
		}
		
		if ( isset($Params['Column']) &&  !empty($Params['Column']))
		{
			$sort_col = $Params['Column'];
		}
		
		if(isset($sort_val) && isset($sort_col) )
		{
			
			$wwSearchUserList = $oWw->tri($wwSearchUserList, $sort_col, $sort_val);
			
			$tpl->setVariable( 'sort_val', $sort_val );
			$tpl->setVariable( 'sort_col', $sort_col );
		}
			
		//$Offset = $Offset/10;
					
		$wwSearchUserList = $oWw->pagination($wwSearchUserList, $Offset, $pageLimit);
		
    }
    

	$tpl->setVariable( 'offset', $Offset );
	$tpl->setVariable( 'page_limit', $pageLimit );
	$tpl->setVariable( "search_user", urlencode( $searchText ) );	
	$tpl->setVariable( 'user_search_list', $wwSearchUserList );
	$tpl->setVariable( 'item_count', $searchResult['SearchCount'] );
	
	
	$tpl->setVariable( "SearchUser", $http->variable( "SearchUser" ) );
}		
		


if ( $Module->isCurrentAction( 'ExportUsers' ) )
{	
		$Module->redirectTo( '/layout/set/export/tools/export/wwusrlist' );
		return;
}

$tpl->setVariable( 'view_parameters', $viewParameters );

//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );

$Result['content'] = $tpl->fetch( "design:whoswho/userlist.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who - Les inscrits' ) );

