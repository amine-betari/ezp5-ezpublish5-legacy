<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebymeasearch.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oMeasearch = new ebyMeaSearch();






if ( $Module->isCurrentAction( 'RemoveButton' )  )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ))
	{
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		
		if(!$oMeasearch->delObject($actionIDArray))
		{
			eZDebug::writeNotice( 'Erreur RemoveButton', 'bouygues:mea-search/list.php'); 	
		}
		
	}
}


$objectList = $oMeasearch->getObjectList();

$tpl->setVariable( 'object_list', $objectList );



$Result['content'] = $tpl->fetch( "design:mea-search/list.tpl" );
$Result['left_menu'] = 'design:mea-search/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Liste des mots-clés' ) );

