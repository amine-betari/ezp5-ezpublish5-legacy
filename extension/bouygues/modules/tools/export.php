<?php

include_once( "kernel/common/template.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

if ( isset($Params['action']) )
{
	switch($Params['action']){
		case 'wwusrlist':
			include_once( "extension/bouygues/classes/ebyexportwwusrlist.php" );	
		break;	
	}
	
	
	
}


eZDB::checkTransactionCounter();
eZExecution::cleanExit();