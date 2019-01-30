<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysubscribeuser.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

$tpl = templateInit();


if($http->hasVariable('email_register'))
	$testedEmail = $http->variable('email_register');
elseif($http->hasVariable('Login'))
	$testedEmail = $http->variable('Login');
	
	$oUsr = eZUser::fetchByEmail($testedEmail);	
	if($oUsr)
		echo 'true';
	else
		echo 'false';


//Disable the template :: ajax request
eZDB::checkTransactionCounter();
eZExecution::cleanExit();

$Result = array();
$Result['content'] = $tpl->fetch( "design:ebyidentification/error.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => "Email exists" )
);