<?php
/**
 * Management of the general parameters of the site ... The ones that the webmaster central has rights to manage
 *
 * @author J. Leger
 * @version $Id: ebyparam.php
 * @copyright (C) J. Leger 2009
 *
 */


class ebyParam
{
   
  
    var $widget_list;
   	var $ini;
   	var $typeINI;
    
    protected $db;
	
    
	public function __construct()
	{
		
		$this->db = eZDB::instance();
		$this->ini = eZINI::instance('bouygues.ini');
		$this->typeINI = $this->ini->variableArray( 'TypeList','Type'); 

	}
	
	
	public function getListEntry($type=null,$orderby=null)
	{
		$sql = "SELECT * FROM  eby_settings WHERE 1 ";
		if($type!=null){
			$sql.= " AND type = '".$type."'";
		}else{
			$sql.= " AND type <> 'ww_field'";
		}
		if($orderby!=null){
			$sql.= " ORDER BY type, cle ASC";
		}
		$recDb = $this->db->arrayQuery( $sql );
		
		$entries=array();
		foreach ( $recDb as $row )
	  	{
	    	$valeur = unserialize(base64_decode($row['valeur']));
	    	if(is_array($valeur)){
	    		$entries[$row['id']]['valeur'] = $valeur;
	    	}else{
	    		$entries[$row['id']]['valeur'] = utf8_encode($valeur);
	    	}
	  		
	  		$entries[$row['id']]['cle'] = $row['cle'];
	  		$entries[$row['id']]['type'] = $row['type'];
			$entries[$row['id']]['section_id'] = $row['section_id'];
	
	  	}
	 	
		return $entries;
	}
	
	
	public function getEntryById($id)
	{
		$sql = "SELECT * FROM  eby_settings WHERE id = $id ";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$entry=array();	
		
		foreach ( $recDb as $row )
	  	{
	  		$valeur = unserialize(base64_decode($row['valeur']));
	    	if(!is_array($valeur)){
	    		$valeur = utf8_encode($valeur);
	    	}
	  		$entry[$row['id']]['valeur'] = $valeur;
	  		$entry[$row['id']]['cle'] = $row['cle'];
	  		$entry[$row['id']]['type'] = $row['type'];
	  		$entry[$row['id']]['section_id'] = $row['section_id'];
	
	  	}
	 	
		return $entry;	
	}
	
	
	
	public function setEntry($id=null,$type=null,$cle=null,$valeur,$section_id=null)
	{
		$this->db->begin();
		
		if($section_id!=null){ 
			$sectionVal = $section_id;
		}else{
			$sectionVal = 'NULL';
		}
		
		if($id!=null){
			$sql = "UPDATE eby_settings SET ";
			if($type!=null) $sql.= "type = '".$type."', ";
			if($cle!=null) $sql.= "cle = '".$cle."', ";
			$sql.= "section_id = ".$sectionVal.", ";
			$sql.= "valeur = '".base64_encode(serialize(utf8_decode($valeur)))."'";
			$sql.= "WHERE id = ".$id;
		}else{
			$sql = "INSERT INTO eby_settings SET 
								section_id = ".$sectionVal.",
								type = '".$type."',
								cle = '".$cle."',
								valeur = '".base64_encode(serialize(utf8_decode($valeur)))."'";
		}
		
		if(!$this->db->query($sql)){
			return false;
		}else{
			$this->db->commit();
			return true;
		}		
			
		
	}
	
	
	
	public function delEntry($arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ //echo "DELETE FROM eby_settings WHERE id = ".$id;
				if(!$this->db->query(  "DELETE FROM eby_settings WHERE id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebyparam.php');	
					return false;
				}
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	

	
	
}



 
?>