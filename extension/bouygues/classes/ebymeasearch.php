<?php
/**
 * API de gestion des MEA Search
 * this class is not used anymore ...
 *
 * @author J. Leger
 * @version $Id: ebymeasearch.php
 * @copyright (C) J. Leger 2009
 *
 */


class ebyMeaSearch
{
   
  
    protected $db;
	
    
	public function __construct()
	{
		
		$this->db = eZDB::instance();
		
	}
	
	public function getObjectList()
	{
		$sql = "SELECT * FROM  eby_mea_search  GROUP BY object_id";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$objectList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  		$sql2 = "SELECT * FROM  eby_mea_search WHERE object_id=".$row['object_id'];
	  		$recDb2 = $this->db->arrayQuery( $sql2 );
	  		$keyFr=array();
	  		$keyEn=array();
	  		foreach ( $recDb2 as $row2 )
	  		{
	  			if($row2['langue']=='fre-FR')
	  			{
	  				array_push($keyFr, $row2['keyword']);
	  			}else{
	  				array_push($keyEn, $row2['keyword']);
	  			}
	  		}
	  		$row['keys_fr']=implode(', ',$keyFr);
	  		$row['keys_en']=implode(', ',$keyEn);
	  		
	  		$objectList[] = $row;
	  		
	  
	  	}
	 	
		return $objectList;	
	}
	
	
	
	public function delObject($arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ 
				if(!$this->db->query(  "DELETE FROM eby_mea_search WHERE object_id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebymeasearch.php');	
					return false;
				}
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	
	
	
	public function getKeywordList($object_id,$langue='fre-FR')
	{
		$sql = "SELECT * FROM  eby_mea_search WHERE object_id = ".$object_id." AND langue LIKE '".$langue."'";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$keywordList=array();	
		
		foreach ( $recDb as $row )
	  	{
	  		$keywordList[] = $row;
	  
	  	}
	 	
		return $keywordList;	
	}
	
	
	public function boolObjectExist($id)
	{
		$sql = "SELECT * FROM  eby_mea_search WHERE object_id = ".$id;
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrObj=array();
		foreach ( $recDb as $row )
	  	{
	  		$arrObj[]= $row;
	  
	  	}
	  	
	  	if(count($arrObj)>0) return true;
	  	
	  	return false;
	 	
			
	}
	
	public function getKeyword($id)
	{
		$sql = "SELECT * FROM  eby_mea_search WHERE id = ".$id;
		
		$recDb = $this->db->arrayQuery( $sql );
		
		
		foreach ( $recDb as $row )
	  	{
	  		return $row;
	  
	  	}
	 	
			
	}
	
	
	
	public function setKeyword($id=null,$object_id,$langue='fre-FR',$keyword)
	{
		$this->db->begin();
		
		
		if($id!=null){
			$sql = "UPDATE eby_mea_search SET 
							keyword = '".addslashes($keyword)."' 
					WHERE id = ".$id;
		}else{
			$sql = "INSERT INTO eby_mea_search SET 
								object_id = ".$object_id.",
								langue = '".$langue."',
								keyword = '".addslashes($keyword)."'";
		}
		
		if(!$this->db->query($sql)){
			return false;
		}else{
			$this->db->commit();
			return true;
		}		
			
		
	}
	
	
	
	public function delKeywordEntry($arrId=null)
	{
		$this->db->begin();
		if($arrId!=null)
		{
			foreach($arrId as $id)
			{ 
				if(!$this->db->query(  "DELETE FROM eby_mea_search WHERE id = ".$id))
				{
					eZDebug::writeNotice( "sql : ".$sql, 'bouygues:classes/ebymeasearch.php');	
					return false;
				}
			}
			$this->db->commit();
		}
		return true;
		
		
	}
	

	public function getObjectByKeywords($keyword){
		
		if(strlen($keyword) > 0){
		
			$sql = "SELECT object_id FROM  eby_mea_search WHERE keyword LIKE '%".addslashes($keyword)."%' GROUP By object_id";
			$recDb = $this->db->arrayQuery( $sql );
        	
	 		$objectList=array();	
			
			foreach ( $recDb as $row )
	  		{
	  			$object = eZContentObject::fetch($row['object_id']);
	  			$objectList[] = $object;
	  			unset($object);
	  		}
	 		
	  		if(count($objectList) > 0)
				return $objectList;
		}
		return false;
	}
	
	
}



 
?>