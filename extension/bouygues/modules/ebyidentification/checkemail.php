<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/ebysubscribeuser.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

//$tpl = templateInit();

$type = $Params ['type'];
$email = $Params ['email'];

if($http->hasVariable('email_register'))
	$testedEmail = $http->variable('email_register');
elseif($http->hasVariable('Login'))
	$testedEmail = $http->variable('Login');
	
$oUsr = eZUser::fetchByEmail($testedEmail);	

if($oUsr)
	$userSetting = eZUserSetting::fetch( $oUsr->attribute( "contentobject_id") );

if($oUsr && $email != $testedEmail && $userSetting->attribute( "is_enabled" ) == 1)
	echo ezpI18n::tr('extension/bouygues/ebyidentification', 'registration_email_already_registered');
else{
	
	if($email == $testedEmail){
		$oContentUser = eZContentObject::fetch($oUsr->ContentObjectID);
		if($oContentUser){
			$dataMap = $oContentUser->attribute('data_map');
			$no_galby_sync = $dataMap['no_galby_sync']->content();
		}
	}else
		$no_galby_sync = 0;
		
	if($no_galby_sync == 1)
		echo 'true';
	else{
		$galby = MySOAP::getContactByMailOnly($testedEmail);
		if($galby)
			echo 'true';
		else
			echo ezpI18n::tr('extension/bouygues/ebyidentification', 'registration_email_error');
	}
}


//Disable the template :: ajax request
eZDB::checkTransactionCounter();
eZExecution::cleanExit();
