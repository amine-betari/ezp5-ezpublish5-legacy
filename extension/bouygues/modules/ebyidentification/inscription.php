<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/ebysubscribeuser.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

// Processus d'inscription
if ( $http->hasPostVariable( "RegisterButton" ) )
{

	if( $http->hasVariable('email_register')) {
	    $emailUser = $http->variable ('email_register');
		$lang = $http->hasVariable('langue')?$http->variable ('langue'):null;
		$newsletter = $http->variable ('newsletter');
	}    
	
	//si format email ok
	if(eZMail::validate($emailUser) ) 
	{

	    //instanciation inscription à Eby
	    $oEby = new ebySubscribeUser();
	    $oEby->emailUser = $emailUser;		
	    $status = $oEby->chkUser($oEby->emailUser);

	    if($status==1)
	    {

			if($aParams = MySOAP::getContactByMailOnly($oEby->emailUser)){
    			//création user état désactivé + envoie email
				$aParams['langue'] = $lang;
				if(is_null($aParams['langue']))
					$aParams['langue'] = (eZLocale::instance()->localeFullCode()=='fre-FR')?0:1;
					
	    		if($oUser = $oEby->createUser($aParams, $newsletter))
	    		{
	    			//envoie email d'activation
	    			if($oEby->sendEmail($oUser))
	    			{
	    				$Module->redirectTo( '/user/success/' );				
					}
	    		}		    			   
		    }else{
				$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_email_error' );
			}	
			
	    }else{
	    	//test si le compte a été importé mais désactivé
	    	$oUsr = eZUser::fetchByEmail($oEby->emailUser);
			$userSetting = eZUserSetting::fetch( $oUsr->attribute( "contentobject_id") );
			
	    	if($userSetting->attribute( "is_enabled" )==0)
	    	{
				
				$aParams['langue'] = $lang;
				if(is_null($aParams['langue']))
					$aParams['langue'] = (eZLocale::instance()->localeFullCode()=='fre-FR')?0:1;
				
				$oContentUser = eZContentObject::fetch($oUsr->ContentObjectID);
				$version = $oContentUser->createNewVersion( false, false);
				$datamap = $version->datamap();
				
				$arrLangue = array('Français','English');
				$datamap['langue']->fromString($arrLangue[$aParams['langue']]);
				$datamap['langue']->store();
				$oContentUser->store();
				$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentUser->attribute( 'id' ),
				                                                             'version'   => $version->attribute( 'version' ) ) );		

				
				$newHash = $oUsr->createHash( $oEby->emailUser, 'passeby', eZUser::site(), $hashType );
			    $oUsr->setAttribute( "password_hash_type", $hashType );
				$oUsr->setAttribute( "password_hash", $newHash );
				$oUsr->store();

				eZContentCacheManager::clearContentCacheIfNeeded( $oUsr->attribute( "contentobject_id") );
			    eZContentCacheManager::generateObjectViewCache( $oUsr->attribute( "contentobject_id") );

				//Create the hash
				eZUserAccountKey::removeByUserID($oUsr->ContentObjectID);
				$oEby->hash = md5( mt_rand() . time() . $oUsr->ContentObjectID );
				$accountKey = eZUserAccountKey::createNew( $oUsr->ContentObjectID, $oEby->hash, time() );
				$accountKey->store();
				
	    		if($oEby->sendEmail($oUsr)){
		    		$Module->redirectTo( '/user/success/' );
	    		}		
	    	}else{
	    		$statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_email_already_registered' );
	    	}
	    }
	}else{ 
	    $statusMessage = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_email_not_valid' );
	
	}
}

$tpl = templateInit();
$tpl->setVariable( 'status_message', $statusMessage );


$title = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_title' );
$text = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'registration_path_text' );

$Result = array();
$Result['content'] = $tpl->fetch( "design:ebyidentification/inscription_form.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => $text,'title' => $title )
);

?>