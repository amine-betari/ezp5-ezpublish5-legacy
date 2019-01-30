<?php
/**
 * API de gestion Restricted Area
 *
 * @author J. Leger
 * @version $Id: ebyrestrictedarea.php
 * @copyright (C) J. Leger 2009
 *
 */
include_once( "extension/bouygues/classes/ebyuseraccess.php" );

class ebyRestrictedArea Extends ebyUserAccess
{
   
   var $arrSection;
   protected $db;
	
    
	public function __construct()
	{
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();
		$this->arrSection = $this->getListSection('restricted-access');
	}
	
	
	
	public function setGroup($id=null,$nom,$section_id=null)
	{
	
		if(!is_numeric($section_id)) return false;
			
		$this->db->begin();
		
		if($id!=null)
		{
			$sql = "UPDATE eby_ra_group SET 
							section_id = ".$section_id.",
							nom = '".$this->db->escapeString($nom)."' 
					WHERE id = ".$id;
		}else{
			$sql = "INSERT INTO eby_ra_group SET 
								section_id = ".$section_id.",
								nom = '".$this->db->escapeString($nom)."'";
		}

		if(!$this->db->query($sql)){
			return false;
		}else{
			
			if($id==null){
				$ret = $this->db->lastSerialID( 'eby_ra_group', 'id' );
			}else{
				$ret = $id;
			}	
			
			$this->db->commit();
			return $ret;
		}		
		
	}
	
	
	public function setUserGroup($groupId,$arrUserId)
	{
	
		$this->db->begin();
		
		foreach($arrUserId as $userId)
		{
			$this->db->query( "REPLACE INTO eby_ra_user_link SET 
								user_id = ".$userId.",
								group_id = ".$groupId);
			
		} 
		
		$this->db->commit();
		
	}	
	
	
	public function delGroup($arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ 
				if(!$this->db->query(  "DELETE FROM eby_ra_group WHERE id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
					return false;
				}
				if(!$this->db->query(  "DELETE FROM eby_ra_tree_link WHERE group_id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
					return false;
				}
				if(!$this->db->query(  "DELETE FROM eby_ra_user_link WHERE group_id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
					return false;
				}
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	
	
	
	public function getGroupData($id)
	{
		$sql = "SELECT * FROM  eby_ra_group WHERE id = ".$id;
		
		$recDb = $this->db->arrayQuery( $sql );
		
	
		foreach ( $recDb as $row )
	  	{
	  		return $row;
	  
	  	}
	 	
	}
	
	
	public function getGroupList()
	{
		$strSetcion = implode(',',$this->arrSection);
		
		$sql = "SELECT * FROM  eby_ra_group WHERE section_id IN (".$strSetcion.")";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrGroup = array();
		foreach ( $recDb as $row )
	  	{
	  		$oSection = eZSection::fetch($row['section_id']);
	  		$row['section'] = $oSection->attribute('name'); 
	  		$arrGroup[]= $row;
	  
	  	}
	 	
	  	return $arrGroup;
	}
	

	public function getGroupUserList($group_id)
	{
		$sql = "SELECT * FROM  eby_ra_user_link WHERE group_id=".$group_id;
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrGroupUser = array();
		foreach ( $recDb as $row )
	  	{
	  		$arrGroupUser[]= $row['user_id'];
	  
	  	}
	 	
	  	return $arrGroupUser;
	}
	
	
	public function delGroupUser($group_id, $arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ 
				if(!$this->db->query(  "DELETE FROM eby_ra_user_link WHERE user_id = ".$id." AND group_id=".$group_id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
					return false;
				}
				
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	
	
	
	public function getDossierList()
	{

		$strSetcion = implode(',',$this->arrSection);
		
		$sql = "SELECT * FROM  eby_ra_tree_link t1, eby_ra_group t2  
				WHERE t1.group_id = t2.id 
				AND t2.section_id IN (".$strSetcion.")
				ORDER BY node_id";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrTmp = array(); $i = -1; $node_idTemp=''; $k=0;
		foreach ( $recDb as $row )
	  	{
			if($row['node_id'] != $node_idTemp){
				$i++; $k=0;
				$node_idTemp = $row['node_id'];
				$arrTmp[$i] = $row;
			}
			
			$arrTmp[$i]['groups'][$k] = $row['nom'];
			$k++;

	  	}

	  	return $arrTmp;
	}
	
	
	
	public function setDossierGroup($arrGroupId,$arrNodeId)
	{
		$this->db->begin();
		
		if(count($arrNodeId)==1)
		{
			if(!$this->db->query(  "DELETE FROM eby_ra_tree_link WHERE node_id=".$arrNodeId[0]))
			{
				eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
				return false;
			}
		}
		
		foreach($arrGroupId as $groupId)
		{
			foreach($arrNodeId as $nodeId)
			{	
				$node = eZContentObjectTreeNode::fetch( $nodeId );				
				$this->db->query( "REPLACE INTO eby_ra_tree_link SET 
								node_id = ".$nodeId.",
								group_id = ".$groupId.",
								url_alias = '".$node->attribute('url_alias')."'");
			}	
			
		} 
		
		$this->db->commit();
		
	}	
	
	
	public function getDossierData($id)
	{
		$sql = "SELECT * FROM  eby_ra_tree_link WHERE node_id=".$id;
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrTmp = array();
		foreach ( $recDb as $row )
	  	{
	  		$arrTmp[]= $row;
	  	}
	 	
	  	return $arrTmp;
	}
	
	
	
	public function delDossier($arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ 
				if(!$this->db->query(  "DELETE FROM eby_ra_tree_link WHERE node_id=".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyrestrictedarea.php');	
					return false;
				}
				
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	
	
	public function isRestricted($section_id, $url_alias, $lang){
		
		
		
		if($section_id){
		
			if($lang == '')
				$url_alias = substr($url_alias, 1, strlen($url_alias));
			else
				$url_alias = substr($url_alias, 4, strlen($url_alias));
			$url_alias_array = explode("/", $url_alias); $testedAlias = '';
			
			
			$testedAlias = '';
			foreach($url_alias_array as $alias){
				
				if($alias != ''){
					$testedAlias .= $alias;
					
					$sql = "SELECT a.node_id FROM eby_ra_tree_link a, eby_ra_group c WHERE 
					c.section_id = ".$section_id." AND c.id = a.group_id AND 
					a.url_alias='".$testedAlias."'";
        	    	
					$testedAlias .= '/';
        	    	
					$recDb = $this->db->arrayQuery( $sql );
					if(count($recDb) > 0){
						return $recDb[0]['node_id'];
					}
					
					unset($sql);
					unset($recDb);
				}
			}

			unset($url_alias_array);
		}
	  	return false;
		
	}
	
	public function isRestrictedUser($user_id, $node_id){
		

		$sql = "SELECT a.node_id FROM eby_ra_tree_link a, eby_ra_group c, eby_ra_user_link b WHERE 
		b.user_id = ".$user_id." AND c.id = b.group_id AND 
		a.node_id = ".$node_id." AND a.group_id = c.id";

		$recDb = $this->db->arrayQuery( $sql );
		if(count($recDb) > 0){
			unset($recDb);
			return false;
		}

		return true;
	}
	
	
}



 
?>