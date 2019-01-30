<?php
include_once( "extension/bouygues/classes/whoswho.php" );
class whoswhoFunctionCollection
{
	protected $db;
    /*!
     Constructor
    */
    function __construct()
    {
    	$this->db = eZDB::instance();
    }

    function listSearchOptions($type, $section_id = 0){

    	$sql = "SELECT id, cle, valeur FROM eby_settings WHERE type = '".$type."'";
		if($section_id > 0)
			$sql .= " AND (section_id = ".$section_id." OR section_id IS NULL OR section_id = '')";
    	
		$sql .= " ORDER BY cle ASC";
    	
    	$resArray = $this->db->arrayQuery( $sql );
		
		$arrReturn = array(); $i = 0;
		foreach($resArray as $result){
			$arrReturn[$i] = $result;
			$arrReturn[$i]['valeur'] = utf8_encode(unserialize(base64_decode($result['valeur'])));
			$i++;
		}

		
	    return array('result' => $arrReturn); 
    }

    function fetchOptionValue($id){
    	
		return array('result' => whoswho::fetchOptionValue($id));
    }
    
    function search( 
    	$first_name, 
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
    	$ww_id
    )
    {    	
        return array( 'result' =>  whoswho::search($first_name, 
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
											    	$ww_id));
    }
    
	function fetch( $user_id, $ww_id )
    {

        return array( 'result' =>  whoswho::fetch($user_id, $ww_id));
    }
    
    function fetchSettingsSearch($ww_id){
    	return array( 'result' =>  whoswho::fetchSettingsSearch($ww_id));
    }
    
	function fetchSettingsFields($ww_id){
    	return array( 'result' =>  whoswho::fetchSettingsFields($ww_id));
    }

	function fetchWhoswhoByUser($user_id){
		if($user_id == 0)
			$user_id = eZUser::currentUserID();
			
		$whoswhoObj = new whoswho();		
		$userWhoswhoSubscriptions = $whoswhoObj->getSubscription($user_id);
		
		$arrWhoswho = array();
		foreach($userWhoswhoSubscriptions as $userWhoswhoSubscription)
			$arrWhoswho[] = $userWhoswhoSubscription['ww_id'];
		
		//Get all the whos who available
		$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 2,
																		   	'ClassFilterType' => 'include',
																	       	'ClassFilterArray' => array( 'bouygues_whoswho' ),
																			'Limitation' => array()
																		), 2 );
																		
		$whoswho = array();
		foreach($nodes as $node){
			if(in_array($node->attribute('contentobject_id'), $arrWhoswho))
				$whoswho[] = $node;
		}
	
		
		return array( 'result' =>  $whoswho);
	
	}
    
	function hasSubscribedAtLeastOnce($user_id){
		
		$whoswhoObj = new whoswho();
		return array( 'result' =>  $whoswhoObj->hasSubscribedAtLeastOnce($user_id));
		
	}
    
}

?>
