<?php

include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];

$lang = (eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en';

// Processus de login automatique
if ( $Params['uri'] )
{

	$newsletterUser = false;
	if($Params['uri'] == 'yournewsletter'){
		$userData = eZUserSubscriptionData::fetchByHash( $Params['hash'] );
		if ( !$userData )
			header('Location: '.$lang.'/user/login');
		$oUsr = eZUser::fetchByEmail($userData->attribute( 'email' ));
		$newsletterUser = true;
	}else
		$oUsr = eZUser::fetchByEmail($Params['email']);	
	

	if($oUsr->PasswordHash == $Params['hash'] || $newsletterUser == true)
		eZUser::setCurrentlyLoggedInUser( $oUsr, $oUsr->attribute( 'contentobject_id' ) );

	if($Params['uri'] == 'update')
		header('Location: '.$lang.'/ebyidentification/'.$Params['uri']);
	else
		header('Location: '.$lang.'/profile/'.$Params['uri']);
}else
	header('Location: '.$lang.'/user/login');

?>