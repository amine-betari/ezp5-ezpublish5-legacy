<?php
/**
 * process d'inscription
 *
 * @author J. Leger
 * @version $Id: ebysubscribeuser.php
 * @copyright (C) J. Leger 2009
 *
 */
include_once( "extension/bouygues/classes/newsletter.php" );

class ebySubscribeUser
{

   
    var $userGroupIntranet;
    var $userClassId;
    var $sectionId;
    var $hash;
    var $emailUser;
    var $password;
    const PASSWORD_RESET = 'passeby';
    
	public function __construct()
	{
		
		$this->userGroupIntranet = 71;
		$this->userClassId = 4;
		$this->sectionId = 2;
		
	}
	
	public function chkUser($emailUser)
	{
	 	if(eZUser::fetchByEmail($emailUser)){	 		
	 		$status = 2;
	 	}else{
	 		$status = 1;
	 	}
		return $status;
	}
    
	/** 
	 * @ return : array('first_name'=> 'Mike', 'last_name' => 'MYERS'); 
	 * 
	 */
		
	
	public function createUser(array $aParams, $newsletter = '0' , $logout = true)
	{
		
		$login = $this->emailUser;
		
		$this->password = 'passeby';
		
		$class = eZContentClass::fetch( $this->userClassId);
	    $contentObject = $class->instantiate( 14, 2 );
	    $contentObjectId = $contentObject->attribute( 'id' );
	    $dataMap = $contentObject->dataMap();        
	    
	    foreach($aParams as $identifier=>$value)
	    {
	    	$attribute = $dataMap[$identifier];
	        $attribute->setAttribute( 'data_text', $value);
	        $attribute->sync();

	    }        
	    
	    $nodeAssignment = eZNodeAssignment::create( array(
			'contentobject_id' => $contentObjectId,
	        'contentobject_version' => $contentObject->attribute( 'current_version' ),
	        'parent_node' => $this->userGroupIntranet,
			'sort_field' => 2,
	        'sort_order' => 0,
	        'is_main' => 1
	    	));
	
		$nodeAssignment->store();
		
		$version = $contentObject->createNewVersion();
	    $version->setAttribute( 'status', eZContentObjectVersion::STATUS_INTERNAL_DRAFT );
	    $version->store();	
	    
	    $user = new eZUser( $contentObject->attribute( 'id' ) );
	    $user->setAttribute('login', $login );
	    $user->setAttribute('email', $this->emailUser );
	    $hashType = eZUser::hashType() . "";
	
	    $newHash = $user->createHash( $login, $this->password, eZUser::site(), $hashType );
	    $user->setAttribute( "password_hash_type", $hashType );
		$user->setAttribute( "password_hash", $newHash );
		$user->store();
	
				
		$operationResult = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $contentObjectId, 'version' => 1 ) );
	    //on assigne la section 
	    $object = eZContentObject::fetch( $contentObjectId, true);
	    
	    eZContentObjectTreeNode::assignSectionToSubTree( $contentObject->attribute( 'main_node_id' ), $this->sectionId);
	
	     // Log out user courant
		 if($logout)
		 {	
		 	eZUser::logoutCurrent();
		 }
	
	    // Create enable account hash and send it to the newly registered user
		$this->hash = md5( mt_rand() . time() . $contentObject->attribute( 'id' ) );
		$accountKey = eZUserAccountKey::createNew( $contentObject->attribute( 'id' ),$this->hash, time() );
		$accountKey->store();
	 			
	    //utilisateur désactivé
	    $userSetting = eZUserSetting::fetch( $contentObject->attribute( 'id' ) );
	    $userSetting->setAttribute( "is_enabled", 0 );
	    $userSetting->store();   

		//Newsletter eby
		if($newsletter == '1'){
			$newsletterObj = new newsletter();
			
			$newsletterTypeObj = new eZNewsletterType();
			$newsletterTypeObj->setAttribute( 'id', 1 );
			$subscriptionList = $newsletterTypeObj->subscriptionList();
			
			$newsletterObj->addSubscription($subscriptionList[0]->SubscriptionID, $contentObject->attribute( 'id' ));
		}
		
	    eZLog::write ( 'Création compte e.by :'.$this->emailUser, 'bouygues_ebyidentification.log', 'var/log');
	    
	    return $user;
	}
	
	
	public function setUser(array $aParams)
	{
		$db = eZDB::instance();
		$db->begin();
		$emailChange = false;
		
		$oUser = eZUser::currentUser();
		$login = $oUser->Login;
		$oContentUser = eZContentObject::fetch($oUser->ContentObjectID);
		
		
		
		if(eZMail::validate($aParams['email_register']) ) 
		{
			$login = $oUser->attribute( "login" );
			$type = $oUser->attribute( "password_hash_type" );
			$hash = $oUser->attribute( "password_hash" );
			$site = $oUser->site();
			$ini = eZINI::instance();
			
			$version = $oContentUser->createNewVersion( false, false, 'fre-FR' );
			$datamap = $version->datamap();
			
			$newPassword=trim($aParams['newPassword']);
			$confirmPassword=trim($aParams['confirmPassword']);
			
			if ( $newPassword == "" )
			{
	                $newPassword = false;
					eZDebug::writeNotice( 'Password empty', 'bouygues:classes/ebysubscribeuser.php');	                
			}
							
			$arrLangue = array('Français','English');
			$datamap['langue']->fromString($arrLangue[$aParams['langue']]);
			$datamap['langue']->store();

			//changement d'email => changement de login => process de revalidation password (email)
			if($aParams['email_register']!=$login)
			{
				if ( eZUser::fetchByName( $aParams['email_register'] ) || eZUser::fetchByEmail( $aParams['email_register']  ) )
			    {
					eZDebug::writeNotice( 'Email existe deja', 'bouygues:classes/ebysubscribeuser.php');										         	
					return false;
				}
				
				//if ($newPassword  &&  $newPassword == $confirmPassword )
				//{
					
					
					$userSetting = eZUserSetting::fetch( $oUser->ContentObjectID );
					$userSetting->setAttribute( "is_enabled", false );
				    $userSetting->store();
				
					$newPassword = 'passeby';
				
					$oUser->setAttribute( 'login', $aParams['email_register'] );
					$oUser->setAttribute( 'email', $aParams['email_register'] );
					$login = $aParams['email_register'];
					$oUser->store();	
							             
					$newHash = $oUser->createHash( $login, $newPassword, $site, $type );
					$oUser->setAttribute( "password_hash", $newHash );
					$oUser->setAttribute( "password_hash_type", $type );
					$oUser->store();
							             
					$hashEmail = md5( mt_rand() . time() . $oUser->ContentObjectID );
					$accountKey = eZUserAccountKey::createNew( $oUser->ContentObjectID,$hashEmail, time() );
					$accountKey->store();
							             
					$emailUser=$login;
					$emailChange=true;
					
					

				//}	
			}
			
			
		    
			if ($newPassword  &&  $newPassword == $confirmPassword )
			{
				$minPasswordLength = $ini->hasVariable( 'UserSettings', 'MinPasswordLength' ) ? $ini->variable( 'UserSettings', 'MinPasswordLength' ) : 3;
		
				if ( strlen( $newPassword ) < $minPasswordLength )
				{
					$newPasswordTooShort = 1;
					eZDebug::writeNotice( 'Password too short', 'bouygues:classes/ebysubscribeuser.php');
					return false;
								                
		        }else{
					$newHash = $oUser->createHash( $login, $newPassword, $site, $type );
					$oUser->setAttribute( "password_hash", $newHash );
					$oUser->store();
				}
		            
			}
			
			$oContentUser->store();
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentUser->attribute( 'id' ),
			                                                             'version'   => $version->attribute( 'version' ) ) );		
			$db->commit();
			
			if($emailChange){
				include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
				$oLocaleSwitcher = new SGLocaleSwitcher();

				$oLocaleSwitcher->setUserLang($emailUser);
				
				//Send the activation email
				$subject = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_changeemail_subject' );
				$tpl = templateInit();

				$tpl->setVariable( 'title', ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_changeemail_title1' ) );
				$tpl->setVariable( 'subtitle', ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_changeemail_title2' ) );

				$tpl->setVariable( 'user', $oUser );
		    	$tpl->setVariable( 'object', $oContentUser );
				$tpl->setVariable( 'hash', $hashEmail );
				
			    $templateResult = $tpl->fetch( 'design:emails/changeemail.tpl' );
				
				$mail = new eZMail();

				$ini = eZINI::instance();
				if ( $tpl->hasVariable( 'content_type' ) )
					$mail->setContentType( $tpl->variable( 'content_type' ) );
				$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
				if ( !$emailSender )
					$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
				$mail->setSender( $emailSender );
				$mail->setReceiver( $emailUser );
				

				$mail->setSubject( $subject );
				$mail->setBody( $templateResult );
				$mailResult = eZMailTransport::send( $mail );
				
				unset($oLocaleSwitcher);
				
				return 2;
				
			}
					
			return 1;
		}
	 	
	}
	
	
	public function sendEmail( $oUser)
	{
		include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
		$oLocaleSwitcher = new SGLocaleSwitcher();
		
		$oLocaleSwitcher->setUserLang($this->emailUser);
		
		$object = eZContentObject::fetch( $oUser->ContentObjectID );
		$user = eZUser::fetch( $oUser->ContentObjectID );
		$tpl = templateInit();
		
		$tpl->setVariable( 'title', ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_title1' ) );
		$tpl->setVariable( 'subtitle', ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_title2' ) );
		
		
		
		$tpl->setVariable( 'user', $user );
    	$tpl->setVariable( 'object', $object );
    	$hostname = eZSys::hostname();
    	$tpl->setVariable( 'hostname', $hostname );
		$tpl->setVariable( 'hash', $this->hash );
	    $templateResult = $tpl->fetch( 'design:emails/registrationinfo.tpl' );
		 
		
		$mail = new eZMail();
		
		$ini = eZINI::instance();
		if ( $tpl->hasVariable( 'content_type' ) )
			$mail->setContentType( $tpl->variable( 'content_type' ) );
		$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
		if ( !$emailSender )
			$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
		$mail->setSender( $emailSender );
		$mail->setReceiver( $this->emailUser );
		$subject = ezpI18n::tr( 'extension/bouygues/ebyidentification', 'email_touser_subject' );
		
		$mail->setSubject( $subject );
		$mail->setBody( $templateResult );
		$mailResult = eZMailTransport::send( $mail );
		
		unset($oLocaleSwitcher);
		return true;
	}
   

}

?>