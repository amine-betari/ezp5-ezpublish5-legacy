<?php
/**
 * API de gestion sondage
 *
 * @author J. Leger
 * @version $Id: ebysondage.php
 * @copyright (C) J. Leger 2009
 *
 */


class ebySondage
{
   
    
    protected $db;
	
    
	public function __construct()
	{
		
		$this->db = eZDB::instance();

	}
	
	public function setSondage($id=null,$data)
	{
		
		$this->db->begin();
		
		foreach($data['ActionIDArray'] as $val){
			$reponse_ok = $val;
		}
		
		if($id!=null)
		{
			$sql = "UPDATE eby_sondage SET 	question='".addslashes($data['question'])."', 
											reponse1='".addslashes($data['reponse1'])."',
											reponse2='".addslashes($data['reponse2'])."',
											reponse3='".addslashes($data['reponse3'])."',
											question_eng='".addslashes($data['question_eng'])."', 
											reponse1_eng='".addslashes($data['reponse1_eng'])."',
											reponse2_eng='".addslashes($data['reponse2_eng'])."',
											reponse3_eng='".addslashes($data['reponse3_eng'])."',
											etat = ".$data['etat'].",
											dte_etat=NOW() ,
											user_id=".eZUser::currentUserID()."
					WHERE id = ".$id; 

 					echo $sql;									 
			
		}else{
			$sql = "INSERT INTO eby_sondage (question,
											reponse1,
											reponse2,
											reponse3,
											question_eng,
											reponse1_eng,
											reponse2_eng,
											reponse3_eng,
											etat,
											dte_etat,
											user_id) 
									VALUE   ('".addslashes($data['question'])."',
											 '".addslashes($data['reponse1'])."',
											 '".addslashes($data['reponse2'])."',
											 '".addslashes($data['reponse3'])."',
											 '".addslashes($data['question_eng'])."',
											 '".addslashes($data['reponse1_eng'])."',
											 '".addslashes($data['reponse2_eng'])."',
											 '".addslashes($data['reponse3_eng'])."',
											 ".$data['etat'].",
											 NOW(),
											 ".eZUser::currentUserID()."
											 ) ";
		}
		
		
		if(!$this->db->query($sql)){
			return false;
		}else{
			$this->db->commit();
			return true;
		}		
			
		
	}
	
	
	public function getSondageList()
	{
		$sql = "SELECT * FROM  eby_sondage ORDER BY dte_etat desc";
		
		$recDb = $this->db->arrayQuery( $sql );
		
		$arrSondage=array();	
		
		foreach ( $recDb as $row )
	  	{
	    	//créateur
	  		$oAdmin = eZContentObject::fetch($row['user_id']);
			if($oAdmin){
    			$dataMapAdm = $oAdmin->attribute( 'data_map' );
				$row['admin'] = $dataMapAdm['last_name']->content().' '.$dataMapAdm['first_name']->content();
			}else
				$row['admin'] = "Inconnu";
				
			//nb réponses
			$sql2 = "SELECT * FROM  eby_sondage_user WHERE sondage_id=".$row['id'];
			$recDb2 = $this->db->arrayQuery( $sql2 );
			$row['nb_reponses'] = count($recDb2);
			
	  		$arrSondage[] = $row;
	
	  	}
	 	
		return $arrSondage;
	}
	
	
	public function getSondageData($id=null)
	{
		if($id!=null)
		{
			$sql = "SELECT * FROM  eby_sondage WHERE id=".$id;
			
			$recDb = $this->db->arrayQuery( $sql );
			
			$arrSondage=array();	
			
			foreach ( $recDb as $row )
		  	{
		    	
		  		$arrSondage = $row;
		
		  	}
		 	
			return $arrSondage;
		
		}else{
			return false;
		}
	}
	
	
	public function deleteSondage($arrId)
	{
		if(is_array($arrId)){
			$this->db->begin();
			
			foreach($arrId as $val){
				
				$sql = "DELETE FROM eby_sondage_user WHERE sondage_id = ".$val;
				if(!$this->db->query( $sql  )){
					return false;
				}
				$sql = "DELETE FROM eby_sondage WHERE id = ".$val;
				if(!$this->db->query( $sql  )){
					return false;
				}
			}
			$this->db->commit();
			return true;
		}else{
			return false;
		}	
		
	}
	
	static function fetchLast($idSondage = null){
		$ebsondage = new ebySondage();
		
		if(is_null($idSondage))
			$sql = "SELECT a.id as id, a.question, a.reponse1, a.reponse2, a.reponse3, 
			a.question_eng, a.reponse1_eng, a.reponse2_eng, a.reponse3_eng,
			COUNT(b.reponse) as nbReponse, b.reponse FROM  eby_sondage a LEFT JOIN eby_sondage_user b ON ( b.sondage_id = a.id )
			WHERE a.etat = 1 GROUP BY a.id, b.reponse ORDER BY dte_etat DESC";
		else
			$sql = "SELECT a.id as id, a.question, a.reponse1, a.reponse2, a.reponse3, 
			a.question_eng, a.reponse1_eng, a.reponse2_eng, a.reponse3_eng,
			COUNT(b.reponse) as nbReponse, b.reponse FROM  eby_sondage a LEFT JOIN eby_sondage_user b ON ( b.sondage_id = a.id )
			WHERE a.etat = 1 AND a.id = $idSondage GROUP BY a.id, b.reponse";
			
		$recDb = $ebsondage->db->arrayQuery( $sql );

		$arrResult = array(); 
		$arrResult['reponse1_rate'] = $arrResult['reponse1_nb'] = 0;
		$arrResult['reponse2_rate'] = $arrResult['reponse2_nb'] = 0;
		$arrResult['reponse3_rate'] = $arrResult['reponse3_nb'] = 0;
		$arrResult['nbTotal'] = 0;
		$id = 0;
		foreach($recDb as $row){
			if($id == 0 || $id == $row['id']){
				$id = $row['id'];
				
				$arrResult['id'] = 				$id;
				$arrResult['question'] = 		stripslashes($row['question']);
				$arrResult['reponse1'] = 		stripslashes($row['reponse1']);
				$arrResult['reponse2'] = 		stripslashes($row['reponse2']);
				$arrResult['reponse3'] = 		stripslashes($row['reponse3']);
				$arrResult['question_eng'] = 	stripslashes($row['question_eng']);
				$arrResult['reponse1_eng'] = 	stripslashes($row['reponse1_eng']);
				$arrResult['reponse2_eng'] =	stripslashes($row['reponse2_eng']);
				$arrResult['reponse3_eng'] = 	stripslashes($row['reponse3_eng']);
			
				if($row['reponse'] == 1)		$arrResult['reponse1_nb']+=$row['nbReponse'];
				if($row['reponse'] == 2)		$arrResult['reponse2_nb']+=$row['nbReponse'];
				if($row['reponse'] == 3)		$arrResult['reponse3_nb']+=$row['nbReponse'];
				$arrResult['nbTotal']+=$row['nbReponse'];
			}else
				break;
		}
		
		if($arrResult['nbTotal'] > 0){
			$arrResult['reponse1_rate'] = number_format(100*$arrResult['reponse1_nb']/$arrResult['nbTotal'],0);
			$arrResult['reponse2_rate'] = number_format(100*$arrResult['reponse2_nb']/$arrResult['nbTotal'],0);
			$arrResult['reponse3_rate'] = number_format(100*$arrResult['reponse3_nb']/$arrResult['nbTotal'],0);
		}
		unset($ebsondage);
		
		return $arrResult;
	}
	
	static function setResponse($sondage_id, $response, $userId = null){
		if(is_null($userId))
			$userId = eZUser::currentUserID();
		
		if($reponse = self::hasResponded($sondage_id, $userId))
			return $reponse;
			
		$ebsondage = new ebySondage();
		$sql = "INSERT INTO  eby_sondage_user (sondage_id, user_id, reponse, dte_reponse) VALUES (
						".$sondage_id.",
						".$userId.",
						".$response.",
						NOW())";
		
		if(!isset($_COOKIE['sondage'.$sondage_id]))
			setcookie('sondage'.$sondage_id, $response, time()+2592000, '/', '', false, true);
		
		if(!$ebsondage->db->query($sql)){
			return false;
		}else{
			$ebsondage->db->commit();
			return $reponse;
		}

		unset($ebsondage);
	}
	
	static function hasResponded($sondage_id, $userId = null){
		if(is_null($userId))
			$userId = eZUser::currentUserID();
			
		$ebsondage = new ebySondage();
		
		$sql = "SELECT reponse FROM  eby_sondage_user WHERE sondage_id = ".$sondage_id." AND user_id = ".$userId;

		$recDb = $ebsondage->db->arrayQuery( $sql );
		
		unset($ebsondage);

		if(count($recDb) > 0 && $userId != 10)
			return $recDb[0]['reponse'];

		if(isset($_COOKIE['sondage'.$sondage_id]))
			return $_COOKIE['sondage'.$sondage_id];
			
		return false;
	}
	
	static function listAllResponses($idSondage){
		$ebsondage = new ebySondage();
		$sql = "SELECT a.id as id, a.question, a.reponse1, a.reponse2, a.reponse3, 
		a.question_eng, a.reponse1_eng, a.reponse2_eng, a.reponse3_eng, b.user_id as user_id, 
		COUNT(b.reponse) as nbReponse, b.reponse, b.dte_reponse 
		FROM  eby_sondage a LEFT JOIN eby_sondage_user b ON ( b.sondage_id = a.id )
		WHERE a.etat = 1 AND a.id = $idSondage GROUP BY b.user_id, b.reponse";

		$recDb = $ebsondage->db->arrayQuery( $sql );
		$arrResponders = array(); $i=0;
		foreach($recDb as $row){
			
			$oUser = eZContentObject::fetch($row['user_id']);
			if($oUser){
    			$dataMap = $oUser->attribute( 'data_map' );
				$row['user'] = $dataMap['last_name']->content().' '.$dataMap['first_name']->content();
			}else
				$row['user'] = "Inconnu";
			
			$row['reponse_str'] = $row['reponse'.$row['reponse']];
			$arrResponders[$i] = $row;
			$i++;
		}
		
		return $arrResponders;
		
	}
	
}



 
?>