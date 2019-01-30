<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/whoswho.php" );

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

if ( $Module->isCurrentAction( 'DeleteButton' ) )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ) ){
		$oWw = new ebyWhoswho();
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		foreach($actionIDArray as $userId){
			$oWw->delUser($userId);
		}
	}
}	

$tpl->setVariable('arrErrors', MySOAP::getEmailGalbyError());


//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );


$Result['content'] = $tpl->fetch( "design:whoswho/alertgalby.tpl" );
$Result['left_menu'] = "design:whoswho/menu.tpl";
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Alertes GALBY' ) );

