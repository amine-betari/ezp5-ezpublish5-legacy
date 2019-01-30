<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/ebysubscribeuser.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

// Processus de mise à jour
if ( $http->hasPostVariable( "RegisterButton" ) )
{

	if( $http->hasVariable('email_register')) {
	    $emailUser = $http->variable ('email_register');
	}    
	
	$oUser = eZUser::currentUser();
	$oContentUser = eZContentObject::fetch($oUser->ContentObjectID);
	
	$dataMap = $oContentUser->attribute('data_map');
	$no_galby_sync = $dataMap['no_galby_sync']->content();
	$galby_status = MySOAP::getContactByMailOnly($emailUser);
	//si format email ok
	if(eZMail::validate($emailUser) && ($galby_status || $no_galby_sync == 1)) 
	{
			$oEby = new ebySubscribeUser();
	    	$oEby->emailUser = $emailUser;	
	   
	    	//modification
	    	$aParams['email_register'] = $http->postVariable('email_register');
	    	$aParams['newPassword'] = $http->postVariable('newPassword');
	    	$aParams['confirmPassword'] = $http->postVariable('confirmPassword');
	    	$aParams['langue'] = $http->postVariable('langue');
	    	
	    	if(!$checkSet = $oEby->setUser($aParams))
	    	{
				echo 3;
				//$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_email_already_registered' );
				
	    	}else{
				
				
			}
	}elseif(!$galby_status)
		echo 4;//$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_galby_error' );
	else
		echo 5;//$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_email_not_valid' );
	
	echo $checkSet;
	
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
}

$tpl = templateInit();
if(MySOAP::isEmailGalbyError())
	$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_galby_error' );


$tpl->setVariable( 'status_message', $statusMessage );

$Result = array();
$Result['content'] = $tpl->fetch( "design:user/edit.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_profile' ) )
);

?>