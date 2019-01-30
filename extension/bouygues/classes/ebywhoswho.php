<?php
/**
 * API de gestion drag and drop
 *
 * @author J. Leger
 * @version $Id: ebywhoswho.php
 * @copyright (C) J. Leger 2009
 *
 */

include_once( "extension/bouygues/classes/whoswho.php" );
class ebyWhoswho
{
     
    const WW_USER_STATUS_PENDING = 0;
	const WW_USER_STATUS_ACCEPTED = 1;
    const WW_USER_STATUS_REFUSED = 2;
    
   	const WW_USER_LIST_REMOVED = 0; 
   	const WW_USER_LIST_SELECTED = 1;
    
   	const PASSWORD_RESET = 'passeby';
   
   	 
    protected $db;
	
    
	public function __construct()
	{
		$this->db = eZDB::instance();

	}
	
	public function getAllFields()
	{
		$sql = "SELECT * FROM  eby_settings WHERE type = 'ww_field'";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$allFields=array();	
		
		foreach ( $recDb as $row )
	  	{
	    	
	  		$allFields[$row['cle']] = unserialize(base64_decode($row['valeur']));
	
	  	}
	 	
		return $allFields;
	}
	
	
	public function getWwFields($id){
		$sql = "SELECT * FROM  eby_ww_settings WHERE ww_id = $id AND type='field'";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$wwFields=array();	
		
		foreach ( $recDb as $row )
	  	{
	    	
	  		$wwFields[$row['cle']] = unserialize($row['config']);
	
	  	}
	 	
		return $wwFields;	
	}
	
	
	public function getWwFieldsSearch($id){
		$sql = "SELECT * FROM  eby_ww_settings WHERE ww_id = $id AND type='search'";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$wwFieldsSearch=array();	
		
		foreach ( $recDb as $row )
	  	{
	    	
	  		$wwFieldsSearch[$row['cle']] = unserialize($row['config']);
	
	  	}
	 	
		return $wwFieldsSearch;	
	}
	
	
	public function setWwFields($id,$fields,$type){
		
		$this->db->begin();
		$this->db->query( "DELETE FROM eby_ww_settings WHERE ww_id = ".$id." AND type='".$type."'" );
		
		$sql = "INSERT INTO eby_ww_settings (ww_id,type,cle,config) VALUE ";

		foreach($fields as $key => $cle){
			$sql.="( ".$id.",'".$type."','".$cle."', '".serialize(true)."'),";	
		}
		$sql = substr($sql,0,strlen($sql)-1);
		
		if(!$this->db->query($sql)){
			return false;
		}else{
			$this->db->commit();
			return true;
		}		
			
		
	}
	
	public static function getWwUsersList($etat,$wwIds='all',$arrPagination=null,$total=null,$liste=null){
	
		$db = eZDB::instance();
		
		$sql = "SELECT *   
				FROM  eby_ww_user t1, eby_ww_user_link t2
				WHERE t1.user_id = t2.user_id 
				AND t2.etat=".$etat;
		
		if($wwIds!='all' && is_array($wwIds)){
			$str = implode(',', $wwIds);
			$sql.= ' AND ww_id IN ('.$str.')';	
		}
		
		if($liste!=null){
			$sql.= ' AND t2.liste = '.$liste;
		}

		$sql.='	ORDER BY t2.dt_etat DESC,t2.ww_id';

		if($arrPagination!=null){
			$recDb = $db->arrayQuery( $sql,array( 'offset' => $arrPagination['offset'],'limit'  => $arrPagination['limit'] ) );
		}else{
			$recDb = $db->arrayQuery( $sql );
		}
			
		
		
		if($total!=null){
			return count($recDb);
		}
		 
		$wwUserList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  				
	    		$oWw = eZContentObject::fetch($row['ww_id']);
			

	        	$oUserCO = eZContentObject::fetch($row['user_id']);
				$oUser = eZUser::fetch($row['user_id']);
		    	if($oUserCO && $oUser)
		    	{
		        	
			    	$dataMap = $oUserCO->attribute( 'data_map' );
					$last_name = $dataMap['last_name']->content();
			    	$first_name = $dataMap['first_name']->content();	    	
			    	
			    	$admin='';

			    	if($row['admin_id']!=null){
			    		$oAdmin = eZContentObject::fetch($row['admin_id']);
						if($oAdmin){
			    			$dataMapAdm = $oAdmin->attribute( 'data_map' );
							$admin = $dataMapAdm['last_name']->content().' '.$dataMapAdm['first_name']->content();
						}
				   	}
				   
				   	$wwUserList[] = array(	'user_id' 			=> $row['user_id'],
			  								'nom'	 			=> $last_name,
			  								'prenom' 			=> $first_name, 
			    							'email' 			=> $oUser->attribute( 'email' ), 
			  								'ww_name' 			=> $oWw->attribute( 'name' ),
				   							'ww_id' 			=> $row['ww_id'],
			    							'admin' 			=> $admin,
			  								'dt_etat' => mktime(substr($row['dt_etat'],11,2),substr($row['dt_etat'],14,2),substr($row['dt_etat'],17,2),substr($row['dt_etat'],5,2),substr($row['dt_etat'],8,2),substr($row['dt_etat'],0,4)
			  							));
		    	}					
	    	
	  	}
	 	
		return $wwUserList;	
	}
	
	
	public static function getUsersList($etat,$wwIds='all'){
	
		$db = eZDB::instance();
		
		$sql = "SELECT *   
				FROM  eby_ww_user t1, eby_ww_user_link t2
				WHERE t1.user_id = t2.user_id 
				AND t2.etat=".$etat;

		if($wwIds!='all' && is_array($wwIds)){
			$str = implode(',', $wwIds);
			$sql.= ' AND ww_id IN ('.$str.')';	
		}
		
		$sql.='	GROUP BY t1.user_id  
				ORDER BY t1.user_id,t2.ww_id';
		
		$recDb = $db->arrayQuery( $sql );
		
		$wwUserList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  				
	    		$arrWw = self::getWwUserById($row['user_id'], 1);
	        	$oUserCO = eZContentObject::fetch($row['user_id']);
				
				if($oUserCO){
		    		$oUser = eZUser::fetch($row['user_id']);
		    		
					if($oUser){
						$dataMap = $oUserCO->attribute( 'data_map' );
						$last_name = $dataMap['last_name']->content();
		    			$first_name = $dataMap['first_name']->content();	    	
		    		
		    			$admin='Inconnu';
		    			if($row['admin_id']!=null){
		    				$oAdmin = eZContentObject::fetch($row['admin_id']);
							if($oAdmin){
		    					$dataMapAdm = $oAdmin->attribute( 'data_map' );
								$admin = $dataMapAdm['last_name']->content().' '.$dataMapAdm['first_name']->content();
			   				}
						}
			    	
			   			$wwUserList[] = array(	'user_id' 		=> $row['user_id'],
		  									'nom'	 			=> $last_name,
		  									'prenom' 			=> $first_name, 
		    								'email' 			=> $oUser->attribute( 'email' ), 
		  									'ww' 				=> $arrWw,
		    								'admin' 			=> $admin,
		  									'dt_etat' => mktime(substr($row['dt_etat'],11,2),substr($row['dt_etat'],14,2),substr($row['dt_etat'],17,2),substr($row['dt_etat'],5,2),substr($row['dt_etat'],8,2),substr($row['dt_etat'],0,4)
		  								));
					}
	    		}
				unset($row);
				unset($oAdmin);
				unset($dataMapAdm);
				unset($admin);
				unset($oUserCO);
				unset($arrWw);
				unset($oUser);
				unset($dataMap);
				unset($last_name);
				unset($first_name);
				
	  	}
		unset($recDb);
		return $wwUserList;	
	}
	
	
	public static function getWwUserById($user_id, $etat = null){
	
		$db = eZDB::instance();
		$sql = "SELECT *   
				FROM  eby_ww_user_link
				WHERE user_id=".$user_id;
		if(!is_null($etat))
			$sql .= " AND etat=1";
		
		$recDb = $db->arrayQuery( $sql );
		$wwList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  		$oWw = eZContentObject::fetch($row['ww_id']);
			$row['name'] = $oWw->attribute( 'name' );
			$wwList[] = $row;
	  	}
		
		return $wwList;
		
	}
	
	
	public function setStatusUserWw($arrId,$status=null){
		include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
		if($status!=null && is_array($arrId)){
			$this->db->begin();
			foreach($arrId as $val){
				$ids = explode('-',$val);
				if(!$this->db->query(  "UPDATE eby_ww_user_link
									SET etat=".$status.", 
										dt_etat=NOW(),
										admin_id=".eZUser::currentUserID()."  
									WHERE user_id = ".$ids[0]." AND ww_id=".$ids[1] )){
				
					return false;
				}
				
				
				$ww_obj = eZContentObject::fetch($ids[1]);
				$current_user_obj = eZContentObject::fetch($ids[0]);
				$current_user = eZUser::fetch( $ids[0] );
				$email = $current_user->attribute('email');
				
				
				$oLocaleSwitcher = new SGLocaleSwitcher();
				$oLocaleSwitcher->setUserLang($email);
				
				$tpl = templateInit();
				$tpl->setVariable( 'name', $current_user_obj->attribute('name') );
				$tpl->setVariable( 'whoswho_name', $ww_obj->attribute('name') );
				$tpl->setVariable( 'ww_id', $ids[1] );
				$tpl->setVariable( 'user_id', $ids[0] );
				$tpl->setVariable( 'section_id', $ww_obj->attribute('section_id') );
				$tpl->setVariable( 'email', $email );
				
				if($status == 2){
					$title = ezpI18n::tr( 'design/bouygues/whoswho', 'email_refused_title1' );
					$subtitle = ezpI18n::tr( 'design/bouygues/whoswho', 'email_refused_title2' );
					$subject = ezpI18n::tr( 'design/bouygues/whoswho', 'email_refused_subject' );
				
					$tpl->setVariable( 'title', $title );
					$tpl->setVariable( 'subtitle', $ww_obj->attribute('name'));
					$templateResult = $tpl->fetch( 'design:emails/whoswhorefused.tpl' );
				}elseif($status == 1){
					//Set the section of the user
					$this->setUserSection($ids[0]);
					
					
					$title = ezpI18n::tr( 'design/bouygues/whoswho', 'email_accepted_title1' );
					$subtitle = ezpI18n::tr( 'design/bouygues/whoswho', 'email_accepted_title2' );
					$subject = ezpI18n::tr( 'design/bouygues/whoswho', 'email_accepted_subject' );
				
					$tpl->setVariable( 'title', $title );
					$tpl->setVariable( 'subtitle', $ww_obj->attribute('name'));
					$templateResult = $tpl->fetch( 'design:emails/whoswhoaccepted.tpl' );
				}
				$mail = new eZMail();
				
				$ini = eZINI::instance();
				if ( $tpl->hasVariable( 'content_type' ) )
					$mail->setContentType( $tpl->variable( 'content_type' ) );
				
				$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
				if ( !$emailSender )
					$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
				
				$mail->setSender( $sender_email );
				$mail->addReceiver( $email );
				
				$mail->setSubject( $subject );
				$mail->setBody( $templateResult );
				
				$mailResult = eZMailTransport::send( $mail );
				
				unset($oLocaleSwitcher);
			}
			$this->db->commit();
			return true;
		}else{
			return false;
		}	
		
	}
	
	public function setUserWw($arrId,$status=null,$newWwId){
		if($status!=null && is_array($arrId)){
			$this->db->begin();
			
			foreach($arrId as $val){
				$ids = explode('-',$val);
				$sql = "REPLACE INTO eby_ww_user_link
										SET etat=".$status.", 
											dt_etat=NOW(),
											admin_id=".eZUser::currentUserID().",  
											user_id = ".$ids[0].",
											ww_id=".$newWwId;
				if(!$this->db->query( $sql  )){
					return false;
				}
				
				//Set the section of the user
				$this->setUserSection($ids[0]);
			}
			$this->db->commit();
			return true;
		}else{
			return false;
		}	
		
	}
	
	public function deleteUserWw($arrId){
		if(is_array($arrId)){
			$this->db->begin();
			
			foreach($arrId as $val){
				$ids = explode('-',$val);
				if($ids[1] > 0){
					$sql = "DELETE FROM eby_ww_user_link WHERE user_id = ".$ids[0]." AND ww_id = ".$ids[1];

					if(!$this->db->query( $sql  )){
						return false;
					}
				}
				$this->setUserSection($ids[0]);
			}
			$this->db->commit();			
			return true;
		}else{
			return false;
		}	
		
	}
	
	public function setUserSection($user_id, $section_id = null){

		if(is_null($section_id)){
			$userWhoswho = new whoswho();
			$idWhoswho = $userWhoswho->hasSubscribedAtLeastOnce($user_id);
			$section_id = 2; //User
			
			if($idWhoswho){
				$oContentWhoswho = eZContentObject::fetch($idWhoswho);
				$section_id = $oContentWhoswho->attribute('section_id');
			}
		}
		
		$oContentUser = eZContentObject::fetch($user_id);
		
		if($oContentUser){
			$currentSection_id = $oContentUser->attribute('section_id');
			
			//if($currentSection_id == 2){
			$version = $oContentUser->createNewVersion( false, false, 'fre-FR' );
				
			$oContentUser->setAttribute('section_id', $section_id);
			$oContentUser->store();
				
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentUser->attribute( 'id' ),
			                                                             'version'   => $version->attribute( 'version' ) ) );
			unset($version);
			unset($result);
			
			//}
		}
		unset($oContentWhoswho);
		unset($oContentUser);
		unset($userWhoswho);
	
	}
	
	public static function getSearchWwUsersList($SearchResult,$wwIds='all')
	{
		
		$wwUserList=array();
				
		$db = eZDB::instance();

	 	foreach($SearchResult as $item)
	 	{
	 		$userId = $item->attribute('contentobject_id');
	 		$oUser = eZContentObject::fetch($userId);

	 		if($oUser->ClassID==4)
	 		{

	 			$dataMap = $oUser->attribute( 'data_map' );
				$last_name = $dataMap['last_name']->content();
				$first_name = $dataMap['first_name']->content();
					
		 		$sql = "SELECT *   
						FROM  eby_ww_user_link 
						WHERE etat=".self::WW_USER_STATUS_ACCEPTED." 
						AND user_id = ".$userId;
				
				if($wwIds!='all' && is_array($wwIds))
				{
					$str = implode(',', $wwIds);
					$sql.= ' AND ww_id IN ('.$str.')';	
				}
				
				$recDb = $db->arrayQuery( $sql );
					
				if(count($recDb)>0)
				{					
					foreach ( $recDb as $row )
				  	{
				    	$oWw = eZContentObject::fetch($row['ww_id']);
				    	
				    	$admin='';
				    	if($row['admin_id']!=null)
				    	{
				    		$oAdmin = eZContentObject::fetch($row['admin_id']);
							if($oAdmin){
				    			$dataMapAdm = $oAdmin->attribute( 'data_map' );
								$admin = $dataMapAdm['last_name']->content().' '.$dataMapAdm['first_name']->content();
							}
					   	}
				    	
					   	$wwUserList[] = array(	'user_id' => $row['user_id'],
				  								'nom' => $last_name,
				  								'prenom' => $first_name,  
				  								'ww_name' => $oWw->attribute( 'name' ),
				    							'ww_id' => $row['ww_id'],
				    	 						'admin' => $admin,
				  								'dt_etat' => mktime(substr($row['dt_etat'],11,2),substr($row['dt_etat'],14,2),substr($row['dt_etat'],17,2),substr($row['dt_etat'],5,2),substr($row['dt_etat'],8,2),substr($row['dt_etat'],0,4))
					   						);
				  
				  	}
				
		 		  	
			 	}
			 	else
			 	{	
			 		$wwUserList[] = array(	'user_id' => $userId,
			  								'nom' => $last_name,
			  								'prenom' => $first_name  
					  					);
			 	}
		 		
	 		}	
	 	
	 	}	 		 		
		 	
		
		return $wwUserList;
			
		
		
		
	}
	
	public static function getEbySettings($id=null,$type=''){
		$db = eZDB::instance();
		if($id!=null){
			$sql = "SELECT *  FROM  eby_settings WHERE id = ".$id."  ORDER BY cle ASC";
			$recDb = $db->arrayQuery( $sql );
			if(is_array($recDb) && count($recDb)>0){
				foreach ( $recDb as $row )
			  	{
			    	 return array('id'=>$id,'type'=> $row['valeur'],'cle' => $row['cle'],'valeur'=> unserialize(base64_decode($row['valeur'])));
			   	}
			}	
		}elseif($type!=''){
			$sql = "SELECT *  FROM  eby_settings WHERE type = '".$type."' ORDER BY cle ASC";
			$recDb = $db->arrayQuery( $sql );
			$arrList = array();
			if(is_array($recDb) && count($recDb)>0){
				foreach ( $recDb as $row )
			  	{
			    	 $arrList[] = array('id'=>$row['id'],'type'=> $row['type'],'cle' => $row['cle'],'valeur'=> utf8_encode(unserialize(base64_decode($row['valeur']))));
			   	}
			   	return $arrList;
			}	
		
		}else{	
			return false;
		}
	}
	
	
	
	
	public static function getUserData($user_id,$text_format=false){
		$db = eZDB::instance();
		$userData=array();	

		$oContentUser = eZContentObject::fetch($user_id);
		$oUser = eZUser::fetch($user_id);

		if($text_format)
		{//principalement pour l'export XLS de sonnÃ©es
			$dataMap = $oContentUser->attribute( 'data_map' );
			
			$last_name = $dataMap['last_name']->content();
	    	$first_name = $dataMap['first_name']->content();
	    	
	    	$options = $dataMap['civilite']->contentClassAttribute()->content();
		    $selected = $dataMap['civilite']->content();
		    $civilite='';
		    if (!isset( $selected[0] )  || !is_numeric( $selected[0] ) ) 
		     	$selected[0]=0;
		    if($selected[0] != 0)
		     	$civilite= $options['options'][$selected[0]]['name'];  	
	     
	     	$my_node_image = $dataMap['image'];
	    	$image_alias_handler = new eZImageAliasHandler( $my_node_image );
	    	$my_node_image_uri =  "/" . $image_alias_handler->attributeFromOriginal( 'url' );
	    	
	    	$userData['last_name'] = $last_name;
	  		$userData['first_name'] = $first_name;
	    	$userData['civilite'] = $civilite;
	    	$userData['image'] = $my_node_image_uri;				
	    	
		    		
		}else{
			$userData['object'] = $oContentUser;
			$userData['object_user'] = $oUser;
		}
		
		
    	$userData['user_id'] = $user_id;
    	
		$sql = "SELECT * FROM  eby_ww_user WHERE user_id = ".$user_id;
		$recDb = $db->arrayQuery( $sql );
		
		$date_entree = null;
		foreach ( $recDb as $row )
	  	{
	    	$date_naissance='';
	    	$date_entree='';
	    	
	    	if($text_format){
	    		$arrEnt = self::getEbySettings($row['entreprise']);
	    		$row['entreprise'] = $arrEnt['valeur'];

	    		$arrFil = self::getEbySettings($row['filiale_autre']);
	    		$row['filiale_autre'] = $arrFil['valeur'];
  		
	    		$arrFil = self::getEbySettings($row['filiale']);
	    		$row['filiale'] = $arrFil['valeur'];
	    		
	    		$arrSect = self::getEbySettings($row['secteur']);
	    		$row['secteur'] = $arrSect['valeur'];
	    		
	    		if($row['date_entree']!='' &&  $row['date_entree']!= null) 
	    			$date_entree = substr($row['date_entree'],8,2) .'/'. substr($row['date_entree'],5,2).'/'.substr($row['date_entree'],0,4);	
				if($row['date_naissance']!='' &&  $row['date_naissance']!= null) 
	    			$date_naissance = substr($row['date_naissance'],8,2) .'/'. substr($row['date_naissance'],5,2).'/'.substr($row['date_naissance'],0,4);
	    			
	    		
	    	}else{
	    		if($row['date_entree']!='' &&  $row['date_entree']!= null) 
	    			$date_entree = array(substr($row['date_entree'],0,4),substr($row['date_entree'],5,2),substr($row['date_entree'],8,2));
	    		if($row['date_naissance']!='' &&  $row['date_naissance']!= null) 
	    			$date_naissance = array(substr($row['date_naissance'],0,4),substr($row['date_naissance'],5,2),substr($row['date_naissance'],8,2));	
	    	}
	    	
	    	$userData['fonction'] = $row['fonction'];
	    	$userData['service'] = $row['service'];
    		$userData['direction'] = $row['direction'];
    		$userData['service'] = $row['service'];
  			$userData['pro_adresse'] = self::br2nl($row['pro_adresse']);
    		$userData['emplacement'] = $row['emplacement'];
    		$userData['pro_tel'] = $row['pro_tel'];
    		$userData['pro_mobile'] = $row['pro_mobile'];
    		$userData['pro_fax'] = $row['pro_fax'];
    		$userData['assistante_nom'] = $row['assistante_nom'];
    		$userData['assistante_tel'] = $row['assistante_tel'];
    		$userData['date_entree'] = $date_entree;
    		$userData['date_naissance'] = $date_naissance;
    		$userData['diplome'] = self::br2nl($row['diplome']);
    		$userData['parcours_pro'] = self::br2nl($row['parcours_pro']);
    		$userData['mission_actuelle'] = self::br2nl($row['mission_actuelle']);
    		$userData['mission_precedente'] = self::br2nl($row['mission_precedente']);
    		$userData['competences'] = self::br2nl($row['competences']);
    		$userData['centres_interet'] = self::br2nl($row['centres_interet']);
    		$userData['entreprise'] = $row['entreprise'];
    		$userData['filiale'] = $row['filiale'];
    		$userData['filiale_autre'] = $row['filiale_autre'];
    		$userData['secteur'] = $row['secteur'];
    		$userData['etat'] = $row['etat'];
    		$userData['dt_etat'] = mktime(substr($row['dt_etat'],11,2),substr($row['dt_etat'],14,2),substr($row['dt_etat'],17,2),substr($row['dt_etat'],5,2),substr($row['dt_etat'],8,2),substr($row['dt_etat'],0,4));
  			
			unset($row);
			
	  
	  	}
		unset($recDb);
		unset($oContentUser);
		unset($oUser);
		return $userData;	
	}
	
	
	public static function br2nl($txt) 
	{
		return preg_replace("/\<br\s*\/?\>/i", "\n", $txt);
	}
	
	
	public static function deleteUserImage($user_id)
	{
		$db = eZDB::instance();
		$db->begin();

		$oUser = eZContentObject::fetch($user_id);
		$version = $oUser->createNewVersion( false, false, 'fre-FR' );
		$datamap = $version->datamap();
		
		$datamap['image']->removeThis();
		
		
		$db->commit();
		
		return true;
	}
	
	
	public static function setUsersWwData($arrData=null)
	{
		$db = eZDB::instance();
		$emailChange = false;
		
		if($arrData!=null)
		{
			$db->begin();
			
			//maj content object user
			$oContentUser = eZContentObject::fetch($arrData['user_id']);
			
			$version = $oContentUser->createNewVersion( false, false, 'fre-FR' );
			$datamap = $version->datamap();
			
			if ( $arrData['last_name']!='')
			{
				$datamap['last_name']->fromString($arrData['last_name']);
				$datamap['last_name']->store();
			}	
			
			if ( $arrData['first_name']!='')
			{
				$datamap['first_name']->fromString($arrData['first_name']);
				$datamap['first_name']->store();
			}
			
			if(eZMail::validate($arrData['user_email']) ) 
			{
				
				$oUser = eZUser::fetch($arrData['user_id']);
				
				$login = strtolower($oUser->attribute( "login" ));
				
			    $type = $oUser->attribute( "password_hash_type" );
			    $hash = $oUser->attribute( "password_hash" );
			    $site = $oUser->site();
			    $ini = eZINI::instance();
			    
			    $newPassword=$arrData['user_password'];
			    $confirmPassword=$arrData['user_password_confirm'];
				
			    if(strtolower($arrData['user_email'])!=trim($login))
		    	{

		         	if ( eZUser::fetchByName( $arrData['user_email'] ) || eZUser::fetchByEmail( $arrData['user_email']  ) ){
eZDebug::writeNotice( 'Email existe deja', 'bouygues:classes/ebywhoswho.php');										         	
		            	return false;
		         	}
			
		    		 $oUser->setAttribute( 'login', $arrData['user_email'] );
		       		 $oUser->setAttribute( 'email', $arrData['user_email'] );
		       		 $login=$arrData['user_email'];
		             $oUser->store();	
		             
		             $newHash = $oUser->createHash( $login, self::PASSWORD_RESET, $site, $type );
		             $oUser->setAttribute( "password_hash", $newHash );
		             $oUser->setAttribute( "password_hash_type", $type );
		             $oUser->store();
		             
		             $hashEmail = md5( mt_rand() . time() . $arrData['user_id'] );
					 $accountKey = eZUserAccountKey::createNew( $arrData['user_id'],$hashEmail, time() );
					 $accountKey->store();
		             
					 $emailUser=$login;
		             $emailChange=true;
		    	}
		    	
			    
			    if ( $newPassword == "_ezpassword" )
	            {
	                $newPassword = false;
eZDebug::writeNotice( 'Password _ezpassword', 'bouygues:classes/ebywhoswho.php');	                
	            }
		    
		        if ($newPassword  &&  $newPassword == $confirmPassword )
		        {
		            $minPasswordLength = $ini->hasVariable( 'UserSettings', 'MinPasswordLength' ) ? $ini->variable( 'UserSettings', 'MinPasswordLength' ) : 3;
		
		            if ( strlen( $newPassword ) < $minPasswordLength )
		            {
		                $newPasswordTooShort = 1;
eZDebug::writeNotice( 'Password too short', 'bouygues:classes/ebywhoswho.php');			                
		            }
		            else
		            {
		                $newHash = $oUser->createHash( $login, $newPassword, $site, $type );
		                $oUser->setAttribute( "password_hash", $newHash );
		                $oUser->store();
		            }   
		        }		    			
			}	

			$datamap['no_galby_sync']->fromString($arrData['no_galby_sync']);
			$datamap['no_galby_sync']->store();			

			$oUserSetting = eZUserSetting::fetch( $arrData['user_id']);
		    $oUserSetting->setAttribute( "is_enabled", $arrData['is_enabled'] );
		    $oUserSetting->store();
			
			if(isset($arrData['image']) && is_array($arrData['image']))
			{
					$datamap['image']->fromString($arrData['image']['tmp_name']);
					$datamap['image']->store();
			}
			
			if(is_array($arrData['civilite']) && count($arrData['civilite'])>0)
			{
				$options = $datamap['civilite']->contentClassAttribute()->content();
		    	$civilite= $options['options'][$arrData['civilite'][0]]['name'];//echo $civilite;
		    	$datamap['civilite']->fromString($civilite);
				$datamap['civilite']->store();
			}
			
			if(is_array($arrData['langue']) && count($arrData['langue'])>0){
				$arrLangue = array('Français','English');
				$datamap['langue']->fromString($arrLangue[$arrData['langue'][0]]);
				$datamap['langue']->store();
			}
						
			$oContentUser->store();
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentUser->attribute( 'id' ),
			                                                                               'version'   => $version->attribute( 'version' ) ) );			
			    
			
			//mise Ã  jour table eby_ww_user
			
			$sqlFields = "	dt_etat = NOW(),
							pro_adresse = '".$db->escapeString($arrData['pro_adresse'])."',
							emplacement = '".$db->escapeString($arrData['emplacement'])."',
							service = '".$db->escapeString($arrData['service'])."',
							filiale_autre = '".$db->escapeString($arrData['filiale_autre'])."',
							filiale = '".$db->escapeString($arrData['filiale'])."',
							pro_tel = '".$db->escapeString($arrData['pro_tel'])."',
							pro_mobile = '".$db->escapeString($arrData['pro_mobile'])."',
							pro_fax = '".$db->escapeString($arrData['pro_fax'])."',
							assistante_nom = '".$db->escapeString($arrData['assistante_nom'])."',
							assistante_tel = '".$db->escapeString($arrData['assistante_tel'])."',
							fonction = '".$db->escapeString($arrData['fonction'])."',
							direction = '".$db->escapeString($arrData['direction'])."',
							mission_actuelle = '".$db->escapeString($arrData['mission_actuelle'])."',
							diplome = '".$db->escapeString($arrData['diplome'])."',
							mission_precedente = '".$db->escapeString($arrData['mission_precedente'])."',
							parcours_pro = '".$db->escapeString($arrData['parcours_pro'])."',
							competences = '".$db->escapeString($arrData['competences'])."',";
			
			if(isset($arrData['entreprise_id']) && $arrData['entreprise_id']!='') 
						$sqlFields.= "entreprise = ".$arrData['entreprise_id'].",";
			
			if ( checkdate($arrData['date_entree_date_month'] ,$arrData['date_entree_date_day'], $arrData['date_entree_date_year'] ) )
						$sqlFields.= "date_entree = '".$arrData['date_entree_date_year']."-".$arrData['date_entree_date_month']."-".$arrData['date_entree_date_day']."',";

			if(checkdate( $arrData['date_naissance_date_month'], $arrData['date_naissance_date_day'], $arrData['date_naissance_date_year']))
						$sqlFields.= "date_naissance = '".$arrData['date_naissance_date_year']."-".$arrData['date_naissance_date_month']."-".$arrData['date_naissance_date_day']."',";			
						
			if(isset($arrData['secteur_id'])) 
						$sqlFields.= "secteur = '".$arrData['secteur_id']."',";
			
			$sqlFields.= " centres_interet = '".$db->escapeString($arrData['centres_interet'])."'"; 
			
			$sql = "SELECT *   
					FROM  eby_ww_user
					WHERE user_id=".$arrData['user_id'];//echo $sqlFields;exit;
			$recDb = $db->arrayQuery( $sql );
			if(count($recDb)>0){
			
				$sql = "UPDATE eby_ww_user SET "; 
				$sql.= $sqlFields;
				$sql.= " WHERE user_id = ".$arrData['user_id'];
				if(!$db->query( $sql)){
					return false;
				}else{
					$db->commit();					
					return true;
				}
			}else{
				$sql = "INSERT INTO eby_ww_user SET 
							user_id = ".$arrData['user_id'].",
							etat = 1,";
							
				$sql.= $sqlFields;
				
				if(!$db->query( $sql)){
					return false;
				}else{
					$db->commit();
					
					return true;
				}
			}	
		}else{
			return false;
		}
		
		
	}
	
	
	
	
	public static function removeWwUsers($ww_id=null){
		$db = eZDB::instance();
		$sqlD = "DELETE FROM eby_ww_user_link WHERE ww_id = ".$ww_id;
		eZDebug::writeNotice( "sql : ".$sqlD, 'bouygues:classes/ebywhoswho.php');
		return (bool)$db->query( $sqlD );
		
		
		/*
		$db = eZDB::instance();
		if($ww_id!=null){
			$sql = "SELECT user_id   
					FROM  eby_ww_user
					WHERE ww_id = ".$ww_id;

			$recDb = $db->arrayQuery( $sql );
			foreach ( $recDb as $row )
		  	{				
				$sqlD = "DELETE FROM eby_ww_user_link WHERE ww_id = ".$ww_id." AND user_id=".$row['user_id'];
				eZDebug::writeNotice( "sql : ".$sqlD, 'bouygues:classes/ebywhoswho.php');
				$db->query( $sqlD);
				
				unset($sqlD);
				self::setUserSection($row['user_id']);
			
			}
			
			return true;
		}else{
			return false;
		}	
		*/
	}
	
	
	public static function removeWw($ww_id=null){
		$db = eZDB::instance();
		$db->begin();
		
		if ($ww_id!=null) {
			
			if (!self::removeWwUsers($ww_id)) {
				return false;
			}
			
			$sql = "DELETE FROM eby_ww_settings WHERE ww_id = ".$ww_id;
			
			if (!$db->query( $sql)) {
				
				eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebywhoswho.php');
				return false;
				
			} else {
				
				//supression du Whw
				$object = eZContentObject::fetch($ww_id);
				$object->remove();
				$object->purge();
				
				$db->commit();
				return true;
				
			}
		} else {
			return false;
		}
	}
	
	public function delUser($user_id){
		$this->db->begin();
		
		$sqlWwData = "DELETE FROM eby_ww_user WHERE user_id = ".$user_id;
		$sqlWwLink = "DELETE FROM eby_ww_user_link WHERE user_id = ".$user_id;
		$sqlRaLink = "DELETE FROM eby_ra_user_link WHERE user_id = ".$user_id;
		$sqlFavorite = "DELETE FROM eby_favorite_user WHERE user_id = ".$user_id;
		$sqlEbyPerso = "DELETE FROM eby_ebyperso WHERE user_id = ".$user_id;
		$sqlGalbyError = "DELETE FROM eby_galby_error WHERE user_id = ".$user_id;
		
		$this->db->query( $sqlWwData);
		$this->db->query( $sqlWwLink);
		$this->db->query( $sqlRaLink);
		$this->db->query( $sqlFavorite);
		$this->db->query( $sqlEbyPerso);
		$this->db->query( $sqlGalbyError);
		
		$object = eZContentObject::fetch($user_id);
		$object->remove();
		$object->purge();
		
		$this->db->commit();
		return true;
	}
	
	public function setListeUserWw($arrId,$wwId,$liste){
		
		$this->db->begin();
		foreach($arrId as $user_id){
			
			if(!$this->db->query(  "UPDATE eby_ww_user_link
									SET liste=".$liste."  
									WHERE user_id = ".$user_id." AND ww_id=".$wwId )){
		eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebywhoswho.php');	
				return false;
			}
		}
		$this->db->commit();
		
		return true;
		
	}
	
	
	
	public function setWwEmail($data){
		
		$this->db->begin();
		$userId = eZUser::currentUserID();

		$strIds = ''; $count = count($data['wwIds']); $i = 1;
		foreach($data['wwIds'] as $val){
			if($i < $count)
				$strIds .= $val.'|';
			else
				$strIds .= $val;
			$i++;
		}

		// Check if exists
		if(isset($data['id']) && $data['id'] >0){
			$sqlCheck = "SELECT id FROM eby_ww_message
								WHERE id = ".$data['id'];
								
		}

		if(isset($sqlCheck) && $this->db->query( $sqlCheck  )){
			//We update
			$sql = "UPDATE eby_ww_message SET sujetFr = '".addslashes($data['sujetFr'])."',
											sujetEn = '".addslashes($data['sujetEn'])."',
											corpsFr = '".addslashes($data['corpsFr'])."',
											corpsEn = '".addslashes($data['corpsEn'])."',
											ww_ids = '".$strIds."'
									WHERE id = ".$data['id'];
		}else{
			//We insert
			$sql = "INSERT INTO eby_ww_message (sujetFr, sujetEn, corpsFr, corpsEn, ww_ids, user_id) 
									VALUES('".addslashes($data['sujetFr'])."',
										'".addslashes($data['sujetEn'])."',
										'".addslashes($data['corpsFr'])."',
										'".addslashes($data['corpsEn'])."', 
										'".$strIds."',
										".$userId.")";

		}

		$this->db->query( $sql );
		
		$this->db->commit();
		
		return true;
		
	}
	
	public function getWwEmail($id = null){
		$this->db->begin();
		$userId = eZUser::currentUserID();

		if($id > 0)
			$sql = "SELECT * FROM eby_ww_message Where id = ".$id." Order By date DESC";
		else
			$sql = "SELECT * FROM eby_ww_message Order By date DESC";
			
        $recDb = $this->db->arrayQuery( $sql );
		
		$arrReturn = array(); $i = 0;
		foreach($recDb as $row){
			$arrReturn[$i] = $row;
			$j = 0;
			$ww_ids = explode('|', $row['ww_ids']);
			foreach($ww_ids as $ww_id){
				$oContentWhoswho = eZContentObject::fetch($ww_id);
				if($oContentWhoswho){
					$arrReturn[$i]['ww'][$j]['ww_id'] .= $ww_id;
					$arrReturn[$i]['ww'][$j]['name'] = $oContentWhoswho->attribute('name');
					unset($oContentWhoswho);
					$j++;
				}
			}
			$i++;
		}
		return $arrReturn;
	}
	
	public function delWwEmail($id){
		
		$this->db->begin();
		$sql = "DELETE FROM eby_ww_message Where id = ".$id;
		$this->db->query( $sql );
		$this->db->commit();
		
		return true;
	}
	
	static public function getWwEmailCount(){
		$db = eZDB::instance();
		$db->begin();

		$sql = "SELECT count(id) as numMessage FROM eby_ww_message Where etat = 0";

        $recDb = $db->arrayQuery( $sql );

		$db->commit();

		return $recDb[0]['numMessage'];
	}
	
	static public function sendEmail( $oUser,$hashEmail,$emailUser)
	{
 
		include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
		$oLocaleSwitcher = new SGLocaleSwitcher();
		$oLocaleSwitcher->setUserLang($emailUser);
		

		$object = eZContentObject::fetch( $oUser->ContentObjectID );
		$user = eZUser::fetch( $oUser->ContentObjectID );
		
		$ini = eZINI::instance();
		
		$tpl = templateInit();
		
		
		$tpl->setVariable( 'title', ezpI18n::tr('extension/bouygues/ebyidentification', 'email_touser_title1') );
		$tpl->setVariable( 'subTitle', ezpI18n::tr('extension/bouygues/ebyidentification', 'email_touser_title2') );
		
		$tpl->setVariable( 'user', $user );
    	$tpl->setVariable( 'object', $object );
    	$hostname = eZSys::hostname();
    	$arrHostname = explode('.',$hostname);
    	if($arrHostname[0]=='admin'){
    		array_shift($arrHostname);
    		$hostname = implode('.',$arrHostname);
    	}
    	    	
    	$tpl->setVariable( 'hostname', $hostname );
	    
	    $tpl->setVariable( 'password', self::PASSWORD_RESET);
		$tpl->setVariable( 'hash', $hashEmail );
	    $templateResult = $tpl->fetch( 'design:emails/registrationinfo.tpl' );

		$mail = new eZMail();	 
		$mail->setContentType($ini->variable( 'MailSettings', 'ContentType' ) );
			
		$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
		if ( !$emailSender )
			$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
		$mail->setSender( $emailSender );
		$mail->setReceiver( $emailUser );
		$subject = ezpI18n::tr( 'kernel/user/register', 'Registration info' );
		
		$mail->setSubject( $subject );
		$mail->setBody( $templateResult );
		$mailResult = eZMailTransport::send( $mail );

		unset($oLocaleSwitcher);

		return true;
	}

	
	
	public function pagination($userList, $offset = null , $limit = null)
	{
//echo '$limit '.$limit . ' $offset '.$offset;		
		$counter =0;
		$userListFinal = array();
    	foreach($userList as $user)
    	{
    		//if($counter>=((int)$offset*$limit) && $counter < ($limit+((int)$offset*$limit)))
	    	if($counter>=((int)$offset) && $counter < ($limit+((int)$offset)))
	    	{
	    		$userListFinal[] = $user;
	    	}
	    	$counter++;	
    	}
    	
    	return $userListFinal;
			    	
	}
	
	
	
	//runs the sort, and returns sorted array 
    public function tri($myarray, $key_to_sort, $type_of_sort = '') 
    { 
        $this->key = $key_to_sort; 
        
        if ($type_of_sort == 'desc') 
            uasort($myarray, array($this, 'myreverse_compare')); 
        else 
            uasort($myarray, array($this, 'mycompare')); 
            
        return $myarray; 
    } 
    
    
    //for ascending order 
    private function mycompare($x, $y) 
    { 
        if ( $x[$this->key] == $y[$this->key] ) 
            return 0; 
        else if ( $x[$this->key] < $y[$this->key] ) 
            return -1; 
        else 
            return 1; 
    } 
    
    
    //for descending order 
    private function myreverse_compare($x, $y) 
    { 
        if ( $x[$this->key] == $y[$this->key] ) 
            return 0; 
        else if ( $x[$this->key] > $y[$this->key] ) 
            return -1; 
        else 
            return 1; 
    } 
	
	
}



 
?>