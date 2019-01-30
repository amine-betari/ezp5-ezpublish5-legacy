<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyrestrictedarea.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oRA = new ebyRestrictedArea();
$action='list';


if ( isset($Params['id']) )
{
	$action='edit';
	
	$groupList = $oRA->getgroupList();
    $dossierData = $oRA->getDossierData($Params['id']);
	$tpl->setVariable( 'edition', true );
    $tpl->setVariable( 'group_list', $groupList );
    $tpl->setVariable( 'node_selected', $dossierData );
	
}


if ( $Module->isCurrentAction( 'AddDossierButton' ) )
{
	$action='edit';
	
	$groupList = $oRA->getgroupList();
    $tpl->setVariable( 'group_list', $groupList );
	
}


if ( $Module->isCurrentAction( 'CreateButton' ) )
{
	$action='list';
	
	if ( $http->hasPostVariable( 'ActionIDArray' ) 
	&& $http->hasPostVariable( 'GroupIdArray' ) 
	&& count($http->postVariable( 'ActionIDArray' ))>0 
	&& count($http->postVariable( 'GroupIdArray' ))>0 )
	{
		if(!$oRA->setDossierGroup( $http->postVariable( 'GroupIdArray' ), $http->postVariable( 'ActionIDArray' )))
		{
			eZDebug::writeNotice( 'Erreur setDossierGroup', 'bouygues:restricted-access/dossier.php'); 	
		}
		
	}
	
	
}




if ( $Module->isCurrentAction( 'SelectButton' ) )
{
	$action='edit';
        
	$selectedNodeIDArray = eZContentBrowse::result( 'AddNodeMultiple' );
       
	if ( is_array( $selectedNodeIDArray ))
    {
        $tpl->setVariable( 'node_selected', $selectedNodeIDArray );
		           
    }

    $groupList = $oRA->getgroupList();
    $tpl->setVariable( 'group_list', $groupList );
}



if ( $Module->isCurrentAction( 'BrowseForNodes' ) )
{
       
	eZContentBrowse::browse( array( 'action_name' => 'AddNodeMultiple',
								    'from_page' => $Module->redirectionURI( 'restricted-access', 'dossier' ) ),
                             $Module );
}


if ( $Module->isCurrentAction( 'RemoveButton' ) )
{
	$action='list';
	
	if ( $http->hasPostVariable( 'ActionIDArray' ) )
	{
		
		if(!$oRA->delDossier( $http->postVariable( 'ActionIDArray' )))
		{
			eZDebug::writeNotice( 'Erreur RemoveButton', 'bouygues:restricted-access/dossier.php'); 	
		}
		
	}
	
	
}


if($action=='list')
{
	$dossierList = $oRA->getDossierList();
    $tpl->setVariable( 'dossier_list', $dossierList );
}


if($action=='edit')
{
	$Result['content'] = $tpl->fetch( "design:restricted-access/dossier.tpl" );
}else{
	$Result['content'] = $tpl->fetch( "design:restricted-access/dossier_list.tpl" );	
}
$Result['left_menu'] = 'design:restricted-access/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Gestion des restrictions d\'accès' ) );

