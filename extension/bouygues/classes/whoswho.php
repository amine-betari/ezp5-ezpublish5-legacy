<?php
/**
 * API de gestion drag and drop
 *
 * @author J. Leger
 * @version $Id: ebyperso.php
 * @copyright (C) J. Leger 2009
 *
 */
include_once( "extension/bouygues/classes/ebyuseraccess.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );

class whoswho
{
   
    var $userId;    
    protected $db;
    protected $fields;
	
    
	public function __construct()
	{
		
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();
		$this->fields = array(
			'civilite' => 				array( 'searchType' => 'select', 'searchable' => true, 'mandatory' => false ),
			'first_name' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'last_name' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'user_account' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'image' => 					array( 'searchType' => 'input', 'searchable' => false, 'mandatory' => false ),
			'fonction' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'direction' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'service' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'entreprise' => 			array( 'searchType' => 'select', 'searchable' => true, 'mandatory' => false ),
			'filiale' => 				array( 'searchType' => 'select', 'searchable' => true, 'mandatory' => false ),
			'filiale_autre' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'secteur' => 				array( 'searchType' => 'select', 'searchable' => true, 'mandatory' => false ),
			'pro_adresse' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'emplacement' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'user_account' => 			array( 'searchType' => 'input', 'searchable' => false, 'mandatory' => false ),
			'pro_tel' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'pro_mobile' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'pro_fax' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'assistante_nom' => 		array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'assistante_tel' => 		array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'date_naissance' => 		array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'date_entree' => 			array( 'searchType' => 'input', 'searchable' => false, 'mandatory' => false ),
			'diplome' => 				array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'parcours_pro' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'mission_actuelle' => 		array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'mission_precedente' => 	array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'competences' => 			array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false ),
			'centres_interet' => 		array( 'searchType' => 'input', 'searchable' => true, 'mandatory' => false )
		);

	}
	
	public function getSubscription($userId = null, $whoswho = null){
		if(is_null($userId))
			$userId = $this->userId;
		
	    $sql = "SELECT * FROM eby_ww_user_link WHERE user_id = '".$userId."' AND etat = 1";
	    if(!is_null($whoswho))
			$sql .= " AND ww_id = ".$whoswho.""; 

		$resArray = $this->db->arrayQuery( $sql );

		$arrReturn = array(); $i = 0;
	    // Affichage des résultats en HTML
	    foreach($resArray as $res) {
	    	$arrReturn[$i++] = $res;
	    }
	    
	    return $arrReturn; 
	    
	}
	
	public function addSubscription($whoswho, $userId = null, $message = ''){
		if(is_null($userId))
			$userId = $this->userId;
			
		$sqlCheck = "SELECT * FROM eby_ww_user_link WHERE user_id = '".$userId."'";
	    $sqlCheck .= " AND ww_id = ".$whoswho." AND etat = 2"; 
	    
		$resArrayCheck = $this->db->arrayQuery( $sqlCheck );
		
		if(count($resArrayCheck) == 0)
			$sql = "INSERT INTO eby_ww_user_link (user_id, ww_id, etat, dt_etat, admin_id, liste) VALUES (".$userId.", ".$whoswho.", 0, NOW(), null, 0) ";
		else
			$sql = "UPDATE eby_ww_user_link set etat = 0 WHERE user_id=".$userId." AND ww_id=".$whoswho;

		if($this->db->query( $sql )){
			
			//Check if the whos who data are already stored
			$resArray = $this->db->arrayQuery( "SELECT user_id FROM eby_ww_user WHERE user_id = ".$userId );
			
			$ww_obj = eZContentObject::fetch($whoswho);
			$current_user_obj = eZContentObject::fetch($userId);
			$current_user = eZUser::fetch( $userId );
			$section_id = $ww_obj->attribute('section_id');
			$adminUsers = ebyUserAccess::getAdminList($section_id);
			$dataMap = $current_user_obj->attribute('data_map');
			$tpl = templateInit();
			
			
			include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
			$oLocaleSwitcher = new SGLocaleSwitcher();
			foreach($adminUsers as $adminuser){
				
				$oLocaleSwitcher->setUserLang($adminuser['email']);
				
				$title = ezpI18n::tr( 'design/bouygues/whoswho', 'email_request_title1' );
				$subject = ezpI18n::tr( 'design/bouygues/whoswho', 'email_request_subject' );

				$tpl->setVariable( 'currentLang', $oLocaleSwitcher->currentLocale );
				$tpl->setVariable( 'title', $title );
				$tpl->setVariable( 'subtitle', $ww_obj->attribute('name'));
				$tpl->setVariable( 'whoswho', $ww_obj->attribute('name'));
				
				$tpl->setVariable( 'first_name', $dataMap['first_name']->content() );
				$tpl->setVariable( 'last_name', $dataMap['last_name']->content() );
				$tpl->setVariable( 'email', $current_user->attribute('email') );
				$tpl->setVariable( 'message', $message );
				$tpl->setVariable( 'admin_first_name', $adminuser['first_name'] );
				$tpl->setVariable( 'admin_last_name', $adminuser['last_name'] );
				
				$templateResult = $tpl->fetch( 'design:emails/whoswhorequest.tpl' );
				$mail = new eZMail();
				
				$ini = eZINI::instance();
				if ( $tpl->hasVariable( 'content_type' ) )
					$mail->setContentType( $tpl->variable( 'content_type' ) );

				$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
				if ( !$emailSender )
					$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );

				$mail->setSender( $emailSender );
				$mail->setReceiver( $adminuser['email'] );
				
				$mail->setSubject( $subject.' '.$ww_obj->attribute('name') );
				$mail->setBody( $templateResult );

				$mailResult = eZMailTransport::send( $mail );
				unset($mail);
				unset($mailResult);
				unset($templateResult);
				
			}
			unset($oLocaleSwitcher);
			
			if(count($resArray) == 0){
				//Get data from Annuaire Groupe
				$data = array(
								fonction => '',
								direction => '',
								service => '',
								pro_adresse => '',
								emplacement => '',
								pro_tel => '',
								pro_mobile => '',
								pro_fax => '',
								assistante_nom => '',
								assistante_tel => '',
								date_entree => '',
								date_naissance => '',
								diplome => '',
								parcours_pro => '',
								mission_actuelle => '',
								mission_precedente => '',
								competences => '',
								centres_interet => '',
								entreprise => '',
								filiale => '',
								secteur => '',
								filiale_autre => '');
				
				$annuaireResults = MySOAP::searchCollaborator($dataMap['last_name']->content(),$dataMap['first_name']->content());
				if(count($annuaireResults['result']) == 1){
					foreach($annuaireResults['result'] as $key => $userData)
						if(count($userData['users']) == 1){
							$data = array(
											fonction => htmlspecialchars(addslashes($userData['users'][0]['personalTitle'])),
											direction => htmlspecialchars(addslashes($userData['users'][0][''])),
											service => htmlspecialchars(addslashes($userData['users'][0]['workSite'])),
											pro_adresse => htmlspecialchars(addslashes($userData['users'][0]['location'])),
											emplacement => htmlspecialchars(addslashes($userData['users'][0][''])),
											pro_tel => htmlspecialchars(addslashes($userData['users'][0]['telephoneNumber'])),
											pro_mobile => htmlspecialchars(addslashes($userData['users'][0]['mobile'])),
											pro_fax => htmlspecialchars(addslashes($userData['users'][0]['facsimileTelephonenumber'])),
											assistante_nom => htmlspecialchars(addslashes($userData['users'][0]['secretaryName'])),
											assistante_tel => htmlspecialchars(addslashes($userData['users'][0]['secretaryPhone'])),
											date_entree => '',
											date_naissance => '',
											diplome => '',
											parcours_pro => '',
											mission_actuelle => '',
											mission_precedente => '',
											competences => '',
											centres_interet => '',
											entreprise => htmlspecialchars(addslashes($userData['users'][0]['company'])),
											filiale => '',
											secteur => '',
											filiale_autre => htmlspecialchars(addslashes($userData['users'][0]['organizationalUnit'])));
						}
				}
				
				
				$this->setData($data, null, true);
			}		
			
			return true;
		}
	}
	
	public function hasSubscribed($whoswho, $userId = null, $etat = 0){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sql = "SELECT * FROM eby_ww_user_link WHERE user_id = '".$userId."'";
	    $sql .= " AND ww_id = ".$whoswho." AND etat = ".$etat; 

		$resArray = $this->db->arrayQuery( $sql );
		
		if(count($resArray) == 0)
			return false;
			
		return true;
		
	}
	
	public function hasSubscribedAtLeastOnce($user_id){
	
		if(is_null($user_id))
			$user_id = $this->userId;
		
		$sql = "SELECT ww_id FROM eby_ww_user_link WHERE user_id = '".$user_id."'";
	    $sql .= " AND etat = 1 ORDER BY dt_etat DESC"; 

		$resArray = $this->db->arrayQuery( $sql );
		
		if(count($resArray) == 0)
			return false;
			
		return $resArray[0]['ww_id'];
	}
	
	public function delSubscription($whoswho, $userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sql = "DELETE FROM eby_ww_user_link WHERE user_id = ".$userId." AND ww_id = ".$whoswho." ";
	    
		if($this->db->query( $sql )){
			
			//Set the section of the user
			include_once( "extension/bouygues/classes/ebywhoswho.php" );
			$ebyWw = new ebyWhoswho();
			$ebyWw->setUserSection($userId);
			
			//Send email to all webmaster of the whos who section
			$ww_obj = eZContentObject::fetch($whoswho);
			$current_user_obj = eZContentObject::fetch($userId);
			$current_user = eZUser::fetch( $userId );
			$section_id = $ww_obj->attribute('section_id');
			$adminUsers = ebyUserAccess::getAdminList($section_id);
			$dataMap = $current_user_obj->attribute('data_map');
			$tpl = templateInit();
			
			include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
			$oLocaleSwitcher = new SGLocaleSwitcher();
			foreach($adminUsers as $adminuser){
				
				$oLocaleSwitcher->setUserLang($adminuser['email']);
				
				$title = ezpI18n::tr( 'design/bouygues/whoswho', 'email_unsubscribe_title1' );
				$subject = ezpI18n::tr( 'design/bouygues/whoswho', 'email_unsubscribe_subject' );

				$tpl->setVariable( 'title', $title );
				$tpl->setVariable( 'subtitle', $ww_obj->attribute('name'));
				$tpl->setVariable( 'whoswho', $ww_obj->attribute('name'));
				
				$tpl->setVariable( 'first_name', $dataMap['first_name']->content() );
				$tpl->setVariable( 'last_name', $dataMap['last_name']->content() );
				$tpl->setVariable( 'email', $current_user->attribute('email') );
				$tpl->setVariable( 'admin_first_name', $adminuser['first_name'] );
				$tpl->setVariable( 'admin_last_name', $adminuser['last_name'] );
				
				$templateResult = $tpl->fetch( 'design:emails/whoswhounsubscribe.tpl' );
				$mail = new eZMail();
				
				$ini = eZINI::instance();
				if ( $tpl->hasVariable( 'content_type' ) )
					$mail->setContentType( $tpl->variable( 'content_type' ) );

				$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
				if ( !$emailSender )
					$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );

				$mail->setSender( $emailSender );
				$mail->setReceiver( $adminuser['email'] );
				

				$mail->setSubject( $subject.' '.$ww_obj->attribute('name') );
				$mail->setBody( $templateResult );

				$mailResult = eZMailTransport::send( $mail );
				unset($mail);
				unset($mailResult);
				unset($templateResult);
				
			}
			unset($oLocaleSwitcher);
			return true;
		}
	}
	
	public function setSubscription($whoswho, $status, $userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sql = "UPDATE INTO eby_ww_user_link SET etat = ".$status." WHERE user_id = ".$userId." AND ww_id = ".$whoswho." AND dt_etat = NOW() ";
	    
		if($this->db->query( $sql )) return true;
	}

	public function getData($userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
	    $sql = "SELECT * FROM eby_ww_user WHERE user_id = '".$userId."'";
	    
		$resArray = $this->db->arrayQuery( $sql );
		
		if(count($resArray) > 0)
			return $resArray[0];
		else
			return array();
	}
	
	public function getRandomUser($whoswho){
		
	    $sql = "SELECT user_id FROM eby_ww_user_link WHERE ww_id = '".$whoswho."' AND etat = 1 ORDER BY RAND() LIMIT 1";

		$resArray = $this->db->arrayQuery( $sql );

	    foreach($resArray as $res) {
	    	return $res['user_id'];
	    }
	    
	    return false; 
	    
	}
	
	public function setData($data, $userId = null, $booAnnuaire = false){
		
		if(is_null($userId))
			$userId = $this->userId;
		
		$this->db->begin();
			
	    $sql = "SELECT * FROM eby_ww_user WHERE user_id = '".$userId."'";
	    
		$resArray = $this->db->arrayQuery( $sql );
		
		$dob='NULL';
		$arrDob = explode('/',$data['date_naissance']);
		if(checkdate( $arrDob[1], $arrDob[0], $arrDob[2]))
		{
			$dob = "'".htmlspecialchars(addslashes($arrDob[2]."-".$arrDob[1]."-".$arrDob[0]))."'";	                     
		}
		$dateEntree='NULL';
		$arrDE = explode('/',$data['date_entree']);
		if(checkdate( $arrDE[1], $arrDE[0], $arrDE[2]))
		{
			$dateEntree = "'".htmlspecialchars(addslashes($arrDE[2]."-".$arrDE[1]."-".$arrDE[0]))."'";	                     
		}
		
		if(count($resArray) == 0)
		{
			$sqlUpdate = "INSERT INTO eby_ww_user (user_id,
					fonction,
					direction,
					service,
					pro_adresse,
					emplacement,
					pro_tel,
					pro_mobile,
					pro_fax,
					assistante_nom,
					assistante_tel,
					date_entree,
					diplome,
					parcours_pro,
					mission_actuelle,
					mission_precedente,
					competences,
					centres_interet,
					entreprise,
					filiale,
					secteur,
					filiale_autre,
					date_naissance) VALUES(
				'".addslashes($userId)."',
				'".htmlspecialchars(addslashes($data['fonction']))."',
				'".htmlspecialchars(addslashes($data['direction']))."',
				'".htmlspecialchars(addslashes($data['service']))."',
				'".htmlspecialchars(addslashes($data['pro_adresse']))."',
				'".htmlspecialchars(addslashes($data['emplacement']))."',
				'".htmlspecialchars(addslashes($data['pro_tel']))."',
				'".htmlspecialchars(addslashes($data['pro_mobile']))."',
				'".htmlspecialchars(addslashes($data['pro_fax']))."',
				'".htmlspecialchars(addslashes($data['assistante_nom']))."',
				'".htmlspecialchars(addslashes($data['assistante_tel']))."',
				".$dateEntree.",
				'".htmlspecialchars(addslashes($data['diplome']))."',
				'".htmlspecialchars(addslashes($data['parcours_pro']))."',
				'".htmlspecialchars(addslashes($data['mission_actuelle']))."',
				'".htmlspecialchars(addslashes($data['mission_precedente']))."',
				'".htmlspecialchars(addslashes($data['competences']))."',
				'".htmlspecialchars(addslashes($data['centres_interet']))."',
				'".htmlspecialchars(addslashes($data['entreprise']))."',
				'".htmlspecialchars(addslashes($data['filiale']))."',
				'".htmlspecialchars(addslashes($data['secteur']))."',
				'".htmlspecialchars(addslashes($data['filiale_autre']))."',
				".$dob."
			)";
		}else{
			$sqlUpdate = "UPDATE eby_ww_user SET 
					fonction = '".htmlspecialchars(addslashes($data['fonction']))."',
					direction = '".htmlspecialchars(addslashes($data['direction']))."',
					service = '".htmlspecialchars(addslashes($data['service']))."',
					pro_adresse = '".htmlspecialchars(addslashes($data['pro_adresse']))."',
					emplacement = '".htmlspecialchars(addslashes($data['emplacement']))."',
					pro_tel = '".htmlspecialchars(addslashes($data['pro_tel']))."',
					pro_mobile = '".htmlspecialchars(addslashes($data['pro_mobile']))."',
					pro_fax = '".htmlspecialchars(addslashes($data['pro_fax']))."',
					assistante_nom = '".htmlspecialchars(addslashes($data['assistante_nom']))."',
					assistante_tel = '".htmlspecialchars(addslashes($data['assistante_tel']))."',
					date_entree = ".$dateEntree.",
					date_naissance = ".$dob.",
					diplome = '".htmlspecialchars(addslashes($data['diplome']))."',
					parcours_pro = '".htmlspecialchars(addslashes($data['parcours_pro']))."',
					mission_actuelle = '".htmlspecialchars(addslashes($data['mission_actuelle']))."',
					mission_precedente = '".htmlspecialchars(addslashes($data['mission_precedente']))."',
					competences = '".htmlspecialchars(addslashes($data['competences']))."',
					centres_interet = '".htmlspecialchars(addslashes($data['centres_interet']))."',
					entreprise = '".htmlspecialchars(addslashes($data['entreprise']))."',
					filiale = '".htmlspecialchars(addslashes($data['filiale']))."',
					secteur = '".htmlspecialchars(addslashes($data['secteur']))."',
					filiale_autre = '".htmlspecialchars(addslashes($data['filiale_autre']))."',
					dt_etat = NOW() 
					WHERE user_id = ".$userId;
		}
		
		if($this->db->query( $sqlUpdate ))
		{
			//Set the picture if not null and set email and login if email != email_old
			$oContentUser = eZContentObject::fetch($userId);
			$version = $oContentUser->createNewVersion( false, false, 'fre-FR' );
			$datamap = $version->datamap();
			
			if(is_array($data['civilite']) && count($data['civilite'])>0)
			{
				$options = $datamap['civilite']->contentClassAttribute()->content();
		    	$civilite= $options['options'][$data['civilite'][0]]['name'];//echo $civilite;
		    	$datamap['civilite']->fromString($civilite);
				$datamap['civilite']->store();
			}
			
			if(eZMail::validate($data['email']) ) 
			{
				$oUser = eZUser::fetch($userId);
				$oUser->setInformation ($userId, $data['email'], $data['email']);
				$oUser->store();
			}
			
			if(isset($data['picture']) && is_array($data['picture']))
			{
				$datamap['image']->fromString($data['picture']['tmp_name']);
				$datamap['image']->store();
			}
			
			$oContentUser->store();
			
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentUser->attribute( 'id' ),
			                                                                    'version'   => $version->attribute( 'version' ) ) );		
			
			$this->db->commit();
			
			//Send email to all webmaster of the whos who to which this user has suscribed
			
			$current_user = eZUser::fetch( $userId );
			$sqlWhoswho = "SELECT ww_id FROM eby_ww_user_link WHERE user_id = ".$userId." AND etat = 1";
			
			$resArrayWhoswho = $this->db->arrayQuery( $sqlWhoswho );
			$sectionArray = array(); $wwList = array();
			foreach($resArrayWhoswho as $whoswho){
				$ww_obj = eZContentObject::fetch($whoswho['ww_id']);
				$wwList[] = $ww_obj->attribute('name');
				$sectionArray[] = $ww_obj->attribute('section_id');
			}

			$adminUsers = ebyUserAccess::getAdminList($sectionArray);
			$dataMapEmail = $oContentUser->attribute('data_map');
			
			$tpl = templateInit();
			
			
			if(!$booAnnuaire){
			
				include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
				$oLocaleSwitcher = new SGLocaleSwitcher();
				foreach($adminUsers as $adminuser){
					
					$oLocaleSwitcher->setUserLang($adminuser['email']);
					
					$title = ezpI18n::tr( 'design/bouygues/whoswho', 'email_update_title1' );
					$subtitle = ezpI18n::tr( 'design/bouygues/whoswho', 'email_update_title2' );
					$subject = ezpI18n::tr( 'design/bouygues/whoswho', 'email_update_subject' );
            	
					$tpl->setVariable( 'title', $title );
					$tpl->setVariable( 'subtitle', $subtitle);
					$tpl->setVariable( 'user_id', $userId);
					$tpl->setVariable( 'wwList', $wwList);
					
					$tpl->setVariable( 'first_name', $dataMapEmail['first_name']->content() );
					$tpl->setVariable( 'last_name', $dataMapEmail['last_name']->content() );
					$tpl->setVariable( 'email', $current_user->attribute('email') );
					$tpl->setVariable( 'admin_first_name', $adminuser['first_name'] );
					$tpl->setVariable( 'admin_last_name', $adminuser['last_name'] );
					
					//All whos who fields
					$whowhoData = self::fetch($userId, 0);
					
					$arrData = array();
					foreach($whowhoData[0] as $key => $value){
						if($key <> 'user_id' && $key <> 'dt_etat' && $key <> 'etat' && $value <> '' && $key <> 'age_by'){
							if($this->fields[$key]['searchType'] == 'select'){
								$value2 = self::fetchOptionValue($value);
								if($value2 <> '') {
									$arrData[$key]['value'] =  $value2;
									$arrData[$key]['label'] =  ezpI18n::tr( 'extension/bouygues/whoswho', $key );
								}
							}else{
								$arrData[$key]['label'] =  ezpI18n::tr( 'extension/bouygues/whoswho', $key );
								
								if($key == 'date_naissance' || $key == 'date_entree')
									$arrData[$key]['value'] =  substr($value, 8,2).'-'.substr($value, 5,2).'-'.substr($value, 0,4);
								else
									$arrData[$key]['value'] =  $value;
							}
						}
					}
					
					$tpl->setVariable( 'dataUpdated', $arrData );
					
					$templateResult = $tpl->fetch( 'design:emails/whoswhoupdate.tpl' );
					$mail = new eZMail();
					
					$ini = eZINI::instance();
					if ( $tpl->hasVariable( 'content_type' ) )
						$mail->setContentType( $tpl->variable( 'content_type' ) );
            	
					$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
					if ( !$emailSender )
						$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
            	
					$mail->setSender( $emailSender );
					$mail->setReceiver( $adminuser['email'] );
					
            	
					$mail->setSubject( $subject);
					$mail->setBody( $templateResult );
            	
					$mailResult = eZMailTransport::send( $mail );
            	
					
					
					unset($mail);
					unset($mailResult);
					unset($templateResult);
				}
				unset($oLocaleSwitcher);
			}
			
			
			return true;
		}
		
		return false;
		
	}

	static function search($first_name, 
					    	$last_name, 
					    	$civilite,
							$fonction,
							$direction,
							$service,
							$entreprise,
							$filiale,
							$secteur, 
							$pro_adresse, 
							$emplacement,
							$pro_tel,
							$pro_mobile, 
							$pro_fax, 
							$assistante_nom,
							$assistante_tel,
							$date_naissance,
							$date_entree,
							$diplome, 
							$parcours_pro, 
							$mission_actuelle, 
							$mission_precedente, 
							$competences, 
							$centres_interet,
							$limit,
							$offset,
					    	$ww_id)
	{
		
		if(strlen($first_name) > 0 && strlen($last_name) > 0){
			$arrFilter[0] = 'and';
			$arrFilter[1] = array('user/first_name','like','*'.$first_name.'*');
			$arrFilter[2] = array('user/last_name','like','*'.$last_name.'*');
		}elseif(strlen($first_name) == 0 && strlen($last_name) > 0)
			$arrFilter[0] = array('user/last_name','like','*'.$last_name.'*');
		elseif(strlen($first_name) > 0 && strlen($last_name) == 0)
			$arrFilter[0] = array('user/first_name','like','*'.$first_name.'*');
		
				
		if(isset($arrFilter))
			$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 5,
																	   	'ClassFilterType' => 'include',
																       	'ClassFilterArray' => array( 'user' ),
																		'AttributeFilter' => $arrFilter,
																		'Limitation' => array(),
																		'SortBy' => array('attribute', true, 'user/last_name' )
																	), 5);
		else
			$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 5,
																	   	'ClassFilterType' => 'include',
																       	'ClassFilterArray' => array( 'user' ),
																		'Limitation' => array(),
																		'SortBy' => array('attribute', true, 'user/last_name' )
																	), 5);

		$arrQuery = array(
			'fonction' => $fonction,
			'direction' => $direction,
			'service' => $service,
			'entreprise' => $entreprise,
			'filiale' => $filiale,
			'secteur' => $secteur,
			'pro_adresse' => $pro_adresse,
			'emplacement' => $emplacement,
			'pro_tel' => $pro_tel,
			'pro_mobile' => $pro_mobile,
			'pro_fax' => $pro_fax,
			'assistante_nom' => $assistante_nom,
			'assistante_tel' => $assistante_tel,
			'date_naissance' => $date_naissance,
			'date_entree' => $date_entree,
			'diplome' => $diplome,
			'parcours_pro' => $parcours_pro,
			'mission_actuelle' => $mission_actuelle,
			'mission_precedente' => $mission_precedente,
			'competences' => $competences,
			'centres_interet' => $centres_interet
		);


		$arrResults = array(); $i = 0; $offsetTemp = 0; $arrResults['nbResult'] = 0; $userArray = array();
		foreach($nodes as $node){
			$object = $node->attribute( 'object' );
			$id = $object->attribute('id');
		
			if(!in_array($id, $userArray)){
				$userArray[$i] = $id;
				$userObj = eZUser::fetch($id);
				
				$whoswho = self::fetch($id, $ww_id, $arrQuery);
				
				if($whoswho){
					$offsetTemp++;
					$arrResults['nbResult']++;
				}
				if($whoswho && $i < $limit && $offsetTemp >= $offset){	
					$arrResults[$i]['whoswho'] = $whoswho[0];
					$objDataMap = $object->attribute('data_map');
					$arrResults[$i]['id'] = $id;
					$arrResults[$i]['first_name'] = $objDataMap['first_name']->attribute('content');
					$arrResults[$i]['last_name'] = $objDataMap['last_name']->attribute('content');
					$arrResults[$i]['email'] = $userObj->attribute('email');			
					$i++;
				}elseif($whoswho && $i >= $limit)
					$i++;
			}
		}

		return $arrResults;
	}
	
	static function fetch($id, $wwId, $arrQuery = null){
		$db = eZDB::instance();
		$whoswho = new whoswho();
		
		
		if($wwId == 0)
			$sql = "SELECT * FROM eby_ww_user a WHERE a.user_id = '".$id."' ";
		else
			$sql = "SELECT a.* FROM eby_ww_user a, eby_ww_user_link b 
					WHERE a.user_id = '".$id."' AND b.etat = 1 AND b.user_id = a.user_id AND b.ww_id = '".$wwId."'";

		if(!is_null($arrQuery)){
			foreach($arrQuery as $key => $value){
				if(strlen($value) > 0)
					if($whoswho->fields[$key]['searchType'] == 'input')
						$sql .= " AND a.".$key." LIKE '%".$value."%'";
					elseif($value > 0)
						$sql .= " AND a.".$key." = ".$value."";
			}
		}

		$resArray = $db->arrayQuery( $sql );

		if(count($resArray) > 0){
			$dob = $resArray[0]['date_naissance'];
		
			if(!is_null($resArray[0]['date_naissance']) && $resArray[0]['date_naissance'] != '0000-00-00')
				$dob = $resArray[0]['date_naissance'];
			else $dob = null;
			
			
			if(!is_null($resArray[0]['date_entree']) && $resArray[0]['date_entree'] != '0000-00-00')
				$resArray[0]['age_by'] = self::age($resArray[0]['date_entree']);
			else
				$resArray[0]['age_by'] = null;
				
			if(!is_null($dob)) $resArray[0]['age'] = self::age($dob);
			else $resArray[0]['age'] = null;
			
			$resArray[0]['dt_etat'] = strtotime($resArray[0]['dt_etat']);
			
	   		return $resArray;
		}
	   	return false;
	}
	
	static function fetchSettingsSearch($ww_id){
		$db = eZDB::instance();
		
		$whoswho = new whoswho();
		$arrSearchFields = array();
		
		//Get all the fields selected by the webmaster
		$sql = "SELECT b.*, a.config FROM eby_settings b JOIN eby_ww_settings a ON(b.cle = a.cle)
				WHERE b.type = 'ww_field' AND (a.ww_id = ".$ww_id.") AND (a.type = 'search')";
		
		$resArray = $db->arrayQuery( $sql ); $arrResult = array();
		foreach($resArray as $res)
			if($whoswho->fields[$res['cle']]['searchable'])
				$arrResult[$res['cle']] = $whoswho->fields[$res['cle']];

		return $arrResult;
	}
	
	static function fetchSettingsFields($ww_id){
		$db = eZDB::instance();
		
		$whoswho = new whoswho();
		$arrSearchFields = array();
		
		//Get all the fields selected by the webmaster	
		$sql = "SELECT b.*, a.config FROM eby_settings b JOIN eby_ww_settings a ON(b.cle = a.cle)
				WHERE b.type = 'ww_field' AND (a.ww_id = ".$ww_id.") AND (a.type = 'field')";
		
		$resArray = $db->arrayQuery( $sql ); $arrResult = array();
		foreach($resArray as $res)
			$arrResult[$res['cle']] = $whoswho->fields[$res['cle']];

		return $arrResult;
	}
	
	static function fetchOptionValue($id){
		$db = eZDB::instance();
		$sql = "SELECT id,valeur FROM eby_settings WHERE id = '".$id."'";
		$resArray = $db->arrayQuery( $sql );
	
		$string = '';
		foreach($resArray as $result)
			$string =  utf8_encode(unserialize(base64_decode($result['valeur'])));
		
		return $string;
	}
	
	static function age($naiss)  {
		list($annee, $mois, $jour) = split('[-.]', $naiss);
		$today['mois'] = date('m');
		$today['jour'] = date('d');
		$today['annee'] = date('Y');
		$annees = $today['annee'] - $annee;
		if ($today['mois'] <= $mois) {
			if ($mois == $today['mois']) {
				if ($jour > $today['jour'])
					$annees--;
			}
			else
				$annees--;
		}
		return $annees;
	}
}
?>