<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );

$Module = $Params["Module"];
$Result = array();
$oHTTP = eZHTTPTool::instance();

// Get the variable action, from post
if ( $oHTTP->hasVariable( 'action' ) ) 
{
	$sAction = $oHTTP->variable( 'action' );
}

if ( isset( $sAction ) )
{
	if ( $sAction == 'checkemail' )
	{
		if ( $oHTTP->hasVariable( 'sender_email' ) )
		{
			$sSenderEmail = $oHTTP->getVariable( 'sender_email' );
		}
		elseif ( $oHTTP->hasVariable( 'email' ) )
		{
			$sSenderEmail =	$oHTTP->getVariable( 'email' );
		}
		echo MySOAP::isGalbyEmailValid( $sSenderEmail );
	}
	elseif ( $sAction == 'checkemails' )
	{
		$emails = $oHTTP->getVariable( 'email' );
		$return = "true";
		$aEmails = explode(';',$emails);
		foreach( $aEmails as $email )
		{
			// Check if $email are in GALBY and then send
			$isEmailValid = MySOAP::isGalbyEmailValid($email);
			if ( $isEmailValid == "false" )
			{
				$return = $isEmailValid;
			}
		}
		
		echo  $return;
	}
	else
	{
		$sName = $oHTTP->postVariable( 'name' );
		$sSenderEmail =	$oHTTP->postVariable( 'sender_email' );
		$sEmails = $oHTTP->postVariable( 'email' );
		$content = $oHTTP->postVariable( 'content' );
		$sURL =	$oHTTP->postVariable( 'url' );
		$fullURL = $sURL;
		
		$urlWithoutHTTP = explode('https://', $sURL);
		$urlSplit = explode('/', $urlWithoutHTTP[1]);
		
		if(count($urlSplit) > 3)
			$sURL = 'https://'.$urlSplit[0].'/'.$urlSplit[1].'/.../'.$urlSplit[count($urlSplit)-1];
		
		
		$aEmails = explode(';',$sEmails);
		
		$returnString = nl2br(ezpI18n::tr( 'design/bouygues/sendtofriend', 'confirmation' ));
		
		include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
		$oLocaleSwitcher = new SGLocaleSwitcher();
		
		foreach( $aEmails as $iKey => $sEmail )
		{
			// Check if $email are in GALBY and then send
			$isEmailValid = MySOAP::isGalbyEmailValid( trim($sEmail) );
			if ( $isEmailValid == 'true' )
			{
				// ========================================================
				$oLocaleSwitcher->setUserLang($sEmail);
				// ========================================================
				
				// Building mail in the expected language
				$oMailTemplate = templateInit();
						
				$sTitle = ezpI18n::tr( 'design/bouygues/sendtofriend', 'email_title1' );
				$sSubtitle = ezpI18n::tr( 'design/bouygues/sendtofriend', 'email_title2' );
				
				$oMailTemplate->setVariable( 'url', $sURL );
				$oMailTemplate->setVariable( 'fullURL', $fullURL );
		    	$oMailTemplate->setVariable( 'sender', $sName );
		    	$oMailTemplate->setVariable( 'content', $content );

				$oMailTemplate->setVariable( 'title', $sTitle );
				$oMailTemplate->setVariable( 'subtitle', $sSubtitle );
				
				$sTemplateResult = $oMailTemplate->fetch( 'design:emails/sendtofriend.tpl' );
				$oMail = new eZMail();
				
				if ( $oMailTemplate->hasVariable( 'content_type' ) )
				{
					$oMail->setContentType( $oMailTemplate->variable( 'content_type' ) );
				}
				
				$oMail->setSender( $sSenderEmail );
				$oMail->setReceiver( $sEmail );
				
				$sSubject1 = ezpI18n::tr( 'design/bouygues/sendtofriend', 'email_subject1' );
				$sSubject2 = ezpI18n::tr( 'design/bouygues/sendtofriend', 'email_subject2' );
				$sSubject = $sName . ' ' . $sSubject1;
				unset( $sSubject1, $sSubject2 );
		
				$oMail->setSubject( $sSubject );
				$oMail->setBody( $sTemplateResult );
				
				$sMailResult = eZMailTransport::send( $oMail );
				
				unset( $oMailTemplate, $oMail, $sTemplateResult, $sTitle, $sSubtitle, $sSubject );
				
				
			}	
		}
		unset( $oLocaleSwitcher ); // Very important unset since the destructor reset to original locale
		echo $returnString;
	
	}
	
	// Disable the template :: ajax request
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
}
else
{	
	$sURL =	$oHTTP->getVariable( 'url' );

	$oTemplate = templateInit();
	$oTemplate->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

	// Get the user information
	$oUser = eZUser::currentUser();
	if ( $oUser->isLoggedIn() )
	{
		$oTemplate->setVariable( 'currentUser', $oUser );
	}

	$oTemplate->setVariable( 'url', $sURL );

	$Result['content'] = $oTemplate->fetch( "design:tools/sendtofriend.tpl" );
	$Result['path'] = array(
	array(
			'url' => false,
			'text'  => 'Envoi à un ami'
		) 
	);
}
