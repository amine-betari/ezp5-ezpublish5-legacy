<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/annuaire.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

if($http->hasPostVariable( 'company' )){
	
	$company = $http->postVariable( 'company' );
	$login = $http->postVariable( 'login' );
	$domain = $http->postVariable( 'domain' );
	$telephoneNumber = $http->postVariable( 'telephoneNumber' );
	
	$callCollab = MySOAP::makeCall($company, $domain, $login, $telephoneNumber);
	
	echo $callCollab;
}


eZDB::checkTransactionCounter();
eZExecution::cleanExit();