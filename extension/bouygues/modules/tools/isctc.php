<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/annuaire.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

if($http->hasPostVariable( 'domain' )){
	
	$domain = $http->postVariable( 'domain' );
	if(MySOAP::isCTCActivated($domain))
		echo 'ok';
	else
		echo 'ko';
}


eZDB::checkTransactionCounter();
eZExecution::cleanExit();