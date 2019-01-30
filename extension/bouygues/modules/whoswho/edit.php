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



$oWw = new ebyWhoswho();
$allFields = $oWw->getAllFields();

if ( $Module->isCurrentAction( 'AfficherButton' ) )
{
			
	if ( $http->hasPostVariable( 'WhosWhoID' )  && trim($http->postVariable( 'WhosWhoID' ))!='' ){
		
		$wwID = $http->postVariable( 'WhosWhoID' );
    	$wwFields = $oWw->getWwFields($wwID);    
		$wwFieldsSearch = $oWw->getWwFieldsSearch($wwID);
		
		foreach ($allFields as $key => $val) {
			if(isset($wwFields[$key])){
				$val['actif'] = true;
				$allFields[$key] = $val;
			}
			
			if(isset($wwFieldsSearch[$key])){
				$val['search'] = true;
				$allFields[$key] = $val;
			}
		}
		$tpl->setVariable( 'ww_id', $wwID );
    	
	}
	
}


if ( $Module->isCurrentAction( 'ModifierFieldsButton' ) )
{
			
	if ( $http->hasPostVariable( 'WwID' ) ){
		
		$wwID = $http->postVariable( 'WwID' );
		$fields = $http->postVariable( 'field_checked' );
		
		//insertion des champs sélectionnés
		if($wwID!='' && count($fields)>0){
			//print($wwID);
			//print_r($fields);
			if(!$oWw->setWwFields($wwID,$fields,'field')){
				eZDebug::writeDebug( "Erreur method setWwFields field", 'bouygues:whoswho/edit.php'); 
			}	
		}
		
		//mise à jour des champs 
    	$wwFields = $oWw->getWwFields($wwID);    
 //print_r($wwFields);   	
		$wwFieldsSearch = $oWw->getWwFieldsSearch($wwID);
		
		foreach ($allFields as $key => $val) {
			//'direction' => array('parent_type'=>'table','parent_nom'=>'eby_ww_user','titre'=>'Direction')
			if(isset($wwFields[$key])){
				$val['actif'] = true;
				$allFields[$key] = $val;
			}
			
			if(isset($wwFieldsSearch[$key])){
				$val['search'] = true;
				$allFields[$key] = $val;
			}
		}
		
		//print $wwID;
		$tpl->setVariable( 'ww_id', $wwID ); 
	}
		
}



if ( $Module->isCurrentAction( 'ModifierSearchButton' ) )
{
			
	if ( $http->hasPostVariable( 'WwID' ) ){
		
		$wwID = $http->postVariable( 'WwID' );
		$search = $http->postVariable( 'search_checked' );
		
		//insertion des champs sélectionnés
		if($wwID!='' && count($search)>0){
			//print($wwID);
			//print_r($fields);
			
			if(count($search)>6){
				eZDebug::writeDebug( "Erreur nb search > 6", 'bouygues:whoswho/edit.php'); 
			}else{
				if(!$oWw->setWwFields($wwID,$search,'search')){
					eZDebug::writeDebug( "Erreur method setWwFields Search", 'bouygues:whoswho/edit.php'); 
				}	
			}
		}
		
		//mise à jour des champs 
    	$wwFields = $oWw->getWwFields($wwID);    
 //print_r($wwFields);   	
		$wwFieldsSearch = $oWw->getWwFieldsSearch($wwID);
		
		foreach ($allFields as $key => $val) {
			//'direction' => array('parent_type'=>'table','parent_nom'=>'eby_ww_user','titre'=>'Direction')
			if(isset($wwFields[$key])){
				$val['actif'] = true;
				$allFields[$key] = $val;
			}
			
			if(isset($wwFieldsSearch[$key])){
				$val['search'] = true;
				$allFields[$key] = $val;
			}
		}
		
		//print $wwID;
		$tpl->setVariable( 'ww_id', $wwID ); 
	}
		
}


$tpl->setVariable( 'all_fields', $allFields );
//$tpl->setVariable( 'all_search', $allSearch );

//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );


$Result['content'] = $tpl->fetch( "design:whoswho/edit.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who Configuration' ) );

