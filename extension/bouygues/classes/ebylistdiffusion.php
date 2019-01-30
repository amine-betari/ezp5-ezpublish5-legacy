<?php

class ebyListDiffusion
{
   
    
    protected $db;
	
    var $key;
    
	public function __construct()
	{
		$this->db = eZDB::instance();
	}

	
	
	
	
	public function getWwUsers($etat=1,$wwIds='all')
	{
	
//eZLog::write ( 'ebyListDiffusion->getWwUsers : $wwIds => ' .  $wwIds , 'eby_admin.log', 'var/log');		
		
		
		$sql = "SELECT *   
				FROM  eby_ww_user t1, eby_ww_user_link t2
				WHERE t1.user_id = t2.user_id 
				AND t2.etat=".$etat;
		
		if($wwIds!='all' && is_array($wwIds))
		{
			$str = implode(',', $wwIds);
			$sql.= ' AND ww_id IN ('.$str.')';	
		}
		
		
		$sql.='	ORDER BY t2.dt_etat DESC,t2.ww_id';
		$recDb = $this->db->arrayQuery( $sql );

//eZLog::write ( 'ebyListDiffusion->getWwUsers : $sql => ' .  $sql , 'eby_admin.log', 'var/log');
		$userList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  				
    		$oWw = eZContentObject::fetch($row['ww_id']);
		
        	$oUserCO = eZContentObject::fetch($row['user_id']);
			$oUser = eZUser::fetch($row['user_id']);
	    	if($oUserCO && $oUser)
	    	{
	        	
		    	$dataMap = $oUserCO->attribute( 'data_map' );
	
			   
			   	$userList[] = array(	'user_id' 			=> $row['user_id'],
		  								'last_name'	 		=> $dataMap['last_name']->content(),
		  								'first_name' 		=> $dataMap['first_name']->content(), 
		    							'email' 			=> $oUser->attribute( 'email' ), 
			   							'diffusion_type' 	=> 'ww',
		  								'diffusion_name' 	=> $oWw->attribute( 'name' ),
			   							'diffusion_id' 		=> $row['ww_id'],
		    							
		  							);
		  							
	    	}					
	    	
	  	}
	 	
	  	
		return $userList;	
	}
	
	
	public function getNlUsers($arrNl = null)
	{
		$userList=array();
		
		if(!is_null($arrNl))
		{
			foreach($arrNl as $nl)
			{
				$subscriberList = eZSubscription::fetchListBySubscriptionListID( $nl, array(),0,10000 );
				
				foreach($subscriberList as $subscriber)
				{
					$userList[] = array('user_id' 			=> $subscriber->attribute('id'),
		  								'last_name'	 		=> $subscriber->attribute('name'),
		  								'first_name' 		=> $subscriber->attribute('firstname'),
		    							'email' 			=> $subscriber->attribute('email'), 
			   							'diffusion_type' 	=> 'nl',
		  								'diffusion_name' 	=> $subscriber->attribute('subscription_list')->attribute('name'),
			   							'diffusion_id' 		=> $subscriber->attribute('subscription_list')->attribute('id'),
		    							
		  							);
				}				
			}	
			
		}
		
		return $userList;
	}
	
	
	public function getRaUsers($arrRa = null)
	{
		$userList=array();
		
		if(!is_null($arrRa))
		{
			foreach($arrRa as $ra)
			{
				
				
				$sql = "SELECT * FROM  eby_ra_user_link t1, eby_ra_group t2  
						WHERE t1.group_id = t2.id
						AND t1.group_id=" . $ra['id'];
				$recDb = $this->db->arrayQuery( $sql );
		
//eZLog::write ( 'ebyListDiffusion->getRaUsers : $sql => ' .  $sql , 'eby_admin.log', 'var/log');				
				foreach ( $recDb as $row )
			  	{
			  		//$row['user_id'];
			  		//$oWw = eZContentObject::fetch($row['ww_id']);
		
		        	$oUserCO = eZContentObject::fetch($row['user_id']);
					$oUser = eZUser::fetch($row['user_id']);
			    	if($oUserCO && $oUser)
			    	{
			        	
				    	$dataMap = $oUserCO->attribute( 'data_map' );
						 
					   	$userList[] = array(	'user_id' 			=> $row['user_id'],
				  								'last_name'	 		=> $dataMap['last_name']->content(),
				  								'first_name' 		=> $dataMap['first_name']->content(), 
				    							'email' 			=> $oUser->attribute( 'email' ), 
					   							'diffusion_type' 	=> 'ra',
				  								'diffusion_name' 	=> $row['nom'],
					   							'diffusion_id' 		=> $row['group_id'],
				    							
				  							);
					}
			  		
			  
			  	}
	 			
			}
		}	
		
		return $userList;
		
	}
	
	
	
	
	
	public function checkDiffusionUsers($arrUsers,$arrDiffusion)
	{
		$retUsers = array();
		$flagUser = false;
		$flagValid = true;
		$status = false;
		$comment ='';
		
		foreach($arrUsers as $user)
		{
			
			if(!empty($user['id']))
			{
				if($oUser = eZUser::fetch($user['id']) )
				{
					$comment .= 'user existant sur ID<br/>';
					$flagUser = true;
				}else{
					$comment .= 'user inconnu sur ID <br/>';
					
				}
			}
			
			if(!empty($user['email']) && !$flagUser)
			{
				if($oUser = eZUser::fetchByEmail($user['email']) )
				{
					$user['id'] = $oUser->ContentObjectID;
					$comment .= 'user existant sur EMAIL<br/>';
					$flagUser = true;
				}else{
					$comment .= 'user inconnu sur EMAIL<br/>';
					if(!eZMail::validate($user['email']) )
					{
						$comment .= 'email invalide !<br/>';
						$comment .= '<span style="color:red">Action => il ne sera pas importé.</span><br/>';
						$flagValid = false;
					}
					elseif($user['last_name']=='' || $user['first_name']=='' )
					{
						$comment .= 'Le nom et le prénom doivent être renseigné !<br/>';
						$comment .= '<span style="color:red">Action => il ne sera pas importé.</span><br/>';
						$flagValid = false;
					}
					
					
				}
			}
			
			if($flagUser)
			{
				switch($arrDiffusion['type'])
				{
					
					case 'ww':
//eZLog::write ( 'ebyListDiffusion->checkWwUsers : $arrDiffusion => ' .  print_r($arrDiffusion,1) , 'eby_admin.log', 'var/log');						
						if($ret = $this->checkWwUserById($oUser->attribute('contentobject_id'), $arrDiffusion['id']))
						{
							$comment .= 'cet utilisateur est déja inscrit ! <br/>';
							$comment .= '<span style="color:red">Action => il ne sera pas importé.</span><br/>';
							$flagValid = false;	
						}	
						
					break;
					
					case 'nl':
						
						if($ret = $this->checkNlUserById($oUser->attribute('contentobject_id'), $arrDiffusion['id']))
						{
//eZDebug::writeNotice( 'ebyListDiffusion->checkDiffusionUsers NL :' . print_r($ret,1), 'eby:ebyListDiffusion.php');							
							$comment .= 'cet utilisateur est déja inscrit ! <br/>';
							$comment .= '<span style="color:red">Action => il ne sera pas importé.</span><br/>';
							$flagValid = false;	
						}	
						
					break;
					
					case 'ra':

						if($ret = $this->checkRaUserById($oUser->attribute('contentobject_id'), $arrDiffusion['id']))
						{
							$comment .= 'cet utilisateur est déja inscrit ! <br/>';
							$comment .= '<span style="color:red">Action => il ne sera pas importé.</span><br/>';
							$flagValid = false;	
						}	
						
					break;
					
				}	
			}
			
			if(!$flagUser && $flagValid)
			{
				$comment .= '<span style="color:blue">Action => création user</span><br/>';
				$user['id']='new';
				$status = true;
				
			}
			
			if($flagUser && $flagValid)
			{
				$status = true;
				$comment .= '<span style="color:green">Action => il sera importé</span><br/>';
			}	
				
//eZLog::write ( 'ebyListDiffusion->checkWwUsers : $flagUser => ' .  $flagUser . ' $flagValid=>'.$flagValid , 'eby_admin.log', 'var/log');				
//eZDebug::writeNotice( 'ebyListDiffusion->checkWwUsers : $flagUser => ' .  $flagUser . ' $flagValid=>'.$flagValid , 'eby:listdiffusion/list.php');
			
			$retUsers[]=array(	'id' 		=> $user['id'], 
								'email' 	=> $user['email'],
								'last_name' => $user['last_name'],
								'first_name' => $user['first_name'],
								'comment' 	=> $comment,
								'status'	=> $status, 
							);
			$comment ='';
			$flagUser = false;
			$flagValid = true;
			$status = false;
		}
		
		return $retUsers;
	}
	
	
	
	private function checkWwUserById($user_id, $ww_id)
	{
	
		$sql = "SELECT *   
				FROM  eby_ww_user_link
				WHERE user_id=" . $user_id . "
				AND ww_id =" . $ww_id . "
				AND etat=1";
		
		$recDb = $this->db->arrayQuery( $sql );
		
//eZLog::write ( 'ebyListDiffusion->checkWwUserById : $$recDb => ' .  print_r($recDb,1) , 'eby_admin.log', 'var/log');	
		
		return $recDb;
		
	}
	
	
	private function checkNlUserById($user_id, $nl_id)
	{
	
		$oNl = eZSubscription::fetchByUserSubscriptionListID( $user_id,$nl_id);
		
//eZLog::write ( 'ebyListDiffusion->checkNlUserById : $oNl => ' .  print_r($oNl,1) , 'eby_admin.log', 'var/log');	
		
		return $oNl;
		
	}
	
	
	private function checkRaUserById($user_id, $ra_id)
	{
	
		$sql = "SELECT * FROM  eby_ra_user_link WHERE group_id=" . $ra_id . " AND user_id=" . $user_id ;
		
		$recDb = $this->db->arrayQuery( $sql );
		
		
		return $recDb;
		
	}
	
	
	public function setDiffusionUsers($diffusion_type,$diffusion_id,$user_import, $arrNewUsers)
	{
//eZDebug::writeNotice( 'ebyListDiffusion->setDiffusionUsers : $diffusion_type => ' .  $diffusion_type . 
//					' $diffusion_id=>' . $diffusion_id . ' $user_import=>' . print_r($user_import,1)
//					. ' $arrNewUsers=>' . print_r($arrNewUsers,1), 'eby:listdiffusion/list.php');
					
		$userImportFinal = array();
		switch($diffusion_type)
		{
			case 'ww':
				$oWw = new ebyWhoswho();
				$arrId = array();
				$i=0;
				foreach($user_import as $user_id)
				{
					if($user_id=='new')
					{
						$user_id = $this->setNewUser($arrNewUsers['email'][$i],$arrNewUsers['first_name'][$i],$arrNewUsers['last_name'][$i]);
					}
						
					$arrId[] = $user_id . '-' . $diffusion_id;
					
					$userImportFinal[] = $user_id;
					
					$i++;
				}
//eZDebug::writeNotice( 'ebyListDiffusion->setDiffusionUsers :  $$oEby=>' . print_r($oEby,1), 'eby:listdiffusion/list.php');	
				$sql = "REPLACE INTO eby_ww_user
										SET etat=1, 
											dt_etat=NOW(),
											user_id = " . $user_id;
				$this->db->query( $sql );
				
				$ret = $oWw->setUserWw($arrId,$status=1,$diffusion_id);
				
				//return $ret;
				 
			break;
			
			case 'nl':
				$i=0;
				foreach($user_import as $user_id)
				{
					if($user_id=='new')
					{
						$user_id = $this->setNewUser($arrNewUsers['email'][$i],$arrNewUsers['first_name'][$i],$arrNewUsers['last_name'][$i]);
					}

					
					$oUserCO = eZContentObject::fetch($user_id);
					$dataMap = $oUserCO->attribute( 'data_map' );
					$oUser = eZUser::fetch($user_id);
					
					$subscription = eZSubscription::create($diffusion_id);

					$subscription->setAttribute( 'user_id', $user_id );		
					$subscription->setAttribute( 'email', $oUser->attribute( 'email' ) );
					$subscription->setAttribute( 'firstname', $dataMap['first_name']->content() );
					$subscription->setAttribute( 'name', $dataMap['last_name']->content() );
					$subscription->setAttribute( 'status', 2 ); //2 => statut approuvé       
//eZDebug::writeNotice( 'ebyListDiffusion->setDiffusionUsers : eZSubscription::FieldSeparationCharacter=>' . print_r(eZSubscription::FieldSeparationCharacter,1), 'eby:listdiffusion/list.php');			
	        		//$subscription->setAttribute( 'output_format', implode( eZSubscription::FieldSeparationCharacter, 1 ) );//1 => format HTML
	        		$subscription->setAttribute( 'output_format', '0,1' );//1 => format HTML
//eZDebug::writeNotice( 'ebyListDiffusion->setDiffusionUsers : Avant ->store()', 'eby:listdiffusion/list.php');
	                $subscription->store();
//eZDebug::writeNotice( 'ebyListDiffusion->setDiffusionUsers : Avant ->publish()', 'eby:listdiffusion/list.php');
	                $subscription->publish();  

	                $userImportFinal[] = $user_id;
	                $i++;
				}
				
				//return true;
				 
			break;
			
			case 'ra':
				
				foreach($user_import as $user_id)
				{
					$i=0;
					if($user_id=='new')
					{
						$user_id = $this->setNewUser($arrNewUsers['email'][$i],$arrNewUsers['first_name'][$i],$arrNewUsers['last_name'][$i]);
					}
					
					$this->db->query( "REPLACE INTO eby_ra_user_link SET user_id = ". $user_id .", group_id = " . $diffusion_id);
					
					$userImportFinal[] = $user_id;
					$i++;
				}
				
				//return true;
						
			break;	
			
		}
		
		return $userImportFinal;
	}
	
	
	public function getDiffusionUsers($diffusion_type,$diffusion_id,$user_import)
	{
		
		$retUsers = array();
//eZDebug::writeNotice( 'getDiffusionUsers => $diffusion_type:' . $diffusion_type . ' $diffusion_id:' . $diffusion_id . ' $user_import:' . print_r($user_import,1), 'eby:listdiffusion/list.php');		
		switch($diffusion_type)
		{
			case 'ww':
			case 'nl':
			case 'ra':
				
				foreach($user_import as $user_id)
				{
					$oUser = eZUser::fetch($user_id);
					$oUserCO = eZContentObject::fetch($user_id);
					$dataMapUser = $oUserCO->attribute( 'data_map' );
					//if(is_object($dataMapUser))
					//{
						$comment = 'user importé';
						
						$retUsers[]=array(	
											'id' 		=> $user_id, 
											'email' 	=> $oUser->attribute('email'),
											'last_name' => $dataMapUser['last_name']->content(),
											'first_name' => $dataMapUser['first_name']->content(),
											'comment' 	=> $comment,
										);
					//}
				}	
						
			break;
		}

//eZDebug::writeNotice( 'getDiffusionUsers =>  $retUsers:' . print_r($retUsers,1), 'eby:listdiffusion/list.php');		
		return $retUsers;
									
	}
	
	
	public function setNewUser($email,$first_name,$last_name)
	{
		$oEby = new ebySubscribeUser();
		$oEby->emailUser = $email;
		$aParams = array('first_name' => $first_name, 'last_name' => $last_name);

	if($oEby instanceof ebySubscribeUser)
	{
		//eZDebug::writeNotice( 'ebyListDiffusion->setNewUser :  $email=>' . $email . ', $first_name=>' . $first_name . ',$last_name=>' . $last_name, 'eby:listdiffusion/list.php');
		if($oUser = $oEby->createUser($aParams, 0 , false))
    	{
    		return $oUser->attribute( 'contentobject_id' );
    	}		
	}
/*
		if($oUser = $oEby->createUser($aParams, 0 , false))
    	{
//eZDebug::writeNotice( 'ebyListDiffusion->setNewUser :  $oUser=>' . print_r($oUser,1), 'eby:listdiffusion/list.php');    		
    		return $oUser->attribute( 'contentobject_id' );
    	}
*/		

	}
	
	
	
	
    
	
}	
