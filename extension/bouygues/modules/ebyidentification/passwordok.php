<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysubscribeuser.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

$tpl = templateInit();

$userLogin = 		$http->variable('Login');
$userPassword = 	$http->variable('Password');

$loginHandlers = array( 'standard' );
$hasAccessToSite = true;
foreach ( array_keys ( $loginHandlers ) as $key )
{
    $loginHandler = $loginHandlers[$key];
    $userClass = eZUserLoginHandler::instance( $loginHandler );
    if ( !is_object( $userClass ) )
    {
        continue;
    }
    $user = $userClass->loginUser( $userLogin, $userPassword );
    if ( $user instanceof eZUser )
    {
        $hasAccessToSite = $user->canLoginToSiteAccess( $GLOBALS['eZCurrentAccess'] );
        if ( !$hasAccessToSite )
        	echo 'false';
		else
			echo 'true';
		$user->logoutCurrent();
        break;
    }else
		echo 'false';
}

//Disable the template :: ajax request
eZDB::checkTransactionCounter();
eZExecution::cleanExit();

$Result = array();
$Result['content'] = $tpl->fetch( "design:ebyidentification/error.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => "Email exists" )
);