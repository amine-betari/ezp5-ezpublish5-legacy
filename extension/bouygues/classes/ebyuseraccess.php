<?php
/**
 * 
 *
 * @author J. Leger
 * @version $Id: ebyuseraccess.php
 * @copyright (C) J. Leger 2009
 *
 */


class ebyUserAccess
{
   	var $userId;
   	
    protected $db;
	
   	const WW_ACCESS_ALL = 10;
   	const MAIN_SECTION_ID = 2;
   	const WW_CONTENTCLASS_ID = 43;
   
	public function __construct()
	{
		
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();

	}
	
	public function getListSection($module='whoswho')
	{
		
		$oUsr = eZUser::fetch($this->userId);

		if($oUsr){
		$aRole = $oUsr->generateAccessArray();
		$section = null;

		switch($module)
		{
			case 'whoswho': 
				if(isset($aRole['whoswho']['administrate']))
				{
						
						$section[] = 6;
						$section[] = 7;
						$section[] = 8;
						$section[] = 9;
						$section[] = 10;
						$section[] = 11;
						$section[] = 12;
						$section[] = 13;
						$section[] = 14;
						$section[] = 15;
						$section[] = 16;
						$section[] = 18;
				
				}elseif(isset($aRole['whoswho']['edit']))
				{
					foreach($aRole['whoswho']['edit'] as $key1 => $val1)
					{
						if(is_array($val1))
						{							
							$section[] = $val1['Section'][0];
						}
					}
				}
				break;
				
			case 'restricted-access':
				if(isset($aRole['restricted-access']['administrate']))
				{
	
						$section[] = 6;
						$section[] = 7;
						$section[] = 8;
						$section[] = 9;
						$section[] = 10;
						$section[] = 11;
						$section[] = 12;
						$section[] = 13;
						$section[] = 14;
						$section[] = 15;
						$section[] = 16;
						$section[] = 18;
				
				}elseif(isset($aRole['restricted-access']['edit']))
				{
					foreach($aRole['restricted-access']['edit'] as $key1 => $val1)
					{
						if(is_array($val1) && isset($val1['Section']))
						{
							foreach($val1['Section'] as $section_id) {
								if (empty($section)) $section = array();
								if(!in_array($section_id, $section)) $section[] = $section_id;
							}
						}
					}
				}
				break;	
				
		}	
		unset($aRole);
		return $section;
		}else
			return array();
	}
	
	
	
	public function getListWw()
	{
		$arrWw = null;
		$section = self::getListSection();
		if($section!=null){
			if(!is_array($section) ){
				$section = array();
				$oSections = eZSection::fetchList();
				foreach($oSections as $sec){
					$section[] = $sec->attribute('id');
				}
				unset($oSections);
				
			}
			$liste = eZContentObject::fetchList( true,	array( 	'contentclass_id' => self::WW_CONTENTCLASS_ID, 
														  		'section_id' 		=> array($section),
														  		'status'         	=> eZContentObject::STATUS_PUBLISHED 
															)
												);
			if(count($liste)>0){
				foreach($liste as $wwId){
					$arrWw[] = $wwId->attribute('id');
				}
			}
			unset($liste);
		}	
		 	
		return $arrWw;
	}
	
	
	public function checkUserWw($user_id)
	{
		$wwList = self::getListWw();
		if($wwList!=null){
			
			$db = eZDB::instance();
			$sql = "SELECT *   
					FROM  eby_ww_user_link
					WHERE user_id=".$user_id;
			
			$str = implode(',', $wwList);
			$sql.= ' AND ww_id IN ('.$str.')'; 
			$recDb = $db->arrayQuery( $sql );
			if(count($recDb)>0){
				return true;
			}else{
				return false;
			}
			
		}else{
			return false;
		}
		
		
	}
	
	public function getRoleUser()
	{
		$oRol = eZRole::fetchByUser(array($this->userId)) ;
		
		return $oRol; 
	}
	
	public function getUser()
	{
		$oUsr = eZUser::fetch($this->userId);
		
		return $oUsr; 
	}
	
	
	static function getAdminList($section){
		$ini = eZINI::instance('bouygues.ini');
    	$sectionGroup = $ini->variableArray( 'SectionGroups','Sections'); 
		$groups = array($sectionGroup[0][0]);
		
		if(is_array($section)){
			foreach($section as $item)
				$groups[] = $sectionGroup[$item][0];
		}else
			$groups[] = $sectionGroup[$section][0];
		
		$arrUsers = array(); $i = 0; $userArray = array();
		foreach($groups as $group){
			$groupObject = ezContentObject::fetch($group);
			$usersNodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 1,
																   	'ClassFilterType' => 'include',
															       	'ClassFilterArray' => array( 'user' ),
																	'Limitation' => array(),
																	'SortBy' => array('attribute', true, 'user/last_name' )
																), $groupObject->attribute('main_node_id'));
			
			foreach($usersNodes as $user){
				$object = $user->attribute( 'object' );
				$dataMap = $object->attribute('data_map');
				$id = $object->attribute('id');
				
				if(!in_array($id, $userArray)){
					$userArray[$i] = $id;
					$userObj = eZUser::fetch($id);
					$arrUsers[$i]['email'] = $userObj->attribute('email');
					$arrUsers[$i]['first_name'] = $dataMap['first_name']->attribute('content');
					$arrUsers[$i]['last_name'] = $dataMap['last_name']->attribute('content');
					
					$i++;
				}
			
			}
		}
		
		return $arrUsers;
	}
	
	
}



 
?>