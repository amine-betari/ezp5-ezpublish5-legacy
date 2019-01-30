<?php 
include_once( "kernel/common/template.php" );
$cli->output("Starting Relance Who s Who email");	
eZLog::write ( 'Début cron relance...', 'bouygues_ww_relance.log', 'var/log');

include_once( "extension/bouygues/classes/ebywhoswho.php" );

$ini = eZINI::instance( 'bouygues.ini' );
$admin_user_id=$ini->variable('UserSettings','AdminUserID');

$debug=$ini->variable('DebugSettings','Debug');
$debugEmail='';
if($debug){
	$debugEmail=$ini->variable('DebugSettings','DebugEmail');
}

$admin_user = eZUser::fetch( $admin_user_id );
eZUser::setCurrentlyLoggedInUser($admin_user,$admin_user_id);

$db = eZDB::instance();


//traitement des messages en attente d'envoie												
$sql = "SELECT * FROM eby_ww_message Where etat = 0";
$recDb = $db->arrayQuery( $sql );

$cli->output($sql);

foreach ( $recDb as $message ){
	$cli->output("Relances trouvées...");
	
	$Wws = explode('|', $message['ww_ids']); $error = false;

	foreach ( $Wws as $ww ){
			
		
			$ww_obj = eZContentObject::fetch($ww);	
			$ww_name = $ww_obj->attribute('name');
			$cli->output("Whos who concerné : ".$ww_name);
			//récupération des utilisateurs de 		
			$sql = "SELECT * FROM eby_ww_user_link 
					WHERE `ww_id` = ".$ww." 
					AND etat=".ebyWhoswho::WW_USER_STATUS_ACCEPTED;
			
			$usersWw = $db->arrayQuery( $sql );
			
			if ($usersWw) {
				$error = false;
				$i=0;
				$arrDataMail = getDataMail($message);
				$arrDataMail['ww_name'] = $ww_name;
				foreach ( $usersWw as $user ){
					if(!sendEmail($user['user_id'],$arrDataMail)){
						$error = true;
					}
					$i++;
				}		
						
			}
	}
	if(!$error){
		$sqlUpdate = "UPDATE eby_ww_message Set etat = 1 Where id = ".$message['id'];
		$recDbUpdate = $db->arrayQuery( $sqlUpdate );
	}										
										
}	


function getDataMail($oMsg){
	global $cli;
	
	//info expediteur
	$oUserExp = eZUser::fetch($oMsg['user_id']);
	$arrData['exp_email'] = $oUserExp->Email;
	$oUserDataExp = eZContentObject::fetch($oMsg['user_id']);
	$dataMap = $oUserDataExp->attribute( 'data_map' );
	$arrData['exp_last_name'] = $dataMap['last_name']->content();
    $arrData['exp_first_name'] = $dataMap['first_name']->content();
    
	//contenu du mail
	$arrData['sujet_fr'] = $oMsg['sujetFr'];
	$arrData['sujet_en'] = $oMsg['sujetEn'];
	$arrData['corps_fr'] = $oMsg['corpsFr'];
	$arrData['corps_en'] = $oMsg['corpsEn'];
	
	//paramétrer envoi mail
	$ini = eZINI::instance();
	$arrData['transport_server'] = $ini->variable( 'MailSettings', 'TransportServer' );
	
	return $arrData;
}	

function sendEmail($user_id,$arrDataMail){
	global $cli;
	global $debug;
	global $debugEmail;
	
	
	//info destinataire
	$oUserDest = eZUser::fetch($user_id);
	if($oUserDest){
		$cli->output('User Email : '. $oUserDest->Email);
		$oContentObject = eZContentObject::fetch($user_id);
		$dataMap = $oContentObject->attribute( 'data_map' );
		$destLastName = $dataMap['last_name']->content();
    	$destFirstName = $dataMap['first_name']->content();
    	$destLangue = $dataMap['langue']->content();
    	
		include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
		$oLocaleSwitcher = new SGLocaleSwitcher();
		$oLocaleSwitcher->setUserLang($oUserDest->Email);

		if($destLangue[0]==1){
			$sujet = $arrDataMail['sujet_en'];
			$corps = $arrDataMail['corps_en'];
		}else{
			$sujet = $arrDataMail['sujet_fr'];
			$corps = $arrDataMail['corps_fr'];
		}
		
		$sTitle = ezpI18n::tr( 'design/bouygues/whoswho', 'email_title1_relance' );
		$sSubtitle = ezpI18n::tr( 'design/bouygues/whoswho', 'email_title2_relance' );
		
		$tpl = templateInit();
		
		$tpl->setVariable( 'first_name', $destFirstName );
		$tpl->setVariable( 'last_name', $destLastName );
		$tpl->setVariable( 'message', $corps );
		$tpl->setVariable( 'email', $oUserDest->Email );
		$tpl->setVariable( 'subtitle', $sSubtitle );
		$tpl->setVariable( 'title', $sTitle );
		
		
		
		$templateResult = $tpl->fetch( 'design:emails/whoswhorelance.tpl' );
		$mail = new eZMail();
		
		$ini = eZINI::instance();
		if ( $tpl->hasVariable( 'content_type' ) )
			$mail->setContentType( $tpl->variable( 'content_type' ) );
    	
		$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
		if ( !$emailSender )
			$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
		
		$mail->setSender( $emailSender );
		$mail->setReceiver( $oUserDest->Email );
		
    	
		$mail->setSubject( $sujet );
		$mail->setBody( $templateResult );

		$mailResult = eZMailTransport::send( $mail );
		unset($mail);
		unset($mailResult);
		unset($templateResult);
		unset($tpl);
		unset($oLocaleSwitcher);
	}
	return true;
}

$cli->output("Opération terminée...");
